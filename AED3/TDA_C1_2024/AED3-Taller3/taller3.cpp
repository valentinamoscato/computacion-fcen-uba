#include <iostream>
#include <vector>
#include <algorithm>

#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// IDEA
// El concepto es lograr que JJ se suba un arbol en el area con mayor densidad de bellotas
// Para cada arbol i, hay una cantidad de bellotas en cada altura j (entre 1 y h)
// JJ arranca en una posicion (i, h) y tiene dos opciones: seguir bajando por el mismo arbol o saltar a otro
// Necesitamos tomar el maximo beneficio en bellotas dentro de esas posibilidades
// Inicialmente, decidiendo a cual de los arboles subir

// Podemos guardar la cantidad de bellotas en un arbol i a altura j en un vector de matrices acorns[t][h]
// Donde acorns[i][j] = cantidad de bellotas en el arbol i a la altura j
// Luego, podemos guardar el beneficio maximo de subir a un arbol i en una matriz dp[t][h]
// y el mejor beneficio en cada altura en un vector best[h]
// Finalmente, el resultado sera el maximo beneficio de subir a un arbol i (entre 0 y t) a la altura h es el valor en best[h]

// O(t * h)

struct Dataset {
    int trees;
    int height;
    int flyHeight;
    vector<vector<int>> acorns;
};

int maxAcorns(int t, int h, int f, vector<vector<int> > acorns, vector<vector<int> > &dp, vector<int> &best) {
    for (int i = 1; i <= h; ++i) { // For each height
        for(int j = 0; j < t; ++j) { // For each tree
            dp[j][i] = acorns[j][i] + max(dp[j][i - 1], (i - f >= 0 ? best[i - f] : 0)); // Calculate the maximum acorns
            best[i] = max(best[i], dp[j][i]); // Update the best acorns for the current height
        }
    }
    return best[h];
};

int main() {
    int c;
    while (cin >> c && c != 0) {
        vector<Dataset> datasets(c);

        // Read datasets
        for (int i = 0; i < c; ++i) {
            cin >> datasets[i].trees >> datasets[i].height >> datasets[i].flyHeight;
            datasets[i].acorns.resize(datasets[i].trees, vector<int>(datasets[i].height + 1, 0));

            for (int j = 0; j < datasets[i].trees; ++j) {
                int numAcorns;
                cin >> numAcorns;
                for (int k = 0; k < numAcorns; ++k) {
                    int height;
                    cin >> height;
                    datasets[i].acorns[j][height]++;
                }
            }
        }

        // Calculate results
        vector<int> results;
        for (const auto& dataset : datasets) {
            vector<vector<int>> dp(dataset.trees, vector<int>(dataset.height + 1, -1)); // DP matrix
            vector<int> best(dataset.height + 1, 0); // Best acorns for each height
            int maxValue = maxAcorns(dataset.trees, dataset.height, dataset.flyHeight, dataset.acorns, dp, best);
            results.push_back(maxValue);
        }

        // Print results
        for (int i = 0; i < c; ++i) {
            cout << results[i] << endl;
        }
    }

    return 0;
}
