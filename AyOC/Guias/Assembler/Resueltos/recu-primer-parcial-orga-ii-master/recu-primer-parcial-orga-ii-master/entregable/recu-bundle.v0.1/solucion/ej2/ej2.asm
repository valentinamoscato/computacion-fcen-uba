global combinarImagenes_asm

section .data
setear_transparencia: db 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255
inversor: dw 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF

;########### SECCION DE TEXTO (PROGRAMA)
section .text

; void combinarImagenes_asm(uint8_t *src_a, uint8_t *src_b, uint8_t *dst, uint32_t width, uint32_t height);
; [rdi]: src_a, [rsi]: src_b, [rdx]: dst, [ecx]: width, [r8d]: height
combinarImagenes_asm:
    push rbp
    push r12
    sub rsp, 8
    mov rbp, rsp

    mov r12, rdx    ; Cuando corro el codigo, me tira SIGSEV cuando trato de mover algo al dst. Para parchearlo, supongo que en algun momento se pierde
                    ; el valor de rdx. Por lo tanto, lo guardo en el registro no-volatil r12 y lo uso como dst

    ; Primero tengo que calcular la cantidad total de iteraciones que tiene que hacer el codigo. Eso se calcula como 
    ; width * height / (cantidad de pixeles con los que trabajamos por iteracion). Como voy a trabajar con 4 pixeles por iteracion, seria dividido 4.
    ; Asumimos (confirmado por un profesor) que width es multiplo de 4. Por lo tanto, width * height / 4 es un numero entero
    mov eax, r8d
    mul ecx
    mov ecx, eax
    shr ecx, 2
    .ciclo:
        movdqu xmm0, [rdi]     ; xmm0 = | A_a | R_a | G_a | B_a | ... |
        movdqu xmm1, [rsi]     ; xmm1 = | A_b | R_b | G_b | B_b | ... |

        ; Primero, me voy a encargar de setear el res[ij]_B y res[ij]_R. Una vez calculados los valores y guardados en dst en la posicion que les corresponde,
        ; me encargare de calcular res[ij]_G. Esto principalmente por un tema de registros: si quiero calcular todo a la vez no tengo registros suficientes
        ; (al menos para la estrategia que quiero plantear).

        ; Primero, me encargo de calcular res[ij]_B. Para ello, aislo B_a y R_b. Para hacerlo, voy a hacer un shifteo a la izquierda (para borrar los 
        ; valores superiores) y despues uno a la derecha (para colocarlo en la parte baja de la dword).
        movdqu xmm2, xmm0   ; xmm2 = | A_a | R_a | G_a | B_a | ... |
        movdqu xmm3, xmm1   ; xmm3 = | A_b | R_b | G_b | B_b | ... |
        pslld xmm2, 24      ; xmm2 = | B_a |  0  |  0  |  0  | ... |
        psrld xmm2, 24      ; xmm2 = |  0  |  0  |  0  | B_a | ... |
        pslld xmm3, 8       ; xmm3 = | R_b | G_b | B_b |  0  | ... |
        psrld xmm3, 24      ; xmm3 = |  0  |  0  |  0  | R_b | ... |

        ; Me queda sumar los dos valores y de paso setearles la transparencia en 255
        paddb xmm2, xmm3                        ; xmm2 = |  0  |  0  |  0  | B_a + R_b | ... |
        por xmm2, [setear_transparencia]        ; xmm2 = | 255 |  0  |  0  | B_a + R_b | ... |
        movdqu [r12], xmm2                      ; ya muevo lo que obtuve hasta ahora al dst para evitar guardamelo. Cuando quiera agregarle el calculo de los 
                                                ; otros atributos, muevo lo que esta en dst a un registro, hago "por" y lo vuelvo a meter en dst
        
        ; Ahora calculo res[ij]_R con la misma idea. Quiero aislar R_a y B_b
        movdqu xmm2, xmm0   ; xmm2 = | A_a | R_a | G_a | B_a | ... |
        movdqu xmm3, xmm1   ; xmm3 = | A_b | R_b | G_b | B_b | ... |
        
        ; Voy a hacer 3 shifteos para ya colocarlo en la posicion final
        psrld xmm2, 16      ; xmm2 = |  0  |  0  | A_a | R_a | ... |
        pslld xmm2, 24      ; xmm2 = | R_a |  0  |  0  |  0  | ... |
        psrld xmm2, 8       ; xmm2 = |  0  | R_a |  0  |  0  | ... |
        pslld xmm3, 24      ; xmm3 = | B_b |  0  |  0  |  0  | ... |
        psrld xmm3, 8       ; xmm3 = |  0  | B_b |  0  |  0  | ... |

        ; Resto los dos valores
        psubb xmm3, xmm2    ; xmm3 = |  0  | B_b - R_a |  0  |  0  | ... |

        ; Lo combino con lo que calcule antes
        movdqu xmm4, [r12]  ; xmm1 = | 255 |  0  |  0  | B_a + R_b | ... |
        por xmm4, xmm3      ; xmm3 = | 255 | B_b - R_a |  0  | B_a + R_b | ... |
        movdqu [r12], xmm4

        ; Por ultimo, me queda calcular res[ij]_G. Para eso, tengo que aislar los valores G_a y G_b, chequear cual de los dos es mas grande y actuar en
        ; consecuencia.
        movdqu xmm2, xmm0   ; xmm2 = | A_a | R_a | G_a | B_a | ... |
        movdqu xmm3, xmm1   ; xmm3 = | A_b | R_b | G_b | B_b | ... |
        pslld xmm2, 16      ; xmm2 = | G_a | B_a |  0  |  0  | ... |
        psrld xmm2, 24      ; xmm2 = |  0  |  0  |  0  | G_a | ... |
        pslld xmm3, 16      ; xmm3 = | G_b | B_b |  0  |  0  | ... |
        psrld xmm3, 24      ; xmm3 = |  0  |  0  |  0  | G_b | ... |

        ; Chequeo cual es mas grande. Antes de hacer la comparacion, copio xmm2 (G_a) en otro registro, ya que se me va a sobreescribir con el resultado de 
        ; la comparacion
        movdqu xmm4, xmm2   ; xmm4 = |  0  |  0  |  0  | G_a | ... |
        pcmpgtd xmm2, xmm3  ; En xmm2 esta la mascara que indica los G_a y G_b que cumplen la guarda

        movdqu xmm5, xmm2   ; Como la mascara hay que aplicarsela a dos registros distintos, hago una copia
        movdqu xmm6, xmm2   ; Ademas, guardo otra copia para que sea mas rapido calcular el caso contrario
        pand xmm2, xmm4     ; xmm2 = |  0  |  0  |  0  | G_a | ... |
        pand xmm3, xmm5     ; xmm3 = |  0  |  0  |  0  | G_b | ... |

        ; En xmm2 y xmm3 estan los G_a y G_b que cumplen la primera guarda. Por lo tanto, tengo que restarlos y agregarlos a lo que ya tengo calculado
        psubd xmm2, xmm3    ; xmm2 = |  0  |  0  |  0  | G_a - G_b | ... | 
        pslld xmm2, 8       ; xmm2 = |  0  |  0  | G_a - G_b |  0  | ... |. Lo muevo a la posicion final
        movdqu xmm3, [r12]  ; xmm3 = | 255 | B_b - R_a |  0  | B_a + R_b | ... |
        por xmm3, xmm2      ; xmm3 = | 255 | B_b - R_a | G_a - G_b | B_a + R_b | ... |
        movdqu [r12], xmm3  ; Lo coloco devuelta en dst

        ; Ahora me faltan los res[ij]_B que no cumplen la guarda. Para eso, invierto la comparacion que hice previamente (que esta guardada en xmm6), lo que  
        ; me va a dar todos los pixeles que entran en el caso contrario.
        pxor xmm6, [inversor]       ; un xor entre un bit y un 1 te invierte el valor del bit (0 xor 1 = 1 y  1 xor 1 = 0). Por lo tanto, hacer un pxor del
                                    ; registro con una mascara de todos 1s nos invierte el registro.
        ; Perdi los G_a y G_b que habia aislado, por lo que tengo que obtenerlos de vuelta
        movdqu xmm2, xmm0   ; xmm2 = | A_a | R_a | G_a | B_a | ... |
        movdqu xmm3, xmm1   ; xmm3 = | A_b | R_b | G_b | B_b | ... |
        pslld xmm2, 16      ; xmm2 = | G_a | B_a |  0  |  0  | ... |
        psrld xmm2, 24      ; xmm2 = |  0  |  0  |  0  | G_a | ... |
        pslld xmm3, 16      ; xmm3 = | G_b | B_b |  0  |  0  | ... |
        psrld xmm3, 24      ; xmm3 = |  0  |  0  |  0  | G_b | ... |

        ; Les aplico la mascara. Primero me hago una copia de la mascara para poder aplicarsela a los dos registros
        movdqu xmm5, xmm6
        pand xmm2, xmm5
        pand xmm3, xmm6

        pavgb xmm2, xmm3    ; Calculo el promedio
        pslld xmm2, 8       ; xmm2 = |  0  |  0  | promedio(G_a, G_b) |  0  | ... |. Lo muevo a su posicion final

        ; Por ultimo, lo guardo en el dst
        movdqu xmm3, [r12]      ; xmm3 = | 255 | B_b - R_a | 0 | B_a + R_b | ... |
        por xmm3, xmm2          ; xmm3 = | 255 | B_b - R_a | promedio(G_a, G_b) | B_a + R_b | ... |
        movdqu [r12], xmm3

        ; Itero
        add rdi, 16
        add rsi, 16
        add r12, 16
        dec ecx
        cmp ecx, 0
        jne .ciclo

    add rsp, 8
    pop r12
    pop rbp
    ret