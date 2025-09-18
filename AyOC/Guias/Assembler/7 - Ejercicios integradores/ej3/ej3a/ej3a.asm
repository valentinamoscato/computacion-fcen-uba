;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

; Completar las definiciones (serán revisadas por ABI enforcer):
USUARIO_ID_OFFSET EQU 0
USUARIO_NIVEL_OFFSET EQU 4
USUARIO_SIZE EQU 8

CASO_CATEGORIA_OFFSET EQU 0
CASO_ESTADO_OFFSET EQU 4
CASO_USUARIO_OFFSET EQU 8
CASO_SIZE EQU 16

SEGMENTACION_CASOS0_OFFSET EQU 0
SEGMENTACION_CASOS1_OFFSET EQU 8
SEGMENTACION_CASOS2_OFFSET EQU 16
SEGMENTACION_SIZE EQU 24

ESTADISTICAS_CLT_OFFSET EQU 0
ESTADISTICAS_RBO_OFFSET EQU 1
ESTADISTICAS_KSC_OFFSET EQU 2
ESTADISTICAS_KDT_OFFSET EQU 3
ESTADISTICAS_ESTADO0_OFFSET EQU 4
ESTADISTICAS_ESTADO1_OFFSET EQU 5
ESTADISTICAS_ESTADO2_OFFSET EQU 6
ESTADISTICAS_SIZE EQU 7

;void contar_casos_por_nivel(caso_t* arreglo_casos, int largo, int* contador_nivel)
; rdi = arreglo_casos
; rsi = largo
; rdx = contadores
contar_casos_por_nivel:
    push rbp ; alineado
    mov rbp, rsp
    push r13
    push r14 ; alineado
    push r15
    sub rsp, 8 ; alineado

    xor r13, r13
    mov r14, rdi ; r14 tiene arreglo_casos

    xor r15, r15

    .ciclo_aux:
        mov r15, [r14 + r13*CASO_SIZE] ; r15 = &arreglo_casos[i]
        mov r15, [r15 + CASO_USUARIO_OFFSET] ; r15 = caso->usuario
        mov r15, [r15 + USUARIO_NIVEL_OFFSET] ; r15 = usuario->nivel

        cmp r15, 0
        je .sumar_nivel_0

        cmp r15, 1
        je .sumar_nivel_1

        cmp r15, 2
        je .sumar_nivel_2
    
    .siguiente_caso_aux:
        inc r13
        cmp r13, rsi
        je .fin
        jmp .ciclo_aux

    .sumar_nivel_0:
        inc [rdx]
        jmp .siguiente_caso_aux
    
    .sumar_nivel_1:
        inc [rdx+8]
        jmp .siguiente_caso_aux

    .sumar_nivel_2:
        inc [rdx+16]
        jmp .siguiente_caso_aux

    .fin:
        add rsp, 8
        pop r14
        pop r13
        pop rbp
        ret

;segmentacion_t* segmentar_casos(caso_t* arreglo_casos, int largo)
; rdi = arreglo_casos
; rsi = largo
global segmentar_casos
segmentar_casos:
    push rbp
    mov rbp, rsp
    push 13

    xor r13, r13
    mov r13, 0

    pop r13
    pop rbp
    ret