.section .data
N:  .word   5
.section .text
.global main

main:
    la      a0 , N   # argument for fibonacci
    ld      a0 , 0(a0) 
    li      a1 , 0      
    mv      a2 , sp     # start of sp
    mv      a3 , sp     # bottom of stack memory used
    li      a4 , 0
    jal     sfib
    j       exit

sfib:
    addi    sp , sp , -40   # Function prologue
    addi    a3 , a3 , -40   # increment a3 to keep track of stack memory used
    sd      a0 , 0(sp)
    sd      a1 , 8(sp)
    sd      ra , 16(sp)

    li      t0 , 0
    ld      t1 , 0(sp)
    beq     t0 , t1 , base1     # Check base cases
    li      t0 , 1
    ld      t1 , 0(sp)
    beq     t0 , t1 , base2

rec:
    ld      a0 , 0(sp)
    addi    a0 , a0 , -1
    jal     sfib
    sd      a0 , 24(sp)   # a0 = sum of fib(n-1)
    sd      a1 , 32(sp)   # a1 = val of fib(n-1)
    ld      a0 , 0(sp)
    addi    a0 , a0 , -2 
    jal     sfib
    mv      s3 , a0   # a0 = sum of fib(n-2)
    mv      s4 , a1   # a1 = val of fib(n-2)
    ld      s1 , 24(sp)
    ld      s2 , 32(sp)
    add     a1 , s2 , s4   # a1 = return fib(n)
    add     a0 , s1 , a1   # a0 = return sum of fib(n) 
    ld      ra , 16(sp)
    addi    sp , sp , 40
    ret

base1:
    li      a0 , 0      # return {0 , 0} and function epilogue
    li      a1 , 0
    ld      ra , 16(sp)
    li      t6 , 0
    beq     a4 , t6 , store
    addi    sp , sp , 40
    ret

store:
    mv      a5 , a3
    addi    a4 , a4 , 1
    addi    sp , sp , 40
    ret

base2:
    li      a0 , 1      # return {1 , 1} and function epilogue
    li      a1 , 1
    ld      ra , 16(sp)
    addi    sp , sp , 40
    ret 

exit:
    sub     a1 , a2 , a5
    li      a7 , 93
    ecall
