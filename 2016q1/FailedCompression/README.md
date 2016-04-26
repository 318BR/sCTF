#[Failed Compression](https://ctftime.org/task/2258)

This one was a pain in the *ss. I opened the file (compressed.zip, 73mb) and found a lot of JPEG JFIF broken headers, and also PNG IHDR ones.

I was REALLY bored to code something nice to extract all the files, so I thought I could use some luck this time. Then I focused on the JPEG files.

Before you continue, I'd like you to know that I'm not proud of the following lines ;)


##1. Convert the file to hex
`xxd -p compressed.zip | tr -d "\n" > hex`

-----------

##2. Make an ugly loop to isolate the JPEG markers within spaces using an uglier sed.

`j=0; for i in $(cat hex | sed 's/e000104a/ STARTHERE/g;s/ae4260/ENDHERE /g'); do  echo $i > $j.j;  let j++;  done;`

----------

##3. Loop all the files, now fixing the headers and footers, then converting back from hex to file.

`for i in *.j ; do  sed -i 's/STARTHERE/ffd8ffe000104a/g;s/ENDHERE/ae4260/g' $i; xxd -r -p $i > ${i}pg ; done;`

-----------

##4. For easy browsing, let's make a HTML file with all the valid JPEG files
`for i in $(file *.jpg| grep JPEG | cut -f1 -d:); do echo "<img src='$i'>" >> index.html; done`

------------

As I said, we needed luck. The flag was in one of the jpeg files :)
Take a look at 264.jpg

----------
