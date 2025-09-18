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
;   - optimizar
global EJERCICIO_2A_HECHO
EJERCICIO_2A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - contarCombustibleAsignado
global EJERCICIO_2B_HECHO
EJERCICIO_2B_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1C como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - modificarUnidad
global EJERCICIO_2C_HECHO
EJERCICIO_2C_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ATTACKUNIT_CLASE EQU 0
ATTACKUNIT_COMBUSTIBLE EQU 12
ATTACKUNIT_REFERENCES EQU 14
ATTACKUNIT_SIZE EQU 16

global optimizar
optimizar:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi= mapa_t           mapa
	; rsi = attackunit_t*    compartida
	; rdx = uint32_t*        fun_hash(attackunit_t*)
	; prologo
	push rbp ; alineado
	mov rbp, rsp
	push r12
	push r13 ; alineado
	push r14
	push r15 ; alineado

	mov r12, rdi ; r12 tiene el mapa
	xor r13, r13 ; i = 0
	xor r14, r14 ; j = 0

	xor r15, r15
	mov r15, rsi

	mov rdi, r15
	call rdx

	xor r15, r15
	mov r15, rax ; r15 tiene fun_hash(compartida)

	.ciclo_i:
		cmp r13, 255
		jge .fin

	.ciclo_j:
		mov rbx, r13
		imul rbx, 255
		add rbx, r14
		shl rbx, 3 ; rax = rax*8
		mov rdi, [r12 + rbx] ; rdi = r12 (base del mapa) + rax (offset)
		mov rdi, rdi
		call rdx

		cmp rax, r15
		je .siguiente_ciclo_j

		cmp rdi, rsi
		je .siguiente_ciclo_j

		mov rax, [rsi + ATTACKUNIT_REFERENCES]
		inc rax
		mov [rsi + ATTACKUNIT_REFERENCES], rax
		mov rax, [rdi + ATTACKUNIT_REFERENCES]
		inc rax
		mov [rdi + ATTACKUNIT_REFERENCES], rax
		mov [rdi], rsi

		inc r14 ; j++
		cmp r14, 255
		je .siguiente_ciclo_i

	.siguiente_ciclo_j:
		jmp .ciclo_j

	.siguiente_ciclo_i:
		inc r13 ; i++
		mov r14, 0
		jmp .ciclo_i

	.fin:
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbp
		ret

global contarCombustibleAsignado
contarCombustibleAsignado:
	; r/m64 = mapa_t           mapa
	; r/m64 = uint16_t*        fun_combustible(char*)
	ret

global modificarUnidad
modificarUnidad:
	; r/m64 = mapa_t           mapa
	; r/m8  = uint8_t          x
	; r/m8  = uint8_t          y
	; r/m64 = void*            fun_modificar(attackunit_t*)
	ret
