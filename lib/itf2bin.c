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

void error(size_t nerror,const char* msg){
	fprintf(stderr,"%s: ERRO(%ld): %s\n",__FILE__,nerror,msg);
	exit(nerror);
}

struct Header{
	float xmin;
	float xmax;
	float zmin;
	float zmax;
};

typedef struct Header *header;

int main(int argc, char* argv[]){

	FILE *fp;
	char ch[50];
	int i;
	header h = (header) malloc(sizeof(*h));
	char* eq;
	float v[4];

	if(argv[1]==NULL)
		error(1,"O usuário não passou nenhum arquivo!");

	if((fp=fopen(argv[1],"r"))==NULL)
		error(2,"Não foi possível abrir o arquivo passado!");

	while(strstr(ch,"<tm>")==NULL)
		fscanf(fp,"%s\n",ch);

	for(i=0;i<4;i++){
		fscanf(fp,"%s\n",ch);
		eq = strchr(ch,'=');
		if(eq==NULL)
			continue;
		eq++;
		v[i]=strtof(eq,NULL);
	}

	h->xmin=v[0];
	h->xmax=v[1];
	h->zmin=v[2];
	h->zmax=v[3];
	printf("xmin=%f\nxmax=%f\nzmin=%f\nzmax=%f\n",
		h->xmin,
		h->xmax,
		h->zmin,
		h->zmax);

	fclose(fp);
}
