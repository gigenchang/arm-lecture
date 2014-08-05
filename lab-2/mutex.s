	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
		mov r3, #locked
		ldrex r1, [r0]         @ get the state of mutex
		teq r1, #unlocked      @ is mutex unlock?
		strexeq r2, r3, [r0]   @try to locked the mutex
		teqeq r2, #0           @ test locking mutex is success or not
		bne lock_mutex         @ if mutex is not unlocked or it fails to lock the mutex, try again
        @ END CODE INSERT
	bx lr

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
		@ INSERT CODE BELOW
		mov r1, #unlocked
		str r1, [r0]
        @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
