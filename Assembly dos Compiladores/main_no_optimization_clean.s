_Z9somaVetorPsi:
.LFB0:
	push	ebp                      # Salva o valor de ebp na pilha
	mov	ebp, esp                    # Move o ponteiro da pilha (esp) para o ponteiro de base (ebp)
	sub	esp, 16                     # Reserva 16 bytes de espaço na pilha
	call	__x86.get_pc_thunk.ax       # Chama a função __x86.get_pc_thunk.ax para obter o endereço atual (usado em relocação de endereços)
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_  # Ajusta o valor de eax com o offset da tabela de endereços globais
	mov	DWORD PTR -4[ebp], 0         # Inicializa a variável local (armazenada em -4[ebp]) com 0
	mov	DWORD PTR -8[ebp], 0         # Inicializa a variável local (armazenada em -8[ebp]) com 0
	jmp	.L2                          # Pula para o rótulo .L2

.L3:                                   # Rótulo usado em loops
	mov	eax, DWORD PTR -8[ebp]       # Carrega o índice atual (armazenado em -8[ebp]) no registrador eax
	lea	edx, [eax+eax]               # Multiplica o índice por 2 e armazena o resultado em edx
	mov	eax, DWORD PTR 8[ebp]        # Carrega o endereço do vetor (passado como argumento) em eax
	add	eax, edx                    # Calcula o endereço do elemento no vetor
	movzx	eax, WORD PTR [eax]          # Carrega o valor de 16 bits no endereço do vetor para eax, com extensão zero
	cwde                            # Converte o valor de 16 bits para 32 bits, estendendo o sinal
	add	DWORD PTR -4[ebp], eax       # Soma o valor do vetor à variável acumuladora armazenada em -4[ebp]
	add	DWORD PTR -8[ebp], 1         # Incrementa o índice (armazenado em -8[ebp])
	
.L2:                                   # Verifica a condição do loop
	mov	eax, DWORD PTR -8[ebp]       # Carrega o índice atual em eax
	cmp	eax, DWORD PTR 12[ebp]       # Compara o índice com o tamanho do vetor (passado como argumento)
	jl	.L3                          # Se o índice for menor que o tamanho, pula de volta para .L3

	mov	eax, DWORD PTR -4[ebp]       # Carrega o valor acumulado em eax (resultado final)
	leave                            # Desfaz a função, restaurando esp e ebp
	ret                              # Retorna o valor no registrador eax (resultado final)


main:
.LFB1:
	lea	ecx, 4[esp]                 # Carrega o valor do quarto argumento (argc/argv) no registrador ecx
	and	esp, -16                    # Alinha a pilha para um múltiplo de 16 bytes
	push	DWORD PTR -4[ecx]           # Salva o valor no endereço de -4[ecx] na pilha
	push	ebp                       # Salva o valor de ebp na pilha
	mov	ebp, esp                    # Move o ponteiro da pilha para o ponteiro de base
	push	ecx                       # Salva ecx na pilha
	sub	esp, 36                    # Reserva 36 bytes de espaço na pilha

	call	__x86.get_pc_thunk.ax       # Chama a função __x86.get_pc_thunk.ax para obter o endereço atual
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_  # Ajusta o valor de eax com o offset da tabela de endereços globais
	mov	eax, DWORD PTR gs:20         # Carrega um valor da seção gs (TLS) no registrador eax
	mov	DWORD PTR -12[ebp], eax      # Salva o valor de eax na variável local -12[ebp] (usada para verificação de pilha)
	xor	eax, eax                    # Zera o registrador eax
	mov	WORD PTR -22[ebp], 1        # Armazena o valor 1 no vetor (posição -22[ebp])
	mov	WORD PTR -20[ebp], 2        # Armazena o valor 2 no vetor (posição -20[ebp])
	mov	WORD PTR -18[ebp], 3        # Armazena o valor 3 no vetor (posição -18[ebp])
	mov	WORD PTR -16[ebp], 4        # Armazena o valor 4 no vetor (posição -16[ebp])
	mov	WORD PTR -14[ebp], 5        # Armazena o valor 5 no vetor (posição -14[ebp])

	push	5                          # Empilha o tamanho do vetor (5)
	lea	eax, -22[ebp]                # Calcula o endereço do vetor e armazena em eax
	push	eax                        # Empilha o endereço do vetor
	call	_Z9somaVetorPsi             # Chama a função _Z9somaVetorPsi para somar os valores do vetor
	add	esp, 8                      # Ajusta o ponteiro da pilha após a chamada da função
	add	eax, eax                    # Dobra o valor de eax (resultado da soma do vetor)
	mov	DWORD PTR -28[ebp], eax      # Armazena o resultado final em -28[ebp]

	mov	eax, 0                      # Prepara o retorno da função main com valor 0 (sucesso)
	mov	edx, DWORD PTR -12[ebp]      # Carrega o valor salvo de -12[ebp] para verificação de segurança da pilha
	sub	edx, DWORD PTR gs:20         # Compara com o valor atual da pilha
	je	.L7                         # Se não houver diferença, pula para .L7 (fim da função)
	call	__stack_chk_fail_local      # Caso contrário, chama a função para falha de verificação de pilha

.L7:
	mov	ecx, DWORD PTR -4[ebp]       # Carrega o valor de -4[ebp] em ecx
	leave                            # Desfaz a função, restaurando esp e ebp
	lea	esp, -4[ecx]                # Ajusta esp para corresponder a ecx
	ret                              # Retorna o controle para o chamador


__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]         # Carrega o valor de esp (endereço de retorno) em eax
	ret                              # Retorna o controle para o chamador

