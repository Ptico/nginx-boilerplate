#!/bin/bash
hostname=$1
config_file='generated/default.conf'

echo "Creating config for $hostname"

function ask_attribute {
  echo "Set value of $1:"
  echo -n "$1="
  read value
  echo
  eval "$1='$value'"
}

ask_attribute 'public_folder'

mkdir -p 'generated'
echo '' > "$config_file" # clear previous file

while read line
do
    eval echo "$line" >> "$config_file"
done < "templates/default.tmpl.conf"

echo "Config file created!"