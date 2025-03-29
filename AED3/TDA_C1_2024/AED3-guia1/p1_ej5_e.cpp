#include <iostream>
#include <vector>
#include <tuple>
#include <limits>

using namespace std;

// Complejidad: O(n*c)

tuple<int, int> cc(int B[], int n, int c, vector<vector<tuple<int, int>>>& memo) {
    if (c == 0 || c < B[0]) {
        return make_tuple(B[0], 1); // No se puede pagar menos de un billete
    } else {
        if (get<0>(memo[n][c]) != -1) { // Si ya calculó el valor para este par de parámetros, retornar el valor almacenado
            return memo[n][c];
        }
        int min_cost = numeric_limits<int>::max(); // Costo mínimo
        int min_bills = numeric_limits<int>::max(); // Cantidad de billetes mínima
        for (int i = 0; i < n; ++i) { // Recorrer los billetes
            if (B[i] <= c) { // Si el billete es menor o igual al costo
                tuple<int, int> t = cc(B + i + 1, n - i - 1, c - B[i], memo); // Llamada recursiva, se le pasa el arreglo de billetes a partir del billete actual, la cantidad de billetes restantes y el costo restante
                int cost = B[i] + get<0>(t); // Costo total
                int bills = 1 + get<1>(t); // Cantidad de billetes
                if (cost < min_cost || (cost == min_cost && bills < min_bills)) { // Si el costo es menor o la cantidad de billetes es menor
                    min_cost = cost; // Actualizar costo mínimo
                    min_bills = bills; // Actualizar cantidad de billetes mínima
                }
            }
        }
        memo[n][c] = make_tuple(min_cost, min_bills); // Almacenar el valor calculado en la matriz de memoización
        return memo[n][c]; // Retornar costo mínimo y cantidad de billetes mínima
    }
}

int main() {
    int n, c;
    cin >> n >> c;
    int B[n];
    for (int i = 0; i < n; ++i) {
        cin >> B[i];
    }
    vector<vector<tuple<int, int>>> memo(n + 1, vector<tuple<int, int>>(c + 1, make_tuple(-1, -1))); // Inicializar la matriz de memoización
    tuple<int, int> result = cc(B, n, c, memo);
    cout << "Min cost: " << get<0>(result) << ", Min bills: " << get<1>(result) << endl;
    return 0;
}
