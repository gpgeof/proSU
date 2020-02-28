#!/bin/sh
# Gera uma figura de uma secao em afastamento minimo

file1=seis_cdp.su
eps1=seis_minoffset

dt=0.004
tmin=0.0
tmax=4.5

#wrgb=0,0,1.0 grgb=1.0,1.0,1.0 brgb=1.0,0,0
#wrgb=0.0,0.0,1.0 grgb=1.0,1.0,1.0 brgb=1.0,0.0,0.0

suwind key=offset min=-1175 max=-1175 < $file1 | supsimage d1=$dt f2=0 d2=0.062176166 \
width=15.0 height=8.0 perc=99 legend=1 lx=17.5 units="Amplitude" wrgb=0,0,1.0 grgb=1.0,1.0,1.0 brgb=1.0,0,0 \
labelfont=Times-Roman label1="Tempo (s)" label2="Distancia (km)" \
title="Afastamento Minimo" titlesize=20 > $eps1.eps

#suwind < seis.su key=offset min=-1175 max=-1175 > offset_min.su

#suwind < seis.su key=offset min=-1175 max=-1175 | supswigb > wigb_plot.eps \
#perc=99 nbpi=150 va=5 wbox=15.0 hbox=8.0 labelfont=Times-Roman \
#label1="Tempo (s)" label2="CDP -597 ao 9012" title="Afastamento minimo (1175 m)" titlesize=20

#12000/193 = 62.176165803 distancia em x do modelo/numero de tiros do modelo (fldr)
#62.176165803/1000 = 0.062176166 distancia em km
