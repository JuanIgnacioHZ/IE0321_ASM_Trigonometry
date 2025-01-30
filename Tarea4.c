#include <stdio.h>
#include <math.h>
#include "Tarea4.h"

int main(){

	float a = 2;
	trigo_equis(a);

	return 0;
}

int factorial(int n){
	// Esta función calcula el factorial de la entrada n
	if (n <= 1){
		return 1;
	} else {
		return n*factorial(n-1);
	}
}

float n_pow(float x, int n){
	// Calcula la potencia de x^n
	if (n > 0){
		return x*n_pow(x, n-1);
	} else {
		return 1;
	}
}

float seno(float equis, int taylor_iter){
	float seno_de_equis = 0;
	int i;
	
	for (i=0; i<taylor_iter; i++){
		// i := n
		// Tres términos a, b, c
		// se suma a*b/c
		int a, c = 0;
		float b, seno_tmp = 0;

		// Cálculo de a = (-1)^(n)
		if (i%2 == 0){
			a = 1;
		} else {
			a = -1;
		}

		// Cálculo de b = x^(2n+1)
		b = n_pow(equis, 2*i+1);

		// Cálculo de c = (2n+1)!
		c = factorial(2*i+1);

		seno_de_equis = seno_de_equis + ((a*b)/c);
	}

	return seno_de_equis;

}

float coseno(float equis, int taylor_iter){
	float coseno_de_equis = 0;
	int i;
	
	for (i=0; i<taylor_iter; i++){
		// i := n
		// Tres términos a, b, c
		// se suma a*b/c
		int a, c = 0;
		float b, coseno_tmp = 0;

		// Cálculo de a = (-1)^(n)
		if (i%2 == 0){
			a = 1;
		} else {
			a = -1;
		}

		// Cálculo de b = x^(2n+1)
		b = n_pow(equis, 2*i);

		// Cálculo de c = (2n+1)!
		c = factorial(2*i);

		coseno_de_equis = coseno_de_equis + ((a*b)/c);
	}

	return coseno_de_equis;


}

void trigo_equis(float equis){

	int taylor_iter = 8;
	float sen_equis, cos_equis, tan_equis = 0;
	sen_equis = seno(equis, taylor_iter);
	cos_equis = coseno(equis, taylor_iter);
	tan_equis = sen_equis/cos_equis;
	printf("Para el ángulo: %f (en radianes),\nse tiene los siguientes resultados.\n", equis);
	printf("\tValor del seno del ángulo: \t\t%f\n", sen_equis);
	printf("\tValor del coseno del ángulo: \t\t%f\n", cos_equis);
	printf("\tValor de la tangente del ángulo: \t%f\n", tan_equis);
}


