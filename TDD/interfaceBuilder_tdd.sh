#!/bin/bash
#
# interfaceBuilder_tdd.sh (Shell Script)
# 
# Objetivo: Testes automáticos do programa interfaceBuilder.
# 
# Site: https://dirack.github.io
# 
# Versão 1.0
# 
# Programador: Rodolfo A C Neves (Dirack) 02/04/2020
# 
# Email: rodolfo_profissional@hotmail.com
# 
# Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.

source $(dirname $0)/tdd_lib.sh

DIR=".."

[ -f "./interfaceBuilder" ] && {
	DIR="."
}

# Criar novo modelo itf
TMP=$(mktemp -u tmp_XXXX.itf)

trap "rm $TMP" err exit

error "$($DIR/interfaceBuilder -c $TMP 0 12 0 3.5 && echo $?)" "0" "1" "Criar novo modelo .itf" 

echo "Adicionar 7 interfaces ao modelo..."
xedge=("0,12" "0,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12")
zedge=("0.3,0.25" "0.7,0.45" "1.2,1.2,1.3,1.4,0.7,1.05,1.2" "1.7,1.7,1.8,2.0,1.1,1.45,1.8" "2.2,2.2,2.3,2.5,1.6,1.9,2.2" "2.7,2.7,2.8,2.9,2.2,2.4,2.7" "3.5,3.5,3.5,3.5,3.5,3.5,3.5")

sfill=("0,0.1,0,0,0.39,0,0" "0,0.4,0,0,0.31,0,0" "0,0.9,0,0,0.28,0,0" "0,1.5,0,0,0.25,0,0" "0,2.0,0,0,0.55,0,0" "0,2.4,0,0,0.44,0,0" "0,3.0,0,0,0.16,0,0")

ERRO="0"
for i in $(seq 0 1 6)
do
	echo "...Interface $i"
	$DIR/interfaceBuilder -a $TMP x=${xedge[$i]} y=${zedge[$i]} sfill=${sfill[$i]}
	[ "$?" -ne "0" ] && {
		ERRO="1"		
		break
	}
done

error "$ERRO" "0" "2" "Adicionar interfaces ao modelo $TMP"

# Testar remover uma interface da pilha
NUM_INTERFACES_ANTES=$($DIR/interfaceBuilder -s "$TMP" | grep Arquivo | rev | cut -d" " -f1)
error "$?" "0" "3" "Ver informações sobre o modelo $TMP"

$DIR/interfaceBuilder -r "$TMP"
NUM_INTERFACES_DEPOIS=$($DIR/interfaceBuilder -s "$TMP" | grep Arquivo | rev | cut -d" " -f1)
RESULTADO=$(echo "${NUM_INTERFACES_ANTES}-1" | bc)
error "$NUM_INTERFACES_DEPOIS" "$RESULTADO" "4" "Testar número de interfaces após remoção $TMP"
