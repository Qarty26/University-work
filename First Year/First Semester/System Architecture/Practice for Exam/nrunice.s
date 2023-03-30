.data
cit: .asciz "%d"
v: .space 100
n: .space 4
elem: .space 4
count: .long 0

.text

.global main

main:

push $n
push $cit
call scanf
pop %ebx
pop %ebx

lea v, %edi
mov $0, %ecx

jmp loopcit

loopcit1:

	add $1, %ecx

		loopcit:

		cmp n, %ecx
		je invalid

		pusha
		push $elem
		push $cit
		call scanf
		pop %ebx
		pop %ebx
		popa

		mov elem, %eax
		mov %eax, (%edi, %ecx,4)

		jmp loopcit1
			
invalid:

	mov $0, %eax
	mov $0, %ecx

valid:

	cmp n, %eax
	je exit
	
	mov $0, %ecx
	
	valid2:
	
		cmp n, %ecx
		je valid_temp
		
		mov (%edi,%eax,4) , %ebx
		mov (%edi, %ecx,4), %edx
		
		cmp %ebx, %edx
		je count_func
		
		add $1, %ecx
		jmp valid2
		
		count_func:
		
			mov count, %esi
			add $1, %esi
			mov %esi, count
			
			add $1, %ecx
			jmp valid2
		
		
		valid_temp:

			mov count, %esi
			cmp $1, %esi
			jg afis
			
			add $1, %eax

			mov $0, %esi
			mov %esi, count
			jmp valid

afis:

	mov (%edi, %eax,4), %esi
	mov %esi, elem

	pusha
	push elem
	push $cit
	call printf
	pop %ebx
	pop %ebx
	popa
	
	add $1, %eax
	mov $0, %esi
	mov %esi, count
	
	jmp valid

exit:

push $0
call fflush
pop %ebx

mov $1, %eax
xorl %ebx, %ebx
int $0x80
