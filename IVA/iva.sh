#!/bin/bash
#
# iva.sh (Shell Script)
#
# Dependências: Utilize 'sudo apt-get install texlive-extra-utils' para salvar figuras.
#
# Dependências: Utilize 'sudo apt-get install imagemagick' para salvar figuras.
#
# Objetivo: Fazer a analise de velocidade iterativa utilizamdo as funções
# nativas do su.
# 
# Site: http://www.dirackslouge.online
#
# Versão 1.0
#
# Programador: Murilo S. V. Rodrigues 05/04/2020
#
# Programador: Rodolfo A. C. Neves 05/04/2020 
#
# Email (Manutenção): murilovj@gmail.com
# 
# Email (Manutenção): rodolfo_profissional@hotmail.com
# 
# Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.

clear

echo " "
echo " *** ANALISE INTERATIVA DE VELOCIDADE ***"
echo " "

rm -rf panel.* picks.* par.* tmp* velan_plot* curvefile* npairs* mpicks_bin* junk* Semblance*.eps CMP*.eps cmp*.dat
#------------------------------------------------
# Analise de velocidade Interativo
#------------------------------------------------
nrpicks=1

i=1
while [ $i -le $nrpicks ]
do
    echo "Specifique o numero de CMP" >/dev/tty
    read picknow
	echo " "
    echo "A posicao e CMP $picknow "
#------------------------------------------------
# Definicao de variaveis:
#------------------------------------------------
#indata=seis_cdp_sort_noise.su
indata=cmp_test.su
outdata=cmp$picknow.dat

nv=400     # Numero de velocidades
dv=10      # Intervalo
fv=1000    # Primeira velocidade

#------------------------------------------------
# Obter ns, dt, primeira vez em um arquivo sismico
#------------------------------------------------
nt=$(sugethw ns < $indata | sed 1q | sed 's/.*ns=//')
dt=$(sugethw dt < $indata | sed 1q | sed 's/.*dt=//')
ft=$(sugethw delrt < $indata | sed 1q | sed 's/.*delrt=//')
# Converter dt do valor do cabecalho em microssegundos
# a segundos para o grafico do perfil de velocidade
dt=$(echo "scale=6; $dt / 1000000" | bc -l)
# Se "delrt", use-o; senao use zero
if [ $ft -ne 0 ] ; then
  tstart=$(echo "scale=6; $ft / 1000" | bc -l)
else
  tstart="0.0"
fi

>$outdata   # Arquivo vazio
>par.cmp    # Arquivo vazio

#------------------------------------------------
# Plotando o CDP:
#------------------------------------------------

    suwind <$indata key=cdp min=$picknow \
            max=$picknow >panel.$picknow
    suxwigb <panel.$picknow xbox=312 ybox=10 \
             wbox=300 hbox=600 \
             title="Secao CMP $picknow" \
             perc=94 key=offset verbose=0 &
#------------------------------------------------
   supswigp <panel.$picknow label2='Afastamento [m]' label1='Tempo [s]' \
             perc=94 key=offset verbose=0 wbox=7.0 hbox=9.0 > CMP_$picknow.eps

#------------------------------------------------
# Preparando o CVS (Constant Velocity Stack)
#------------------------------------------------

    >tmp1
    j=1
    k=`expr $picknow + 10`
    l=$(echo "$dv * $nv / 120" | bc -l)

    suwind <$indata key=cdp min=$picknow \
            max=$k >tmp0

    while [ $j -le 10 ]
    do
	vel=$(echo "$fv + $dv * $j * $nv / 10" | bc -l)

	sunmo <tmp0 vnmo=$vel |

	sustack >>tmp1
        sunull ntr=2 nt=$nt dt=$dt >>tmp1
        j=`expr $j + 1`
    done
    suximage <tmp1 xbox=624 ybox=10 wbox=300 hbox=600 \
	     title="Painel CVS CMP $picknow" \
	     label1="Tempo [s]" label2="Velocidade [m/s]" \
	     f2=$fv d2=$l verbose=0 mpicks=picks.$picknow \
	     perc=99 n2tic=5 cmap=rgb0 &

#------------------------------------------------
# Plotando o mapa de Semblance:
#------------------------------------------------
	echo " "
    echo "  Coloque o ponteiro do mouse sobre o mapa de Semblance ou sobre"
    echo "  os paineis CVS e pressiones 's' para salvar a velocidade marcada." 
    echo "  Pressione 'q' no mapa de semblance depois de marcar todas as velocidades"
    suvelan <panel.$picknow nv=$nv dv=$dv fv=$fv |
	suximage xbox=1 ybox=10 wbox=300 hbox=600 \
		units="Semblance" f2=$fv d2=$dv \
		label1="Tempo [s]" label2="Velocidades [m/s]" \
		title="Mapa de Semblance - CMP $picknow" cmap=hsv2 \
		legend=1 units=Semblance verbose=0 gridcolor=black \
		grid1=solid grid2=solid mpicks=picks.$picknow
#------------------------------------------------
# definir valores de filtro para os plots wiggle
	f=1,5,70,80		# largura de banda dos dados a serem transmitidos
	amps=0,1,1,0	# nao mude
	sufilter < panel.$picknow f=$f amps=$amps |
	suvelan nv=$nv dv=$dv fv=$fv > velan_plot
	supsimage < velan_plot units="Semblance" \
	    f2=$fv d2=$dv label1="Tempo [s]" label2="Velocidade [m/s]" \
	    legend=1 lstyle=vertright units=Semblance gridcolor=black \
		ghls=.3333,.5,1 bhls=0,.5,1 whls=0.666666,.5,1 \
	    verbose=0 wclip=0 bclip=1 grid1=solid grid2=solid > Semblance_$picknow.eps

#------------------------------------------------
		sort <picks.$picknow -V > curvefile.$picknow
		a2b n1=2 outpar=junk < picks.$picknow > mpicks_bin.$picknow
		sed 's/n2=/npair=/g' < junk > npairs.$picknow
		mkparfile < curvefile.$picknow string1=tnmo string2=vnmo >par.$i
#------------------------------------------------------------
# Plotando a secao corrigida de NMO e o perfil de velocidades
#------------------------------------------------------------

    >tmp2
    echo "cdp=$picknow" >>tmp2
    cat par.$i >>tmp2
#------------------------------------------------------------
# plot do semblance + perfil de velocidade
#------------------------------------------------------------
	suximage <velan_plot xbox=1 ybox=10 wbox=300 hbox=600 \
		units="Semblance" f2=$fv d2=$dv \
		label1="Tempo [s]" label2="Velocidades [m/s]" \
		title="Mapa de Semblance - CMP $picknow" cmap=hsv2 \
		legend=1 units=Semblance verbose=0 gridcolor=black \
		grid1=solid grid2=solid \
		par=npairs.$picknow curve=curvefile.$picknow curvecolor=black curvewidth=2 &
	supsimage < velan_plot units="Semblance" \
	    f2=$fv d2=$dv label1="Tempo [s]" label2="Velocidade [m/s]" \
	    legend=1 lstyle=vertright units=Semblance gridcolor=black \
		ghls=.3333,.5,1 bhls=0,.5,1 whls=0.666666,.5,1 \
	    verbose=0 wclip=0 bclip=1 grid1=solid grid2=solid \
		par=npairs.$picknow curve=curvefile.$picknow curvecolor=black curvewidth=2 > Semblance_vel_$picknow.eps
#------------------------------------------------------------
    sunmo <panel.$picknow par=tmp2 > tmp_nmo
	supswigp < tmp_nmo label2='Afastamento [m]' label1='Tempo [s]' \
	perc=94 key=offset verbose=0 wbox=7.0 hbox=9.0 > CMP_After_NMO_$picknow.eps
    suxwigb < tmp_nmo title="Secao CMP depois do NMO" xbox=1 ybox=10 \
	     wbox=300 hbox=600 verbose=0 key=offset perc=94 &
        sed <par.$i '
	s/tnmo/xin/
	s/vnmo/yin/
	        ' >par.uni.$i
    unisam nout=$nt fxout=0.0 dxout=$dt \
	   par=par.uni.$i method=mono |
    xgraph n=$nt nplot=1 d1=$dt f1=0.0 \
		label1="Tempo [s]" label2="Velocidade [m/s]" \
		title="Funcao Velocidade CMP $picknow" \
           -geometry 200x600+934+10 style=seismic &

	echo " "
	echo " t-v PICKS CMP $picknow"
	echo "----------------------"
	cat picks.$picknow
	echo " "	

    echo "Deseja salvar as velocidades marcadas? (y/n) " >/dev/tty
    read response

    rm tmp*

    case $response in
	n) i=$i echo "Removendo as velocidades marcadas"
		echo " *** FECHANDO JANELAS ***"
		zap ximage
		zap xgraph
		zap xwigb
		clear
		;;
        y) i=`expr $i + 1`
           echo "$picknow  $i" >>par.cmp
		echo " *** FECHANDO JANELAS ***"
		zap ximage
		zap xgraph
		zap xwigb
		;;
        *) echo " *** FECHANDO JANELAS ***"
		zap ximage
		zap xgraph
		zap xwigb
		clear
;;
    esac

done

#------------------------------------------------
# Criando o arquivo de saida para as velocidades
#------------------------------------------------

mkparfile <par.cmp string1=cdp string2=# >par.0

i=0
while [ $i -le $nrpicks ]
do
  sed < par.$i 's/$/ \\/g' >> $outdata
  i=`expr $i + 1`
done
#------------------------------------------------
# convertendo eps para pdf e cropando pdf e png 
#------------------------------------------------
echo " "
find . -name "*.eps" -exec epstopdf {} ";"
for FILE in ./*.pdf; do
  pdfcrop "${FILE}"
done
#------------------------------------------------
mv CMP_$picknow-crop.pdf CMP_$picknow.pdf
mv Semblance_$picknow-crop.pdf Semblance_$picknow.pdf
mv Semblance_vel_$picknow-crop.pdf Semblance_vel_$picknow.pdf
mv CMP_After_NMO_$picknow-crop.pdf CMP_After_NMO_$picknow.pdf
#------------------------------------------------
convert -density 150 CMP_$picknow.pdf +profile "icc" -alpha remove -alpha off -quality 90 CMP_$picknow.png
convert -density 150 Semblance_$picknow.pdf -alpha remove -alpha off -quality 90 Semblance_$picknow.png
convert -density 150 Semblance_vel_$picknow.pdf -alpha remove -alpha off -quality 90 Semblance_vel_$picknow.png
convert -density 150 CMP_After_NMO_$picknow.pdf +profile "icc" -alpha remove -alpha off -quality 90 CMP_After_NMO_$picknow.png
#
DIR="$PWD/figuras/"
if [ -d "$DIR" ]; then
	cd "$PWD/figuras/"
	rm -rf CMP_$picknow.pdf Semblance_$picknow.pdf Semblance_vel_$picknow.pdf CMP_After_NMO_$picknow.pdf
	rm -rf CMP_$picknow.png Semblance_$picknow.png Semblance_vel_$picknow.png CMP_After_NMO_$picknow.png
	cd ..
	mv -fi CMP_$picknow.pdf Semblance_$picknow.pdf Semblance_vel_$picknow.pdf CMP_After_NMO_$picknow.pdf ./figuras/
	mv -fi CMP_$picknow.png Semblance_$picknow.png Semblance_vel_$picknow.png CMP_After_NMO_$picknow.png ./figuras/
else
	mkdir figuras
	mv -fi CMP_$picknow.pdf Semblance_$picknow.pdf Semblance_vel_$picknow.pdf CMP_After_NMO_$picknow.pdf ./figuras/
	mv -fi CMP_$picknow.png Semblance_$picknow.png Semblance_vel_$picknow.png CMP_After_NMO_$picknow.png ./figuras/
  exit 1
fi
#------------------------------------------------
# salva os pares tnmo e vnmo na pasta cmp_data
#------------------------------------------------
DIR1="$PWD/cmp_data/"
if [ -d "$DIR1" ]; then
	cd "$PWD/cmp_data/"
	rm -rf $outdata
	cd ..
	mv -fi $outdata ./cmp_data/
else
	mkdir cmp_data
	mv -fi $outdata ./cmp_data/
  exit 1
fi
#------------------------------------------------
# remove arquivos desnecessarios apos a compilacao
#------------------------------------------------
echo " "
echo " O arquivo de saida dos pares t-v e "$outdata
echo " "

rm -rf panel.* picks.* par.* tmp* velan_plot* curvefile* npairs* mpicks_bin* junk* Semblance*.eps CMP*.eps cmp*.dat

exit 0
