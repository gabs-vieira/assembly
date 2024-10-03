section .data
    Mes db 'JanFevMarAbrMaiJunJulAgoSetOutNovDez'
    dia db 16 dup (0)
    Data db 16 dup (0)

section .text
    global _start

_start:
    ; Exemplo de entrada
    mov al, 23  ; dia
    mov ah, 9   ; mês (Setembro)
    mov bl, 15  ; ano (2015)

    ; Chama a rotina para formatar a data
    call format_date

    ; Aqui você pode adicionar código para sair do programa ou fazer outra coisa

    ; Saída do programa
    mov eax, 60 ; syscall: exit
    xor edi, edi ; status: 0
    syscall

format_date:
    ; Salva os registradores que serão usados
    push eax
    push ebx
    push ecx
    push edx

    ; Converte o dia para string e armazena em Data
    movzx ecx, al
    mov edi, Data
    call byte_to_string
    mov byte [edi], ' '
    inc edi
    mov byte [edi], 'd'
    inc edi
    mov byte [edi], 'e'
    inc edi
    mov byte [edi], ' '
    inc edi

    ; Converte o mês para string e armazena em Data
    movzx ecx, ah
    dec ecx ; Ajusta o índice do mês (1-based para 0-based)
    mov esi, Mes
    imul ecx, 3 ; Cada mês tem 3 caracteres
    add esi, ecx
    movsb
    movsb
    movsb
    mov byte [edi], ' '
    inc edi
    mov byte [edi], 'd'
    inc edi
    mov byte [edi], 'e'
    inc edi
    mov byte [edi], ' '
    inc edi

    ; Converte o ano para string e armazena em Data
    movzx ecx, bl
    call byte_to_string

    ; Restaura os registradores
    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

byte_to_string:
    ; Converte um byte em ecx para string e armazena em [edi]
    mov eax, ecx
    mov ecx, 10
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    inc edi
    add al, '0'
    mov [edi], al
    inc edi
    ret