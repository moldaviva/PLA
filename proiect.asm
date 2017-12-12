.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem msvcrt.lib, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern scanf:  proc
extern printf: proc
extern fread:  proc
extern fopen:  proc
extern fclose: proc
extern exit:   proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
format1    db "Introduceti o operatie cu matrici:", 13, 10, 0
filename   db 20    dup(0)
operatie   dw 20    dup(0)
operatie1  db "A+B"   , 0
operatie2  dw "aA"    , 0
operatie3  db "A-B"   , 0
operatie4  db "At"    , 0
operatie5  db "det(A)", 0
format2    db "%s"    , 0
mode_rb    db "rb"    , 0
format3    db "%c"    , 0
format4    db "%d"    , 0
buffer     db           0
;N_matrix   db			0
matrix     db 100   dup(0)
mesaj_A    db "A="    , 0
mesaj_B    db "B="    , 0
mesaj_a_   db "a="    , 0
filename_A db 20    dup(0) 
filename_B db 20    dup(0)
scalar     db           0
afisare	   db "%d ",    0
.code
start:
	
	push offset format1
	call printf
	add esp, 4
	
	push offset operatie
	push offset format2
	call scanf
	add esp, 8
	
	mov ax, operatie
	mov bx, operatie2
	cmp ax, bx
	jz operatie_aA
operatie_aA:
	push offset mesaj_A
	call printf 
	add esp, 4
	
	push offset filename_A
	push offset format2
	call scanf
	add esp, 8

	push offset mode_rb
	push offset filename_A
	call fopen
	add esp, 8
	mov esi, eax
	mov ebx, 0
	push esi
	push 1
	push 1
	push offset buffer
bucla_citire: 
	call fread
	test eax, eax
	jz inchidere_fisier
	cmp buffer, 13
	jz continuare_bucla_citire
	cmp buffer, 10
	jz continuare_bucla_citire
	cmp buffer, 20
	jz continuare_bucla_citire
	mov cl, buffer
	mov matrix[ebx], cl
	inc ebx
continuare_bucla_citire:
	xor eax, eax
	mov al, buffer
	push eax
	push offset format3
	call printf
	add esp, 8
	jmp bucla_citire
inchidere_fisier:
	add esp, 16
	push esi
	call fclose
	add esp, 4
citire_scalar:
	push offset scalar
	push offset format3
	call scanf
	add esp, 8
inmultire_cu_scalar:
	mov al, scalar
	mov ecx, 1
	mov dl, matrix[0]
inmultire:
	mul matrix[ebx]
	push ax
	push offset afisare
	call printf
	add esp, 8
	mov eax, 0
	dec ecx
	cmp ecx, ebx
	jl inmultire
	
	push 0
	call exit
end start
