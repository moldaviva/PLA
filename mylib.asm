scanfff macro operatie, format
	push offset operatie
	push offset format
	call scanf
	add esp, 8
endm

printfa macro format
	push offset format
	call printf
	add esp, 4
endm

printfb macro operatie, format
	push operatie
	push offset format
	call printf
	add esp, 8
endm

fopennn macro filename, mode
	push offset mode
	push offset filename
	call fopen
	add esp, 8
endm

fclosee macro numar
	push numar
	call fclose
	add esp, 8
endm

fscanff macro matrix, format
	push offset matrix
	push offset format
	push esi
	call fscanf
	add esp, 12
endm

fprint1 macro matrix, format
	push matrix
	push offset format
	push esi
	call fprintf
	add esp, 12
endm

fprint2 macro format
	push offset format
	push esi
	call fprintf
	add esp, 8
endm

compare macro operatie, xoperatie, eticheta1, eticheta2, eticheta3, eticheta4
eticheta1:	
	lea si, operatie
	lea di, xoperatie
	dec di
eticheta2:
	inc di
	lodsb
	cmp [edi], al
	jne eticheta3                            
	cmp al, 0                                 
	jne eticheta2
	jmp eticheta4
endm

operatiee macro mesaj, filename, format, mode
	printfa mesaj
	scanfff filename, format
	fopennn filename, mode
        mov esi, eax
	mov ebx, 0
	mov ecx, 0
endm

citire_matrice macro matrix, eticheta1, eticheta2, eticheta3
eticheta1:
	fscanff buffer, format3
	test eax, eax
	jl eticheta2
	mov cl, buffer
 	mov matrix[ebx], cl
	mov edx, esi
	lea esi, buffer
	lea edi, matrix[ebx]
	mov ecx, 1
	rep movsb
	mov esi, edx
	inc ebx
	jmp eticheta1
eticheta2:
	fclosee esi
	jmp eticheta3
endm

afisare_matrice macro matrix, format, minus, endline, eticheta1, eticheta2, eticheta3, eticheta4, filename, nr_linii, nr_coloane
	mov cl, matrix_A[0]
	mov eax, ecx
	mul ecx
	mov ecx, eax
	mov nr_linii, ecx
	mov cl, matrix[0]
	mov nr_coloane, ecx
	mov ebx, 0
eticheta1:
	inc ebx
	cmp matrix_s[ebx], 0
	jz eticheta4
	fprint1 minus
eticheta4:	
	mov al, matrix[ebx]
	fprint1 eax, format
	cmp ebx, nr_linii
	jz eticheta2
	cmp ebx, nr_coloane
	jne eticheta1
	mov ecx, 0
	mov cl, matrix_A[0]
	add nr_coloane, ecx
	fprint2 endline 
	jmp eticheta1
eticheta2:
	fclosee esi
	printfa filename
	jmp eticheta3
endm
