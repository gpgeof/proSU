#! /bin/sh
# Migracao pos-stack em profundidade metodo de diferencas finitas

wbox=500 
hbox=300

#nt=501
dt=0.004
ft=0.0
nxm=864
dxm=13.889
xm0=0.0
nz=1200
dz=2.9

input=seis_stack.su
output=migfd2.su

vfile=campovel1.bin
vfilet=modelovelt.bin

transp n1=$nz n2=$nxm <$vfile >$vfilet
#ximage n1=600 n2=350  d1=20 d2=10  < modelovelt.bin perc=99 legend=1 &

sumigfd < $input nz=$nz dz=$dz dx=$dxm vfile=$vfilet >$output

suximage < $input perc=99 f1=$ft d1=$dt f2=$xm0 d2=$dxm \
           wbox=$wbox hbox=$hbox \
           label1="Tempo [s]" label2="CDP" title="Secao ZO" &

suximage < $output perc=99 f1=$ft d1=$dz f2=$xm0 d2=$dxm \
           wbox=$wbox hbox=$hbox \
           label1="Profundidade [m]" label2="CDP" title="Secao Migrada FD -- NMO + MUTE + STACK" &

exit 0




