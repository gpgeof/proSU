#! /bin/sh

dt=0.004 
ft=0.0 
nxm=864 
dxm=13.889  
xm0=0.0
nz=350 
dz=10

input=seis_stack.su
output_migpspi=seis_Mig_PSPI_depth.su
output_migsplit=seis_Mig_SPLIT_STEP_depth.su
output_migffd=seis_Mig_FFD_depth.su

vfile=modelo_velocidade.bin
vfilet=modelo_velocidade_tranps.bin

#-------------------------------------------------------------------------------
#Transpondo o modelo de velocidade em profundidade

transp   n1=$nz n2=$nxm <$vfile >$vfilet

#-------------------------------------------------------------------------------
#Migracao em profundidade PSPI (Phase-Shift Plus Interpolation)

sumigpspi <$input nz=$nz dz=$dz dt=$dt dx=$dxm vfile=$vfilet > $output_migpspi

#-------------------------------------------------------------------------------
#Migracao em profundidade SPLIT-STEP

sumigsplit < $input nz=$nz dz=$dz dx=$dxm vfile=$vfilet > $output_migsplit

#-------------------------------------------------------------------------------
#Migracao em profundidade FFD (Fourier Finite Difference)

sumigffd < $input nz=$nz dz=$dz dx=$dxm vfile=$vfilet > $output_migffd

#-------------------------------------------------------------------------------
#Visualizar a secao ZO empilhada

suximage < $input perc=99 f1=$ft d1=$dt d2=$dxm cmap=rgb1 \
           label1="Time [s]" label2="Distance [m]" title="ZO Section" &

#-------------------------------------------------------------------------------
#Visualizar secao migrada PSPI (Phase-Shift Plus Interpolation)

suximage < $output_migpspi perc=99 label1="Depth [m]" n1=$nz d1=$dz n2=$nxm d2=$dxm \
	   cmap=rgb1 label2="Distance [m]" title="PSPI Migrated Section" &

#-------------------------------------------------------------------------------
#Secao migrada SPLIT-STEP

suximage < $output_migsplit perc=99 label1="Depth [m]" d2=$dxm \
	   cmap=rgb1 label2="Distance [m]" title="SPLIT-STEP Migrated Section" &

#-------------------------------------------------------------------------------
#Secao migrada FFD (Fourier Finite Difference)

suximage < $output_migffd perc=95 label1="Depth [m]" d2=$dxm \
	   cmap=rgb1 label2="Distance [m]" title="FFD Migrated Section" &

#-------------------------------------------------------------------------------

exit

