extern malloc

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - es_indice_ordenado
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - indice_a_inventario
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ITEM_NOMBRE EQU 0
ITEM_FUERZA EQU 20
ITEM_DURABILIDAD EQU 24
ITEM_SIZE EQU 28

;; La funcion debe verificar si una vista del inventario está correctamente 
;; ordenada de acuerdo a un criterio (comparador)

;; bool es_indice_ordenado(item_t** inventario, uint16_t* indice, uint16_t tamanio, comparador_t comparador);

;; Dónde:
;; - `inventario`: Un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice`: El arreglo de índices en el inventario que representa la vista.
;; - `tamanio`: El tamaño del inventario (y de la vista).
;; - `comparador`: La función de comparación que a utilizar para verificar el
;;   orden.
;; 
;; Tenga en consideración:
;; - `tamanio` es un valor de 16 bits. La parte alta del registro en dónde viene
;;   como parámetro podría tener basura.
;; - `comparador` es una dirección de memoria a la que se debe saltar (vía `jmp` o
;;   `call`) para comenzar la ejecución de la subrutina en cuestión.
;; - Los tamaños de los arrays `inventario` e `indice` son ambos `tamanio`.
;; - `false` es el valor `0` y `true` es todo valor distinto de `0`.
;; - Importa que los ítems estén ordenados según el comparador. No hay necesidad
;;   de verificar que el orden sea estable.

global es_indice_ordenado
es_indice_ordenado:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = item_t**     inventario
	; rsi = uint16_t*    indice
	; rdx = uint16_t     tamanio
	; rcx = comparador_t comparador
	push rbp
	mov rbp, rsp
	push rbx
	push r12 ; alineado
	push r13
	push r14 ; alineado
	push r15
	sub rsp, 8 ; alineado

	; preservo los registros asi en los calls no hay kilombo
	mov rbx, rdi; rbx = inventario
	mov r12, rsi; r12 = indice
	mov r14, rcx; r14 = comparador
	mov r13, rdx;
	dec r13 ;r13 = tamanio - 1

	xor r15, r15 ; r15 = i (inicializado en 0)
.ciclo:
	cmp r15w, r13w ; i = tamanio -1?
	je .igual
	xor rdi, rdi
	mov di, [r12 + r15*2] ; rdi = indice[i]
	mov rdi, [rbx + rdi*8]

	xor rsi,rsi ; just in case dejo todo en 0
	inc r15
	mov si, [r12 + r15*2] ; rdi = indice[i+1]
	dec r15
	mov rsi, [rbx + rsi*8] ; rdi = inventario[indice[i + 1]];
	call r14 ;comparo
	cmp al, 0 ; es false?
	je .notIgual
	inc r15
	jmp .ciclo
	
.notIgual:
	xor rax,rax ; devuelvo 0 (false)
	jmp .termino
.igual:
	mov rax, 1 ; devuelvo 1 (true)
.termino:
	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

;; Dado un inventario y una vista, crear un nuevo inventario que mantenga el
;; orden descrito por la misma.

;; La memoria a solicitar para el nuevo inventario debe poder ser liberada
;; utilizando `free(ptr)`.

;; item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio);

;; Donde:
;; - `inventario` un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice` es el arreglo de índices en el inventario que representa la vista
;;   que vamos a usar para reorganizar el inventario.
;; - `tamanio` es el tamaño del inventario.
;; 
;; Tenga en consideración:
;; - Tanto los elementos de `inventario` como los del resultado son punteros a
;;   `ítems`. Se pide *copiar* estos punteros, **no se deben crear ni clonar
;;   ítems**

global indice_a_inventario
indice_a_inventario:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = item_t**  inventario
	; rsi = uint16_t* indice
	; dx = uint16_t  tamanio
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14 ; alineado

	; preservo parametros
	mov rbx, rdi ; rbx = inventario
	mov r12, rsi ; r12 = indice
	mov r13w, dx ; r13w = tamanio

	xor r14,r14 ; r14 = i

	xor rdi, rdi 
	mov di, r13w
	imul di, ITEM_SIZE 
	call malloc ; rax = resultado

.ciclo:
	cmp r14w, r13w
	je .termino
	xor rsi,rsi
	mov si, [r12 + r14*2] ; rsi = indice[i]
	mov rsi, [rbx + rsi*8] ; rsi = inventario[inidice[i]]
	mov [rax + r14*8], rsi ; resultado[i] = inventario[indice[i]];
	inc r14
	jmp .ciclo

.termino:
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
