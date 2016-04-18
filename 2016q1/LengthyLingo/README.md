# LenghtyLingo
## Description:
Can you crack the code? We intercepted this flag but can't seem to figure out how it was encrypted.

The solution is quite simple. You have to count the length of each word, then convert it's number to ascii.
I've came up with this one-liner:

``sed 's/, /\n/g' encrypted.dat | while read i; do printf "\x$(printf %x ${#i})"; done``
