.section .data
n1:   .word    700
n2:   .word    600
.section .text

.global main

main:
    addi    sp , sp , -28
    li      a0 , 700
    sw      a0 , 0(sp)
    li      a0 , 600
    sw      a0 , 4(sp)

op:
    lw      a1 , 0(sp)
    lw      a2 , 4(sp)
    add     a3 , a1 , a2
    sw      a3 , 8(sp)

    lw      a1 , 0(sp)
    lw      a2 , 4(sp)
    sub     a3 , a1 , a2
    sw      a3 , 12(sp)

    lw      a1 , 0(sp)
    lw      a2 , 4(sp)
    and     a3 , a1 , a2
    sw      a3 , 16(sp)

    lw      a1 , 0(sp)
    lw      a2 , 4(sp)
    or      a3 , a1 , a2
    sw      a3 , 20(sp)

    lw      a1 , 0(sp)
    lw      a2 , 4(sp)
    xor     a3 , a1 , a2
    sw      a3 , 24(sp)

exit:
    li a7 , 93
    ecall
