ENTRY(_start)

SECTIONS
{
    . = ALIGN(1);
    .text : {
        *(.text)
        *(.rodata)
        *(.rodata.*)
    }
}
