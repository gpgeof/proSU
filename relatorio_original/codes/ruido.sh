#! /bin/sh
#-------------------------------------------------------------------------------
# Adiciona ruido a secao sismica
# scale = (1/sn) * (absmax_signal/sqrt(2))/sqrt(energy_per_sample)
#-------------------------------------------------------------------------------
indata=seis_cdp.su              # dado de entrada
outdata=seis_noise.su           # dado com ruido
sn=50                           # razao sinal/ruido
noisetype=gauss                 # tipo de ruido
seed=from_clock                 # semente de partida

suaddnoise <$indata >$outdata  sn=$sn  noise=$noisetype  seed=$seed	

# cdp 1150 sem ruido
suwind < $indata key=cdp min=1150 max=1150 | suximage perc=99 &
# cdp 1150 com ruido
suwind < $outdata key=cdp min=1150 max=1150 | suximage perc=99 &

exit

	

