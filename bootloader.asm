org 0x7c00

	mov	[BOOT_DRIVE], dl	; BIOS stores boot drive in dl

	mov	bp, 0x8000		; move stack out
	mov	sp, bp			; of the way

	mov	bx, 0x4000		; load 2 sectors from the disk
	mov	dh, 2			; into 0x0000:0x4000
	mov	dl, [BOOT_DRIVE]
	call	disk_load

	mov	bx, 0
	mov	es, bx
	jmp	0x4000

	jmp $

include "util/print_string.asm"
include "util/print_hex.asm"
include "util/disk_load.asm"

BOOT_DRIVE: db 0
NEWLINE: db 0x0a, 0x0d, 0x0

; drive padding and boot stuff
times 510-($-$$) db 0
    dw 0xaa55

; vim: ft=fasm:ts=8:sts=4:sw=4
