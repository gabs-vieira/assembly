_Z9somaVetorPsi:
    push    ebx                  ; Salva o valor de EBX na pilha
    mov     edx, DWORD PTR 12[esp]  ; Carrega o número de elementos (elementos)
    test    edx, edx             ; Verifica se o número de elementos é 0 ou negativo
    jle     .L4                  ; Se for <= 0, pula para .L4
    mov     eax, DWORD PTR 8[esp]  ; Carrega o endereço do vetor (vetor)
    lea     ebx, [eax+edx*2]     ; Calcula o endereço do final do vetor
    xor     edx, edx             ; Zera EDX (variável soma)
.L3:
    movsx   ecx, WORD PTR [eax]  ; Carrega um valor do vetor e converte para inteiro
    add     eax, 2               ; Incrementa o ponteiro do vetor (avança 2 bytes)
    add     edx, ecx             ; Soma o valor à soma acumulada
    cmp     eax, ebx             ; Verifica se chegou ao final do vetor
    jne     .L3                  ; Se não chegou, continua o loop
    mov     eax, edx             ; Coloca o resultado da soma em EAX (retorno)
    pop     ebx                  ; Restaura o valor de EBX
    ret                          ; Retorna o valor
.L4:
    xor     edx, edx             ; Se o vetor era vazio, zera EDX
    pop     ebx                  ; Restaura o valor de EBX
    mov     eax, edx             ; Retorna 0
    ret                          ; Finaliza
main:   
    xor     eax, eax  ; Zera EAX (fun%C3%A7%C3%A3o main n%C3%A3o faz nada no final)    
    ret               ; Retorna
