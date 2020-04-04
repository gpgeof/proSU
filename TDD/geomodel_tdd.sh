#!/bin/bash
#
# geomodel_tdd.sh (Shell Script)
# 
# Objetivo: Testes automatizados do programa geomodel.
# 
# Site: https://dirack.github.io
# 
# Versão 1.0
# 
# Programador: Rodolfo A C Neves (Dirack) 04/04/2020
# 
# Email: rodolfo_profissional@hotmail.com
# 
# Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.

source $(dirname $0)/tdd_lib.sh

# Verificar diretório do programa a ser testado
DIR=".."

[ -f "./interfaceBuilder" ] && {
	DIR="."
}

# Criar novo modelo itf
TMP=$(mktemp -u tmp_XXXX.itf)
TMPBIN=$(echo $TMP | cut -d"." -f1)
TMPEPS="${TMPBIN}.eps"
TMPBIN="${TMPBIN}.bin"

trap "rm $TMP $TMPBIN $TMPEPS" err exit

# Criar modelo de testes e adicionar 7 interfaces
$DIR/interfaceBuilder -c "$TMP" 0 12 0 3.5 

xedge=("0,12" "0,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12" "0,2,4,6,8,10,12")
zedge=("0.3,0.25" "0.7,0.45" "1.2,1.2,1.3,1.4,0.7,1.05,1.2" "1.7,1.7,1.8,2.0,1.1,1.45,1.8" "2.2,2.2,2.3,2.5,1.6,1.9,2.2" "2.7,2.7,2.8,2.9,2.2,2.4,2.7" "3.5,3.5,3.5,3.5,3.5,3.5,3.5")

sfill=("0.1,0.39" "0.4,0.31" "0.9,0.28" "1.5,0.25" "2.0,0.55" "2.4,0.44" "3.0,0.16")

for i in $(seq 0 1 6)
do
	$DIR/interfaceBuilder -a $TMP x=${xedge[$i]} y=${zedge[$i]} sfill=${sfill[$i]}
	[ "$?" -ne "0" ] && {
		error "1" "0" "1" "Criar as interfaces do modelo..."
	}
done

$DIR/geomodel -m $TMPBIN $TMP

error "$?" "0" "1" "Gerar modelo..."

$DIR/geomodel -i $TMPBIN $TMP

error "$?" "0" "2" "Gerar imagem eps do modelo..."
