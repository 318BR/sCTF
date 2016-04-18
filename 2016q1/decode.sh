#!/bin/bash
# There are a lot of temporary files created because this script was retrieved from my bash_history
# 
# This script will beat the VertiCode level from sctf q1 2016
#
# by atcasanova@protonmail.ch
# n00bsb.rocks
(( $# != 1 )) && { echo "please specify input file"; exit 1; }

# constants:
line_height=12
pixel_width=12
line_width=168
color_width=83

# convert png to txt using ImageMagick's convert
convert $1 txt: > out.txt
sed -i '1d' out.txt
lines=$(tail -1 out.txt | cut -f2 -d, | cut -f1 -d:)

# get just one line of pixels for each real line in the image
for (( i=0; i<$lines; i+=$line_height )); do 
	grep -E "^[0-9]*,$i: " out.txt ; 
done > lines.txt

# get just one pixel per needed column in the original image
>sane.txt
for i in $(cat lines.txt | cut -f2 -d, | cut -f1 -d: | sort -nu); do
	for (( j=$color_width; j<$line_width; j+=$pixel_width )); do 
		grep "^$j,$i: " lines.txt >> sane.txt
	done
done 

# each "line" in one line
cat sane.txt | tr -s ' ' | sed 's/, /,/g;s/( /(/g' | cut -f4 -d " " | xargs -L8 > end.txt

# black and white to binary
sed 's/ black/1/g;s/ white/0/g' end.txt | sed 's/^[a-z]*/\0 /g' >ideal.txt

# binary conversion, color conversion and mathematics, then print ascii code
paste -d-  <(for i in $(cat ideal.txt | cut -f2 -d" "); do echo $((2#$i)); done) ideal.txt > last.txt
for i in $(cat last.txt | cut -f1 -d" " | sed 's|red|0|g;s|purple|1|g;s|blue|2|g;s|green|3|g;s|yellow|4|g;s|orange|5|g'| bc); do 
	printf "\x$(printf %x $i)";
done
echo
