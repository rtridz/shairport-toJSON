#!/bin/bash
 
now_playing_dir=/etc/shairport/now_playing
datafile=$now_playing_dir.json
 
stringify() {
  a=${1%%=*}
  b=${1##*=}
  echo "\"$a\": \"$b\""
}
 
exec 4< $now_playing_dir
while read -ru 4 line ; do
  if [[ $line == artist* ]]; then
    echo '{' > $datafile
  elif [ -z "$line" ]; then
    echo '}' >> $datafile
    continue
  fi
 
  # jsonify the string
  data=$(stringify "$line")
 
  # for logging
  echo $line
 
  # pretty print the JSON
  # comment is the last line of the output
  if [[ $line == comment* ]]; then
    echo "  $data" >> $datafile
  else
    echo "  $data," >> $datafile
  fi
done
 
exec 4<&-
echo Exiting