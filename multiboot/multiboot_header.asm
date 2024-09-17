; Taken from 
; https://os.phil-opp.com/multiboot-kernel/
; Which uses info from multiboot spec 
; https://nongnu.askapache.com/grub/phcoder/multiboot.pdf

section .multiboot_header
header_start:
    dd 0xe85250d6                ; magic number (multiboot 2)
    dd 0                         ; architecture 0 (protected mode i386)
    dd header_end - header_start ; header length
    ; checksum
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; insert optional multiboot tags here

    ; required end tag
    dw 0    ; type
    dw 0    ; flags
    dd 8    ; size
header_end:

; No instructions, just kinda puts stuff in memory for multiboot to recognize us