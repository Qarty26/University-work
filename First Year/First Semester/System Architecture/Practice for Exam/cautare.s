.data

apint: .asciz "%d"
apstr: .asciz "%s"
spatiu: .asciz " "
n: .space 4
m: .space 4
sir: .space 100
index: .long 0
elem: .space 4
x: .space 4

start: .space 4
end: .space 4
mid: .space 4

da: .asciz "DA!\n"
nu: .asciz "NU!\n"



.text

.global main

main:

push $x
push $apint
call scanf
pop %ebx
pop %ebx

push $n
push $apint
call scanf
pop %ebx
pop %ebx

mov n, %eax
sub $1, %eax
mov %eax, m

lea sir, %edi

mov $0, %ecx

citire_sir:

	cmp n, %ecx
	je cont_main
	
	pusha
	push $elem
	push $apint
	call scanf
	pop %ebx
	pop %ebx
	popa
	
	mov elem, %eax
	mov %eax, (%edi, %ecx,4)
	
	add $1, %ecx
	
	jmp citire_sir
	
	
cont_main:

	mov $2, %ecx

	mov $0, %eax
	mov %eax, start

	mov m, %eax
	mov %eax, end

	mov $0, %eax
	add start, %eax
	add end, %eax

	div %ecx
	mov %eax, mid
	
	verif:
	
		mov start, %ebp
		mov end, %esi
		
		cmp %ebp, %esi
		jle afis_nu
		
		mov mid, %eax
		mov x, %edx
		
		cmp %edx, (%edi, %eax, 4)
		je afis_da
		jg st
		jl dr
		
	afis_da:
	
		push $da
		push $apstr
		call printf
		pop %ebx
		pop %ebx
		
		jmp exit
		
	st:
	
		mov mid, %eax
		sub $1, %eax
		mov %eax, end
		
		mov $0, %eax
		add end, %eax
		add start, %eax
		
		mov $0, %edx
		div %ecx
		mov %eax, mid
		
		jmp verif
		
	dr:
	
		mov mid, %eax
		add $1, %eax
		mov %eax, start
		
		mov $0, %eax
		add end, %eax
		add start, %eax
		
		mov $0, %edx
		div %ecx
		mov %eax, mid
		
		jmp verif
		
afis_nu:

	push $nu
	push $apstr
	call printf
	pop %ebx
	pop %ebx


exit:

push $0
call fflush
pop %ebx

mov $1, %eax
mov $0, %ebx
int $0x80

