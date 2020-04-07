# Makefile
# 
# Objetivo: Compilação e teste do programa itf2bin.
# Basta rodar 'make test' no diretório do programa.
# 
# Site: https://dirack.github.io
# 
# Versão 1.0
# 
# Programador: Rodolfo A C Neves (Dirack) 07/04/2020
# 
# Email: rodolfo_profissional@hotmail.com
# 
# Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.

test:	itf2bin.c tabelaParametros.h estruturaModeloItf.h modelo.itf
	gcc itf2bin.c -o itf2bin
	./itf2bin modelo.itf modelo.bin
