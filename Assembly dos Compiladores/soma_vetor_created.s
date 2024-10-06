.model small

.stack 100H

.data 
    VETOR  dw 5 dup(?)  ; Vetor de 5 elementos
.code      
; Rotina que soma os elementos de um vetor de 16 bits com endereço no
; reg BX e o número de elementos do vetor no reg CX. O resultado da
; soma é armazenada em AX 
somaVetor proc
    xor AX, AX   
ACUMULA:          
    add AX,[BX]   
    add BX, 2 
    loop ACUMULA          
    ret
endp    


INICIO:  
    mov AX, @DATA
    mov DS, AX 

    ; coloca valores no vetor
    mov BX, offset VETOR
    mov word ptr [BX], 1
    add BX, 2
    mov word ptr [BX], 2
    add BX, 2
    mov word ptr [BX], 3
    add BX, 2
    mov word ptr [BX], 4
    add BX, 2
    mov word ptr [BX], 5

    ; soma os elementos do vetor
    mov CX, 5               ; define numero de elementos (5)
    mov BX, offset VETOR    ; BX aponta pro início do vetor
    call somaVetor          ; chama rotina para somar os elementos do vetor

    ;Programa termina
    mov ah, 4ch
    int 21h
end INICIO  