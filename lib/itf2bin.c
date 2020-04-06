/*
* itf2bin.c (C)
* 
* Objetivo: Coversor de arquivo itf para binário.
* 
* Site: https://dirack.github.io
* 
* Versão 1.0
* 
* Programador: Rodolfo A C Neves (Dirack) 05/04/2020
* 
* Email: rodolfo_profissional@hotmail.com
* 
* Licença: GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.txt>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "estruturaModeloItf.h"
#include "tabelaParametros.h"

int main(int argc, char* argv[]){

	FILE *fp;
	int i;
	char* valor;
	char* chave;
	char* value;
	size_t keylen;
	size_t valen;
	char ch[50];
	tabela tab;
	init(&tab);

	/* Abrir arquivo itf */
	if(argv[1]==NULL){
		fprintf(stderr,"O usuário não passou nenhum arquivo!\n");
		exit(1);
	}

	if((fp=fopen(argv[1],"r"))==NULL){
		fprintf(stderr,"Não foi possível abrir o arquivo passado!\n");
		exit(2);
	}

	/* Ler até a tag de marcação <tm> */
	while(strstr(ch,"<tm>")==NULL)
		fscanf(fp,"%s\n",ch);
	
	/* Começa a ler os parâmetros chave=valor */
	while(strstr(ch,"</tm>")==NULL){
		fscanf(fp,"%s\n",ch);
		valor = strchr(ch,'=');
		if(valor==NULL)
			continue;
		valor++;
		value = (char*) malloc(strlen(valor)*sizeof(char));
		value = strcpy(value,valor);
		keylen = (size_t) (valor-ch);
		chave = (char*) malloc(keylen*sizeof(char));
		memcpy(chave,ch,keylen);
		chave[keylen-1]='\0';
		push(&tab,chave,value);
	}

	print(tab);

	printf("zmax=%s\n",getvalue(tab,"zmax"));

	fclose(fp);
}
