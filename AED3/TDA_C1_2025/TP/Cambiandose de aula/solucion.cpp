#include <iostream>
#include <vector>
using namespace std;

int caminoMinimo = 0;

void caminoMasCorto(int i, int j, int n, int m, vector<vector<int> > matriz, int suma, int camino) {
    // Podas BT

    if (i >= n || j >= m || i < 0 || j < 0) { // Si me salgo de la matriz
        return;
    }
    

    if(i == n && j == m) { // Si llegue a la esquina inferior derecha
        if (suma == 0 && camino < caminoMinimo) { // Si es un camino valido y es el mas corto
            caminoMinimo = camino;
        }
        if (suma == 0) {
            cout << "YES" << endl;
            return;
        }
    }
    
    // Movimiento por la matriz
    if(j < m) {
        caminoMasCorto(i, j + 1, n, m, matriz, suma + matriz[i][j], camino + 1); // Moverme a la derecha
    }
    if (i < n) {
        caminoMasCorto(i + 1, j, n, m, matriz, suma + matriz[i][j], camino + 1); // Moverme hacia abajo
    }
    if (j > 0) {
        caminoMasCorto(i, j - 1, n, m, matriz, suma + matriz[i][j], camino + 1); // Moverme hacia la izquierda
    }
    cout << "NO" << endl;
}

int main() {
    int casosDePrueba = 0;

    std::cin >> casosDePrueba;

    int n = 0;
    int m = 0;

    std::cin >> n;
    std::cin >> m;
    
    vector<vector<int> > matriz(n, vector<int>(m));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            std::cin >> matriz[i][j];
        }
    }

    caminoMasCorto(0, 0, n, m, matriz, 0, 0); // Llamada inicial

    return 0;
}
