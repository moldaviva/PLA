.386
.model flat, stdcall

includelib msvcrt.lib

include mylib.asm

extern printf: proc
extern scanf: proc
extern exit: proc
extern fclose: proc
extern fopen: proc
extern fscanf: proc
extern fprintf: proc


public start

.data
format1    db "Introduceti o operatie cu matrici:", 13, 10, 0
format2    db "%s"    , 0
format3    db "%d"    , 0
format4    db "%d"    , 13, 10, 0  
format5    db "%d"    , 32, 0
operatie   db 20    dup(0)
operatie1  db "A+B"   , 0
operatie2  db "aA"    , 0
operatie3  db "A-B"   , 0
operatie4  db "At"    , 0
operatie5  db "det(A)", 0
mesaj_A    db ">A="    , 13, 10, 0
mesaj_B    db ">B="    , 13, 10, 0
mesaj_a_   db ">a="    , 13, 10, 0
mode_r     db "r"    , 0
mode_w     db "w"    , 0
filename   db 20    dup(0)
filename_A db 20    dup(0) 
filename_B db 20    dup(0)
filename_C db "rezultat.txt", 0
filename_D db "Rezultat: rezultat.txt", 13, 10, 0
nimic      dd 			0
nr_linii   dd           0
nr_coloane dd			0	
buffer     db           0
error1	   db "Matricile nu sunt de aceleasi dimensiuni", 13, 10, 0
endline    db 13, 10, 0
matrix_A   db 100   dup(0)
matrix_B   db 100   dup(0)
matrix_C   db 100   dup(0)
terminare  db "Programul s-a incheiat.", 13, 10, 0
caca1      db "caca1", 13, 10, 0
caca2      db "caca2", 13, 10, 0
caca3      db "caca3", 13, 10, 0
numar      dd           0
.code
start:
	printfa format1
	scanfff operatie, format2
compare_1:	
	lea si, operatie
	lea di, operatie1
	dec di
compare_1_cont:
	inc di
	lodsb
	cmp [edi], al
	jne exitt                             
	cmp al, 0                                 
	jne compare_1_cont
	jmp operatie_1_A
operatie_1_A:
 	printfa mesaj_A
	scanfff filename_A, format2
	fopennn filename_A, mode_r
	mov esi, eax
	mov ebx, 0
	mov ecx, 0
bucla_citire_1_A:
	fscanff buffer, format3
	test eax, eax
	jl inchidere_fisier_1_A
	mov cl, buffer
 	mov matrix_A[ebx], cl
	mov edx, esi
	lea esi, buffer
	lea edi, matrix_A[ebx]
	mov ecx, 1
	rep movsb
	mov esi, edx
	inc ebx
	jmp bucla_citire_1_A
inchidere_fisier_1_A:
	fclosee esi
	jmp operatie_1_B
operatie_1_B:
 	printfa mesaj_B
	scanfff filename_B, format2
	fopennn filename_B, mode_r
	mov esi, eax
	mov ebx, 0
	mov ecx, 0
bucla_citire_1_B:
	fscanff buffer, format3
	test eax, eax
	jl inchidere_fisier_1_B
	mov edx, esi
	lea esi, buffer
	lea edi, matrix_B[ebx]
	mov ecx, 1
	rep movsb
	mov esi, edx
	inc ebx
	jmp bucla_citire_1_B
inchidere_fisier_1_B:
	fclosee esi
	jmp operatie1_A_B
operatie1_A_B:
	fopennn filename_C, mode_w
	mov esi, eax
	mov ecx, 0
	mov cl, matrix_A[0] 
	cmp cl, matrix_B[0]
	jne matrici_inegale
	mov eax, ecx
	mul ecx
	mov ecx, eax
	jmp operatie1_A_B_cont
matrici_inegale:
	printfa error1
	jmp exitt
operatie1_A_B_cont:
	mov al, matrix_A[ecx]
	mov bl, matrix_B[ecx]
	add al, bl
	mov matrix_C[ecx], al
	loop operatie1_A_B_cont

	mov cl, matrix_A[0]
	mov eax, ecx
	mul ecx
	mov ecx, eax
	mov nr_linii, ecx
	mov cl, matrix_A[0]
	mov nr_coloane, ecx
	mov ebx, 0
operatie1_A_B_caca:
	inc ebx
	mov al, matrix_C[ebx]
	fprintt eax, format5
	cmp ebx, nr_linii
	jz sfarsit_operatie1
	cmp ebx, nr_coloane
	jne operatie1_A_B_caca
	mov ecx, 0
	mov cl, matrix_A[0]
	add nr_coloane, ecx
	fprintt nimic, endline 
	jmp operatie1_A_B_caca
sfarsit_operatie1:
	fclosee esi
	printfa filename_D
exitt:
	printfa terminare
	push 0
	call exit
end start
