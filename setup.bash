#!/bin/bash

MY_RUBY_VERSION="2.6.3"

check_if_file_exists() {
  __file="$1"
  if [[ -z "$__file" ]]; then
    return 1;
  fi

  return 0;
}

main(){
  install_dependencies
  install_oh_my_zsh
  install_version_managers
  install_ruby
  fix_docker

  echo ""
  echo "Restart your shell to use version managers like chruby"
  echo "For example: chruby ruby-$MY_RUBY_VERSION"
}

install_dependencies(){
  sudo apt update
  sudo apt upgrade -y

  libs='apt-transport-https ca-certificates build-essential bison
  zlib1g-dev libyaml-dev libcurl4-openssl-dev libssl-dev
  libgdbm-dev libreadline-dev libffi-dev fuse make gcc libxml2-dev
  re2c libbz2-dev libjpeg-turbo8-dev libpng-dev
  libzip-dev libtidy-dev libxslt-dev libncurses-dev automake libtool autoconf
  flex libkrb5-dev libonig-dev make gcc ruby ruby-dev golang php git unixodbc-dev tmux vim neovim curl git zsh docker'

  sudo apt install $libs -y

  sudo apt autoremove -y
}

install_oh_my_zsh(){
  cd "$HOME"
  echo "$PWD"
  (sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && exit 1 && echo "oh-my-zsh successfully installed") || (echo "unable to install oh my zsh" && exit 1)
  cd -
  install_zsh_auto_suggestions
  install_zsh_syntax_highlighting
}

install_ruby(){
  if [[ ! -x "command -v ruby-install" ]]; then
    # fix permissions issues
    sudo chown "$USER:$USER" /usr/local/share
  fi

  ruby-install ruby "$MY_RUBY_VERSION" --no-reinstall

  source /usr/local/share/chruby/chruby.sh
  chruby ruby-"$MY_RUBY_VERSION"
  gem install kubs_cli
}

install_version_managers(){
  install_chruby_and_ruby_install
  install_asdf
}

# this installs ruby & chruby under the .tmp folder within the repo
install_chruby_and_ruby_install(){
  temp_dir=".tmp"
  mkdir -p "$temp_dir"
  cd "$temp_dir" || exit 2
  install_ruby_install
  install_chruby
  cd ..
  rm -rf "$temp_dir"
}

install_ruby_install(){
  RUBY_INSTALL_TAR="ruby-install-0.7.0.tar.gz"
  RUBY_INSTALL_DIR="ruby-install-0.7.0/"

  wget -O "$RUBY_INSTALL_TAR" https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz

  tar -xzvf "$RUBY_INSTALL_TAR"

  echo "$PWD"
  tar -xzvf "$RUBY_INSTALL_TAR"
  cd "$RUBY_INSTALL_DIR" || exit 2
  sudo make install
  cd ..
}

install_chruby(){
  CHRUBY_TAR="chruby-0.3.9.tar.gz"
  CHRUBY_DIR="chruby-0.3.9"

  wget -O "$CHRUBY_TAR" https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz

  tar -xzvf "$CHRUBY_TAR"

  cd "$CHRUBY_DIR" || exit 2
  sudo ./scripts/setup.sh
  cd ..
}

install_asdf(){
  _ASDF_HOME="$HOME/.asdf"
  if [[ ! -z "$_ASDF_HOME" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.5
  fi
}

install_yarn(){
  curl -o- -L https://yarnpkg.com/install.sh | sudo bash
}

install_zsh_auto_suggestions() {
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
}

install_zsh_syntax_highlighting() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
}

install_tmux_plugin_manager() {
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}

add_dejavu_sans_mono_font() {
  mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts || return
  curl --silent -fLo "DejaVu Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf && fc-cache -fv
  cd - || return
}

fix_docker() {
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  sudo service docker restart
}

main
