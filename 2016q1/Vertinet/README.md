# Vertinet

This problem follows the same specifications as the previous *Verticode*, except that you have to solve many of them by developing a client to communicate with the server available at `problems1.2016q1.sctf.io:50000`. Good luck.

# client.sh
## Running

`chmod +x client.sh`

then

`socat TCP4:problems1.2016q1.sctf.io:50000 EXEC:/full/path/to/client.sh,fdin=3,fdout=4`

Maybe you'll need to install `socat`first
