#include <iostream>
#include <vector>
#include <unordered_map>
using namespace std;

// i, j es la posicion del mapa
// matriz es el mapa
// sumaDeTemperatura es la suma de temperaturas acumulada para el recorrido
// memo es la matriz para memoizacion
bool esPosible(int i, int j, vector<vector<int> >& matriz, int sumaDeTemperatura, vector<vector<unordered_map<int, bool> > >& memo) {
    bool fueraDelMapa = i < 0 || i >= matriz.size() || j < 0 || j >= matriz[0].size();

    if (fueraDelMapa) {
        return false;
    }
    
    // Uso find y end porque guardo las sumas de temperaturas en un unordered_map
    bool estaMemoizado = memo[i][j].find(sumaDeTemperatura) != memo[i][j].end();
    if (estaMemoizado) {
        return memo[i][j][sumaDeTemperatura]; // Retorno el resultado memoizado ya calculado
    }

    bool esFinalDelMapa = i == matriz.size() - 1 && j == matriz[0].size() - 1;
    if (esFinalDelMapa) {
        int sumaFinal = sumaDeTemperatura + matriz[i][j];
        bool resultado = (sumaFinal == 0);
        memo[i][j][sumaDeTemperatura] = resultado;
        return resultado;
    }

    int pasosRestantes = (matriz.size() - 1 - i) + (matriz[0].size() - 1 - j);

    int sumaConTemperaturaDeCeldaActual = sumaDeTemperatura + matriz[i][j];

    // Poda: La suma actual es muy grande o muy chica, no es posible y retorno false
    int maxSumaPosible = sumaConTemperaturaDeCeldaActual + pasosRestantes; // Si son todos 1
    int minSumaPosible = sumaConTemperaturaDeCeldaActual - pasosRestantes; // Si son todos -1
    
    if (maxSumaPosible < 0 || minSumaPosible > 0) {
        memo[i][j][sumaDeTemperatura] = false;
        return false;
    }

    // Movimientos hacia abajo y derecha (no contemplo izquierda o arriba porque el camino debe ser minimo)
    bool resultado = esPosible(i + 1, j, matriz, sumaConTemperaturaDeCeldaActual, memo) || 
                    esPosible(i, j + 1, matriz, sumaConTemperaturaDeCeldaActual, memo);

    memo[i][j][sumaDeTemperatura] = resultado;

    return resultado;
}

int main() {
    int casosDePrueba;
    cin >> casosDePrueba;

    while (casosDePrueba--) {
        int n, m;
        cin >> n >> m;

        vector<vector<int> > matriz(n, vector<int>(m));
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                cin >> matriz[i][j];
            }
        }

        // Poda: Si la suma de las dimensiones es impar, no es posible y directamente retorno NO
        if ((n + m - 1) % 2 != 0) {
            cout << "NO" << endl;
            continue;
        }

        // Inicializo la matriz para memoización
        // La matriz sigue la misma estructura que la matriz del mapa pero guarda un unordered_map para cada celda
        // con la suma de temperatura acumulada como key y un bool que representa si es posible llegar al final
        // con esa suma de temperatura
        vector<vector<unordered_map<int, bool> > > memo(n, vector<unordered_map<int, bool> >(m));
        
        if (esPosible(0, 0, matriz, 0, memo)) {
            cout << "YES" << endl;
        } else {
            cout << "NO" << endl;
        }
    }

    return 0;
}
