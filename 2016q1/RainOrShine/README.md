#Rain Or Shine


This one we couldn't crack in time, mostly because I first found a JPEG signature which turned out to be just the thumbnail of the original image, what cost us a lot of time, and also because GIMP wouldn't open layered TIFFs. 

Because of this, we spent a lot of time trying to manually reassemble the QR Code, which was impossible since there were overlayed layers.

By the time I got access to a friend with Photoshop, the challenge was ended.

Cutting to the chase: Open the `rain.wav` file in your favourite hex editor (mine is bless). Keep digging until you find a TIFF header:

**49492a0008**

So what we'll have to do is cut the file from this header until the end: 

`xxd -p rain.wav | tr -d '\n' | grep -Eo "49492a0008[0-9a-f]*" | xxd -r -p > file.tiff`

and then open it with Photoshop (GIMP apparently has some issues managing layered TIFFs), where you can see four layers and easily rearrange them.


The result is a QRCode that you could read with your phone or using zbar-tools
