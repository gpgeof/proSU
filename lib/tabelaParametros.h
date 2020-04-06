/*
* tabelaParametros.h (C)
* 
* Objetivo: Define a estrutura da tabela de parâmetros lida do arquivo itf.
* Os parâmetros serão lidos na forma chave=valor e organizados em uma tabela
* de parâmetros, que é uma estrutura do tipo pilha.
* 
* Site: https://dirack.github.io
* 
* Versão 1.0
* 
* Programador: Rodolfo A C Neves (Dirack) 06/04/2020
* 
* Email: rodolfo_profissional@hotmail.com
* 
* Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Par{
	char* chave;
	char* valor;
	struct Par* prox;
} par;

typedef struct Par* tabela;

void init(tabela* t){
	*t = NULL;
}

void push(tabela* t, char* chave, char* valor){
	par* tmp;
	tmp = (par*) malloc(sizeof(par));
	if(tmp==NULL) return;
	tmp->chave=chave;
	tmp->valor=valor;
	tmp->prox = *t;
	*t = tmp;
}

int isempty(tabela t){
	return (t==NULL);
}

void pop(tabela* t){
	par* tmp = *t;
	if(isempty(*t)) return;
	*t = (*t)->prox;
	free(tmp);
}

char* top(tabela t){
	if(isempty(t)) return NULL;
	return t->chave;
}

char* getvalue(tabela t,char* chave){
	if((strcmp(t->chave,chave))==0) return t->valor;
	if(isempty(t)) return NULL;
	getvalue(t->prox,chave);
}
