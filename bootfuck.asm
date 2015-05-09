; This is my bootable brainfuck interpreter!
org 7c00h

SCREENWIDTH = 80
SCREENHEIGHT = 25
CODEBUF = 500h
TAPEBUF = 7e00h

draw_title:
	; scroll screen down
	mov	ax, 0700h
	mov	bh, 07h
	mov	cx, 0000h
	mov	dx, 184fh
	int	10h
	; print welcome; centered
	mov	ah, 02h
	mov	bx, 0000h
	mov	dx, (SCREENWIDTH - 20) / 2
	int	10h
	mov	si, welcome_string
	call	print_string
	; print best under welcome; centered
	mov	ax, 0200h
	mov	bx, 0000h
	mov	dx, (SCREENWIDTH - 26) / 2
	mov	dh, 1
	int	10h
	mov	si, best_string
	call	print_string
	mov	di, CODEBUF
get_input:
	mov	ah, 0
	int	16h
	cmp	al, 08h
	je	.backspaced
	mov	ah, 0eh
	int	10h
	stosb
	cmp	al, 0dh
	jne	get_input
    .end_of_line:	
	mov	al, 0ah
	int	10h
	jmp	clear_mem
    .backspaced:
	mov	ah, 0eh
	int	10h
	dec	di
	jmp	get_input    
clear_mem:
	mov	di, TAPEBUF
	mov	cx, 4096
	mov	al, 0
	rep stosb
	; the secret doesn't work.
	mov	cx, 20
	mov	si, secret_string
    @@:	lodsb
	stosb
	dec	cx
	jnz	@b
	mov	si, CODEBUF
	mov	di, TAPEBUF
brain_fuck:
	lodsb
	cmp	al, '+'
	jne	@f
	; increment value
	inc	byte [di]
	jmp	brain_fuck
    @@:	cmp	al, '-'
	jne	@f
	; decrement value
	dec	byte [di]
	jmp	brain_fuck
    @@:	cmp	al, '>'
	jne	@f
	; increment index
	inc	di
	jmp	brain_fuck
    @@:	cmp	al, '<'
	jne	@f
	; decrement index
	dec	di
	jmp	brain_fuck
    @@:	cmp	al, ','
	jne	@f
	; input
	mov	ah, 0
	int	16h
	mov	[di], al
	jmp	brain_fuck
    @@:	cmp	al, '.'
	jne	@f
	; output
	mov	al, [di]
	mov	ah, 0eh
	xor	bx, bx
	int	10h
	jmp	brain_fuck
    @@:	cmp	al, '['
	jne	@f
	; start loop
	cmp	byte [di], 0
	mov	cx, 1
	jz	.skip_to_end
	lea	bx, [si-1]	;
    	; how do I simplify this?
	push	bx	;
	jmp	brain_fuck
    .skip_to_end:
	lodsb
	cmp	al, '['
	je	.loop_open
	cmp	al, ']'
	je	.loop_close
	jmp	.skip_to_end
    .loop_open:
	inc	cx
	jmp	.skip_to_end
    .loop_close:
	dec	cx
	jnz	.skip_to_end
	jmp	brain_fuck
    @@:	cmp	al, ']'
	; end loop
	jne	@f
	pop	si
	jmp	brain_fuck
    @@:	cmp	al, 0dh
	jne	brain_fuck
	mov	si, done_string
	call	print_string
cli
hlt
jmp $

include 'print_string.asm' ; pass in si

welcome_string:
	db 'Welcome to BootFuck!', 0dh, 0ah, 0
best_string:
	db 'The greates OS of all time', 0dh, 0ah, 0
done_string:
	db 'All Done!', 0dh, 0ah, 0
secret_string:
	db 'XNT,ENTC,SGD,RDBQDS '

times 510-($-$$) db 0	; pad zeros until the 510th byte
dw 0xaa55				; 512th is the magic number


; vim: ft=fasm:ts=8:sts=4:sw=4
