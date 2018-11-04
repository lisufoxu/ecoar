	.data
msg1:	.asciiz	"Digit remover!\n"
test1:	.asciiz ""
test2:	.asciiz " "
test3:	.asciiz "qscjbwqofb396918ebfjwbfwb19361"
test4:	.asciiz "\n"
result:	.space 80

msg2:	.asciiz "Enter the string: "
inbuf:	.space 80
	.text
main:	la $a0, msg1
	li $v0, 4
	syscall

	#load arguments
	la $a0, test1
	jal strlen	# PC is stored in ra
	la $a0, result
	#display result (content of $a0)
	li $v0, 4
	syscall
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	
	#display a space	
	la $a0, test2
	li $v0, 4
	syscall

	#load arguments
	la $a0, test2
	jal strlen	# PC is stored in ra
	la $a0, result
	#display result (content of $a0)
	li $v0, 4
	syscall
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	
	#display a space	
	la $a0, test2
	li $v0, 4
	syscall
	
	#load arguments
	la $a0, test3
	jal strlen	# PC is stored in ra
	la $a0, result
	#display result (content of $a0)
	li $v0, 4
	syscall
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	
	#display a newline	
	la $a0, test4
	li $v0, 4
	syscall
	
	#display message	
	la $a0, msg2
	li $v0, 4
	syscall
	
	#scan input
	la $a0, inbuf
	la $a1, 80
	li $v0, 8
	syscall
	
	#display scanned string	
	#la $a0, inbuf
	#li $v0, 4
	#syscall
	
	#load arguments
	la $a0, inbuf
	jal strlen	# PC is stored in ra
	la $a0, result
	#display result (content of $a0)
	li $v0, 4
	syscall
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
	addi $a0, $a0, 4
	sw $zero, ($a0)
			
	#terminate the main function
	li $v0, 10
	syscall

# IN $a0 - address of the string, null terminated (asciiz)
# OUT $v0 - length of the string
strlen:
	li $v0, 0
	la $t3, result
strlenloop:
	lb $t0, ($a0)
	addi $a0, $a0, 1
	beqz $t0, strlenexit
	ble $t0, 47, nodigit
	bge $t0, 58, nodigit
	b strlenloop
nodigit:
	sb $t0, ($t3)
	addi $t3, $t3, 1
	b strlenloop	
strlenexit:
	jr $ra
	
	
