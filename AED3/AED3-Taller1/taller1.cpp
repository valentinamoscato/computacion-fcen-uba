#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

using namespace std;

struct Player {
    string name;
    int attack;
    int defense;
};

struct PlayerComparator {
    bool operator()(const Player& a, const Player& b) const {
        if (a.attack != b.attack) {
            return a.attack > b.attack;
        }
        if (a.defense != b.defense) {
            return a.defense < b.defense;
        }
        return a.name < b.name;
    }
};

struct NameComparator {
    bool operator()(const Player& a, const Player& b) const {
        return a.name < b.name;
    }
};

int main() {
    int T;
    cin >> T;
    for (int t = 1; t <= T; t++) {
        vector<Player> players(10);
        for (int i = 0; i < 10; i++)
            cin >> players[i].name >> players[i].attack >> players[i].defense;
        stable_sort(players.begin(), players.end(), PlayerComparator());
        vector<Player> attackers(players.begin(), players.begin() + 5);
        vector<Player> defenders(players.begin() + 5, players.end());
        sort(attackers.begin(), attackers.end(), NameComparator());
        sort(defenders.begin(), defenders.end(), NameComparator());
        cout << "Case " << t << ":\n(";
        for (int i = 0; i < 5; i++)
            cout << (i ? ", " : "") << attackers[i].name;
        cout << ")\n(";
        for (int i = 0; i < 5; i++)
            cout << (i ? ", " : "") << defenders[i].name;
        cout << ")\n";
    }
    return 0;
}
