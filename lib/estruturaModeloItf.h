/*
* estruturaModeloItf.h (C)
* 
* Objetivo: Define a estrutura de dados do modelo itf.
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

#include <stdlib.h>
#include <stdio.h>

typedef struct Interface{
	float* xedge;
	float* zedge;
	float sfill[3];
} interface;

typedef struct Header{
	int kedge;
	float xmin;
	float xmax;
	float zmin;
	float zmax;
} header;

header* initHeader(
			int kedge,
			float xmin,
			float xmax,
			float zmin,
			float zmax)
{

	header* h;
	h = (header*) malloc(sizeof(header));
	h->kedge=kedge;
	h->xmin=xmin;
	h->xmax=xmax;
	h->zmin=zmin;
	h->zmax=zmax;
	return h;
}

void printHeader(header* h){

	printf("kedge=%d\nxmin=%f\nxmax=%f\nzmin=%f\nzmax=%f\n",
		h->kedge,
		h->xmin,
		h->xmax,
		h->zmin,
		h->zmax);
}

interface* initInterface(float* xedge, float* zedge, float* sfill)
{
	interface* i;
	i = (interface*) malloc(sizeof(interface));
	i->xedge=xedge;
	i->zedge=zedge;
	i->sfill[0]=sfill[0];
	i->sfill[1]=sfill[1];
	i->sfill[2]=sfill[2];
	return i;
}

void printInterface(interface* i){

	int tam = (int) (sizeof(i->xedge)/sizeof(i->xedge[0]));
	int j;

	/* Print xedge */
	printf("xedge=");
	for(j=0;j<tam-1;j++){
		printf("%.2f,",i->xedge[j]);
	}

	j++;
	printf("%.2f\n",i->xedge[j]);

	/* Print zedge */
	printf("zedge=");
	for(j=0;j<tam-1;j++){
		printf("%.2f,",i->zedge[j]);
	}

	j++;
	printf("%.2f\n",i->zedge[j]);

	/* Print sedge */
	printf("sedge=");
	for(j=0;j<tam-1;j++){
		printf("0,");
	}

	j++;
	printf("0\n");

}
