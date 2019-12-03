Collection of dotfiles, as well as install files to be used

I use this in conjunction with my [Kubs-CLI Gem](https://github.com/paramagicdev/kubs-cli) to make using everything much easier

Typical use case:

```bash
git clone https://github.com/ParamagicDev/config-files ~/config-files
cd ~/config-files
./setup.bash

source /usr/local/share/chruby/chruby.sh
chruby 2.6.3

gem install kubs_cli

kubs init
kubs copy
kubs install_dependencies
kubs install_packages

source ~/.zshrc
```
