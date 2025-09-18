section .data
;Pago_t
%define OFFSET_MONTO 0
%define OFFSET_APROBADO 1
%define OFFSET_PAGADOR 8
%define OFFSET_COBRADOR 16
%define PAGO_T_TAM 24
;Pago_Splitted
%define OFFSET_CANTAPROBADOS 0
%define OFFSET_CANTREHAZADOS 1
%define OFFSET_ARR_APROBADOS 8
%define OFFSET_ARR_RECHAZADOS 16
%define PAGO_SPLITTED_TAM 24
;list_t
%define OFFSET_FIRST 0
%define OFFSET_LAST 8
;listElem_t
%define OFFSET_DATA 0
%define OFFSET_NEXT 8


section .text

global contar_pagos_aprobados_asm
global contar_pagos_rechazados_asm

global split_pagos_usuario_asm

extern malloc
extern free
extern strcmp


;########### SECCION DE TEXTO (PROGRAMA)

; uint8_t contar_pagos_aprobados_asm(list_t* pList, char* usuario);
; rdi list_t *
; rsi char* usuario
contar_pagos_aprobados_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8 ;queda la pila alineada
    ; === FIN PROLOGO ===
    ; === ME GUARDO VALORES EN REG NO VOLATILES YA QUE USO STRCMP ===
    mov r14, rdi ; pList
    mov r15, rsi ; Usuario
    mov r12, [r14 + OFFSET_FIRST] ; FIRST
    mov r13, [r14 + OFFSET_LAST] ; LAST

    xor rbx, rbx ; inicio contador en 0
    xor rax, rax 
    
    ; === CICLO ===
    cicloAprobados:
    xor r8, r8
    xor r9, r9
    cmp r12, [r13 + OFFSET_NEXT]
    je finAprobados

    ; === CHEQUEO SI APROBADO ===
    mov r8, r12
    mov r8, [r8 + OFFSET_DATA]
    mov r9b, BYTE [r8 + OFFSET_APROBADO]
    cmp r9b, BYTE 1
    jne AvanzarAlSiguientePagoA
    ; === SI ES APROBADO, COMPARO EL USUARIO ===
    xor r8, r8
    xor r9, r9

    mov r8, r12
    mov r8, [r8 + OFFSET_DATA] ; me traigo el cobrador
    mov r9, QWORD [r8 + OFFSET_COBRADOR] 

    mov rdi, r9 ; aca tengo el CHAR* a cobrador
    mov rsi, r15 ; ACA TENGO EL CHAR* a usuario
    call strcmp
    
    ;si es 0 son iguales
    cmp rax,0
    jne AvanzarAlSiguientePagoA
    inc rbx ; sumo 1

    ; === AVANZO AL SIGUIENTE PAGO===
    AvanzarAlSiguientePagoA:
        mov r12, QWORD [r12 + OFFSET_NEXT]
        jmp cicloAprobados
    ; === EPILOGO ===
    finAprobados:
    mov rax, rbx
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:

    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8 ;queda la pila alineada
    ; === FIN PROLOGO ===
    ; === ME GUARDO VALORES EN REG NO VOLATILES YA QUE USO STRCMP ===
    mov r14, rdi ; pList
    mov r15, rsi ; Usuario
    mov r12, [r14 + OFFSET_FIRST] ; FIRST
    mov r13, [r14 + OFFSET_LAST] ; LAST

    xor rbx, rbx ; inicio contador en 0
    xor rax, rax 
    
    ; === CICLO ===
    cicloRechazados:
    xor r8, r8
    xor r9, r9
    cmp r12, [r13 + OFFSET_NEXT]
    je finRechazados

    ; === CHEQUEO SI NO APROBADO ===
    mov r8, r12
    mov r8, [r8 + OFFSET_DATA]
    mov r9b, BYTE [r8 + OFFSET_APROBADO]
    cmp r9b, BYTE 0
    jne AvanzarAlSiguientePagoB
    ; === SI ES NO APROBADO, COMPARO EL USUARIO ===
    xor r8, r8
    xor r9, r9

    mov r8, r12
    mov r8, [r8 + OFFSET_DATA] ; me traigo el cobrador
    mov r9, QWORD [r8 + OFFSET_COBRADOR] 

    mov rdi, r9 ; aca tengo el CHAR* a cobrador
    mov rsi, r15 ; ACA TENGO EL CHAR* a usuario
    call strcmp
    
    ;si es 0 son iguales
    cmp rax,0
    jne AvanzarAlSiguientePagoB
    inc rbx ; sumo 1

    ; === AVANZO AL SIGUIENTE PAGO===
    AvanzarAlSiguientePagoB:
        mov r12, QWORD [r12 + OFFSET_NEXT]
        jmp cicloRechazados
    ; === EPILOGO ===
    finRechazados:
    mov rax, rbx
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
split_pagos_usuario_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    push rdi ; alineo

    ; estado del stack
	; (se pushea hacia abajo)
	; RIP llamada          [rbp + 8]
	; RBP llamada          [rbp]
	; r12                  [rbp-8]
	; r13                  [rbp-16]
	; r14                  [rbp-24]
	; r15                  [rbp-32]
	; rbx                  [rbp-40]
	; padding              [rbp-48]

    ; voy a llamar padding a cuando pusheo basura
    ; === FIN PROLOGO ===
    mov r14, rdi ; pList
    mov r15, rsi ; Usuario
    mov r12, [r14 + OFFSET_FIRST] ; FIRST
    mov r13, [r14 + OFFSET_LAST] ; LAST
    
    ; === cuento la cantidad de aprobados ===
    
    call contar_pagos_aprobados_asm
    push rax ;pusheo mi size_Aprobados
    push rax ;alineo

    shl rax, 3
    ;me guardo lugar para mi array de Aprobados
    mov rdi, rax
    call malloc
    push rax ; me guardo mi arr Aprobados
    push rax ;alineo
    ; estado del stack
	; (se pushea hacia abajo)
	; RIP llamada          [rbp + 8]
	; RBP llamada          [rbp]
	; r12                  [rbp-8]
	; r13                  [rbp-16]
	; r14                  [rbp-24]
	; r15                  [rbp-32]
	; rbx                  [rbp-40]
	; padding              [rbp-48]
    ; size_Aprobados       [rbp -56]
    ; padding              [rbp -64]
    ; arr_Aprobados        [rbp -72]
    ; padding              [rbp -80]

    ; === cuento la cantidad de desaprobados ===
    mov rdi, r14 ;pList
    mov rsi, r15 ; usuario
    call contar_pagos_rechazados_asm
    push rax ;pusheo mi size_Rechazados
    push rax ;alineo

    shl rax, 3
    ;me guardo lugar para mi array de desaprobados
    mov rdi, rax
    call malloc
    push rax
    push rax
    ; estado del stack
	; (se pushea hacia abajo)
	; RIP llamada          [rbp + 8]
	; RBP llamada          [rbp]
	; r12                  [rbp-8]
	; r13                  [rbp-16]
	; r14                  [rbp-24]
	; r15                  [rbp-32]
	; rbx                  [rbp-40]
	; 0x0000000000000000   [rbp-48]
    ; size_Aprobados       [rbp -56]
    ; padding              [rbp -64]
    ; arr_Aprobados        [rbp -72]
    ; padding              [rbp -80]
    ; size_Rechazados      [rbp -88]
    ; padding              [rbp -96]
    ; arr_Rechazados       [rbp -104]
    ; padding              [rbp -112]

     ; === PEDIR MEMORIA PARA PagoSplitted===
     mov rdi, PAGO_SPLITTED_TAM
     call malloc
     push rax
     push rax
   ; estado del stack
	; (se pushea hacia abajo)
	; RIP llamada          [rbp + 8]
	; RBP llamada          [rbp]
	; r12                  [rbp-8]
	; r13                  [rbp-16]
	; r14                  [rbp-24]
	; r15                  [rbp-32]
	; rbx                  [rbp-40]
	; 0x0000000000000000   [rbp-48]
    ; size_Aprobados       [rbp -56]
    ; padding              [rbp -64]
    ; arr_Aprobados        [rbp -72]
    ; padding              [rbp -80]
    ; size_Rechazados      [rbp -88]
    ; padding              [rbp -96]
    ; arr_Rechazados       [rbp -104]
    ; padding              [rbp -112]
    ; puntero A pSplitted  [rbp - 120]
    ; puntero A pSplitted  [rbp - 128]

    ; ==== LINKEO CON MI RES ====

     ;OFFSET_CANTAPROBADOS 0
     ;OFFSET_CANTREHAZADOS 1
     ;OFFSET_ARR_APROBADOS 8
     ;OFFSET_ARR_RECHAZADOS 16
     ;PAGO_SPLITTED_TAM 24
     xor r8, r8
     mov r8b, BYTE [rbp-56]
     mov [rax +OFFSET_CANTAPROBADOS], r8
     xor r8, r8
     mov r8b, BYTE [rbp-88]
     mov [rax +OFFSET_CANTREHAZADOS], r8
     mov r8, [rbp - 72]
     mov [rax + OFFSET_ARR_APROBADOS],r8
     mov r8, [rbp - 104]
     mov [rax + OFFSET_ARR_RECHAZADOS],r8

    xor rax, rax ; i
    xor rbx, rbx ; j

    mov r10, [rbp -72] ; arr_Aprobados
    mov r11, [rbp -104] ; arr_Aprobados
    ; === CICLO ===
    cicloSplitteado:
    xor r8, r8
    xor r9, r9
    cmp r12, [r13 + OFFSET_NEXT]
    je fin

    ; === COMPARO EL USUARIO ===
    xor r8, r8
    xor r9, r9

    mov r8, r12
    mov r8, [r8 + OFFSET_DATA] ; me traigo el cobrador
    mov r9, QWORD [r8 + OFFSET_COBRADOR] 

    mov rdi, r9 ; aca tengo el CHAR* a cobrador
    mov rsi, r15 ; ACA TENGO EL CHAR* a usuario
    push r10
    push r10

    call strcmp
    
    pop r10
    pop r10

    ;si es 0 son iguales
    cmp rax,0
    jne AvanzarAlSiguientePagoS
    
    ;Veo a que lista lo agrego

     ; === CHEQUEO SI APROBADO ===
    mov r8, r12
    mov r8, [r8 + OFFSET_DATA]
    mov r9b, BYTE [r8 + OFFSET_APROBADO]
    cmp r9b, BYTE 1
    je esAprobado
    jne NoesAprobado

    esAprobado:
    mov r8, r12
    mov r8, [r8 + OFFSET_DATA]
    mov [r10], r8
    add r10, 8    
    jmp AvanzarAlSiguientePagoS

    NoesAprobado:
    mov r8, r12
    mov r8, [r8 + OFFSET_DATA]
    mov [r11], r8
    add r11, 8    
    jmp AvanzarAlSiguientePagoS
    ; === AVANZO AL SIGUIENTE PAGO===
    AvanzarAlSiguientePagoS:
        mov r12, QWORD [r12 + OFFSET_NEXT]
        jmp cicloSplitteado

    
    
    ; === EPILOGO ===
    fin:
    mov rax, QWORD [rbp-128] ;respuesta
    ; tengo algun error con los pushes/pops y no me vuelve bien al ret
    mov rbx, rbp
	sub rbx, 40
	mov rsp, rbx
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret
