; print a string with location passed in SI
; clobbers AX, BX
print_string:
	lodsb
	test al, al
	jz @f
	mov ah, 0Eh
	xor bx, bx
	int 10h
	jmp print_string
@@:	ret
