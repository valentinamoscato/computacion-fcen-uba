Dos vecinos que tienen una casa del árbol inventaron un juego donde uno de ellos le comunica al otro por un telefóno en lata, es decir 2 latas y un hilo que las conecta, una secuencia de instrucciones. El otro vecino mueve un muñeco en un tablero de posiciones a medida que recibe la secuencia de instrucciones.

Es un juego cooperativo, con lo cual, ambos ganan si el muñeco se encuentra efectivamente en la posición correcta luego de realizar todos los movimientos y pierden si no lo hace. Las instrucciones son las siguientes:

- Un ‘+’ que se traduce a avanzar una posición.
- Un ‘-’ que se traduce a retroceder una posición.

El problema es que la comunicación por lata no es de la mejor calidad. Cada vez que el vecino que comunica dice una instrucción pueden pasar tres cosas:

- Que el otro vecino escuche correctamente, en cuyo caso hace el movimiento adecuado
- Que el otro vecino escuche la instrucción opuesta, en cuyo caso mueve el muñeco en la dirección opuesta
- Que el otro vecino no logre reconocer la instrucción, en cuyo caso mueve al azar, con una probabilidad de 0.5 de mover en cada dirección.

Como ambos son apasionados de la probabilidad se propusieron estudiarla en su juego. Con lo cual, quieren saber, dada la secuencia de instrucciones dictada y la recibida ¿Cuál es la probabilidad de que el muñeco se encuentre en la posición correcta?

**Input**
La primera línea de la entrada es un string 𝑠1 que representa la secuencia de instrucciones originalmente dictada. Está compuesta por caracteres ‘+’ y ‘-’.

La segunda línea de la entrada es otro string 𝑠2 que representa la secuencia de instrucciones recibida. Está compuesta por caracteres ‘+’, ‘-’ y ‘?’. Donde ‘?’ denota la instrucción no reconocida.

La longitud de los strings no excede los 10 caracteres

**Output**
La salida debe ser un número real correspondiente a la probabilidad pedida. La respuesta será considerada correcta si su error relativo o absoluto no excede 10^9
