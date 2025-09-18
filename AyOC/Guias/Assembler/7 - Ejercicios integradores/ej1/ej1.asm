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
ITEM_NOMBRE EQU 0 ; 18 bytes (2 padding)
ITEM_FUERZA EQU 20 ; 4 bytes (0 padding)
ITEM_DURABILIDAD EQU 24 ; 2 bytes (2 padding)
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

	; prologo
	push rbp
	mov rbp, rsp

	;  preservo 5 registros no volatiles para usar para inventario, indice, comparador, tamanio y variable de control del ciclo
	push rbx
	push r12 ; alineado
	push r13
	push r14 ; alineado
	push r15
	sub rsp, 8 ; alineado

	; preservo los registros pasados por parametro para prevenir conflictos en el call
	mov rbx, rdi; rbx = inventario
	mov r12, rsi; r12 = indice
	mov r14, rcx; r14 = comparador
	mov r13, rdx;
	dec r13 ;r13 = tamanio - 1

	xor r15, r15 ; r15 = i (inicializado en 0)

.ciclo:
	cmp r15w, r13w ; i = tamanio -1?, w es porque son uint16_t
	je .igual ; settear retorno a TRUE

	xor rdi, rdi ; rdi = 0 (por las dudas)
	mov di, [r12 + r15*2] ; rdi = indice[i] (el i-esimo indice), di es porque son uint16_t
	mov rdi, [rbx + rdi*8] ; rdi = inventario[indice[i]]

	xor rsi, rsi ; rsi = 0 (por las dudas)
	inc r15 ; i = i+1 - incrementar i para acceder al siguiente indice
	mov si, [r12 + r15*2] ; rdi = indice[i+1] (el (i+1)-esimo indice), si es porque son uint16_t
	dec r15 ; i = i - restaurar i
	mov rsi, [rbx + rsi*8] ; rdi = inventario[indice[i + 1]]

	call r14 ; comparar los dos items

	cmp al, FALSE ;
	je .notIgual ; settear retorno a FALSE 

	inc r15 ; i++
	jmp .ciclo
	
.notIgual:
	xor rax,rax ; retornar 0 (FALSE)
	jmp .fin

.igual:
	mov rax, TRUE ; retornar TRUE

; epilogo
.fin:
	add rsp, 8 ; restaurar el stack
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

; CONCLUSIONES PRINCIPALES: tenia que preservar los registros no volatiles, y no complicar el acceso a los indices (la proxima, dibujarlo)

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
	; prologo
	push rbp ; alineado
	mov rbp, rsp

	push rbx
	push r12 ; alineado
	push r13 
	push r14 ; alineado

	mov rbx, rdi ; rbx = inventario
	mov r12, rsi ; r12 = indice
	mov r13w, dx ; r13w = tamanio
	
	xor rdi, rdi ; limpiar rdi
	mov di, r13w ; di = tamanio
	imul di, ITEM_SIZE ; di = tamanio*ITEM_SIZE
	call malloc ; rax = resultado - alocar memoria para el nuevo inventario

	xor r14,r14 ; r14 = i

	.ciclo:
		cmp r14w, r13w ; i < tamanio
		je .fin

		xor rsi, rsi ; limpiar rsi

		mov si, [r12 + r14*2] ; rsi = [indice + i*2] = indice[i]
		mov rsi, [rbx + rsi*8] ; rsi = [inventario + (indice + i*2)*8] = inventario[inidice[i]]
		mov [rax + r14*8], rsi ; resultado[i] = inventario[indice[i]] - [resultado + i*8] = inventario[indice[i]] (en rsi)

		inc r14 ; i++
		jmp .ciclo

	.fin:
		; epilogo
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret
