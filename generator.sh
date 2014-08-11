#!/bin/bash
NGINX_PATH=${NGINX_PATH:-/etc/nginx}

# colors
RED_BACK='\033[0;41;30m'
STD_BACK='\033[0;0;39m'

GRN_FONT='\033[1;32m'
STD_FONT='\033[0m'

# host config file render functions

function generate_host {
  hostname=$1
  echo -e "${GRN_FONT}Creating host config for $hostname${STD_FONT}"
  ask_attribute 'public_folder' # get value and create "public_folder"

  config_file="$NGINX_PATH/sites-avalilable/$hostname.conf"
  mkdir -p "$NGINX_PATH/sites-avalilable/"

  echo '' > "$config_file" # clear previous file

  render "templates/default.tmpl.conf"

  echo "Config file created!"
  exit
}

function ask_attribute {
  echo "Set value of $1:"
  echo -n "$1="
  read value
  echo
  eval "$1='$value'"
}

function render {
  while read -r line
  do
    line=${line//\"/\\\"}
    line=${line//\`/\\\`}
    line=${line//\$/\\\$}
    line=${line//\\\${/\${}
    eval "echo \"$line\"" >> "$config_file"
  done < "$1"
}


# install config files functions
function install_configs {
  cp -r conf "$NGINX_PATH"
  cp nginx.conf "$NGINX_PATH"
  echo -e "${GRN_FONT}Config files copied into $NGINX_PATH ${STD_FONT}"
  exit
}

function usage {
  echo "Usage:"
  echo "$0 generate_host host"
  echo "$0 install"
}

# script section
case "$1" in
    "host")
        generate_host $2
        ;;
    "install")
        install_configs
        ;;
    *)
        usage
        ;; 
esac

