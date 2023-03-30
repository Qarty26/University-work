.data

n: .space 15
formatString: .asciz "%ld"
formatString2: .asciz "%s"
x: .long 4
stop_loop1: .space 4
aux: .long 0
spatiu: .ascii " "


.text
.global main

main:

#citire------------
pushl $n
pushl $formatString
call scanf
pop %ebx
pop %ebx
#citire------------


mov n, %eax
cmp $1, %eax
je n1
cmp $2, %eax
je n2



mov n, %eax
sub $2, %eax
mov %eax, n


pushl $2
pushl $formatString
call printf
popl %ebx
popl %ebx

pushl $spatiu
pushl $formatString2
call printf
popl %ebx
popl %ebx

pushl $3
pushl $formatString
call printf
popl %ebx
popl %ebx

pushl $spatiu
pushl $formatString2
call printf
popl %ebx
popl %ebx


mov n, %esi


loop2:

	mov x, %edi
	add $1, %edi
	mov %edi, x

	cmp $0, %esi
	je exit

	mov x, %eax
	mov $2, %ebx
	div %ebx
	add $1, %eax
	mov %eax, stop_loop1


	mov $2, %ecx
			
		

	loop1:			


		cmp %ecx, stop_loop1
			je printx
			
		mov $0, %edx
		mov x, %eax
		div %ecx
		
		cmp $0, %edx
			je loop2
		
		add $1, %ecx
		jmp loop1
		
		
		printx:
			pushl x
			pushl $formatString
			call printf
			popl %ebx
			popl %ebx
			
			pushl $spatiu
			pushl $formatString2
			call printf
			popl %ebx
			popl %ebx
			
			sub $1, %esi
			
			
			jmp loop2
		


	jmp exit
	
	
n1:

	pushl $2
	pushl $formatString
	call printf
	popl %ebx
	popl %ebx

	pushl $0
	call fflush
	popl %ebx

	jmp exit


n2:

	pushl $2
	pushl $formatString
	call printf
	popl %ebx
	popl %ebx
	
	pushl $spatiu
	pushl $formatString2
	call printf
	popl %ebx
	popl %ebx

	pushl $3
	pushl $formatString
	call printf
	popl %ebx
	popl %ebx
	



exit:

	pushl $0
	call fflush
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
