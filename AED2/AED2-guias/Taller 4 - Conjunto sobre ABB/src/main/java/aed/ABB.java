package aed;

import java.util.*;

// Todos los tipos de datos "Comparables" tienen el método compareTo()
// elem1.compareTo(elem2) devuelve un entero. Si es mayor a 0, entonces elem1 > elem2
public class ABB<T extends Comparable<T>> implements Conjunto<T> {

    private class Nodo {
        T valor;
        Nodo izq;
        Nodo der;
        Nodo padre;

        public Nodo(T item) {
            valor = item;
            izq = null;
            der = null;
            padre = null;
        }
    }

    private Nodo raiz;

    public ABB() {
        raiz = null;
    }

    private int sumarRama(Nodo actual) {
        if (actual == null) {
            return 0;
        } else {
            return 1 + sumarRama(actual.izq) + sumarRama(actual.der);
        }
    }

    public int cardinal() {
        if (raiz == null) {
            return 0;
        } else {
            return sumarRama(raiz);
        }
    }

    public T minimo(){
        if (raiz == null) {
            throw new UnsupportedOperationException("No hay elementos para comparar");
        } else if (cardinal() == 1) {
            return raiz.valor;
        }
         else {
            Nodo min = raiz;
            while (min.izq != null) {
                min = min.izq;
            }
            return min.valor;
        }
    }

    public T maximo(){
        if (raiz == null) {
            throw new UnsupportedOperationException("No hay elementos para comparar");
        } else if (cardinal() == 1) {
            return raiz.valor;
        }
         else {
            Nodo max = raiz;
            while (max.der != null) {
                max = max.der;
            }
            return max.valor;
        }
    }

    private Nodo buscarRecursivo(Nodo n, T elem){
        if (n == null) {
            return null;
        } else {
            if (elem.compareTo(n.valor) < 0) {
                return buscarRecursivo(n.izq, elem);
            } else if (elem.compareTo(n.valor) > 0) {
                return buscarRecursivo(n.der, elem);
            } else {
                return n;
            }
        }
    }

    private Nodo buscar(T elem) {
        Nodo _raiz = raiz;
        return buscarRecursivo(_raiz, elem);
    }

    public boolean pertenece(T elem) {
        return buscar(elem) != null;   
    }

    private boolean noPertenece(T elem) {
        return !pertenece(elem);
    }

    public void insertar(T elem){
        if (noPertenece(elem)) {
            Nodo nuevo = new Nodo(elem);
            if (raiz == null) {
                raiz = nuevo;
            } else {
                Nodo actual = raiz;
                while (actual != null) {
                    if (elem.compareTo(actual.valor) < 0) {
                        if (actual.izq == null) {
                            actual.izq = nuevo;
                            actual.izq.padre = actual;
                            return;
                        } else {
                            actual = actual.izq;
                        }
                    } else if (elem.compareTo(actual.valor) > 0) {
                        if (actual.der == null) {
                            actual.der = nuevo;
                            actual.der.padre = actual;
                            return;
                        } else {
                            actual = actual.der;
                        }
                    } else {
                        return;
                    }
                }
            }
        }
    }

    private Nodo hallarSucesor(Nodo _nodo) {
        Nodo nodo = _nodo;
        if (nodo == null) {
            return null;
        } else {
            if (nodo.der != null) {
                Nodo actual = nodo.der;
                while (actual.izq != null) {
                    actual = actual.izq;
                }
                return actual;
            } else {
                Nodo actual = nodo.padre;
                while (actual != null && actual.der == nodo) {
                    nodo = actual;
                    actual = actual.padre;
                }
                return actual;
            }
        }
    }

    private Nodo eliminarNodo(Nodo n, T elem) {
        if (n == null) {
            return n;
        }
        if (elem.compareTo(n.valor) < 0) {
            n.izq = eliminarNodo(n.izq, elem);
            return n;
        } else if (elem.compareTo(n.valor) > 0) {
            n.der = eliminarNodo(n.der, elem);
            return n;
        }
        if (n.izq == null) {
            Nodo temp = n.der;
            return temp;
        } else if (n.der == null) {
            Nodo temp = n.izq;
            return temp;
        }
        else {
            Nodo sucPadre = n;
            Nodo suc = n.der;
            while (suc.izq != null) {
                sucPadre = suc;
                suc = suc.izq;
            }
            if (sucPadre != n)
                sucPadre.izq = suc.der;
            else
                sucPadre.der = suc.der;
            n.valor = suc.valor;
            return n;
        }
    }

    public void eliminar(T elem) {
        if (pertenece(elem)) {
            raiz = eliminarNodo(raiz, elem);
        }
    }

    private String toStringRecursivo(Nodo actual) {
        if (actual == null) {
            return "";
        } else {
            return toStringRecursivo(actual.izq) + actual.valor.toString() + "," + toStringRecursivo(actual.der);
        }
    }

    public String toString(){
        if (raiz == null) {
            return "{}";
        } else {
            String res = toStringRecursivo(raiz);
            res = "{" + res.substring(0, res.length()-1) + "}";
            return res;
        }
    }

    private class ABB_Iterador implements Iterador<T> {
        private Nodo _actual;

        public ABB_Iterador() {
            _actual = raiz;
            while (_actual.izq != null) { 
                _actual = _actual.izq;
            }
        }

        public boolean haySiguiente() {            
           return hallarSucesor(_actual) != null;
        }
    
        public T siguiente() {
            T res = _actual.valor;
            _actual = hallarSucesor(_actual);
            return res;
        }
    }

    public Iterador<T> iterador() {
        return new ABB_Iterador();
    }

}
