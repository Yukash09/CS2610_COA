.section    .data
fname:      .string     "He1"
lname:      .string     "Ho1"
.section    .text

.global main
.extern displayStudentProfile
.extern getCourse

main:
    addi    sp , sp , -8
    sd      ra , 0(sp)
    la      a0 , cname 
    li      t0 , 0x0
    sw      t0 , 0(a0)
    call    getCourse
    mv      a2 , a0 
    la      a0 , fname 
    la      a1 , lname
    call    displayStudentProfile
    ld      ra , 0(sp)
    addi    sp ,sp ,8
    ret
