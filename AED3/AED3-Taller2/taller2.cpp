#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// IDEA
// Para cada edificio i
// Revisa cada edificio j antes de i
// Si el edificio j es más bajo que el edificio i
// Chequea si el ancho de j + el ancho de i es mayor que el valor actual de lis[i]
// Si es así, actualiza lis[i]
// Si el edificio j es más alto que el edificio i
// Chequea si el ancho de j + el ancho de i es mayor que el valor actual de lds[i]
// Si es así, actualiza lds[i]
// Finalmente, el valor máximo de lis y lds es la respuesta

int main() {
    int T;
    cin >> T; // Number of test cases
    for (int t = 1; t <= T; t++) {
        int N;
        cin >> N; // Number of buildings
        vector<int> height(N), width(N), lis(N), lds(N);  // lis: Longest Increasing Subsequence, lds: Longest Decreasing Subsequence
        for (int i = 0; i < N; i++)
            cin >> height[i]; // Height of the ith building
        for (int i = 0; i < N; i++)
            cin >> width[i]; // Width of the ith building
        for (int i = 0; i < N; i++) {
            lis[i] = lds[i] = width[i]; // Initialize lis and lds with the width of the ith building
            for (int j = 0; j < i; j++) { // For each of the previous buildings
                if (height[j] < height[i] && lis[i] < lis[j] + width[i]) // If the jth building is shorter than the ith building and lis[j] + width[i] is greater than lis[i]
                    lis[i] = lis[j] + width[i];  // Update lis[i]
                if (height[j] > height[i] && lds[i] < lds[j] + width[i]) // If the jth building is taller than the ith building and lds[j] + width[i] is greater than lds[i]
                    lds[i] = lds[j] + width[i]; // Update lds[i]
            }
        }
        int lis_max = *max_element(lis.begin(), lis.end()); // Maximum value of lis
        int lds_max = *max_element(lds.begin(), lds.end()); // Maximum value of lds
        if (lis_max >= lds_max)
            cout << "Case " << t << ". Increasing (" << lis_max << "). Decreasing (" << lds_max << ").\n";
        else
            cout << "Case " << t << ". Decreasing (" << lds_max << "). Increasing (" << lis_max << ").\n";
    }
    return 0;
}

2
3 10 2
3 1 4 10
6 3 5 7 8 9 9
5 3 4 5 6 9
3 10 2
3 1 4 10
6 3 5 7 8 9 9
5 3 4 5 6 9
0
