.data

voc: .asciz "aeiouAEIOU"
sir: .space 100
citafis: .asciz "%s"
afis: .asciz "%d"
cont: .space 4
spatiu: .asciz " "
elem: .space 1
lungime: .space 4
.text

.global main

main:

pushl $sir
call gets
popl %ebx

push $sir
call strlen
pop %ebx

mov %eax, lungime

lea sir, %edi
lea voc, %esi
mov $0, %ecx

jmp loop

preloop:

	inc %ecx

	loop:

		cmp lungime, %ecx
		je exit

		mov (%edi,%ecx,1),%bl
		
		mov $0, %eax

		verif_voc:
		
			cmp $10, %eax
			je preloop
			
			mov (%esi,%eax,1),%dl
			cmp %bl, %dl
			je count
			
			add $1, %eax
			jmp verif_voc
			
			count:
			
				incl cont
				jmp preloop
			

exit:

pushl cont
pushl $afis
call printf
popl %ebx
popl %ebx


pushl $0
call fflush
popl %ebx

mov $1, %eax
mov $0, %ebx
int $0x80
