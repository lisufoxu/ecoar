# change every 3rd lowercase letter to uppercase: “ab1cde2f3gh4ij” → “ab1Cde2Fgh4Ij”

.data

# buf: .asciiz "ab1cde2f3gh4ij"
buffer: .space 100
str1:  .asciiz "Enter string: (max 100 characters)"
str2:  .asciiz "Capitalized: "

.text

main:
    la $a0, str1    # Load and print string asking for string
    li $v0, 4
    syscall
    
    li $v0, 8       # take in input
    la $a0, buffer  # load byte space into address
    li $a1, 100      # allot the byte space for string
    syscall
    
    la $a0, buffer
    move $s0, $a0
    
    li $v0, 4
    li $t0, 0
    li $t2, 0
    
loop:
	lb $t1, buffer($t0)		# load byte in $t1	
	beqz $t1, end			# if $t1 == 0 => end
	blt $t1, 'a', not_lower 	# if less than 'a' => not_lower
	bgt $t1, 'z', not_lower		# if more than 'z' => not_lower
	addi $t2, $t2, 1		# increment $t2
	beq $t2, 3, uppercase		# if $t2 == 3 => uppercase
	addi $t0, $t0, 1
	j loop

uppercase:
	add $t2, $zero, $zero
	sub $t1, $t1, 32  	
    	sb $t1, buffer($t0)  		
    	addi $t0, $t0, 1
	j loop

not_lower:
	sb $t1, buffer($t0)
	addi $t0, $t0, 1
	j loop
	
end:
	li $v0, 4
	la $a0, buffer
	syscall 
	li $v0, 10
    	syscall