.section .text
.global main


main:
    li      t0 , 0x800
    csrw    mstatus , t0
    la      t0 , supervisor
    csrw    mepc , t0
    mret

    # Jump to supervisor mode

.align 4
supervisor:

################ Initialize your page tables here ################

    li     t0 , 0x0000000081000000
    li     t1 , 0x0000000082001
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x0000000000000001
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    li     t0 , 0x0000000082001000
    li     t1 , 0x0000000083001
   # srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x0000000000000001
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    li     t0 , 0x0000000083001000 
    li     t1 , 0x0000000080001
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x000000000000007F
    or    t1 , t1 , t2
    sd     t1 , 0(t0)


    # ok

    li     t0 , 0x81000010
    li     t1 , 0x0000000082000
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x1
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    li     t0 , 0x0000000082000000
    li     t1 , 0x0000000083000
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x1
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    li     t0 , 0x0000000083000000 
    li     t1 , 0x0000000080000
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x000000000000006F
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    #okkk
    li     t0 , 0x0000000081000000
    li     t1 , 0x0000000082001
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x0000000000000001
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    li     t0 , 0x0000000082001000
    li     t1 , 0x0000000083001
   # srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x0000000000000001
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

    li     t0 , 0x0000000083001008 
    li     t1 , 0x0000000080002
    #srli   t1 , t1 , 12
    slli   t1 , t1 , 10
    li     t2 , 0x000000000000007F
    or    t1 , t1 , t2
    sd     t1 , 0(t0)

####################################################################
    li      t0 , 0x1800
    csrc    sstatus , t0



    # Prepare jump to user mode
    # la t1, satp_config # load satp val
    # ld t2, 0(t1)
    # li  t5 , 8
    # slli   t5 , t5 , 60
    # add t2 , t2 , t5
    # csrrw zero , satp,  t3




################ DO NOT MODIFY THESE INSTRUCTIONS ################
    la t1, satp_config # load satp val
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero
    li t4, 0
    csrrw zero, sepc, t4 
    sret
####################################################################


.align 12
user_code:
    la t1,var1
    la t2,var2
    la t3,var3
    la t4,var4
    j user_code


.data
.align 12
var1:  .word  1
var2:  .word  2
var3:  .word  3
var4:  .word  4

.align 12
satp_config: .dword  0x8000000000081000 # Value to set in satp
