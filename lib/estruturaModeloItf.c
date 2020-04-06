/*
* estruturaModeloItf.c (C)
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

void initInterface(){}

int main(void){
	header* h;
	h = initHeader(1,0,12,0,3.5);
	printf("kedge=%d\nxmin=%f\nxmax=%f\nzmin=%f\nzmax=%f\n",
		h->kedge,
		h->xmin,
		h->xmax,
		h->zmin,
		h->zmax);

}
