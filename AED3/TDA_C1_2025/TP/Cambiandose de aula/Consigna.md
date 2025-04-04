Tu facultad es una grilla de 𝑛×𝑚 aulas cuadradas, y tenés que moverte del aula en la esquina noroeste(esquina superior izquierda en el mapa) al aula de la esquina sureste (esquina inferior derecha en el mapa).
Como sos una persona muy eficiente, siempre hacés el recorrido pasando por la mínima cantidad de aulas posibles para llegar del aula inicial a la final.

Hay ciertas aulas donde hace frío y ciertas aulas donde hace calor. Para mantenerte templado, querés pasar por la misma cantidad de aulas frías y calientes. Tenés que escribir un programa que decida si es posible hacerlo.

**Input**
La primera línea de la entrada es un número que dice cuántos casos de prueba hay.

Luego, por cada caso de prueba hay una línea con dos números enteros (𝑛 y 𝑚) que representan el tamaño de la grilla de aulas, seguida de 𝑛 líneas cada una con 𝑚 enteros que dicen si el aula correspondiente es fría (-1) or si es caliente (1). Las 𝑛 líneas de 𝑚 enteros cada una representan la grilla de 𝑛×𝑚.

Se garantiza que la cantidad total de aulas sobre todos los casos de prueba es a lo sumo 10^6.

**Output**
Para cada caso de prueba, tenés que printear "YES" si es posible hacer lo que se te pide y "NO" sino.

**Example**
Input:
2
3 4
1 -1 -1 -1
-1 1 1 -1
1 1 1 -1
1 2
1 1

Output:
YES
NO
