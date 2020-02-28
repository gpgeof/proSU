#! /bin/sh
#-------------------------------------------------------------------------------
# Gera o modelo de velocidade exato em conjunto com o matlab (executa o matlab
# durante a conversao do modelo de vagarosidade para modelo uniforme de veloci
# dade)
# Suaviza o modelo gerado no matlab de acordo com os parametros r1 e r2.
#-------------------------------------------------------------------------------
input_model=geomodel.bin                    # binario gerado no trimodel 
output_model=geomodel.tri                   # binario gerado na execucao 
input_model2=modelo_velocidade.bin          # binario gerado no matlab
output_model2=model_velocidade_suaviado.bin # binario gerado no SU

n1=350     # dimensao em z
n2=1200    # dimensao em x 
d1=0.010   # incremento em z (350x0.010 = 3.5km dimensao em z do modelo)
d2=0.010   # incremento em x (1200x0.010 = 12km dimensao em x do modelo)
f1=0.0     # primeiro valor de amostra na dimensao 1
f2=0.0     # primeiro valor de amostra na dimensao 2
r1=5       # paramentro de suvizacao do modelo na direcao 1 
r2=5       # paramentro de suvizacao do modelo na direcao 2

# comando para converter modelo de vagarosidade triangularizado (trimodel) para
# modelo uniforme.
tri2uni<$input_model n1=$n1 n2=$n2 d1=$d1 d2=$d2 f1=$f1 f2=$f2 >$output_model

clear # limpa a tela na execucao do matlab
matlab -nodesktop -r "run $PWD/sloth2velocity.m" #-nodisplay

# suaviza o modelo de velocidade gerado no matlab
smooth2<$input_model2 n1=$n1 n2=$n2 r1=$r1 r2=$r2 >$output_model2
#-------------------------------------------------------------------------------
# figuras
outeps1=output_model.eps

psimage n1=$n1 <$output_model units="Vararosidade" perc=99 f2=0.0 d2=0.010 \
	     d1=$d1 label1="Profundidade (km)" label2="Distancia (km)" \
	     title='Modelo de Vagarosidade convertido (Uniforme)' \
titlesize=20 legend=1 lstyle=vertright width=15.0 height=8.0 > $outeps1
#-------------------------------------------------------------------------------
outeps1=output_model2.eps

psimage n1=$n1 <$output_model2 units="Velocidade" perc=99 f2=0.0 d2=0.010 \
	     d1=$d1 label1="Profundidade (km)" label2="Distancia (km)" \
	     title='Modelo de Vagarosidade Suavizado (Uniforme)' \
titlesize=20 legend=1 lstyle=vertright width=15.0 height=8.0 > $outeps1

clear
echo "arquivo compilado com sucesso !!!"
exit


