#! /bin/sh
#-------------------------------------------------------------------------------
# Empilhamento
#-------------------------------------------------------------------------------
indata=seis_cdp_nmo.su # dado corrigido NMO
outdata=seis_stack.su  # dado de saida empilhado

sustack < $indata > $outdata key=cdp verbose=1

exit
