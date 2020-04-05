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

int main(int argc, char* argv[]){

	FILE *fp;
	char ch[50];

	if(argv[1]==NULL)
		error(1,"O usuário não passou nenhum arquivo!");

	if((fp=fopen(argv[1],"r"))==NULL)
		error(2,"Não foi possível abrir o arquivo passado!");

	while((fscanf(fp,"%s\n",ch))!=EOF){
		if(strstr(ch,"<tm>")!=NULL)
			printf("achou!");
		printf("%s",ch);
	}

	fclose(fp);
}
