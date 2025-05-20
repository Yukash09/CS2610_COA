.section .data
.section .text
.global main 
# mtime - 0x200bff8
# mtimecmp - 0x2004000
main:
    li      t0 , 0x1800
    csrc    mstatus , t0 
    li      t0 , 0x800
    csrs    mstatus , t0
    li      t0 , 0xa0
    csrs    mie , t0
    la      t0 , mtrap
    csrw    mtvec , t0 
    la      t0 , ucode
    csrw    mepc , t0
    li      t0 , 0x30000
    la      t1 , 0x2004000
    sd      t0 , 0(t1)
    mret
    
.align 8
ucode:
    j       ucode

.align 8
mtrap:
    li      t0 , 0x10000
    la      t1 , 0x2004000
    ld      t2 , 0(t1)
    add     t2 , t2 , t0
    sd      t2 , 0(t1)
    la      t0 , mtrap
    csrw    mtvec , t0
    la      t0 , ucode
    csrw    mepc , t0
    mret 
