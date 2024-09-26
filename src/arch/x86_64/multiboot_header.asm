; Modified from 
; https://os.phil-opp.com/multiboot-kernel/
; Which uses info from multiboot spec 
; https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html

section .multiboot_header
header_start:
    dd 0xe85250d6                ; magic number (multiboot 2)
    dd 0                         ; architecture 0 (protected mode i386)
    dd header_end - header_start ; header length
    ; checksum
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; insert optional multiboot tags here
    ; Taken from 
    ; https://github.com/dreamportdev/Osdev-Notes/blob/master/03_Video_Output/01_Framebuffer.md
info_request_tag_start:
    dw  0x01    ;Type: Multiboot2 information request
    dw  0x00    ;Required tag
    dd  info_request_tag_end - info_request_tag_start ;size
    dd  0x08   ; request tag 8 - framebuffer info
info_request_tag_end: 
    align  8 ; align each tag to 8 byte boundry 
framebuffer_tag_start:
    dw  0x05    ;Type: framebuffer
    dw  0x00    ;Required tag
    dd  framebuffer_tag_end - framebuffer_tag_start ;size
    dd  1920   ;Width - if 0 we let the bootloader decide
    dd  1080   ;Height - same as above
    dd  32   ;Depth  - same as above
framebuffer_tag_end:
    align  8 ; align each tag to 8 byte boundry
    ; required end tag
    dw 0    ; type
    dw 0    ; flags
    dd 8    ; size
header_end:

; No instructions, just kinda puts stuff in memory for multiboot to recognize us