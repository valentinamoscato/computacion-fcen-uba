global mezclarColores

section .data

maskMatarA db 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

maskCasoBEsMenor db 1,2,0,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80
maskCasoREsMenor db 2,0,1,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;void mezclarColores( uint8_t *X, uint8_t *Y, uint32_t width, uint32_t height);
; rdi img src
; rsi img dst
; rdx width columnas
; rcx height filas
mezclarColores:
; === Prologo ===
    push rbp
    mov rbp,rsp
    push r12
    push r13
    xor r12, r12


    sar edx, 1 ; divido por 2 el width ya que trabajo de a 2 pixeles
    mov r12d, edx ; me guardo el valor de las columnas

    cicloFilas:
    cmp ecx, 0
    je fin
        cicloColumnas:
        cmp edx, 0
        je avanzoFila

        movq xmm0, [rdi] ; me traigo la imagen source
        ; Limpio los A
        movdqu xmm7, [maskMatarA]
        pand xmm0, xmm7

        ; Busco el min
        movdqu xmm1, xmm0 ; me copio el valor de mis pixeles, voy a shiftearlos para hacer la comparacion
        movdqu xmm2, xmm0 
        
        ; xmm3 preserva los datos
        movdqu xmm3, xmm0

        ;xmm0 0 R G B | 0 R G B

        psrld xmm1, 8 ; shifteo 8 bits para tener 
        ;xmm1 0 0 R G | 0 0 R G 

        psrld xmm2, 16 ; shifteo 16 bits para tener 
        ;xmm2 0 0 0 R | 0 0 0 R 
        
        pminub xmm0, xmm1 
        pminub xmm0,xmm2

        movdqu xmm1, xmm3
        movdqu xmm2, xmm3

        ; chequeo que son distintos
        pextrb r8d, xmm3,0
        pextrb r9d, xmm3,1
        pextrb r10d, xmm3,2
        cmp r8d, r9d
        je caso3
        cmp r8d, r10d
        je caso3
        cmp r9d, r10d
        je caso3

        ; Comparo xmm0 con xmm4, si b es el mas chico estoy en el caso 1:

        pextrb r8d, xmm0, 0 ; pixel a comparar
        pextrb r9d, xmm3, 0 ; blue
        cmp r8d, r9d 
        je posibleCaso1

        ; Comparo xmm0 con xmm4, si r es el mas chico estoy en el caso 2:

        pextrb r8d, xmm3, 1 ; green
        pextrb r9d, xmm3, 0 ; blue
        cmp r8d, r9d
        ja caso3

        pextrb r8d, xmm0, 0 ; pixel a comparar
        pextrb r9d, xmm3, 2 ; red
        cmp r8d, r9d 
        je caso2
        jmp caso3

        posibleCaso1:
        pextrb r8d, xmm3, 1 ; green
        pextrb r9d, xmm3, 2 ; red
        cmp r8d, r9d
        jb caso1
        
        jmp caso3
        
        

        ; ===  Caso Xr > Xg > Xb ===
        caso1:
        ; === Asigno Yr = Xb , Yg = Xr , Yb = Xg ===
            movdqu xmm4, [maskCasoBEsMenor]
            pshufb xmm3, xmm4
            movd eax, xmm3
            pxor xmm6,xmm6
            movd xmm6, eax
            
            jmp siguientePixel

        ; ===  Caso Xr < Xg < Xb ===
        caso2:
        ; === Asigno Yr = Xg , Yg = Xb , Yb = Xr ===
            movdqu xmm4, [maskCasoREsMenor]
            pshufb xmm3, xmm4
            movd eax, xmm3
            pxor xmm6,xmm6
            movd xmm6, eax

            jmp siguientePixel
        ; ===  Sino, dejo el pixel igual ===
        caso3:
            movd eax, xmm3
            pxor xmm6,xmm6
            movd xmm6, eax
            jmp siguientePixel

        ; ============== SIGUIENTE PIXEL =================
        siguientePixel:
        movdqu xmm3, xmm1
        ; veo el siguiente pixel, para eso shifteo los xmm a derecha
        psrlq xmm3, 32
        psrlq xmm0, 32
        ; chequeo que son distintos
        pextrb r8d, xmm3,0
        pextrb r9d, xmm3,1
        pextrb r10d, xmm3,2
        cmp r8d, r9d
        je casoc
        cmp r8d, r10d
        je casoc
        cmp r9d, r10d
        je casoc

        ; Comparo xmm0 con xmm4, si b es el mas chico estoy en el caso 1:

        pextrb r8d, xmm0, 0 ; pixel a comparar
        pextrb r9d, xmm3, 0 ; blue
        cmp r8d, r9d 
        je posibleCasoA

        ; Comparo xmm0 con xmm4, si r es el mas chico estoy en el caso 2:
        pextrb r8d, xmm3, 1 ; green
        pextrb r9d, xmm3, 0 ; blue
        cmp r8d, r9d
        ja casoc

        pextrb r8d, xmm0, 0 ; pixel a comparar
        pextrb r9d, xmm3, 2 ; red
        cmp r8d, r9d 
        je casob
        jmp casoc

        posibleCasoA:
        pextrb r8d, xmm3, 1 ; green
        pextrb r9d, xmm3, 2 ; red
        cmp r8d, r9d
        jb casoa
        jmp casoc

                ; ===  Caso Xr > Xg > Xb ===
        casoa:
        ; === Asigno Yr = Xb , Yg = Xr , Yb = Xg ===
            movdqu xmm4, [maskCasoBEsMenor]
            pshufb xmm3, xmm4
            movd eax, xmm3
            pxor xmm7,xmm7
            movd xmm7, eax
            psllq xmm7,32
            jmp escribo

    ; ===  Caso Xr < Xg < Xb ===
        casob:
        ; === Asigno Yr = Xg , Yg = Xb , Yb = Xr ===
            movdqu xmm4, [maskCasoREsMenor]
            pshufb xmm3, xmm4
            movd eax, xmm3
            pxor xmm7,xmm7
            movd xmm7, eax
            psllq xmm7,32
            jmp escribo
        ; ===  Sino, dejo el pixel igual ===
        casoc:
            movd eax, xmm3
            pxor xmm7,xmm7
            movd xmm7, eax
            psllq xmm7,32
            jmp escribo



        escribo:
        por xmm6, xmm7
        movq [rsi], xmm6
        add rdi, 8
        add rsi, 8 
        avanzoColumna:
            dec edx ; avanzo a los proximos 2 pixeles
            jmp cicloColumnas

        avanzoFila:
            dec ecx
            mov edx,r12d
            jmp cicloFilas



; === Epilogo ===
    fin:
        pop r13
        pop r12
        pop rbp
        ret
