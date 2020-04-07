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
	int n;
	char* valor;
	char* chave;
	char* value;
	size_t keylen;
	size_t valen;
	char ch[50];
	tabela tab;
	init(&tab);
	header* h;
	interface* itf;
	/* Vetores de teste da interface */
	float x[2]={0,12};
	float z[2]={1,1.4};
	float s[3]={0.5,0.5,0.6};

	/* Abrir arquivo itf */
	if(argv[1]==NULL || argv[2]==NULL){
		fprintf(stderr,"O usuário não passou o arquivo itf e/ou um nome para o arquivo bin!\n");
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

	/* Escrever binário */
	if((fp=fopen(argv[2],"wb"))==NULL){
		fprintf(stderr,"Não foi possível abrir o arquivo passado!\n");
		exit(3);
	}

	h = initHeader(atoi(getvalue(tab,"kedge")),
		strtof(getvalue(tab,"xmin"),NULL),
		strtof(getvalue(tab,"xmax"),NULL),
		strtof(getvalue(tab,"zmin"),NULL),
		strtof(getvalue(tab,"zmax"),NULL));

	/* TODO este vetor é apenas de teste
	não foi lido a vartir do arquivo itf
	o header sim, foi lido e carrgado acima */
	itf = initInterface(x,z,s);

	/* Escrever o header no binário */
	n = fwrite(h,sizeof(*h),1,fp);
	n = fwrite(itf,sizeof(*itf),1,fp);

	fclose(fp);
}
