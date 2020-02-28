#! /bin/sh
/bin/rm -f temp*
# Assign values to variables
nangle=101
fangle=-65
langle=65
nt=1200 dt=0.004
datafile=geomodel.bin
seisfile=seis.su
#-------------------------------------------------------------------------------
# Shooting the seismic traces...
#-------------------------------------------------------------------------------

echo " ----Begin looping over triseis."
# Loop over shotpoints
i=0
while [ "$i" -ne "193" ]
do
    fs=`echo "$i * 0.05" | bc -l`
    sx=`echo "$i * 50" | bc -l`
    fldr=`echo "$i + 1" | bc -l`
   
    # Loop over receivers
    j=0
    while [ "$j" -ne "96" ]
    do
            fg=`echo "$i * 0.05 + $j *0.025" | bc -l`
            gx=`echo "$i * 50 + $j * 25 -1175" | bc -l`
            offset=`echo "$j * 25 -1175" | bc -l`
            tracl=`echo "$i * 96 + $j + 1" | bc -l`
            tracf=`echo "$j + 1" | bc -l`
        echo "sx=$sx  gx=$gx  flder=$fldr offset=$offset trace_number=$tracl fs=$fs fg=$fg"
       
            # Loop over reflectors      
        k=2
        while [ "$k" -ne "8" ]
        do
            triseis <$datafile  xs=1.2,10.80 zs=0,0 \
            xg=0.025,11.975 zg=0,0 \
            nangle=$nangle fangle=$fangle langle=$langle \
            kreflect=$k krecord=1 fpeak=12 lscale=0.5 \
            ns=1 fs=$fs ng=1 fg=$fg nt=$nt dt=$dt |
            suaddhead nt=$nt |
            sushw key=dt,tracl,tracr,fldr,tracf,trid,offset,sx,gx \
            a=4000,$tracl,$tracl,$fldr,$tracf,1,$offset,$sx,$gx >> temp$k
           
                k=`expr $k + 1`
            done

        j=`expr $j + 1`
        done

    i=`expr $i + 1`
    done

echo " ----End looping over triseis."

#-------------------------------------------------------------------------------
# Sum contents of the temp files...
#-------------------------------------------------------------------------------
echo " ----Sum files."
susum temp2 temp3 >tempa
susum tempa temp4 >tempb
rm -f tmpa
susum tempb temp5 >tempa
rm -f tmpb
susum tempa temp6 >tempb
rm -f tmpa
susum tempb temp7 >$seisfile
rm -f tmpb
#-------------------------------------------------------------------------------
# Clean up temp files...
#-------------------------------------------------------------------------------
echo " ----Remove temp files."
rm temp*
# Report output file
echo " ----Output file : $seisfile has been generated successfully ."
# Finishing shell script
echo " ----Finish!"
exit

