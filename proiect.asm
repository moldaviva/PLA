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
format1   db "Introduceti o operatie cu matrici:", 13, 10, 0
filename  db 20 dup(0)
operatie  db 20 dup(0)
format2   db "%s", 0
mode_rb   db "rb", 0
format3   db "%c", 0
buffer    db 0
matrix    db 100 dup(0)

.code
start:
	
	push offset format1
	call printf
	add esp, 4
	
	push offset filename
	push offset format2
	call scanf
	add esp, 8
	
	
	push offset mode_rb
	push offset filename
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
	
	push 0
	call exit
end start
