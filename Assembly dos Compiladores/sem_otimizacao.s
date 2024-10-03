_Z9somaVetorPsi:
.LFB0:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	DWORD PTR -4[ebp], 0
	mov	DWORD PTR -8[ebp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -8[ebp]
	lea	edx, [eax+eax]
	mov	eax, DWORD PTR 8[ebp]
	add	eax, edx
	movzx	eax, WORD PTR [eax]
	cwde
	add	DWORD PTR -4[ebp], eax
	add	DWORD PTR -8[ebp], 1
.L2:
	mov	eax, DWORD PTR -8[ebp]
	cmp	eax, DWORD PTR 12[ebp]
	jl	.L3
	mov	eax, DWORD PTR -4[ebp]
	leave
	ret
main:
.LFB1:
	lea	ecx, 4[esp]
	and	esp, -16
	push	DWORD PTR -4[ecx]
	push	ebp
	mov	ebp, esp
	push	ecx
	sub	esp, 36
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR -12[ebp], eax
	xor	eax, eax
	mov	WORD PTR -22[ebp], 1
	mov	WORD PTR -20[ebp], 2
	mov	WORD PTR -18[ebp], 3
	mov	WORD PTR -16[ebp], 4
	mov	WORD PTR -14[ebp], 5
	push	5
	lea	eax, -22[ebp]
	push	eax
	call	_Z9somaVetorPsi
	add	esp, 8
	add	eax, eax
	mov	DWORD PTR -28[ebp], eax
	mov	eax, 0
	mov	edx, DWORD PTR -12[ebp]
	sub	edx, DWORD PTR gs:20
	je	.L7
	call	__stack_chk_fail_local
.L7:
	mov	ecx, DWORD PTR -4[ebp]
	leave
	lea	esp, -4[ecx]
	ret
__x86.get_pc_thunk.ax:
.LFB2:
	mov	eax, DWORD PTR [esp]
	ret
