.data

afis: .asciz "%d"
afis2: .asciz "%s"
a: .space 4
spatiu: .ascii " "
.text

.global main

main:


pushl $a
pushl $afis
call scanf
popl %ebx
popl %ebx



mov a, %ecx
add $1, %ecx

loop1:
	sub $1, %ecx

	cmp $0, %ecx
	je exit
	
	mov $0, %edx
	mov a, %eax
	div %ecx
	cmp $0, %edx
	je printdiv
	
	jmp loop1
	
	printdiv:
	
	pusha
	pushl %ecx
	pushl $afis
	call printf
	popl %ebx
	popl %ebx
	

		
	pushl $spatiu
	pushl $afis2
	call printf
	popl %ebx
	popl %ebx
	
	popa
	

	
	
	jmp loop1


exit:

	pushl $0
	call fflush
	popl %ebx


mov $1, %eax
mov $0, %ebx
int $0x80
