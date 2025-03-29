#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <unordered_set>
#include <unordered_map>
#include <algorithm>

using namespace std;

// Function to calculate the number of rolls needed to transition from 'current' to 'target'
int calculateRolls(const string& current, const string& target) {
    int rolls = 0;
    for (int i = 0; i < 4; ++i) {
        int digit_current = current[i] - '0';
        int digit_target = target[i] - '0';
        int roll_up = (digit_target - digit_current + 10) % 10;
        int roll_down = (digit_current - digit_target + 10) % 10;
        rolls += min(roll_up, roll_down);
    }
    return rolls;
}

// Function to find the minimum number of rolls needed to unlock all keys using Prim's algorithm
int minRollsToUnlock(vector<string>& keys) {
    int n = keys.size();
    vector<vector<int>> graph(n, vector<int>(n, 0));
    
    // Create the graph with the roll counts between each pair of keys
    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            int rolls = calculateRolls(keys[i], keys[j]);
            graph[i][j] = rolls;
            graph[j][i] = rolls;
        }
    }
    
    vector<bool> inMST(n, false);
    vector<int> key(n, INT_MAX);
    key[0] = 0;
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({0, 0});
    int total_rolls = 0;

    while (!pq.empty()) {
        int u = pq.top().second;
        pq.pop();

        if (inMST[u]) continue;
        inMST[u] = true;
        total_rolls += key[u];

        for (int v = 0; v < n; ++v) {
            if (!inMST[v] && graph[u][v] < key[v]) {
                key[v] = graph[u][v];
                pq.push({key[v], v});
            }
        }
    }

    // Calculate rolls from 0000 to the closest key
    int min_initial_rolls = INT_MAX;
    for (int i = 0; i < n; ++i) {
        min_initial_rolls = min(min_initial_rolls, calculateRolls("0000", keys[i]));
    }
    
    return total_rolls + min_initial_rolls;
}

int main() {
    int T;
    cin >> T;

    for (int t = 0; t < T; ++t) {
        int N;
        cin >> N;

        vector<string> keys(N);
        for (int i = 0; i < N; ++i) {
            cin >> keys[i];
        }

        int result = minRollsToUnlock(keys);
        cout << result << endl;
    }

    return 0;
}
