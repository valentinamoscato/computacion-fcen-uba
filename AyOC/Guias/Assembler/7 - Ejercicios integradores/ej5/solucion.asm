; Definiciones comunes
TRUE  EQU 1
FALSE EQU 0

; Identificador del jugador rojo
JUGADOR_ROJO EQU 1
; Identificador del jugador azul
JUGADOR_AZUL EQU 2

; Ancho y alto del tablero de juego
tablero.ANCHO EQU 10
tablero.ALTO  EQU 5

; Marca un OFFSET o SIZE como no completado
; Esto no lo chequea el ABI enforcer, sirve para saber a simple vista qué cosas
; quedaron sin completar :)
NO_COMPLETADO EQU -1

extern strcmp

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
carta.en_juego EQU 0
carta.nombre   EQU 1
carta.vida     EQU 14
carta.jugador  EQU 16
carta.SIZE     EQU 18

tablero.mano_jugador_rojo EQU 0
tablero.mano_jugador_azul EQU 8
tablero.campo             EQU 16
tablero.SIZE              EQU 416

accion.invocar   EQU 0
accion.destino   EQU 8
accion.siguiente EQU 16
accion.SIZE      EQU 24

; Variables globales de sólo lectura
section .rodata

; Marca el ejercicio 1 como hecho (true) o pendiente (false).
;
; Funciones a implementar:
;   - hay_accion_que_toque
global EJERCICIO_1_HECHO
EJERCICIO_1_HECHO: db TRUE

; Marca el ejercicio 2 como hecho (true) o pendiente (false).
;
; Funciones a implementar:
;   - invocar_acciones
global EJERCICIO_2_HECHO
EJERCICIO_2_HECHO: db TRUE

; Marca el ejercicio 3 como hecho (true) o pendiente (false).
;
; Funciones a implementar:
;   - contar_cartas
global EJERCICIO_3_HECHO
EJERCICIO_3_HECHO: db TRUE

section .text

; Dada una secuencia de acciones determinar si hay alguna cuya carta tenga un
; nombre idéntico (mismos contenidos, no mismo puntero) al pasado por
; parámetro.
;
; El resultado es un valor booleano, la representación de los booleanos de C es
; la siguiente:
;   - El valor 0 es false
;   - Cualquier otro valor es true
;
; c
; bool hay_accion_que_toque(accion_t* accion, char* nombre);
; 
global hay_accion_que_toque
hay_accion_que_toque:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = accion_t*  accion
	; rsi = char*      nombre
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14 ; prologo
	sub rsp, 8 ; alineacion a pila
	xor rax, rax ; rax = 0
	mov r12, rdi ; r12 = puntero a accion
	mov r13, rsi ; r13 = puntero a nombre
	mov r14, FALSE ; r14 = FALSE

	.ciclo: ; while
		cmp r12,0 ; puntero a null, termino el ciclo
		je .fin
		mov rdi, [r12 + accion.destino] ; rdi = puntero a carta destino
		add rdi, carta.nombre ; rdu = puntero al nombre de la carta destino
		mov rsi, r13 ; rsi = puntero al nombre de carta buscado
		call strcmp
		cmp eax, 0 ; son iguales
		jne .siguiente
		mov r14, TRUE
		jmp .fin

	.siguiente:
		mov r12, [r12 + accion.siguiente] ; r12 = siguiente accion
		jmp .ciclo

	.fin:
		mov rax, r14 ; devuelvo el resultado en rax
		add rsp, 8
		pop r14 ; epilogo
		pop r13
		pop r12
		pop rbp
		ret

; Invoca las acciones que fueron encoladas en la secuencia proporcionada en el
; primer parámetro.
;
; A la hora de procesar una acción esta sólo se invoca si la carta destino
; sigue en juego.
;
; Luego de invocar una acción, si la carta destino tiene cero puntos de vida,
; se debe marcar ésta como fuera de juego.
;
; Las funciones que implementan acciones de juego tienen la siguiente firma:
; c
; void mi_accion(tablero_t* tablero, carta_t* carta);
; 
; - El tablero a utilizar es el pasado como parámetro
; - La carta a utilizar es la carta destino de la acción (accion->destino)
;
; Las acciones se deben invocar en el orden natural de la secuencia (primero la
; primera acción, segundo la segunda acción, etc). Las acciones asumen este
; orden de ejecución.
;
; c
; void invocar_acciones(accion_t* accion, tablero_t* tablero);
; 
global invocar_acciones
invocar_acciones:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = accion_t*  accion
	; rsi = tablero_t* tablero
	push rbp
	mov rbp, rsp 
	push r12
	push r13 ; prologo
	mov r12, rdi ; lista de acciones
	mov r13, rsi ; tablero

	.ciclo:
		cmp r12, 0
		je .fin
		mov r8, [r12 + accion.destino] ; r8 = puntero a carta
		cmp BYTE [r8 + carta.en_juego], FALSE ; veo si la carta esta en juego
		je .siguiente
		mov rdi, r13 ; puntero al tablero
		mov rsi, r8 ; puntero a la carta actual
		call [r12 + accion.invocar] ; llamo a la funcion
		mov r8, [r12 + accion.destino] ; r8 = puntero a la carta destino
		cmp WORD [r8 + carta.vida], FALSE ; veo si la carta sigue teniendo vida
		jne .siguiente ; esta viva
		mov BYTE [r8 + carta.en_juego], FALSE ; deja de estar en juego
	
	.siguiente:
		mov r12, [r12 + accion.siguiente] ; siguiente accion
		jmp invocar_acciones.ciclo ; vuelvo al ciclo

	.fin:
		pop r13 ; epilogo
		pop r12
		pop rbp
		ret

; Cuenta la cantidad de cartas rojas y azules en el tablero.
;
; Dado un tablero revisa el campo de juego y cuenta la cantidad de cartas
; correspondientes al jugador rojo y al jugador azul. Este conteo incluye tanto
; a las cartas en juego cómo a las fuera de juego (siempre que estén visibles
; en el campo).
;
; Se debe considerar el caso de que el campo contenga cartas que no pertenecen
; a ninguno de los dos jugadores.
;
; Las posiciones libres del campo tienen punteros nulos en lugar de apuntar a
; una carta.
;
; El resultado debe ser escrito en las posiciones de memoria proporcionadas
; como parámetro.
;
; c
; void contar_cartas(tablero_t* tablero, uint32_t* cant_rojas, uint32_t* cant_azules);
; 
global contar_cartas
contar_cartas:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = tablero_t* tablero
	; rsi = uint32_t*  cant_rojas
	; rdx = uint32_t*  cant_azules
	push rbp
	mov rbp, rsp ; prologo
	lea rdi, [rdi + tablero.campo] ; puntero al primer casillero
	mov DWORD [rsi], 0 ; *cant_rojas = 0
	mov DWORD [rdx], 0 ; *cant_azules = 0
	xor r9, r9 ; r9 = 0

	.ciclo:
		cmp r9, tablero.ALTO*tablero.ANCHO ; veo si recorri todos los casilleros
		je .fin
		mov r10, [rdi + r9*8] ; r10 = carta en casilla, 8 porque son punteros
		cmp r10, 0 ; comparo r10 con null
		je .siguiente ; si es null salto al siguiente

	.jugadorAzul:
		cmp BYTE [r10 + carta.jugador], JUGADOR_AZUL ; veo si la carta es del jugador azul
		jne .jugadorRojo
		inc DWORD [rdx] ; incremento el contador de cartas azules
		jmp .siguiente

	.jugadorRojo:
		cmp BYTE [r10 + carta.jugador], JUGADOR_ROJO ; veo si la carta es del jugador rojo
		jne .siguiente
		inc DWORD [rsi] ; incremento el contador de cartas rojas

	.siguiente:
		inc r9
		jmp .ciclo

	.fin:
		pop rbp ; epilogo
		ret
