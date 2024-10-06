; Programa que lê um vetor de words (16 bits) com 5 elementos e 
; calcula (e mostra) a soma dos elementos do vetor. A soma deve 
; ser realizada por uma rotina chamada somVetor, a qual recebe 
; o endereço inicial do vetor no reg BX e o número de elementos no 
; reg m CX. A soma dos elementos é retornada pelo reg AX. 
.model small


.stack 100H


.data 
 VETOR  dw 5 dup(?) 
 
    CR EQU 13
    LF EQU 10
.code  


; Lê um caractere do teclado sem mostrá-lo 
; Devolve o caractere lido em AL
LER_CHAR proc 
 mov AH, 7
    int 21H   
    ret       
endp
  
; Escreve um caractere armazenado em DL na tela     
ESC_CHAR proc ; escreve um caractere em DL
 push AX    ; salva o reg AX
 mov AH, 2
 int 21H
 pop AX     ; restaura o reg AX
 ret  
endp   


; Escreve na tela um inteiro sem sinal    
; de 16 bits armazenado no registrador AX
ESC_UINT16 proc 
    push AX      ; Salvar registradores utilizados na proc
    push BX
    push CX
    push DX 
       
    mov BX, 10   ; divisões sucessivas por 10
    xor CX, CX   ; contador de dígitos
      
LACO_DIV:
    xor DX, DX   ; zerar DX pois o dividendo é DXAX
    div BX       ; divisão para separar o dígito em DX
    
    push DX      ; empilhar o dígito
    inc CX       ; incrementa o contador de dígitos
     
    cmp AX, 0    ; AX chegou a 0?
    jnz LACO_DIV ; enquanto AX diferente de 0 salte para LACO_DIV
           
 LACO_ESCDIG:   
    pop DX       ; desempilha o dígito    
    add DL, '0'  ; converter o dígito para ASCII
    call ESC_CHAR               
    loop LACO_ESCDIG    ; decrementa o contador de dígitos
    
    pop DX       ; Restaurar registradores utilizados na proc
    pop CX
    pop BX
    pop AX
    ret     
endp   
     
; Lê um inteiro de 16 bits sem sinal do teclado
; Devolve o valor lido em AX
LER_UINT16 proc  
 ; Salvar registradores utilizados na proc
 push BX
 push CX
 push DX 


 xor AX, AX 
 xor CX, CX
 mov BX, 10
 
LER_UINT16_SALVA:
 push AX    ; salvando o acumulador
  
LER_UINT16_LEITURA:       
 call LER_CHAR           ; ler o caractere
  
 cmp AL, CR              ; verifica se eh ENTER
 jz LER_UINT16_FIM  ; jz == je
   
 cmp AL, '0'             ; verificar se eh valido
 jb LER_UINT16_LEITURA 
  
 cmp AL, '9'
 ja LER_UINT16_LEITURA 
  
 mov DL, AL      ; escrever o caractere
 call ESC_CHAR
  
 mov CL, AL      ; salvar em CL o caractere
 sub CL, '0'     ; transforma o caractere em valor ('3' -> 3)
 
 pop AX          ; restaurando o acumulador 
 
 mul BX          ; deslocamento esquerda do número para a soma
 add AX,CX
 
 jmp LER_UINT16_SALVA


LER_UINT16_FIM: 
 pop AX          ; restaurando o acumulador 
      
      
 mov DL, CR      ; Dar um enter após a leitura          
 call ESC_CHAR
 mov DL, LF             
 call ESC_CHAR


 ; Restaurar registradores utilizados na proc
 pop DX
 pop CX
 pop BX
   
 ret
endp  
    
; Rotina que soma os elementos de um vetor de 16 bits com endereço no
; reg BX e o número de elementos do vetor no reg CX. O resultado da
; soma é armazenada em AX 
somVetor proc
    push BX   ; Salvar registradores utilizados na proc
    push CX  
       
    xor AX, AX ; Zera o acumulador   
ACUMULA:          
    add AX,[BX]   
    add BX, 2 
    loop ACUMULA          
 
 pop CX    ; Restaurar registradores utilizados na proc
 pop BX    
    ret
endp    


INICIO:  
    mov AX, @DATA
    mov DS, AX 
   
    mov BX, offset VETOR
    mov CX, 5   
    
    ; Leitura do vetor ORIGEM               
LEITURA_VETOR:                         
    call LER_UINT16
    mov [BX], AX   
    add BX, 2
    loop LEITURA_VETOR 
  
    ; Copiar ORIGEM para DESTINO
    mov CX, 5
    mov BX, offset VETOR 
    call somVetor 
 
    call ESC_UINT16 
      
    mov ah, 4ch
    int 21h
 end INICIO    