#! /bin/sh

output=seis_stack.su
output2=seis_stack.eps
dt=0.004

supsimage <$output units="Velocidade" perc=99 \
	     d1=$dt f2=0 d2=0.01388 label1="Tempo (s)" label2="Distancia (km)" \
         wrgb=0,0,1.0 grgb=1.0,1.0,1.0 brgb=1.0,0,0 \
	     title='Secao Empilhada' titlesize=20 legend=1 units="Amplitude" \
         lstyle=vertright width=15.0 height=8.0 > $output2 #grid1=solid grid2=solid

#=12000/864 comprimento do modelo / numero de tracos
#=13,888888889 em metros
#=13,888888889/1000 divido por mil para ficar em km
#=0.013888889

exit
