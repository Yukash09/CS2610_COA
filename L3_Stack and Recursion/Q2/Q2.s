.section .data
str:    .string     "Move from rod X to rod Y\n"
x:      .word       14
y:      .word       23

.section .text
.global main

main:
    li      a0 , 3      # value of n
    li      a1 , 49     # ascii values of '1' , '2' , '3'
    li      a2 , 51
    li      a3 , 50
    jal     toh
    j       exit

toh:
    addi    sp , sp , -40
    sd      a0 , 0(sp) # n at sp 
    sb      a1 , 8(sp) # from at sp + 8
    sb      a2 , 16(sp) # to at sp + 16
    sb      a3 , 24(sp) # aux at sp + 24
    sd      ra , 32(sp) # ret at sp + 32
    li      t0 , 1
    ld      t1 , 0(sp)
    beq     t0 , t1 , base  # base case

rec:
    ld      a0 , 0(sp)      # load values 
    addi    a0 , a0 , -1
    lb      a1 , 8(sp)
    lb      a2 , 24(sp)
    lb      a3 , 16(sp)
    jal     toh         # call toh(n-1 , from , aux , to)

    lb      a1 , 8(sp)  # printing
    lb      a2 , 16(sp)
    la      t0 , str
    la      t1 , x 
    lb      t1 , 0(t1)
    la      t2 , y 
    lb      t2 , 0(t2)
    add     t3 , t0 , t1
    sb      a1 , 0(t3)
    add     t3 , t0 , t2 
    sb      a2 , 0(t3) 
    li      a0 , 1
    la      a1 , str 
    li      a2 , 25
    li      a7 , 64
    ecall  

    ld      a0 , 0(sp)      # load values
    addi    a0 , a0 , -1
    lb      a1 , 24(sp)
    lb      a2 , 16(sp)
    lb      a3 , 8(sp)
    jal     toh         # call toh(n-1 , aux , to , from)

    ld      ra , 32(sp)  # function epilogue
    addi    sp , sp , 40
    ret

base:
    lb      a1 , 8(sp) # printing
    lb      a2 , 16(sp)
    la      t0 , str
    la      t1 , x 
    lb      t1 , 0(t1)
    la      t2 , y 
    lb      t2 , 0(t2)
    add     t3 , t0 , t1
    sb      a1 , 0(t3)
    add     t3 , t0 , t2 
    sb      a2 , 0(t3) 
    li      a0 , 1
    la      a1 , str 
    li      a2 , 25
    li      a7 , 64
    ecall
    ld      ra , 32(sp) # function epilogue
    addi    sp , sp , 40
    ret

exit:
    li      a7 , 93
    ecall
