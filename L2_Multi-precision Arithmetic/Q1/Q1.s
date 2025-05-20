.section .data
n1:  .dword  0x1234567887654321
n2:  .dword  0x8765432112345678
# str: .string  "%d\n"

.section .text
.global main

main:
    addi    sp , sp , -16
    la      a0 , n1
    ld      t0 , n1 
    ld      t1 , n2 
    mul     t2 , t1 , t0
    mulhu   t3  , t1 , t0
    sd      t3 , 8(sp)
    sd      t2 , 0(sp)     

    j exit

exit:
    li a7 , 93
    ecall
