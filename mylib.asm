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

fprintt macro matrix, format
	push matrix
	push offset format
	push esi
	call fprintf
	add esp, 12
endm
