.section .data

.section .text

.global main

main:
    addi    sp , sp , -24
    li      a0 , 5
    sw      a0 , 0(sp)
    li      a0 , 5
    sw      a0 , 4(sp)
    li      a0 , 5
    sw      a0 , 8(sp)
    li      a0 , 5
    sw      a0 , 12(sp)
    li      a0 , 5
    sw      a0 , 16(sp)
    li      a0 , 5
    sw      a0 , 20(sp)
    li      a0 , 0   # i = 0 

forl:
    lw      a1 , 20(sp)
    beq     a0 , a1 , exit
    mv      a2 , sp     # a2 = sp
    slli    a3 , a0 , 2
    add     a4 , a2 , a3  # a4 = a2 + a0 * 4
    lw      a4 , 0(a4)    
    add     a3 , a4 , a0   # a3 = val at a4 + a0
    slli    a5 , a0 , 2
    add     a4 , a2 , a5  # a4 = a2 + a0 * 4
    sw      a3 , 0(a4)
    addi    a0 , a0 , 1
    j       forl

exit:
    li a7 , 93
    ecall
