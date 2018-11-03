.data 
str: .space 256
maxChar: .space 256
revstr: .space 256
prompt: .asciiz "Enter in string, max 256 characters: "
.text
main:
        
        la      $a0, prompt     #calling opening prompt
        li      $v0, 4		# print string
        syscall

        li $v0, 8		# read string
        la $a0, str		# input buffer
        la $a1, maxChar		# max character
        syscall

        li $t0, 0		# load 0 to $t0
        subu $sp, $sp, 4	# create a spot on stack
        sw $t0, ($sp)		# push $t0 (value: 0) onto the stack
        li $t1, 0		# load 0 to $t1 (to get index 0 of the sentence)

bump1:
        lbu $t0, str($t1)	# load str($t1) to $t0 (take the first letter to the last on push it onto the stack)
        beqz $t0, stend		# if $t0 == zero -> branch to stend
        subu $sp, $sp, 4	# create a spot on the stack
        sw $t0, ($sp)		# store $t0 onto the stack
        addu $t1, $t1, 1	# increment $t1
        j bump1			# jump to bump1
        
stend: li $t1, 0		# assign 0 to $t1

populate:
        lw $t0, ($sp)		# set $t0 to content of the stack pointer
        addu $sp, $sp, 4	# free the spot
        beqz $t0, done		# if $t0 == 0 => done
        sb $t0, str($t1)	# store value of $t0 into the indexed value of str($t1)
        addu $t1, $t1, 1	# increment $t1 
        j populate		# loop
        
done: 
        li $v0, 4		# show the reversed string
        la $a1, str		
        syscall
        
        li $v0, 10		# end of program
        syscall
