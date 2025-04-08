#include <iostream>
#include <vector>
using namespace std;

string resultado = "NO";
int caminoMinimo = INT_MAX;
unordered_map<tuple<int, int, int>, bool> memo;

int temperatura(int i, int j, vector<vector<int> >& matriz, int camino, int sumaDeTemperatura) {
    if (i < 0 || i >= matriz.size() || j < 0 || j >= matriz[0].size()) {
        return INT_MAX; // Fuera de los limites del mapa, retorno un numero grande para indicar que no es un camino valido
    }

    if (camino >= caminoMinimo) {
        return INT_MAX; // Si el camino ya es mayor al camino minimo, retorno un numero grande
    }
    
    if (i == matriz.size() - 1 && j == matriz[0].size() - 1) {
        if (sumaDeTemperatura + matriz[i][j] == 0) {
            resultado = "YES"; // Encontre un camino minimo que mantiene la temperatura en 0
            caminoMinimo = min(caminoMinimo, camino); // Actualizo el camino minimo
        }
        return camino; // Termine de recorrer el mapa
    }

    // Busco el camino mas chico entre moverme hacia abajo o hacia la derecha
    int caminoHaciaAbajo = temperatura(i + 1, j, matriz, camino + 1, sumaDeTemperatura + matriz[i][j]);
    int caminoHaciaLaDerecha = temperatura(i, j + 1, matriz, camino + 1, sumaDeTemperatura + matriz[i][j]);

    int nuevoCamino = min(caminoHaciaAbajo, caminoHaciaLaDerecha);

    return nuevoCamino;
}

int main() {
    int casosDePrueba;
    cin >> casosDePrueba;

    vector<vector<vector<int> > > mapas;
    
    while (casosDePrueba > 0) {
        int n, m;
        cin >> n >> m;

        vector<vector<int> > matriz(n, vector<int>(m));

        int i, j;
        // Inicializar la matriz con valores del input
        for (i = 0; i < n; i++) {
            for (j = 0; j < m; j++) {
                cin >> matriz[i][j];
            }
        }

        mapas.push_back(matriz);
        casosDePrueba--;
    }

    for (int k = 0; k < mapas.size(); k++) {
        vector<vector<int> > m = mapas[k];
        caminoMinimo = INT_MAX; // Reinicio el camino minimo para cada caso de prueba
        temperatura(0, 0, m, 0, 0);
        cout << resultado << endl;
        resultado = "NO"; // Reinicio el resultado para el siguiente caso de prueba
    }

    return 0;
}
