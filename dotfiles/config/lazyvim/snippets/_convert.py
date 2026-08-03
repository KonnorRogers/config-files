#!/usr/bin/env python3
import json, re, os, glob, collections

SRC_ULTI = "/home/claude/config-files/dotfiles/my-snippets/.my-snippets"
SRC_JSON = "/home/claude/config-files/dotfiles/vim/snippets"
OUT = "/home/claude/snippets"
os.makedirs(OUT, exist_ok=True)

VISUAL = "\x00VISUAL\x00"
DATE_OPEN, DATE_CLOSE = "\x00D<", ">\x00"

STRF = {
    "%Y": "${CURRENT_YEAR}", "%y": "${CURRENT_YEAR_SHORT}",
    "%m": "${CURRENT_MONTH}", "%d": "${CURRENT_DATE}",
    "%H": "${CURRENT_HOUR}", "%M": "${CURRENT_MINUTE}",
    "%S": "${CURRENT_SECOND}", "%z": "${CURRENT_TIMEZONE_OFFSET}",
    "%F": "${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
    "%T": "${CURRENT_HOUR}:${CURRENT_MINUTE}:${CURRENT_SECOND}",
    "%B": "${CURRENT_MONTH_NAME}", "%b": "${CURRENT_MONTH_NAME_SHORT}",
    "%A": "${CURRENT_DAY_NAME}", "%a": "${CURRENT_DAY_NAME_SHORT}",
}

def strftime_to_vscode(fmt):
    out = fmt
    for k, v in STRF.items():
        out = out.replace(k, v)
    return out

def convert_body_line(line):
    dates = []
    # 1) vim eval interpolation: `!v strftime("...")` -> protected sentinel
    def date_repl(m):
        dates.append(strftime_to_vscode(m.group(1)))
        return f"\x00D{len(dates)-1}\x00"
    line = re.sub(r'`!v\s+strftime\("([^"]*)"\)`', date_repl, line)
    # 2) ${VISUAL} -> sentinel (restored to $TM_SELECTED_TEXT later)
    line = line.replace("${VISUAL}", VISUAL)
    # 3) escape literal ${word...} env/shell braces (keep ${<digit>...} tabstops/transforms)
    line = re.sub(r'\$\{(?!\d)', r'\\${', line)
    # 4) escape literal $word / $( shell dollars (keep $<digit> tabstops)
    line = re.sub(r'\$(?=[A-Za-z_(])', r'\\$', line)
    # 5) restore sentinels (after escaping, so their $ stay intact)
    line = line.replace(VISUAL, "$TM_SELECTED_TEXT")
    for idx, d in enumerate(dates):
        line = line.replace(f"\x00D{idx}\x00", d)
    return line

SNIP_RE = re.compile(r'^snippet\s+(\S+)\s*(?:"([^"]*)")?\s*([A-Za-z]+)?\s*$')

def parse_ultisnips(path):
    snippets = []          # (trigger, desc, [body lines])
    extends = []
    body, trig, desc, in_blk = [], None, None, False
    for raw in open(path, encoding="utf-8").read().splitlines():
        if not in_blk:
            if raw.startswith("extends "):
                extends += [x.strip() for x in raw[len("extends "):].split(",")]
                continue
            m = SNIP_RE.match(raw)
            if m:
                trig, desc = m.group(1), m.group(2)
                body, in_blk = [], True
                continue
            # ignore comments / blanks outside blocks
        else:
            if raw.strip() == "endsnippet":
                # drop stray "options word" cruft line
                if body and body[0].strip() == "options word":
                    body = body[1:]
                snippets.append((trig, desc, body))
                in_blk = False
                continue
            body.append(raw)
    return snippets, extends

def add(dct, name_pool, key, prefix, body_lines, desc):
    # ensure unique JSON key
    base = key
    n = 1
    while key in name_pool:
        n += 1
        key = f"{base} ({n})"
    name_pool.add(key)
    entry = {"prefix": prefix, "body": [convert_body_line(l) for l in body_lines]}
    if desc:
        entry["description"] = desc
    dct[key] = entry

# ---- collect converted UltiSnips per source filetype ----
ulti = collections.defaultdict(dict)      # ft -> {name: entry}
ulti_pool = collections.defaultdict(set)
all_extends = {}
for path in sorted(glob.glob(os.path.join(SRC_ULTI, "*.snippets"))):
    ft = os.path.splitext(os.path.basename(path))[0]
    snips, ext = parse_ultisnips(path)
    if ext:
        all_extends[ft] = ext
    for trig, desc, body in snips:
        name = desc if desc else trig
        add(ulti[ft], ulti_pool[ft], name, trig, body, desc)

# ---- load existing vsnip JSON, translate ${VIM:...} ----
def fix_vim_exprs(s):
    s = re.sub(r'\$\{VIM:expand\(strftime\("([^"]*)"\)\)\}',
               lambda m: strftime_to_vscode(m.group(1)), s)
    s = s.replace('${VIM:expand("%:t:r")}', "$TM_FILENAME_BASE")
    return s

vscode = collections.defaultdict(dict)    # ft -> {name: entry}
pool = collections.defaultdict(set)
for path in sorted(glob.glob(os.path.join(SRC_JSON, "*.json"))):
    ft = os.path.splitext(os.path.basename(path))[0]
    data = json.load(open(path, encoding="utf-8"))
    for name, entry in data.items():
        body = entry.get("body", [])
        if isinstance(body, str):
            body = [body]
        entry["body"] = [fix_vim_exprs(x) for x in body]
        while name in pool[ft]:
            name += " (2)"
        pool[ft].add(name)
        vscode[ft][name] = entry

# ---- merge UltiSnips into the JSON buckets (all.snippets -> global/all) ----
MERGE = {"javascript": "javascript", "ruby": "ruby", "markdown": "markdown", "all": "global"}
for ft, entries in ulti.items():
    target = MERGE.get(ft, ft)
    for name, entry in entries.items():
        nm = name
        while nm in pool[target]:
            nm += " (snip)"
        pool[target].add(nm)
        vscode[target][nm] = entry

# ---- fix UltiSnips conditional-transform snippets VSCode can't express ----
# ruby 'def': `${2/(\S+)/(?2:\()/}$2${2/(\S+)/(?2:\))/}` wrapped $2 in parens when present.
for name, entry in vscode.get("ruby", {}).items():
    entry["body"] = ["def ${1:method_name}(${2:args})" if ln.startswith("def ${1:method_name}${2/")
                     else ln for ln in entry["body"]]

# ---- write out one json per bucket ----
for ft, entries in sorted(vscode.items()):
    with open(os.path.join(OUT, f"{ft}.json"), "w", encoding="utf-8") as f:
        json.dump(entries, f, indent=2, ensure_ascii=False)
        f.write("\n")

# ---- language map for package.json ----
LANG = {
    "javascript": ["javascript", "javascriptreact", "typescript", "typescriptreact"],
    "global": "all",
    "sh": ["sh", "bash", "zsh"],
    "rails": "ruby",          # rails snippets load into ruby buffers
    "snippets": "snippets",
    "sabio": "sabio",         # reached via html/php extended_filetypes
}
contributes = []
for ft in sorted(vscode.keys()):
    lang = LANG.get(ft, ft)
    contributes.append({"language": lang, "path": f"./{ft}.json"})

pkg = {"name": "my-snippets", "contributes": {"snippets": contributes}}
with open(os.path.join(OUT, "package.json"), "w", encoding="utf-8") as f:
    json.dump(pkg, f, indent=2, ensure_ascii=False)
    f.write("\n")

print("buckets written:", sorted(vscode.keys()))
print("extends found:", all_extends)
print("total snippets:", sum(len(v) for v in vscode.values()))
