#! /bin/sh
# organizando geometria (inserindo chave cdp)

input1=seis.su            # binario da aquisicao (triseis)
outtemp=seis2.su          # binario convertido pra versao do usuario
outtemp2=seis_cdp.su      # temporario gerado na execucao
outtemp3=seis_cdp2.su     # temporario gerado na execucao
outtemp4=seis_cdp_sort.su # temporario gerado na execucao
#-------------------------------------------------------------------------------
# descomentar caso o binario desejado der erro na execucao
# converte o dado para a versao do su instalada na maquina
# ns= numero de amostras no tempo (ver script de aquisicao para descobrir ns)
#suswapbytes < $input1 > $outtemp ns=1200 
#mv $outtemp $input1
#-------------------------------------------------------------------------------
# adicionando chave cdp ao dado su
suchw < $input1 key1=cdp key2=sx key3=gx a=0 b=1 c=1 d=2 > $outtemp2
# removendo cdps negativos (parametro a)
suchw key1=cdp key2=cdp key3=cdp a=588 b=1 c=0 d=1 < $outtemp2 >$outtemp3
# sobrescrevendo arquivos
mv $outtemp3 $outtemp2
# sort
susort < $outtemp2 > $outtemp4 cdp offset
# sobrescrevendo arquivos
mv $outtemp4 $outtemp2

# informacoes do dado com chave cdp
surange < $outtemp2

exit

