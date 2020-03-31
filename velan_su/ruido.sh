#! /bin/sh
#-------------------------------------------------------------------------------
# Adiciona ruido a secao sismica
# scale = (1/sn) * (absmax_signal/sqrt(2))/sqrt(energy_per_sample)
#-------------------------------------------------------------------------------

indata=seis_cdp_sort.su      # dado de entrada
outdata=seis_cdp_sort_noise.su  # dado com ruido
sn=98                           # razao sinal/ruido
noisetype=gauss                 # tipo de ruido
seed=from_clock                 # semente de partida

suaddnoise <$indata >$outdata  sn=$sn  noise=$noisetype  seed=$seed	

# cdp 1150 sem ruido
suwind < $indata key=cdp min=1000 max=1000 | suximage perc=99 &
# cdp 1150 com ruido
suwind < $outdata key=cdp min=1000 max=1000 | suximage perc=99 &

exit 0

	

