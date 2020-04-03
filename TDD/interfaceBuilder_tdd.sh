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

error "$($DIR/interfaceBuilder -c $TMP 0 10 0 3 && echo $?)" "0" "1" "Criar novo modelo .itf" 
