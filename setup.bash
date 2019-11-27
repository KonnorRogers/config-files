main(){
  install_dependencies
  install_version_managers

  echo ""
  echo "Restart your shell to use version managers like chruby"
  echo "For example: chruby use $RUBY_VERSION"
}

install_dependencies(){
  sudo apt update
  sudo apt upgrade -y

  libs='apt-transport-https ca-certificates build-essential bison
  zlib1g-dev libyaml-dev libcurl4-openssl-dev libssl-dev
  libgdbm-dev libreadline-dev libffi-dev fuse make gcc libxml2-dev
  re2c libbz2-dev libjpeg-turbo8-dev libpng-dev
  libzip-dev libtidy-dev libxslt-dev libncurses-dev automake libtool autoconf
  flex libkrb5-dev libonig-dev make gcc ruby ruby-dev golang php git unixodbc-dev'

  sudo apt install $libs -y

  sudo apt autoremove -y
}

install_version_managers(){
  install_chruby_and_ruby_install
  install_phpenv
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
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.5
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
}

install_phpenv(){
  curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer | bash
}

main
