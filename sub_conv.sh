#!/bin/bash
files="$@"
for file in $files
do
	if [ ! -f "$file" ]; then
		echo "$file not found"
		continue
	fi
	
	file_charset=$(chardetect "$file" | grep -Po '(?<=: ).*(?=with)' | tr -d ' ')
	if [ ! $file_charset ]
	then
		echo "couldn't determine charset"
		continue
	fi

	echo "file: $file charset: $file_charset"
	
	if [ $file_charset != "utf-8" ]
	then
		echo "converting to utf-8"
		iconv -f $file_charset -t utf-8 $file > /tmp/iconv_tmp
		mv /tmp/iconv_tmp $file	
	fi
	echo "done!"
done
exit 0
