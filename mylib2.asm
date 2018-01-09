sintaxa_faina macro semn, index1, index2, index3, eticheta1, eticheta2, eticheta3, eticheta4, eticheta5, eticheta6, eticheta7	
	mov eax, 0
	mov semn, 0
	mov ebx, 0
	mov al, matrix_A[index1]
	push eax
	mov ebx, index1
	negativ_number semn, eticheta1, eticheta2
	mov cl, matrix_A[index2]
	push ecx	
	mov ebx, index2
	negativ_number semn, eticheta3, eticheta4
	pop ecx
	pop eax
	mul cl
	push eax
	mov eax, 0
	mov al, matrix_A[index3]
	push eax
	mov ebx, index3
	negativ_number semn, eticheta5, eticheta6
	pop ecx
	pop eax
	mul cl
	push eax
	cmp semn, 2
	jge eticheta7
	sub semn, 2
eticheta7:
endm

extra_thicc macro semn1, semn2, semn3, eticheta1, eticheta2, eticheta3, eticheta4, eticheta5, eticheta6, eticheta7, eticheta8, eticheta9, eticheta10
eticheta1:
	cmp semn1, 0
	jz eticheta2
	jmp eticheta6
eticheta2:
	cmp semn2, 0
	jz eticheta3
	jmp eticheta5
eticheta3:
	pop ebx
	pop eax
	sub eax, ebx
	cmp al, 0
	jl eticheta4
	push eax
	mov semn3, 0
	jmp eticheta10
eticheta4:
	mov edi, eax
	mov eax, 256
	sub eax, edi
	push eax
	jmp eticheta10
eticheta5:
	pop ebx
	pop eax
	add eax, ebx
	push eax
	mov semn3, 0
	jmp eticheta10
eticheta6:
	cmp semn2, 0
	jz eticheta7
	jmp eticheta8
eticheta7:
	pop eax
	pop ebx
	add eax, ebx
	push eax
	mov semn3, 1
	jmp eticheta10
eticheta8:
	pop eax
	pop ebx
	sub eax, ebx	
	cmp al, 0
	jl eticheta9
	push eax
	mov semn3, 0
	jmp eticheta10
eticheta9:
	mov edi, eax
	mov eax, 256
	sub eax, edi
	push eax
	mov semn3, 1
	jmp eticheta10
endm

somebody_toucha_my_spaghetii macro semn1, semn2, semn3, eticheta1, eticheta2, eticheta3, eticheta4, eticheta5, eticheta6, eticheta7, eticheta8, eticheta9, eticheta10
eticheta1:
	cmp semn1, 0
	jz eticheta2
	jmp eticheta6
eticheta2:
	cmp semn2, 0
	jz eticheta3
	jmp eticheta4
eticheta3:
	pop eax
	pop ebx
	add eax, ebx
	push eax
	mov semn3, 0
	jmp eticheta10
eticheta4:
	pop ebx 
	pop eax 
	sub eax, ebx
	cmp al, 0
	jl eticheta5
	push eax
	mov semn3, 0
	jmp eticheta10
eticheta5:
	mov edi, eax
	mov eax, 256
	sub eax, edi
	push eax
	mov semn3, 1
	jmp eticheta10
eticheta6:
	cmp semn2, 0
	jz eticheta7
	jmp eticheta8
eticheta7:
	pop ebx
	pop eax
	sub eax, ebx
	sub eax, ebx
	cmp al, 0
	jl eticheta8
	push eax
	mov semn3, 0
	jmp eticheta10
eticheta8:
	mov edi, eax
	mov eax, 256
	sub eax, edi
	push eax
	mov semn3, 1
	jmp eticheta10
eticheta9:
	pop ebx
	pop eax
	add eax, ebx
	push eax
	mov semn3, 1
	jmp eticheta10
endm