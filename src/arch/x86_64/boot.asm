; multiboot info can be found at
; https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html

global start ; Entry point to the kernel

section .text ; default section for executable code 
bits 32 ; GRUB puts us into protected mode, so 32 bit instructions
start:
    ; Check to see if we were loaded by a multiboot compatible bootloader
    ; This is a magic number from the multiboot spec

    cmp eax, 0x36d76289
    jne error

    ; ebx contains the 32-bit physical address of the 
    ; Multiboot2 information structure provided by the boot loader  

    mov ecx, [ebx] ; move total_size into ecx
    add ecx, ebx ; calulate end address of structure 
    add ebx, 8 ; skip starting tag
    cmp ebx, ecx ; check if we are past end address
    jge error ; if we are, go to error

check_type:

    mov edx, [ebx] ; copy data from the address into reg
    cmp edx, 8 ; check if type is 8 - framebuffer info    
    jne skip_tag ; if type is not 8 jump to skip_tag


parse_fb_info:
    
    add ebx, 8 ; increment register to point to u64 framebuffer_addr
    mov edx, [ebx] ; copy framebuffer_addr from the address into reg
    
    add ebx, 8 ; increment register to point to u32 framebuffer_pitch
    mov eax, [ebx] ; copy framebuffer_pitch from the address into reg
    
    add ebx, 4 ; increment register to point to u32 framebuffer_width
    ;mov eax, [ebx] ; copy framebuffer_width from the address into reg
    add ebx, 4 ; increment register to point to u32 framebuffer_height
    imul eax, [ebx] ; multiply framebuffer_width by framebuffer_height
    
    add ebx, 4 ; increment register to point to u32 framebuffer_bpp
    ;mov r8d, [ebx] ; copy framebuffer_bpp from the address into reg

    ;imul eax, 4 ; multiply total pixels by 4 bytes per pixel 
    ; assumes 32-bit truecolour

    mov ebx, edx ; save start address in ebx
    add edx, eax ; get end address 
    mov ecx, 0xFFFFFFFF ; pixel colour - all FFs, which is hopefully white

fb_write_loop_hopefully:

    mov [ebx], ecx ; write pixel colour
    add ebx, 4 ; next pixel
    cmp ebx, edx ; check if we are past end address
    jl fb_write_loop_hopefully ; loop if we aren't past end address
    hlt ; else halt, we're done


skip_tag:
    add ebx, 4 ; increment address to point at u32 size
    mov edx, [ebx] ; copy tag size data from the address into reg
    ; next three instructions are (edx-1)|7 + 1
    ; this ensures alignment across 8 byte boundaries
    sub edx, 1
    or edx, 0x07
    add edx, 1
    sub edx, 4 ; decrease size by the length of the tag type field    
    add ebx, edx ; increment address by size, accounting for 8 byte alignment
    cmp ebx, ecx ; check if we are past end address
    jge error ; if we are, go to error
    jmp check_type ; else go back to check next tag type

error:
    mov eax, 0xDEADBEEF ; Only useful for the debugger
    hlt