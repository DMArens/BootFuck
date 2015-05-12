; turns a hex value from dx into a string
; located at HEX_OUT

print_hex:
	pusha
	mov	cx, 4

    string_loop:
	dec	cx
	mov	ax, dx
	shr	dx, 4
	and	ax, 0xf

	mov	bx, HEX_OUT
	add	bx, 2
	add	bx, cx
	mov	byte [bx], '0'

	cmp	ax, 0xa
	jl	add_char
	add	byte [bx], 7	; ascii digit alpha offset

    add_char:
	add	byte [bx], al
	cmp	cx, 0
	je	done
	jmp	string_loop

    done:
	mov	si, HEX_OUT
	call	print_string
	popa
	ret	

HEX_OUT: db '0x0000', 0xa, 0xd, 0

; vim: ft=fasm:ts=8:sts=4:sw=4
