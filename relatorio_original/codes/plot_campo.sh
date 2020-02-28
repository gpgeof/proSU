#! /bin/sh
#-------------------------------------------------------------------------------
output=campovel.bin
output2=campovel2.eps
#output=campovel_suavizado.bin
#output2=campovel_suav.eps
#-------------------------------------------------------------------------------
# INFORMACOES DE ENTRADA
nsamp=1200 # numero de amostras temporais nt
dt=0.004   # intervalo de amostragem 
#-------------------------------------------------------------------------------
psimage <$output n1=$nsamp units="Velocidade" perc=98 \
	     d1=$dt f2=0.0 d2=0.001112347 label1="Tempo (s)" label2="Distancia (km)" \
	     title='Campo de Velocidade' titlesize=20 legend=1 lstyle=vertright width=15.0 height=8.0 > $output2
		 mycolorsu $output2 campovel_2.eps matlab
#12000/10788 = 1.112347052 distancia em x/numero de cdps
#1.112347052/1000 = 0.001112347 distancia em km
exit
