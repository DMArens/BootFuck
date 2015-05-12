; load DH sectors to ES:BX from drive DL
disk_load:
	push	dx

	mov	ah, 0x02	; BIOS read sector
	mov	al, dh		; read dh sectors
	mov	ch, 0x00	; cylinder 0
	mov	dh, 0x00	; head 0
	mov	cl, 0x02	; sector 2 (after boot)

	int	0x13		; BIOS interrupt

	jc	disk_error	; Jump if read error (carry flag)

	pop	dx
	cmp	dh, al		; compare read sectors with expected
	jne	disk_error	; error if not equal
	ret

disk_error:
	mov	si, DISK_ERROR_MSG
	call	print_string
	jmp $

DISK_ERROR_MSG	db "Disk read error.. Goodbye!", 0

; vim: ft=fasm:ts=8:sts=4:sw=4
