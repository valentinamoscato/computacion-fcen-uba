#include <iostream>
#include <tuple>
#include <limits>

// Complejidad: O(n^2)

std::tuple<int, int> cc(int B[], int n, int c) {
    if (c == 0 || c < B[0]) {
        return std::make_tuple(B[0], 1); // No se puede pagar menos de un billete
    } else {
        int min_cost = std::numeric_limits<int>::max(); // Costo mínimo
        int min_bills = std::numeric_limits<int>::max(); // Cantidad de billetes mínima
        for (int i = 0; i < n; ++i) { // Recorrer los billetes
            if (B[i] <= c) { // Si el billete es menor o igual al costo
                std::tuple<int, int> t = cc(B + i + 1, n - i - 1, c - B[i]); // Llamada recursiva, se le pasa el arreglo de billetes a partir del billete actual, la cantidad de billetes restantes y el costo restante
                int cost = B[i] + std::get<0>(t); // Costo total
                int bills = 1 + std::get<1>(t); // Cantidad de billetes
                if (cost < min_cost || (cost == min_cost && bills < min_bills)) { // Si el costo es menor o la cantidad de billetes es menor
                    min_cost = cost; // Actualizar costo mínimo
                    min_bills = bills; // Actualizar cantidad de billetes mínima
                }
            }
        }
        return std::make_tuple(min_cost, min_bills); // Retornar costo mínimo y cantidad de billetes mínima
    }
}

int main() {
    int n, c;
    std::cin >> n >> c;
    int B[n];
    for (int i = 0; i < n; ++i) {
        std::cin >> B[i];
    }
    std::tuple<int, int> result = cc(B, n, c);
    std::cout << "Min cost: " << std::get<0>(result) << ", Min bills: " << std::get<1>(result) << std::endl;
    return 0;
}
