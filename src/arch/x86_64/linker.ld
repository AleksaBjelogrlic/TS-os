/* Taken from
https://os.phil-opp.com/multiboot-kernel/ */

ENTRY(start)

SECTIONS {
    /* Changed from phil-opp V1 which used 1M
    using 2M instead as per "Linking the Kernel" example in 
    https://wiki.osdev.org/Bare_Bones */
    . = 2M; 

    .boot :
    {
        /* ensure that the multiboot header is at the beginning */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }
}
