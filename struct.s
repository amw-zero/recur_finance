	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0
	.globl	_modify                         ; -- Begin function modify
	.p2align	2
_modify:                                ; @modify
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16                     ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	mov	w9, #7
	str	w9, [x8]
	add	sp, sp, #16                     ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48                     ; =48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32                    ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #0
	stur	wzr, [x29, #-4]
	adrp	x9, l___const.main.d@PAGE
	ldr	w10, [x9, l___const.main.d@PAGEOFF]
	sub	x0, x29, #8                     ; =8
	stur	w10, [x29, #-8]
	adrp	x9, l___const.main.d2@PAGE
	ldr	w10, [x9, l___const.main.d2@PAGEOFF]
	stur	w10, [x29, #-12]
	str	w8, [sp, #16]                   ; 4-byte Folded Spill
	bl	_modify
	ldur	w8, [x29, #-8]
                                        ; implicit-def: $x0
	mov	x0, x8
	adrp	x9, l_.str@PAGE
	add	x9, x9, l_.str@PAGEOFF
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	mov	x0, x9
	mov	x9, sp
	ldr	x11, [sp, #8]                   ; 8-byte Folded Reload
	str	x11, [x9]
	bl	_printf
	ldr	w8, [sp, #16]                   ; 4-byte Folded Reload
	mov	x0, x8
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48                     ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal4,4byte_literals
	.p2align	2                               ; @__const.main.d
l___const.main.d:
	.long	5                               ; 0x5

	.p2align	2                               ; @__const.main.d2
l___const.main.d2:
	.long	6                               ; 0x6

	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"%d\n"

.subsections_via_symbols
