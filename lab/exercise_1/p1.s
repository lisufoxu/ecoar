	.data
info1: .asciiz "Put string, I'll replace all digits with their complement to 9: "
string1: .space 64 # reserve 64 characters including \n character

	.text
main:
	li $v0, 4
	la $a0, info1
	syscall # display program info
	li $v0, 8
	la $a0, string1
	li $a1, 64
	syscall # load string
	addi $sp, $sp, -4
	sw $s0, 0($sp) #store $s0
	add $s0, $zero, $zero # i=0
	jal exchange
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	la $a0, string1
	li $v0, 4
	syscall # display result
	li $v0, 10
	syscall # terminate
	
exchange:
	add $t0, $a0, $s0 # $t0 = addres of char[i]
	addi $s0, $s0, 1 # i+=1
	lb $t1, 0($t0) # load byte to $t1
	beq $t1, $zero, exchangeExit # exit if char[i]=='\0'
	li $t2, '\n'
	beq $t1, $t2, exchangeExit
	li $t2, '0'
	bltu $t1, $t2, exchange # jump if char[i]<'0'
	li $t2, '9'
	bltu $t2, $t1, exchange # jump if char[i]>'9'
	addi $t2, $t2, -48 # convert to int
	addi $t1, $t1, -48 # convert to int
	sub $t1, $t2, $t1 # char[i] = 9 - char[i]
	addi $t1, $t1, 48 # convert to char
	sb $t1, 0($t0) # store changes to char[i]
	j exchange # return to loop
exchangeExit:
	jr $ra
