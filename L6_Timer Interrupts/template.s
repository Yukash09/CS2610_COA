.section .text
.global main

main:

		# Enable interrupts

		# configure timer interrupt 
		# set the value of mtimecmp register

context_switch:

		# save the context of the interrupted task by looking at the task id (jump to relavent label)


save_context_A:
		# save all the registers and PC value in stack_a
		# mepc stores the value of PC at the time of interrupt

save_context_B:
		# save all the registers and PC value in stack_b

switch_to_A:
		# restore the values of registers and PC from stack_a

switch_to_B:
		# restore the values of registers and PC from stack_b

initial_switch_to_B:
		# switching to Task B for the first time

switch:
		# set the value of mtimecmp and switch to your preferred task

Task_A:
		# increment your reg value

finish_a:
    j finish_a

Task_B:
		# decrement the reg value
finish_b:
    j finish_b

.data
.align
stack_a:  .word  # initialize stack for task A (You can choose a random address) 
stack_b:  .word  # initialize stack for task B
current:  .word  # variable to identify the task 