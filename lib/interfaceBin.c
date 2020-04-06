/*
* interfaceBin.c (C)
* 
* Objetivo: Define a estrutura de dados da interface.
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

#include <stdlib.h>
#include <stdio.h>

typedef struct Interface *interface;

struct Interface{
	float* xedge;
	float* zedge;
	float sfill[3];
};

typedef struct Header *header;

struct Header{
	int kedge;
	float xmin;
	float xmax;
	float zmin;
	float zmax;
};

int main(void){

	interface itf1[1], itf2[1];
	header h1, h2;
	FILE *fp;
	int n;
	float valor;

	/* Inicializar o modelo */
	h1 = (header) malloc(sizeof(*h1));
	h2 = (header) malloc(sizeof(*h2));
	h1->kedge=1;
	h1->xmin=0;
	h1->xmax=12;
	h1->zmin=0;
	h1->zmax=3.5;
	itf1[0]=(interface) malloc(sizeof(*itf1));
	itf2[0]=(interface) malloc(sizeof(*itf2));
	itf1[0]->xedge=(float*) malloc(2*sizeof(float));
	itf1[0]->xedge[0]=0;
	itf1[0]->xedge[1]=12;
	itf1[0]->zedge=(float*) malloc(2*sizeof(float));
	itf1[0]->zedge[0]=1;
	itf1[0]->zedge[1]=1.5;
	itf1[0]->sfill[0]=0.5;
	itf1[0]->sfill[1]=0.5;
	itf1[0]->sfill[1]=0.6;

	/* Abrir arquivo */
	if((fp=fopen("interface.itfb","wb"))==NULL){
		fprintf(stderr,"Erro ao tentar abrir arquivo!\n");
		exit(1);
	}

	n = fwrite(h1,sizeof(*h1),1,fp);
	n = fwrite(itf1,sizeof(*itf1),1,fp);
	fclose(fp);

	/* Ler de arquivo binário */
	if((fp=fopen("interface.itfb","rb"))==NULL){
		fprintf(stderr,"Não foi possível ler o arquivo!\n");
		exit(2);
	}

	fread(h2,sizeof(*h2),1,fp);
	printf("kedge=%d\nxmin=%f\nxmax=%f\nzmin=%f\nzmax=%f\n",
		h2->kedge,
		h2->xmin,
		h2->xmax,
		h2->zmin,
		h2->zmax);

	fread(itf2,sizeof(*itf2),1,fp);
	printf("xedge=%.2f,%.2f\nzedge=%.2f,%.2f\nsfill=%.2f,%.2f,%.2f\n",
		itf2[0]->xedge[0],itf2[0]->xedge[1],
		itf2[0]->zedge[0],itf2[0]->zedge[1],
		itf2[0]->sfill[0],itf2[0]->sfill[1],itf2[0]->sfill[2]);

	fclose(fp);
}
