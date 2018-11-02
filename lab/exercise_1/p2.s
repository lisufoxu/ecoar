# /* program finding the longest sequence of digits in given string */
	.data
buf: .asciiz "123re4567rer\0"
buf1: .asciiz "aefefe"
buf2: .asciiz "123re4567rer"
buf3: .ascii "123"

longest: .space 64 # longest sequence is stored here

	.text
main:
	la $a0, buf
	jal find
	jal select
	la $a0, longest
	li $v0, 4
	syscall
	li $v0, 10
	syscall # terminate
# param: a0 - starting address of a string
# return: a0 - starting address, a1 - number of characters to select
find:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $t0, ($a0) # temp address
	addu $a1, $zero, $zero # $t0 - length of longest
	addu $t1, $zero, $zero # temp length counter
	li $t2, '0'
	li $t3, '9'
	
	jal floop1
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
# main loop of find
floop1:
	lbu $t4, ($t0) # load char
	li $t5, '\n'
	beq $t4, $t5, floopExit
	li $t5, '\0'
	beq $t4, $t5, floopExit
	addiu $t0, $t0, 1 # move address to next byte
	slt $t5, $t2, $t4 # set if char > '0'
	slt $t6, $t4, $t3 # set if char < '9'
	# branch if char NOT between '0' and '9'
	beqz $t5, floop2
	bne $t5, $t6, floop2
	# else
	addiu $t1, $t1, 1 # increment temp counter
	# if temp is not greater than longest
	bleu $t1, $a1, floop1
	# else
	addu $a1, $zero, $t1 # longest = temp
	subu $a0, $t0, $t1 # set starting address of longest
	j floop1
floopExit:	
	jr $ra
# if character NOT between '0' and '9'
floop2:
	addu $t1, $zero, $zero # temp counter = 0
	j floop1

# selects the longest sequence. 
# param: a0 - starting address, a1 - number of characters to select
# return: longest
select: 
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	beqz $a1, selectExit
	addu $t0, $zero, $zero # i, denotes how mamy elements were copied
	jal sloop1
selectExit:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
sloop1:
	addu $t2, $a0, $t0 # address of buf[i] 
	lbu $t1, 0($t2) # load character from buf[i]
	sb $t1, longest($t0) # store at longest[i]
	addiu $t0, $t0, 1 # i+1 (set at next character's address)
	blt $t0, $a1, sloop1 # copy next	
	jr $ra # return back to caller
