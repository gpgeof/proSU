#! /bin/sh
#-------------------------------------------------------------------------------
# Migracao Kirchhoff em tempo
#-------------------------------------------------------------------------------

input=seis_stack.su
output=seis_stack_mig.su
dxcdp=25
vfile=campovel_suavizado.bin

sumigtk < $input > $output dxcdp=$dxcdp vfile=$vfile  verbose=1

exit 

