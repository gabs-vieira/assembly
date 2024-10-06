.intel_syntax noprefix
.text
.globl	_Z9somaVetorPsi              # Define a função global _Z9somaVetorPsi
.type	_Z9somaVetorPsi, @function    # Declara o tipo da função
_Z9somaVetorPsi:
.LFB0:
	.cfi_startproc                   # Marca o início de uma função para informações de depuração
	push	ebp                      # Salva o valor de ebp na pilha
	.cfi_def_cfa_offset 8             # Define o deslocamento do CFA (current frame address) como 8
	.cfi_offset 5, -8                 # Salva ebp com um deslocamento de -8
	mov	ebp, esp                    # Move o ponteiro da pilha (esp) para o ponteiro de base (ebp)
	.cfi_def_cfa_register 5           # Define o registrador ebp como o CFA
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
	.cfi_restore 5                   # Restaura o registrador ebp
	.cfi_def_cfa 4, 4                # Define o CFA para esp com um deslocamento de 4
	ret                              # Retorna o valor no registrador eax (resultado final)
	.cfi_endproc                     # Marca o fim da função para informações de depuração

.LFE0:
	.size	_Z9somaVetorPsi, .-_Z9somaVetorPsi  # Define o tamanho da função _Z9somaVetorPsi

.globl	main                           # Define a função global main
.type	main, @function                # Declara o tipo da função
main:
.LFB1:
	.cfi_startproc                   # Marca o início de uma função para informações de depuração
	lea	ecx, 4[esp]                 # Carrega o valor do quarto argumento (argc/argv) no registrador ecx
	.cfi_def_cfa 1, 0                # Define o CFA para o registrador esp
	and	esp, -16                    # Alinha a pilha para um múltiplo de 16 bytes
	push	DWORD PTR -4[ecx]           # Salva o valor no endereço de -4[ecx] na pilha
	push	ebp                       # Salva o valor de ebp na pilha
	mov	ebp, esp                    # Move o ponteiro da pilha para o ponteiro de base
	.cfi_escape 0x10,0x5,0x2,0x75,0  # Diretriz para o CFA, específica do GCC
	push	ecx                       # Salva ecx na pilha
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6  # Diretriz para o CFA, específica do GCC
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
	.cfi_def_cfa 1, 0                # Define o CFA para esp
	leave                            # Desfaz a função, restaurando esp e ebp
	.cfi_restore 5                   # Restaura o registrador ebp
	lea	esp, -4[ecx]                # Ajusta esp para corresponder a ecx
	.cfi_def_cfa 4, 4                # Define o CFA para esp com um deslocamento de 4
	ret                              # Retorna o controle para o chamador
	.cfi_endproc                     # Marca o fim da função para informações de depuração

.LFE1:
	.size	main, .-main               # Define o tamanho da função main

.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat  # Seção de código para __x86.get_pc_thunk.ax
.globl	__x86.get_pc_thunk.ax         # Define a função global __x86.get_pc_thunk.ax
.hidden	__x86.get_pc_thunk.ax         # Torna a função __x86.get_pc_thunk.ax oculta para o linker
.type	__x86.get_pc_thunk.ax, @function  # Declara o tipo da função
__x86.get_pc_thunk.ax:
.LFB2:
	.cfi_startproc                   # Marca o início da função para informações de depuração
	mov	eax, DWORD PTR [esp]         # Carrega o valor de esp (endereço de retorno) em eax
	ret                              # Retorna o controle para o chamador
	.cfi_endproc                     # Marca o fim da função para informações de depuração

.LFE2:
.hidden	__stack_chk_fail_local        # Torna a função __stack_chk_fail_local oculta para o linker
.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"  # Identificação da versão do GCC usada
.section	.note.GNU-stack,"",@progbits # Seção para notas sobre a pilha GNU
