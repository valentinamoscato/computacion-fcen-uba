extern malloc
extern sleep
extern strcpy
extern memcpy
extern wakeup
extern calloc
extern create_dir_entry

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio
sleep_name: DB "sleep", 0
wakeup_name: DB "wakeup", 0

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - init_fantastruco_dir
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - summon_fantastruco
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
DIRENTRY_NAME_OFFSET EQU 0
DIRENTRY_PTR_OFFSET EQU 16
DIRENTRY_SIZE EQU 24

FANTASTRUCO_DIR_OFFSET EQU 0
FANTASTRUCO_ENTRIES_OFFSET EQU 8
FANTASTRUCO_ARCHETYPE_OFFSET EQU 16
FANTASTRUCO_FACEUP_OFFSET EQU 24
FANTASTRUCO_SIZE EQU 32
;
; 00[d d d d | d d d d]
; 08[e e # # | # # # #]
; 16[a a a a | a a a a]
; 24[f # # # | # # # #]

; void init_fantastruco_dir(fantastruco_t* card);
global init_fantastruco_dir
init_fantastruco_dir:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = fantastruco_t* card
	;
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	
	; rbx=rdi -> fantastruco_t*
	mov rbx, rdi

	mov rdi, 2*8 ; tamanio de dos punteros, va a ser directory_t
	call malloc
	mov r12, rax

	; aca me hago dos reservas para los directory_entry_t
	mov rdi, DIRENTRY_SIZE
	call malloc
	mov r13, rax
	;
	mov rdi, DIRENTRY_SIZE
	call malloc
	mov r14, rax
	; ----------- ;


	; Copio los literales "sleep" "wakeup" en el char[10]
	lea rdi, QWORD [r13 + DIRENTRY_NAME_OFFSET]
	lea rsi, [rel sleep_name]
	call strcpy
	
	lea rdi, QWORD [r14 + DIRENTRY_NAME_OFFSET]
	lea rsi, [rel wakeup_name]
	call strcpy
	; ----------- ;

	mov QWORD [r13 + DIRENTRY_PTR_OFFSET], sleep
	mov QWORD [r14 + DIRENTRY_PTR_OFFSET], wakeup

	; asigno card->__dir en r12.
	; tambien los direntry en el directory_t.

	mov QWORD [rbx + FANTASTRUCO_DIR_OFFSET], r12
	mov QWORD [r12 + 0], r13
	mov QWORD [r12 + 8], r14

	mov WORD [rbx + FANTASTRUCO_ENTRIES_OFFSET], 2

	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp

	ret ;No te olvides el ret!

; fantastruco_t* summon_fantastruco();
global summon_fantastruco
summon_fantastruco:
	; Esta función no recibe parámetros
	push rbp
	mov rbp, rsp
	push r12
	push r13

	mov rdi, 1
	mov rsi, FANTASTRUCO_SIZE
	call calloc

	mov BYTE [rax + FANTASTRUCO_FACEUP_OFFSET], 1

	mov r12, rax

	mov rdi, r12
	call init_fantastruco_dir

	mov rax, r12

	pop r13
	pop r12
	pop rbp
	ret 
