.data

i: .space 4
j: .space 4
aux: .space 4
v: .space 100
spatiu: .asciz " "
strout: .asciz "%s"
intout: .asciz "%d"
n: .space 4
m: .space 4
elem: .space 4

.text

.global main


main:

pushl $n
pushl $intout
call scanf
popl %ebx
popl %ebx

mov n, %ecx
sub $1, %ecx
mov %ecx, m

lea v, %edi
mov $0, %ecx

jmp loop

preloop:

	add $1, %ecx

	loop:

		cmp n,%ecx
		je continue_main

		pusha
		pushl $elem
		pushl $intout
		call scanf
		popl %ebx
		popl %ebx
		popa
		
		mov elem, %eax
		mov %eax, (%edi,%ecx,4)
		
		jmp preloop
		
		
continue_main:

mov $0, %eax
jmp sort_for1

pre_sort_for1:

	add $1, %eax
		
		
sort_for1:

	cmp m, %eax
	je preafisare
	
	
	mov %eax, %ecx
	add $1, %ecx


	sort_for2:

		cmp %ecx, n
		je pre_sort_for1

		mov (%edi,%ecx,4), %ebx
		mov (%edi,%eax,4), %edx

		cmp %ebx, %edx
		jg swap

		add $1, %ecx
		jmp sort_for2
		
		swap:
		
			mov %edx, (%edi,%ecx,4)
			mov %ebx, (%edi,%eax,4)
		
			
			add $1, %ecx
			jmp sort_for2


preafisare:

mov $0, %ecx

afisare:

cmp n, %ecx
je exit

mov (%edi, %ecx,4), %edx
mov %edx, elem

			pusha
			pushl elem
			pushl $intout
			call printf
			popl %esi
			popl %esi
			
			pushl $spatiu
			pushl $strout
			call printf
			popl %esi
			popl %esi
			popa



add $1, %ecx
jmp afisare
	
	
		
		


exit:

push $0
call fflush
pop %ebx

mov $1, %eax
xor %ebx, %ebx
int $0x80

