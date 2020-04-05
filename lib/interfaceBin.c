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
	interface next;
};

typedef struct Model *model;

struct Model{
	float xmin;
	float xmax;
	float zmin;
	float zmax;
	interface firstInterface;
};

int main(void){

	interface *itf1;
	model *mod1;

	/* Inicializar o modelo */
	mod1 = (model*) malloc(sizeof(*mod1));

}
