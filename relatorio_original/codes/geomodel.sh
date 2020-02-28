#!/bin/sh
trimodel xmin=0 zmin=0 xmax=12.0 zmax=3.5 \
         1 xedge=0,2,4,6,8,10,12 \
           zedge=0,0,0,0,0,0,0 \
           sedge=0,0,0,0,0,0,0 \
         2 xedge=0,12 \
           zedge=0.3,0.25 \
           sedge=0,0 \
         3 xedge=0,12 \
           zedge=0.7,0.45 \
           sedge=0,0 \
         4 xedge=0,2,4,6,8,10,12 \
           zedge=1.2,1.2,1.3,1.4,0.7,1.05,1.2 \
           sedge=0,0,0,0,0,0,0 \
         5 xedge=0,2,4,6,8,10,12 \
           zedge=1.7,1.7,1.8,2.0,1.1,1.45,1.8 \
           sedge=0,0,0,0,0,0,0 \
         6 xedge=0,2,4,6,8,10,12 \
           zedge=2.2,2.2,2.3,2.5,1.6,1.9,2.2  \
           sedge=0,0,0,0,0,0,0 \
         7 xedge=0,2,4,6,8,10,12 \
           zedge=2.7,2.7,2.8,2.9,2.2,2.4,2.7 \
           sedge=0,0,0,0,0,0,0 \
         8 xedge=0,2,4,6,8,10,12 \
           zedge=3.5,3.5,3.5,3.5,3.5,3.5,3.5 \
           sedge=0,0,0,0,0,0,0 \
           sfill=0,0.1,0,0,0.39,0,0 \
           sfill=0,0.4,0,0,0.31,0,0 \
           sfill=0,0.9,0,0,0.28,0,0 \
           sfill=0,1.5,0,0,0.25,0,0 \
           sfill=0,2.0,0,0,0.55,0,0 \
           sfill=0,2.4,0,0,0.44,0,0 \
           sfill=0,3.0,0,0,0.16,0,0 \
           kedge=1,2,3,4,5,6,7,8 \
           >geomodel.bin

# Create a PS display of the model
spsplot < geomodel.bin > vagarosidade.eps gedge=0.5 gtri=2.0 gmin=0.2 gmax=1.0 \
title="Modelo de camadas curvas" titlesize=20 labelz="Profundidade (km)" \
labelx="Distancia (km)" labelsize=18 dxnum=1.0 dznum=0.5 wbox=15 hbox=8

exit
