.data

n: .space 4
x: .space 4
elem: .space 4
citaf: .asciz "%ld"
citaf_spatiu: .asciz "%s"
v: .space 1000
spatiu: .asciz " "
aux: .space 4

.text

.global main

main:

pushl $n
pushl $citaf
call scanf
popl %ebx
popl %ebx

pushl $x
pushl $citaf
call scanf
popl %ebx
popl %ebx


lea v, %edi
mov $0, %ecx


citire_sir:

	cmp n, %ecx
	je parc_sir1

	pusha
	pushl $elem
	pushl $citaf
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	mov elem, %eax
	mov %eax, (%edi, %ecx, 4)
	
	
	add $1, %ecx
	jmp citire_sir
	
	

parc_sir1:

mov $0, %ecx

parc_sir:

cmp n, %ecx
je exit

mov $0, %edx
mov (%edi, %ecx,4), %eax
mov %eax, aux
mov x, %ebx
div %ebx

cmp $0, %edx
je afisx

add $1, %ecx

jmp parc_sir


	afisx:
		
		pusha
		pushl aux
		pushl $citaf
		call printf
		popl %ebx
		popl %ebx
		
		pushl $spatiu
		pushl $citaf_spatiu
		call printf
		popl %ebx
		popl %ebx
		popa
		
		add $1, %ecx
		jmp parc_sir
		




exit:

	
	
	pushl $0
	call fflush
	popl %ebx

	mov $1, %eax
	mov $0, %ebx
	int $0x80
	
	
