#! /bin/sh
#-------------------------------------------------------------------------------
# Mostra as secoes CDP
# entre os CDPs 1150 e 9650 com espacamento de 500 CDPs
#-------------------------------------------------------------------------------

input=seis_cdp.su

for number in $(seq 1150 500 9650)
do
	echo "CMP - $number"
	suwind < $input key=cdp min=$number max=$number > cmp$number.su
#	suxwigb < cmp$number.su title=" CMP - $number " key=offset \
#	            label1="Tempo (s)" label2="Afastamento (m)" \
#	            perc=94 &
#
	supswigp < cmp$number.su title=" CMP - $number " key=offset \
             label1="Tempo (s)" label2="Afastamento (m)" \
             perc=94 key=offset verbose=0 wbox=11.8 hbox=9.0 > cmp$number.eps
             evince cmp$number.eps & 
done

exit
