.section .text
.global main



main:
    # Prepare jump to super mode
    li t1, 1
    slli t1, t1, 11   #mpp_mask
    csrs mstatus, t1
    
    la t4, supervisor       #load address of user-space code
    csrrw zero, mepc, t4    #set mepc to user code
    
    la t5, page_fault_handler
    csrw mtvec, t5
   
    mret

supervisor:
################## Setting up page tables ##############
    # Set value in PTE2 (Initial Mapping)
    li a0,0x81000000
    li a1, 0x82000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 16(a0)

    # To set V.A 0x0 -> P.A 0x0
    li a1, 0x82001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE1 (Initial Mapping)
    li a0,0x82000000
    li a1, 0x83000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set Frame number in PTE0 (Initial Mapping)
    li a0,0x83000000
    li a1, 0x80000
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 0(a0)

    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 8(a0)

    # Set value in PTE1 (Code Mapping)
    li a0,0x82001000
    li a1, 0x83001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE0 (Code Mapping)
    li a0,0x83001000
    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xf9 # D | A | G | U | X | - | - |V
    sd a1, 0(a0)

    # Data Mapping
    li a1, 0x80002
    slli a1, a1, 0xa
    ori a1, a1, 0xf7 # D | A | G | U | - | W | R |V
    sd a1, 8(a0)
    

####################################################################

    # Prepare jump to user mode
    li t1, 0
    slli t1, t1, 8   #spp_mask
    csrs sstatus, t1

    # Configure satp
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0       # load VA address of user-space code
    csrrw zero, sepc, t4    # set sepc to user code
    
    sret



###################################################################
##################### ADD CODE ONLY HERE  #########################
###################################################################
.align 4
page_fault_handler:

    csrr a0 , mtval 
    srli a0 , a0 , 12
    slli a0 , a0 , 3
    la   a1 , newpage
    ld   a2 , 0(a1) 
    # li   a2 , 0x80001000
    addi a2 , a2 , 1
    sd   a2 , 0(a1)
    slli a2 , a2 , 10
    ori  a2 , a2 , 0x000000000fb
    li   a3 , 0x83001000
    add  a0 , a0 , a3
    sd   a2 , 0(a0) 

    # la   a1 , newpage 
    # ld   a1 , 0(a1)
    # li   a3 , 0x1000 
    # add a1 , a1 , a3
    # la   a2 , newpage
    # sd   a1 , 0(a2)

    csrr a0 , mcause 
    li   a1 , 12
    beq  a0 , a1 , exit1
    j    dataf
    mret

exit1: 
    li   a0  , 0x1000 
    li   a1 , 0x80001000
    srli a2 , a2 , 10
    slli a2 , a2 , 12

cpy:
    beq  a0 , zero , exit2
    ld   a3 , 0(a1)
    sd   a3 , 0(a2) 
    addi a1 , a1 , 8
    addi a2 , a2 , 8
    addi a0 , a0 , -8
    j    cpy

dataf:
    csrr a0 , mtval 
    srli a0 , a0 , 12
    slli a0 , a0 , 3
    li   a1 , 0x80002
    slli a1 , a1 , 10
    ori  a1 , a1 , 0x0ff
    li   a3 , 0x83001000
    add  a0 , a0 , a3
    sd   a1 , 0(a0)

exit2:
    mret


###################################################################
###################################################################



.align 12
user_code:
    la t1,var_count
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    la t5, code_jump_position
    lw t3, 0(t5)
    li t4, 0x2000
    add t3, t3, t4
    sw t3, 0(t5)
    
    jalr t0, t3


.data
.align 12
var_count:  .word  0
code_jump_position: .word 0x0000


.align 8
# Value to set in satp
satp_config: .dword 0x8000000000081000
newpage:    .dword 0x80002
