#! /bin/sh
# UTILIZA O CAMPO DE VELOCIDADE COM TNMO E VNMO 

# INFORMACOES DE ENTRADA
VELDIR=.
INVEL=velan.dat # nome do arquivo txt com os pares de tempo e velocidade
OUTVEL1=interp1d-1ms.bin
OUTVEL2=campovel.bin
output=campovel_suavizado.bin
output2=campovel_suavizado.eps

# INFORMACOES DE ENTRADA
nsamp=1200
dt=0.004
fsamp=0
ncdpin=18     #  numero de cdp analisados
fcdpin=1150   # numero do 1o. cdp da analise de vel.
dcdpin=500    # delta entre cdp utilizado na analise vel.
ncdpout=10788 # numero total de cdps do dado
fcdpout=1     # numero do 1o. cdp de saida
dcdpout=1
p1=250        # parametro de suavizacao em n1 (eixo- vertical).
p2=450        # parametro de suavizacao em n2 (eixo- horizontal).

nlines=`grep -v cdp $INVEL | grep -v "#" | wc -l | awk '{print $1}'`
currline=1

>$OUTVEL1

# INTERPOLACAO ESPACIAL
while [ $currline -le $nlines ]
	do
	nextline=`expr $currline + 1`
	ncolx=`grep -v cdp $INVEL | grep -v "#" | head -$currline | tail -1 | wc -c`
	lcolx=`expr $ncolx - 2`
	ncoly=`grep -v cdp $INVEL | grep -v "#" | head -$nextline | tail -1 | wc -c`
	lcoly=`expr $ncoly - 2`
	Xin=`grep -v cdp $INVEL | grep -v "#" | head -$currline | tail -1 | cut -c6-$lcolx`
	Yin=`grep -v cdp $INVEL | grep -v "#" | head -$nextline | tail -1 | cut -c6-$lcoly`

	unisam xin=$Xin yin=$Yin nout=$nsamp dxout=$dt fxout=$fsamp method=linear >>$OUTVEL1
	currline=`expr $currline + 2`
done
# INTERPOLACAO TEMPORAL
unisam2 nx1=$nsamp dx1=$dt fx1=$fsamp n1=$nsamp d1=$dt f1=$fsamp nx2=$ncdpin dx2=$dcdpin fx2=$fcdpin n2=$ncdpout d2=$dcdpout f2=$fcdpout method1=linear method2=linear <$OUTVEL1 >$OUTVEL2

rm $OUTVEL1

ximage n1=$nsamp < $OUTVEL2  d1=$dt f2=$fcdpout d2=$dcdpout cmap=hsv2 legend=1 title='sem suavizacao'  &

# suavizando o modelo de velocidade

smooth2 n1=$nsamp n2=$ncdpout r1=$p1 r2=$p2 < $OUTVEL2 > $output

ximage n1=$nsamp < $output  d1=$dt cmap=hsv2 legend=1 title='suavizado'

exit

