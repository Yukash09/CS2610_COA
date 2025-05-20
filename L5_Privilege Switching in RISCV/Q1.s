.section .data
.section .text
.global main

main:
	la	t0 , scode
	csrw	mepc , t0 
	li	t0 , 0x800
	csrw	mstatus , t0 
	la	t0 , mtraph
	csrw	mtvec , t0 
	li	t0 , 0x100
	csrw	medeleg , t0
	mret
 
.align 8
mtraph:
	li	t0 , 0x20
	li	t1 , 0x21
	csrr 	a0 , mepc
	addi	a0 , a0 , 4
	csrw	mepc , a0
	mret
 
.align 8
scode:
	la	t0 , ucode
	csrw	sepc , t0 
	li	t0 , 0x000
	csrw	sstatus , t0
	la	t0 , straph
	csrw	stvec , t0 
	sret
 
.align 8
straph:
	li	t0 , 0x12
	li	t1 , 0x13
	ecall
	la	t0 , ucode
	csrw	sepc , t0 
	sret

.align 8
ucode:
	li	t0 , 0x643
	li	t1 , 0x597
	ecall
