extern strcmp
global invocar_habilidad

; Completar las definiciones o borrarlas (en este ejercicio NO serán revisadas por el ABI enforcer)
DIRENTRY_NAME_OFFSET EQU 0
DIRENTRY_PTR_OFFSET EQU 16
DIRENTRY_SIZE EQU 24

FANTASTRUCO_DIR_OFFSET EQU 0
FANTASTRUCO_ENTRIES_OFFSET EQU 8
FANTASTRUCO_ARCHETYPE_OFFSET EQU 16
FANTASTRUCO_FACEUP_OFFSET EQU 24
FANTASTRUCO_SIZE EQU 32

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text

; void invocar_habilidad(void* carta, char* habilidad);
invocar_habilidad:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push rbx
	push r12
	push r13
	push r14
	push r15
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = void*    card ; Vale asumir que card siempre es al menos un card_t*
	mov rbx, rdi
	; rsi = char*    habilidad
	mov r13, rsi

	xor r14, r14 ; aca va a estar la funcion
	
	.next_card_t:
	test r14, r14
	jnz .fin
	test rbx, rbx
	jz .fin

	; cant_habilidades (uint16_t)
	movzx r12, WORD [rbx + FANTASTRUCO_ENTRIES_OFFSET]
	
	; directory_entry_t**
	mov r15, QWORD [rbx + FANTASTRUCO_DIR_OFFSET]
	
	test r12, r12
	jz .end_loop

	.loop:
	dec r12

	; puntero a: direntry -> ability_name
	mov r9, QWORD [r15 + r12*8]
	lea rdi, QWORD [r9 + DIRENTRY_NAME_OFFSET]
	mov rsi, r13
	call strcmp

	test rax, rax
	jnz .continue_loop
	; si se llego aca es porque encontro la funcion
	mov r9, QWORD [r15 + r12*8]
	mov r14, QWORD [r9 + DIRENTRY_PTR_OFFSET]
	mov rdi, rbx
	call r14

	.continue_loop:
	test r12, r12
	jz .end_loop

	jmp .loop
	.end_loop:

	mov rdi, rbx
	mov rbx, [rdi + FANTASTRUCO_ARCHETYPE_OFFSET]
	jmp .next_card_t

	.fin:
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	add rsp, 8
	pop rbp
	ret
