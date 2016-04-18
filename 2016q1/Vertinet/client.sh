# This file is just a client to communicate with the server given
# by the task. It'll use the verticode solution available at:
# https://github.com/atcasanova/sctf/blob/master/VertiCode/decode.sh
# and should be invoked using socat:
# socat TCP4:problems1.2016q1.sctf.io:50000 EXEC:/full/path/to/client.sh,fdin=3,fdout=4
# 
# it uses pure bash and socat, just to show that bash can do ANYTHING :)
# nice to learn how file descriptors work
#
# by atcasanova@protonmail.ch
# n00bsb.rocks

start=0;
print=0;
while read -n1 char;
do
		(( $print == 1 )) && echo -n $char;
		if [ "$char" == "," ]; then
			start=1; continue;
 		fi
		if [ "$char" == "'" ]; then
			start=0;
		fi
		(( $abriu == 1)) && {
			resp+=$char; 
		}
		if (( ${#resp} > 1500 )) && (( $abriu == 0 )); then
			echo -n "${resp}" | base64 -d >/dev/null && {
				echo -n "${resp}" | base64 -d > file.png
				print=1;
				answer=$(../Verticode/decode.sh file.png)
				echo -n $answer >&4
				resp=
			} || print=0;
		fi
done <&3
