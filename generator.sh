#!/bin/bash
hostname=$1

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


echo "Creating config for $hostname"

ask_attribute 'public_folder' # get value and create "public_folder"

config_file='generated/default.conf'
mkdir -p 'generated'
echo '' > "$config_file" # clear previous file

render "templates/default.tmpl.conf"

echo "Config file created!"