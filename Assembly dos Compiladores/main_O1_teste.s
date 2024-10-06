_Z9somaVetorPsi:
.LFB0:
	push ebx               # Salvando o registrador ebx na pilha

	mov ecx, DWORD PTR 8[esp]  # Carrega o ponteiro do vetor (primeiro argumento) para ecx
	mov edx, DWORD PTR 12[esp] # Carrega o tamanho do vetor (segundo argumento) para edx
	test edx, edx              # Verifica se edx (tamanho) é zero
	jle .L4                    # Se for menor ou igual a zero, pula para .L4 (retorna 0)

	mov eax, ecx               # Copia o ponteiro do vetor para eax
	lea ebx, [ecx+edx*2]       # Calcula o fim do vetor (ecx + 2 * tamanho) e armazena em ebx
	mov edx, 0                 # Inicializa edx (acumulador de soma) com 0

.L3:                          # Início do loop
	movsx ecx, WORD PTR [eax]  # Carrega o próximo valor do vetor (elemento de 16 bits) em ecx, com sinal
	add edx, ecx               # Soma o valor ao acumulador edx
	add eax, 2                 # Move o ponteiro do vetor para o próximo elemento (tamanho 2 bytes)
	cmp eax, ebx               # Compara o ponteiro atual com o final do vetor
	jne .L3                    # Se ainda não chegou ao fim, repete o loop

.L1:
	mov eax, edx               # Move o valor da soma (acumulado em edx) para eax (registro de retorno)
	pop ebx                    # Restaura o valor original de ebx
	ret                        # Retorna da função

.L4:
	mov edx, 0                 # Se o vetor for vazio (tamanho <= 0), retorna 0
	jmp .L1                    # Pula para o fim, retornando a soma (neste caso 0)

main:
	mov eax, 0                 # Retorna 0 em main
	ret                        # Fim da função main

.LFE1:
	.size main, .-main         # Define o tamanho da função main
	.ident "GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"  # Informação de versão do compilador
	.section .note.GNU-stack,"",@progbits  # Definição de seção para GNU stack
