.section .data
.section .text
.global main

main:
    li      t0 , 0x1800
    csrc    mstatus , t0
    li      t0 , 0x800
    csrs    mstatus , t0
    li      t0 , 0xa0
    csrs    mie , t0 
    li      t0 , 0x30000
    la      t1 , 0x2004000
    sd      t0 , 0(t1)
    la      t0 , A 
    csrw    mepc , t0
    la      t0 , switch
    csrw    mtvec , t0 
    li      t0 , 0 
    mret

.align 8
cswitch:
    la     a2 , current
    ld     a2 , 0(a2)
    beq    a2 , zero , saveB
    j      saveA

.align 8
saveA:
    la     t5 , stackA
    #lw     t5 , 0(t3)
    sd     t0 , 0(t5)
    csrr   t4 , mepc
    sd     t4 , 8(t5)
    sd     t1 , 16(t5)
    sd     t2 , 24(t5)
    sd     t3 , 32(t5)
    j      switchB  

.align 8
saveB:
    la     t5 , stackB
    #lw     t5 , 0(t3)
    sd     t0 , 0(t5)
    csrr   t4 , mepc
    sd     t4 , 8(t5)
    sd     t1 , 16(t5)
    sd     t2 , 24(t5)
    sd     t3 , 32(t5)
    j      switchA

.align 8
switchA:
    la     t5 , stackA
    #lw     t5 , 0(t3)
    ld     t0 , 0(t5)
    ld     t4 , 8(t5)
    ld     t1 , 16(t5)
    ld     t2 , 24(t5)
    ld     t3 , 32(t5)
    csrw   mepc , t4 
    mret

.align 8
switchB:
    la     t5 , stackB
    #lw     t5 , 0(t3)
    ld     t0 , 0(t5)
    ld     t4 , 8(t5)
    ld     t1 , 16(t5)
    ld     t2 , 24(t5)
    ld     t3 , 32(t5)
    beq    t4 , zero , initswitchB
    csrw   mepc , t4
    mret

.align 8
initswitchB:
    li     t0 , 0x03fffff
    la     t4 , B
    csrw   mepc , t4
    mret

.align 8
switch:
    li     a0 , 0x10000
    la     a1 , 0x2004000
    ld     a2 , 0(a1)
    add    a2 , a2 , a0
    sd     a2 , 0(a1)
    j      cswitch

.align 8
A:
    la     t2 , current
    li     t3 , 1
    sd     t3 , 0(t2)
    addi   t0 , t0 , 100
    li     t1 , 0x0fffffff
    bge    t0 , t1 , finA
    j      A

.align 8
finA:
    la     t2 , current
    li     t3 , 1
    sd     t3 , 0(t2)
    j      finA

.align 8
B:
    la     t2 , current
    li     t3 , 0
    sd     t3 , 0(t2)
    addi   t0 , t0 , -100
    ble    t0 , zero  , finB
    j      B

.align 8
finB:
    la     t2 , current
    li     t3 , 0
    sd     t3 , 0(t2)
    j      finB

.data
.align 8
stackA:     .zero   40
stackB:     .zero   40
current:    .dword   0x0000
