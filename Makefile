# Makefile
# 
# Objetivo: Preparar o ambiente e rodar a suíte de testes.
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

TESTES= interfaceBuilder
DIR_TESTES=./TDD

install:
	@echo "Funcionalidade em desenvolvimento..."

test:	msg $(TESTES)

msg:
	@echo "Testando a biblioteca proSU..."

%:	$(DIR_TESTES)/%_tdd.sh
	@echo "...Testando $@" && $<
