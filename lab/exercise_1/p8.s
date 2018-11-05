# /* remove characters (not digits) preceded by digits */
	.data
#str: .asciiz "9ab3c2" # 9b32
str: .asciiz "abc5f67gh" # abc567h
#str: .asciiz "1e"
	.text
main:
	jal changeStr
	li $v0, 4
	la $a0, str
	syscall
	li $v0, 10
	syscall # terminate

changeStr:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	la $a0, str
	la $a1, str
	#addiu $a1, $a1, 1
	
	jal check
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

# if $t0 is a digit and $t1 is a char then remove $t1
check:
	lbu $t0, ($a1) # 1st char
	lbu $t1, 1($a1) # 2nd char
	beqz $t1, checkExit
	addiu $a0, $a0, 1
	addiu $a1, $a1, 1
	
	#sb $t1, ($a0)
	
	li $t2, '0'
	li $t3, '9'
# if $t0 is not a digit
	sltu $t4, $t0, $t2 # $t0 < '0'
	sltu $t5, $t3, $t0 # $t0 > '9'	
	bnez $t4, inc
	bnez $t5, inc
# $t0 is a digit
# if $t1 is a digit
	sltu $t4, $t1, $t2 # $t1 < '0'
	sltu $t5, $t3, $t1 # $t1 > '9'	
	seq $t6, $t4, $t5
	beqz $t5, inc
# $t1 is not a digit
# remove
	lb $t1, 1($a1)
	addiu $a1, $a1, 1
	beqz $t1, checkExit
	sb $t1, ($a0)
	
	j check

checkExit:
	li $t0, '\0'
	sb $t0, 1($a0)
	jr $ra

# not remove
inc:
	lbu $t1, ($a1)	
	sb $t1, ($a0)
	j check