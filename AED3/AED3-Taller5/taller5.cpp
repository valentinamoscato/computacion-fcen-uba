#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

int main() {
    long long n;
    while (cin >> n && n != 0) {
        vector<long long> a(n);
        for (long long& ai : a) cin >> ai; // Leer el input

        long long work = 0, balance = 0; // Inicializar balance y costo (work)
        for (long long i = 0; i < n; ++i) {
            balance += a[i]; // Actualizar balance con la cantidad de botellas de cada habitante
            work += abs(balance); // Actualizar costo con el valor absoluto del balance
            // Ya que el costo de trabajo de transportar una botella es igual para comprar o para vender
        }

        cout << work << endl;
    }

    return 0;
}
