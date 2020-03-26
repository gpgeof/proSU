#!/bin/bash
#
# velcat.sh (Shell Script)
# 
# Objetivo: Organizar informações sobre velocidade dos CMP's em um único arquivo.
# 
# Site: https://dirack.github.io
# 
# Versão 1.0
# 
# Programador: Rodolfo A C Neves (Dirack) 26/03/2020
# 
# Email: rodolfo_profissional@hotmail.com
# 
# Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.

# Se o usuário não passar um nome
# de arquivo, utilize vela.dat
VELAN_FILE="velan.dat"
[ -z "$1" ] || {
	VELAN_FILE="$1"
}

# Buscar CMP's na pasta atual
CMPS=$(ls cmp*.dat)

echo "cdp=$(echo $CMPS | sed 's/.dat//g;s/cmp//g;s/ /,/g') \\" > "$VELAN_FILE"

for i in $CMPS
do
	FILE="$i"

	grep "tnmo" -A1 "$FILE" >> "$VELAN_FILE"
done
