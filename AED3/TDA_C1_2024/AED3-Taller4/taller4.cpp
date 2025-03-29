#include <iostream>
#include <string>
#include <unordered_map>

using namespace std;

// La idea es resolver el problema recursivamente, 
// dividiendo los strings a y b en sus dos mitades y comparando
// la primera mitad de a con la primera mitad de b y la segunda
// mitad de a con la segunda mitad de b, o la primera mitad de a
// con la segunda mitad de b y la segunda mitad de a con la primera
// mitad de b.

unordered_map<string, unordered_map<string, bool>> memo;

bool isEquivalent(string a, string b) {    
    if (a.size() != b.size()) return false; // Si las longitudes de a y b son distintas, no son equivalentes

    if (a.size() == 1) return a[0] == b[0]; // Si la longitud de a es 1, son equivalentes si a y b son iguales (comparación de caracteres)
    
    if (a.size() == 2) {
        return (a[0] == b[0] && a[1] == b[1]) || (a[0] == b[1] && a[1] == b[0]);
    }

    if (a.size() % 2 != 0) return a == b;

    if (memo.count(a) && memo[a].count(b)) return memo[a][b]; // Memoización para mejorar performance

    int mid = a.size() / 2;

    string a1 = a.substr(0, mid);
    string a2 = a.substr(mid);
    string b1 = b.substr(0, mid);
    string b2 = b.substr(mid);

    bool a1b1 = false;
    bool a1b2 = false;
    bool a2b1 = false;
    bool a2b2 = false;

    a1b1 = isEquivalent(a1, b1);

    if (a1b1) {
        a2b2 = isEquivalent(a2, b2);
    }

    if (!(a1b1 && a2b2)) {
        a1b2 = isEquivalent(a1, b2);
        if (a1b2) {
            a2b1 = isEquivalent(a2, b1);
        }
    }

    bool result = (a1b1 && a2b2) || (a1b2 && a2b1);
    memo[a][b] = result;

    return result;
}

int main() {
    string a, b;
    cin >> a >> b;
    if (isEquivalent(a, b)) {
        cout << "YES" << endl;
    } else {
        cout << "NO" << endl;
    }
    return 0;
}
