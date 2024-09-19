; Taken from 
; https://os.phil-opp.com/multiboot-kernel/

global start ; Entry point to the kernel

section .text ; default section for executable code 
bits 32 ; GRUB puts us into protected mode, so 32 bit instructions
start:
    ; print `OK` to screen - won't work with EFI boot :(
    ; mov dword [0xb8000], 0x2f4b2f4f
    hlt

