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
minus      db "-"     , 0
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
scalar     db 			0
nr_linii   dd           0
nr_coloane dd			0	
buffer     db           0
error      db "Matricile sunt salbatice"
error1	   db "Matricile nu sunt de aceleasi dimensiuni", 13, 10, 0
endline    db 13, 10, 0
matrix_A   db 100   dup(0)
matrix_B   db 100   dup(0)
matrix_C   db 100   dup(0)
matrix_s   db 100   dup(0)
terminare  db "Programul s-a incheiat.", 13, 10, 0
caca1      db "caca1", 13, 10, 0
caca2      db "caca2", 13, 10, 0
caca3      db "caca3", 13, 10, 0
numar      dd           0
.code
start:
	printfa format1
	scanfff operatie, format2
operatie_1:
	compare operatie, operatie1, compare_1, compare_1_cont, operatie_2, operatie_1_A
operatie_2:
	compare operatie, operatie2, compare_2, compare_2_cont, operatie_3, operatie_2_A
operatie_3:
	compare operatie, operatie3, compare_3, compare_3_cont, operatie_4, operatie_3_A
operatie_4:
	compare operatie, operatie4, compare_4, compare_4_cont, exitt, operatie_4_A
	
operatie_1_A:
	operatiee mesaj_A, filename_A, format2, mode_r
	citire_matrice matrix_A, bucla_citire_1_A, inchidere_fisier_1_A, operatie_1_B, semn_1_A
operatie_1_B:
 	operatiee mesaj_B, filename_B, format2, mode_r
	citire_matrice matrix_B, bucla_citire_1_B, inchidere_fisier_1_B, operatie_1_A_B, semn_1_B
operatie_1_A_B:
	fopennn filename_C, mode_w
	mov esi, eax
	mov ecx, 0
	mov cl, matrix_A[0] 
	cmp cl, matrix_B[0]
	jne matrici_inegale_1
	mov eax, ecx
	mul ecx
	mov ecx, eax
	jmp operatie1_A_B_cont
matrici_inegale_1:
	printfa error1
	jmp exitt
operatie1_A_B_cont:
	mov al, matrix_A[ecx]
	mov bl, matrix_B[ecx]
	add ax, bx
	cmp al, 0
	jl negativ_1
	jmp pozitiv_1
negativ_1:
	mov matrix_s[ecx], 1
	mov edi, eax
	mov eax, 256
	sub eax, edi
	mov matrix_C[ecx], al
	loop operatie1_A_B_cont
	jmp afisare_matrice_1
pozitiv_1:
	mov matrix_s[ecx], 0
	mov matrix_C[ecx], al
	loop operatie1_A_B_cont
afisare_matrice_1:
	afisare_matrice matrix_C, format5, endline, operatie1_A_B_afisare, sfarsit_operatie1, exitt, semn_minus_1, filename_D, nr_linii, nr_coloane
	
operatie_2_A:
	operatiee mesaj_A, filename_A, format2, mode_r
	citire_matrice matrix_A, bucla_citire_2_A, inchidere_fisier_2_A, operatie_2_scalar, semn_2_A
operatie_2_scalar:
	printfa mesaj_a_
	scanfff scalar, format3
operatie_2_A_scalar:
	fopennn filename_C, mode_w
	mov esi, eax
	mov ecx, 0
	mov cl, matrix_A[0]
	mov eax, ecx
	mul ecx
	mov ecx, eax
operatie_2_A_scalar_cont:
	mov al, matrix_A[ecx]
	imul scalar
	cmp al, 0
	jl negativ_2
	jmp pozitiv_2
negativ_2:
	mov matrix_s[ecx], 1
	mov edi, eax
	mov eax, 256
	sub eax, edi
	mov matrix_C[ecx], al
	loop operatie_2_A_scalar_cont
	jmp afisare_matrice_2
pozitiv_2:
	mov matrix_s[ecx], 0
	mov matrix_C[ecx], al
	loop operatie_2_A_scalar_cont
afisare_matrice_2:
	afisare_matrice matrix_C, format5, endline, operatie2_A_a_afisare, sfarsit_operatie2, exitt, semn_minus_2, filename_D, nr_linii, nr_coloane

operatie_3_A:
	operatiee mesaj_A, filename_A, format2, mode_r
	citire_matrice matrix_A, bucla_citire_3_A, inchidere_fisier_3_A, operatie_3_B, semn_3_A
operatie_3_B:
 	operatiee mesaj_B, filename_B, format2, mode_r
	citire_matrice matrix_B, bucla_citire_3_B, inchidere_fisier_3_B, operatie_3_A_B, semn_3_B
operatie_3_A_B:
	fopennn filename_C, mode_w
	mov esi, eax
	mov ecx, 0
	mov cl, matrix_A[0] 
	cmp cl, matrix_B[0]
	jne matrici_inegale_3
	mov eax, ecx
	mul ecx
	mov ecx, eax
	jmp operatie3_A_B_cont
matrici_inegale_3:
	printfa error1
	jmp exitt
operatie3_A_B_cont:	
	mov al, matrix_A[ecx]
	mov bl, matrix_B[ecx]
	sub ax, bx
	cmp al, 0
	jl negativ_3
	jmp pozitiv_3
negativ_3:
	mov matrix_s[ecx], 1
	mov edi, eax
	mov eax, 256
	sub eax, edi
	mov matrix_C[ecx], al
	loop operatie3_A_B_cont
	jmp afisare_matrice_3
pozitiv_3:
	mov matrix_s[ecx], 0
	mov matrix_C[ecx], al
	loop operatie3_A_B_cont
afisare_matrice_3:
	afisare_matrice matrix_C, format5, endline, operatie3_A_B_afisare, sfarsit_operatie3, exitt, semn_minus_3, filename_D, nr_linii, nr_coloane

operatie_4_A:
	operatiee mesaj_A, filename_A, format2, mode_r
	citire_matrice matrix_A, bucla_citire_4_A, inchidere_fisier_4_A, operatie_4_transpusa, semn_4_A
operatie_4_transpusa:
	fopennn filename_C, mode_w
	mov esi, eax
	mov ecx, 0
	mov cl, matrix_A[0]
	mov eax, ecx
	mul ecx
	mov ecx, eax
	mov nr_linii, ecx
	mov cl, matrix_A[0]
	mov nr_coloane, ecx
	mov ecx, nr_linii
	sub ecx, nr_coloane
	inc ecx
	mov nr_coloane, ecx
	mov ebx, 1
	mov edi, 1
elemente_transpusa:
	mov eax, 0
	mov al, matrix_A[ebx]
	push eax
	cmp matrix_s[ebx], 1
	jz afisare_negativa
	jmp elemente_transpusa_cont
afisare_negativa:
	pop eax
	mov edx, eax
	mov eax, 256
	sub eax, edx
	push eax
	fprint2 minus
elemente_transpusa_cont:
	pop eax 
	fprint1 eax, format5
	cmp ebx, nr_linii
	jz sfarsit_operatie4
	cmp ebx, nr_coloane
	jne incrementare
	jmp elemente_transpusa_continuare
incrementare:
	add bl, matrix_A[0]
	jmp elemente_transpusa
elemente_transpusa_continuare:
	inc nr_coloane
	inc edi
	mov ebx, edi
	fprint2 endline
	jmp elemente_transpusa
sfarsit_operatie4:
	fclosee esi
	printfa filename_D
	jmp exitt
	
exitt:
	printfa terminare
	push 0
	call exit
end start
