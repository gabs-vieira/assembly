_Z9somaVetorPsi:
	push	ebx
	mov	edx, DWORD PTR 12[esp]
	test	edx, edx
	jle	.L4
	mov	eax, DWORD PTR 8[esp]
	lea	ebx, [eax+edx*2]
	xor	edx, edx
.L3:
	movsx	ecx, WORD PTR [eax]
	add	eax, 2
	add	edx, ecx
	cmp	eax, ebx
	jne	.L3
	mov	eax, edx
	pop	ebx
	ret
.L4:
	xor	edx, edx
	pop	ebx
	mov	eax, edx
	ret
main:
	xor	eax, eax
	ret
