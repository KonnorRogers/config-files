main(){
  install_dependencies
  install_chruby_and_ruby

  echo ""
  echo "Restart your shell to use chruby"
  echo "For example: chruby use 2.6.2"
}

install_dependencies(){
  sudo apt-get update
  sudo apt-get upgrade -y

  libs='apt-transport-https ca-certificates build-essential bison
  zlib1g-dev libyaml-dev libcurl4-openssl-dev libssl-dev
  libgdbm-dev libreadline-dev libffi-dev fuse make gcc libxml2-dev
  re2c libbz2-dev libjpeg-turbo8-dev libpng-dev
  libzip-dev libtidy-dev libxslt-dev automake libtool autoconf
  flex libkrb5-dev libonig-dev make gcc ruby ruby-dev golang php'

  sudo apt-get install $libs -y

  sudo apt-get autoremove -y
}

# this installs ruby & chruby under the .tmp folder within the repo
install_chruby_and_ruby(){
  temp_dir=".tmp"
  mkdir -p "$temp_dir"
  cd "$temp_dir" || exit 2
  install_ruby
  install_chruby
  cd ..
  rm -rf "$temp_dir"
}

install_ruby(){
  RUBY_INSTALL_TAR="ruby-install-0.7.0.tar.gz"
  RUBY_INSTALL_DIR="ruby-install-0.7.0/"

  wget -O "$RUBY_INSTALL_TAR" https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz

  tar -xzvf "$RUBY_INSTALL_TAR"

  echo "$PWD"
  tar -xzvf "$RUBY_INSTALL_TAR"
  cd "$RUBY_INSTALL_DIR" || exit 2
  sudo make install
  ruby-install ruby "$RUBY_VERSION" --no-reinstall
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

main
