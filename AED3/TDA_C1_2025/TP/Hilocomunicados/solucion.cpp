#include <string>
#include <iostream>
using namespace std;

double potencia(double b, int e) { // Potencia (para exponentes positivos)
    if (e == 0) {
        return 1;
    } else {
        return b * potencia(b, e - 1);
    }
}

// Calcular la cantidad de aciertos posibles en base a la diferencia entre los movimientos
// de las soluciones dictada y recibida, y la cantidad de movimientos aleatorios
long long aciertos(int dif, int k) {
    if (k == 0) {
       return dif == 0 ? 1 : 0;
    } else if (k > 0) {
        return aciertos(dif - 1, k - 1) + aciertos(dif + 1, k - 1);
    }
}

double probabilidadDePosicionCorrecta(string secuenciaDictada, string secuenciaRecibida) {
    int longitud = secuenciaDictada.length();
    int longitudRecibida = secuenciaRecibida.length();
    
    if (longitud != longitudRecibida) {
        return 0.0; // Si las secuencias no tienen la misma longitud, la probabilidad es 0
    }

    int cantidadDeMovimientosAdelante[2] = {0,0}; // Cantidad de +
    int cantidadDeMovimientosAtras[2] = {0,0}; // Cantidad de -
    double cantidadDeMovimientosAleatorios = 0.0; // Cantidad de ? en la secuencia recibida
    double probabilidad = 0.0;
    // La primera posicion es la cantidad de movimientos adelante de la secuencia dictada y la segunda la de la secuencia recibida

    // Cuento la cantidad de +, - y ? en ambas secuencias
    for (int i = 0; i < longitud; i++) {
        if (secuenciaDictada[i] == '+') {
            cantidadDeMovimientosAdelante[0]++;
        } else if (secuenciaDictada[i] == '-') {
            cantidadDeMovimientosAtras[0]++;
        }
        if (secuenciaRecibida[i] == '+') {
            cantidadDeMovimientosAdelante[1]++;
        } else if (secuenciaRecibida[i] == '-') {
            cantidadDeMovimientosAtras[1]++;
        }
        if (secuenciaRecibida[i] == '?') {
            cantidadDeMovimientosAleatorios++;
        }
    }

    // Podas: si las secuencias son iguales, la probabilidad es 1.0
    // Si son distintas y no hay movimientos aleatorios, la probabilidad es 0.0

    bool noHayMovimientosAleatorios = cantidadDeMovimientosAleatorios == 0;
    bool sonSecuenciasEquivalentes = noHayMovimientosAleatorios && cantidadDeMovimientosAdelante[0] == cantidadDeMovimientosAdelante[1] && cantidadDeMovimientosAtras[0] == cantidadDeMovimientosAtras[1];

    if (sonSecuenciasEquivalentes) {
        probabilidad = 1.0;
        return probabilidad;
    } else if (noHayMovimientosAleatorios && !sonSecuenciasEquivalentes) {
        probabilidad = 0.0;
        return probabilidad;
    } else {
        // Si no se cumple ninguna de estas condiciones, se calcula la probabilidad
        // La probabilidad de que la secuencia recibida sea correcta es igual a la cantidad de
        // secuencias posibles que coincidan con la secuencia dictada, dividido por la cantidad de secuencias posibles
        // que se pueden formar con los movimientos aleatorios
        long long movimientosFinalesPosibles = potencia(2.0, cantidadDeMovimientosAleatorios);
        // Calcular la cantidad de secuencias posibles que coincidan con la secuencia dictada es
        // equivalente a calcular la cantidad de formas de llegar a la diferencia (dif) entre los movimientos
        // de la secuencia dictada (n) y la secuencia recibida (m) sumando o restando 1 tantas veces
        // como movimientos aleatorios haya (k)
        int n = cantidadDeMovimientosAdelante[0] - cantidadDeMovimientosAtras[0];
        int m = cantidadDeMovimientosAdelante[1] - cantidadDeMovimientosAtras[1];
        int dif = n - m;
        int k = cantidadDeMovimientosAleatorios;
        long long cantidadDeAciertos = aciertos(dif, k);
        probabilidad = (double)cantidadDeAciertos / (double)movimientosFinalesPosibles;
        return probabilidad;
    }
}

int main() {
    string secuenciaDictada;
    string secuenciaRecibida;

    std::cin >> secuenciaDictada;
    std::cin >> secuenciaRecibida;
    
    double probabilidad = probabilidadDePosicionCorrecta(secuenciaDictada, secuenciaRecibida);
    cout << probabilidad << endl;

    return 0;
}
