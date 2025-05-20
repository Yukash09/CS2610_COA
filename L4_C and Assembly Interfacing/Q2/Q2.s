.section .data
rstr:   .string ""
.section    .text
.global  reverse
.global rstr


reverse:
    addi    sp , sp , -16
    sd      a0 , 0(sp)
    sd      ra , 8(sp)
    li      t0 , 0      # t0 - zero
    li      t1 , 0      # t1 - length of the string


for_loop:       # find the length
    lb      t2 , 0(a0)  
    beq     t2 , t0 , exit
    addi    t1 , t1 , 1
    addi    a0 , a0 , 1
    j       for_loop

exit:
    mv      a1 , t1 
    addi    a0 , a0 , -1
    la      t3 , rstr 

for_loop2:
    beq     t1 , t0 , fexit
    lb      t2 , 0(a0)
    sb      t2 , 0(t3)
    addi    t3 , t3 , 1
    addi    a0 , a0 , -1
    addi    t1 , t1 , -1
    j       for_loop2

fexit:
    mv  a0 , a1
    ld  ra , 8(sp)
    addi    sp , sp , 16
    ret       

