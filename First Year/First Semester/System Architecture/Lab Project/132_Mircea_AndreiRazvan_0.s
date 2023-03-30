.data

n: .space 4
index_1: .long 0
index_2: .long 0
matrix: .space 40000
matrix_aux: .space 40000
leg: .space 400
opint: .asciz "%d"
opstr: .asciz "%s"
spatiu: .asciz " "
elem: .space 4
x: .space 4
nr_pb: .space 4
mres: .space 40000
k: .space 4
nod_i: .space 4
nod_j: .space 4


.text



matrix_mult:

	push %ebp
	mov %esp, %ebp	
	
	push %ebx
	push %edi
	
	subl $16, %esp
	
	movl $0,-4(%ebp) #i
	movl $0,-8(%ebp) #j
	movl $0,-12(%ebp) #k
	movl $0,-16(%ebp) #aux

	add $16, %esp
	
	jmp loop_1
	
	pre_loop_1:
	
	addl $1, -4(%ebp)
	movl $0, -8(%ebp)
	
	
	loop_1:
		
		mov -4(%ebp),%ecx
		cmp 20(%ebp), %ecx
		je exit_loop_1
		
		jmp loop_2
		
		pre_loop_2:
		
			addl $1, -8(%ebp)
			movl $0, -12(%ebp)

		loop_2:
			
			mov -8(%ebp),%ecx
			cmp 20(%ebp), %ecx
			je pre_loop_1
			
			jmp loop_3
			
			pre_loop_3:
				
				addl $1, -12(%ebp)	
				
			loop_3:
			
				mov -12(%ebp),%ecx
				cmp 20(%ebp),%ecx
				je pre_loop_2
				


				
				#a[i][k]
				
				movl 8(%ebp),%edi
				
				mov -4(%ebp),%ebx
				mov 20(%ebp),%eax
				xorl %edx, %edx
				mull %ebx
				addl -12(%ebp),%eax
				mov (%edi,%eax,4),%ebx
				mov %ebx, -16(%ebp)
				
				
				
				#b[k][j]
				
				mov 12(%ebp),%edi
				
				mov -12(%ebp),%ebx
				mov 20(%ebp),%eax
				xorl %edx, %edx
				mull %ebx
				addl -8(%ebp),%eax
				mov (%edi,%eax,4),%ebx
				
				mov -16(%ebp),%eax
				mull %ebx
				mov %eax, -16(%ebp)
				
				
				
				#calcul c[i][j]
				
				mov 16(%ebp),%edi
				
				mov -4(%ebp),%ebx
				mov 20(%ebp),%eax
				xorl %edx, %edx
				mull %ebx
				addl -8(%ebp),%eax
				
				mov -16(%ebp),%ecx
				addl %ecx, (%edi,%eax,4)
				
				jmp pre_loop_3
				


	exit_loop_1:	
	
	
	pop %edi
	pop %ebx
	pop %ebp
	ret
	
	
	
	


.global main

main:

push $nr_pb
push $opint
call scanf
pop %ebx
pop %ebx

mov nr_pb,%eax
cmp $1, %eax
je pb1

cmp $2, %eax
je pb2

pb1:

	push $n
	push $opint
	call scanf
	pop %ebx
	pop %ebx		
					
			
	citire_leg:

		mov index_1, %ecx
		cmp %ecx, n
		je cont_main
		
		push $elem
		push $opint
		call scanf
		pop %ebx
		pop %ebx
		
		mov elem, %eax
		lea leg, %edi
		mov index_1, %ecx
		mov %eax, (%edi, %ecx, 4)
		
		incl index_1
		jmp citire_leg
		
		
	cont_main:

		mov $0, %eax
		mov %eax, index_1
		mov %eax, index_2
		jmp citire_conex
		
	precitire_conex:
		
		incl index_1

	citire_conex:
		
		mov index_1, %ecx
		cmp n, %ecx
		je afisare
		
		lea leg, %edi
		mov (%edi, %ecx, 4), %eax
		mov %eax, elem
		
		mov $0, %eax
		mov %eax, index_2
		
		
		for2:
		
			mov index_2, %ecx
			cmp elem, %ecx
			je precitire_conex
			
			pusha
			push $x
			push $opint
			call scanf
			pop %ebx
			pop %ebx
			popa
			
			
			lea matrix, %esi
			mov index_1, %eax
			mov $0, %edx
			mull n
			add x, %eax
			movl $1, (%esi, %eax,4)
			
			incl index_2
			jmp for2
			
			

	afisare:

	lea matrix, %esi
	movl $0, %eax
	movl %eax, index_1
	movl %eax, index_2

	jmp loop1

	preloop1:

		mov index_1, %eax
		add $1, %eax
		mov %eax, index_1


	loop1:
		mov index_1, %eax
		cmp n, %eax
		je exit
		
		mov $0, %eax
		mov %eax, index_2
		

		
		loop2:
			
			mov index_2, %eax
			cmp %eax, n
			je preloop1

			mov index_1, %eax
			mov $0, %edx
			mull n
			add index_2, %eax
			movl (%esi, %eax,4), %ebx
			movl %ebx, elem
			
			pusha
			pushl elem
			pushl $opint
			call printf
			popl %ebx
			popl %ebx
			
			pushl $spatiu
			pushl $opstr
			call printf
			popl %ebx
			popl %ebx
			popa
			

			incl index_2
			

			jmp loop2
			
	
	
#---------------------------------------------B-------------------------------------------------------------		
pb2:

	push $n
	push $opint
	call scanf
	pop %ebx
	pop %ebx		
					
			
	citire_leg2:

		mov index_1, %ecx
		cmp %ecx, n
		je cont_main2
		
		push $elem
		push $opint
		call scanf
		pop %ebx
		pop %ebx
		
		mov elem, %eax
		lea leg, %edi
		mov index_1, %ecx
		mov %eax, (%edi, %ecx, 4)
		
		incl index_1
		jmp citire_leg2
		
		
	cont_main2:

		mov $0, %eax
		mov %eax, index_1
		mov %eax, index_2
		jmp citire_conex2
		
		
		
		
	precitire_conex2:
		
		incl index_1

	citire_conex2:
		
		mov index_1, %ecx
		cmp n, %ecx
		je prelucrare_mres
		
		lea leg, %edi
		mov (%edi, %ecx, 4), %eax
		mov %eax, elem
		
		mov $0, %eax
		mov %eax, index_2
		
		
		for2_2:
		
			mov index_2, %ecx
			cmp elem, %ecx
			je precitire_conex2
			
			pusha
			push $x
			push $opint
			call scanf
			pop %ebx
			pop %ebx
			popa
			
			
			lea matrix, %esi
			mov index_1, %eax
			mov $0, %edx
			mull n
			add x, %eax
			movl $1, (%esi, %eax,4)
			
			incl index_2
			jmp for2_2
			
	prelucrare_mres:
	
	pusha
	push $k
	push $opint
	call scanf
	pop %ebx
	pop %ebx
	
	push $nod_i
	push $opint
	call scanf
	pop %ebx
	pop %ebx
	
	push $nod_j
	push $opint
	call scanf
	pop %ebx
	pop %ebx
	popa

	
	mov k, %ecx
	cmp $0, %ecx
	je k0
	
	cmp $1, %ecx
	je k1
	
	cmp $2, %ecx
	jge k2
	
	k0:
	
		push $0
		push $opint
		call printf
		pop %ebx
		pop %ebx
		
		jmp exit
		
		
	k1:
	
		lea matrix, %edi
		mov nod_i, %eax
		mov n, %ebx
		mov $0, %edx
		mull %ebx
		add nod_j, %eax
		mov (%edi,%eax,4),%ebx
		
		pusha
		push %ebx
		push $opint
		call printf
		pop %ebx
		pop %ebx
		popa
		
		jmp exit
		
	k2:
		
		pusha
		push n
		push $mres
		push $matrix
		push $matrix
		call matrix_mult
		pop %ebx
		pop %ebx
		pop %ebx
		pop %ebx
		popa
		
		
		
		sub $2, %ecx
		
		loop_k:
		
			cmp $0, %ecx
			je afisare_nr_leg
			
			lea mres, %edi
			lea matrix_aux, %esi
			
			mov n, %eax
			mov $0, %edx
			mull %eax
			mov $0, %edx
			
			loop_pregatire:
			
				cmp %edx, %eax
				je cont_loop_k
				
				mov (%edi,%edx,4),%ebx
				mov %ebx, (%esi,%edx,4)
				movl $0,(%edi,%edx,4)
				
				
				add $1, %edx
				jmp loop_pregatire
				
			
			cont_loop_k:
		
				pusha
				push n
				push $mres
				push $matrix
				push $matrix_aux
				call matrix_mult
				pop %ebx
				pop %ebx
				pop %ebx
				pop %ebx
				popa
				
				sub $1, %ecx
				jmp loop_k
				
				
		afisare_nr_leg:
		
			lea mres, %edi
			mov nod_i, %eax
			mov n, %ebx
			mov $0, %edx
			mull %ebx
			add nod_j, %eax
			mov (%edi,%eax,4),%ebx
			
			pusha
			push %ebx
			push $opint
			call printf
			pop %ebx
			pop %ebx
			popa


exit:

push $0
call fflush
pop %ebx

mov $1, %eax
mov $0, %ebx
int $0x80
