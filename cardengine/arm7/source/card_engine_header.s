#include "locations.h"

@---------------------------------------------------------------------------------
	.section ".init"
@---------------------------------------------------------------------------------
	.global _start
	.align	4
	.arm

.global card_engine_start
.global card_engine_start_sync
.global card_engine_end
.global cardStruct
.global patches_offset
.global moduleParams
.global fileCluster
.global debugCluster
.global saveCluster
.global language
.global gottenSCFGExt
.global dsiMode
.global ROMinRAM
.global consoleModel
.global romread_LED
.global gameSoftReset
.global soundFix

#define ICACHE_SIZE	0x2000
#define DCACHE_SIZE	0x1000
#define CACHE_LINE_SIZE	32


patches_offset:
	.word	patches
intr_vblank_orig_return:
	.word	0x00000000
intr_timer0_orig_return:
	.word	0x00000000
intr_timer1_orig_return:
	.word	0x00000000
intr_timer2_orig_return:
	.word	0x00000000
intr_timer3_orig_return:
	.word	0x00000000
intr_fifo_orig_return:
	.word	0x00000000
moduleParams:
	.word	0x00000000
fileCluster:
	.word	0x00000000
debugCluster:
	.word	0x00000000
cardStruct:
	.word	0x00000000
language:
	.word	0x00000000
gottenSCFGExt:
	.word	0x00000000
dsiMode:
	.word	0x00000000
ROMinRAM:
	.word	0x00000000
consoleModel:
	.word	0x00000000
romread_LED:
	.word	0x00000000
gameSoftReset:
	.word	0x00000000
cheat_data_offset:    
	.word	cheat_data - patches_offset
cheat_data_len:
	.word	0x00000000

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

card_engine_start:

vblankHandler:
@ Hook the return address, then go back to the original function
	stmdb	sp!, {lr}
	adr 	lr, code_handler_start_vblank
	ldr 	r0,	intr_vblank_orig_return
	bx  	r0

timer0Handler:
@ Hook the return address, then go back to the original function
	stmdb	sp!, {lr}
	adr 	lr, code_handler_start_timer0
	ldr 	r0,	intr_timer0_orig_return
	bx  	r0

timer1Handler:
@ Hook the return address, then go back to the original function
	stmdb	sp!, {lr}
	adr 	lr, code_handler_start_timer1
	ldr 	r0,	intr_timer1_orig_return
	bx  	r0

timer2Handler:
@ Hook the return address, then go back to the original function
	stmdb	sp!, {lr}
	adr 	lr, code_handler_start_timer2
	ldr 	r0,	intr_timer2_orig_return
	bx  	r0

timer3Handler:
@ Hook the return address, then go back to the original function
	stmdb	sp!, {lr}
	adr 	lr, code_handler_start_timer3
	ldr 	r0,	intr_timer3_orig_return
	bx  	r0

fifoHandler:
@ Hook the return address, then go back to the original function
	stmdb	sp!, {lr}
	adr 	lr, code_handler_start_fifo
	ldr 	r0,	intr_fifo_orig_return
	bx  	r0

code_handler_start_vblank:
	push	{r0-r12} 
	ldr	r3, =myIrqHandlerVBlank
	bl	_blx_r3_stub		@ jump to myIrqHandler
	
	@ exit after return
	b	exit

code_handler_start_timer0:
	push	{r0-r12} 
	ldr	r3, =myIrqHandlerTimer
	bl	_blx_r3_stub		@ jump to myIrqHandler
	
	@ exit after return
	b	exit

code_handler_start_timer1:
	push	{r0-r12} 
	ldr	r3, =myIrqHandlerTimer
	bl	_blx_r3_stub		@ jump to myIrqHandler
	
	@ exit after return
	b	exit

code_handler_start_timer2:
	push	{r0-r12} 
	ldr	r3, =myIrqHandlerTimer
	bl	_blx_r3_stub		@ jump to myIrqHandler
	
	@ exit after return
	b	exit

code_handler_start_timer3:
	push	{r0-r12} 
	ldr	r3, =myIrqHandlerTimer
	bl	_blx_r3_stub		@ jump to myIrqHandler
	
	@ exit after return
	b	exit

code_handler_start_fifo:
	push	{r0-r12} 
	ldr	r3, =myIrqHandlerFIFO
	bl	_blx_r3_stub		@ jump to myIrqHandler
  
  
	@ exit after return
	b	exit

@---------------------------------------------------------------------------------
_blx_r3_stub:
@---------------------------------------------------------------------------------
	bx	r3

@---------------------------------------------------------------------------------

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

exit:
	pop   	{r0-r12} 
	pop  	{lr}
	bx  lr

.pool

.global fastCopy32
.type	fastCopy32 STT_FUNC
@ r0 : src, r1 : dst, r2 : len
fastCopy32:
	stmfd   sp!, {r3-r11,lr}
	@ copy 512 bytes
	mov     r10, r0
	mov     r9, r1
	mov     r8, r2
loop_fastCopy32:
	ldmia   r10!, {r0-r7}
	stmia   r9!,  {r0-r7}
	subs    r8, r8, #32  @ 4*8 bytes
	bgt     loop_fastCopy32
	ldmfd   sp!, {r3-r11,lr}
	bx      lr

card_engine_end:

patches:
.word	card_pull_out_arm9
.word	card_irq_enable_arm7
.word	vblankHandler
.word	timer0Handler
.word	timer1Handler
.word	timer2Handler
.word	timer3Handler
.word	fifoHandler
.word   card_pull
.word   arm7Functions
.word   swi02
.word   j_twlGetPitchTable
.word   getPitchTableStub
.word   arm7FunctionsThumb
.pool
@---------------------------------------------------------------------------------

	.thumb
@---------------------------------------------------------------------------------
swi02:
@---------------------------------------------------------------------------------
	swi	#0x02
	bx	lr
@---------------------------------------------------------------------------------

	.arm
@---------------------------------------------------------------------------------
j_twlGetPitchTable:
@---------------------------------------------------------------------------------
	ldr	r12, = twlGetPitchTable
	bx	r12
.pool
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
twlGetPitchTable:
@---------------------------------------------------------------------------------
	ldr	r1, =0x46A
	subs	r0, r0, r1
	swi	#0x1B0000
	lsls	r0, r0, #0x10
	lsrs	r0, r0, #0x10
	bx	lr
@---------------------------------------------------------------------------------

	.thumb
@---------------------------------------------------------------------------------
getPitchTableStub:
@---------------------------------------------------------------------------------
	nop
	nop
	nop
	nop
	nop
	nop
@---------------------------------------------------------------------------------

	.arm
@---------------------------------------------------------------------------------
card_pull_out_arm9:
@---------------------------------------------------------------------------------
	bx      lr
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
card_irq_enable_arm7:
@---------------------------------------------------------------------------------
	push    {lr}
	push	{r1-r12}
	ldr	r3, =myIrqEnable
	bl	_blx_r3_stub2
	pop   	{r1-r12} 
	pop  	{lr}
	bx  lr
_blx_r3_stub2:
	bx	r3
.pool
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
card_pull:
@---------------------------------------------------------------------------------
	bx lr
cacheFlush:
	stmfd   sp!, {r0-r11,lr}

	@disable interrupt
	ldr r8,= 0x4000208
	ldr r11,[r8]
	mov r7, #0
	str r7, [r8]

//---------------------------------------------------------------------------------
IC_InvalidateAll:
/*---------------------------------------------------------------------------------
	Clean and invalidate entire data cache
---------------------------------------------------------------------------------*/
	mcr	p15, 0, r7, c7, c5, 0

//---------------------------------------------------------------------------------
DC_FlushAll:
/*---------------------------------------------------------------------------------
	Clean and invalidate a range
---------------------------------------------------------------------------------*/
	mov	r1, #0
outer_loop:
	mov	r0, #0
inner_loop:
	orr	r2, r1, r0			@ generate segment and line address
	mcr p15, 0, r7, c7, c10, 4
	mcr	p15, 0, r2, c7, c14, 2		@ clean and flush the line
	add	r0, r0, #CACHE_LINE_SIZE
	cmp	r0, #DCACHE_SIZE/4
	bne	inner_loop
	add	r1, r1, #0x40000000
	cmp	r1, #0
	bne	outer_loop

//---------------------------------------------------------------------------------
DC_WaitWriteBufferEmpty:
//---------------------------------------------------------------------------------
	MCR     p15, 0, R7,c7,c10, 4

	@restore interrupt
	str r11, [r8]

	ldmfd   sp!, {r0-r11,lr}
	bx      lr
	.pool

arm7Functions:
.word    eepromProtect
.word    eepromPageErase
.word    eepromPageVerify
.word    eepromPageWrite
.word    eepromPageProg
.word    eepromRead
.word    cardRead
.word    cardId
saveCluster:
.word    0x00000000

arm7FunctionsThumb:
.word    eepromProtectThumbStub
.word    eepromPageEraseThumbStub
.word    eepromPageVerifyThumbStub
.word    eepromPageWriteThumbStub
.word    eepromPageProgThumbStub
.word    eepromReadThumbStub
.word    cardReadThumbStub
.word    cardIdThumbStub

.thumb
_blx_r3_stubthumb:
	bx	r3

eepromProtectThumbStub:
	push    {r14}
	push	{r1-r4}
	ldr	r3, =eepromProtect
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3    
	
eepromPageEraseThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =eepromPageErase
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3    

eepromPageVerifyThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =eepromPageVerify
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3
	
eepromPageWriteThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =eepromPageWrite
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3
	
eepromPageProgThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =eepromPageProg
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3

cardReadThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =cardRead
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3

eepromReadThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =eepromRead
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3
	
cardIdThumbStub:
	push    {lr}
	push	{r1-r4}
	ldr	r3, =cardId
	bl	_blx_r3_stubthumb
	pop   	{r1-r4} 
	pop  	{r3}
	bx  r3

	.pool

	.arm
.global tryLockMutex
.type	tryLockMutex STT_FUNC
@ r0 : mutex adr
tryLockMutex:
	mov r1, r0   
	mov r2, #1
	swp r0,r2, [r1]
	cmp r0, r2
	beq trymutex_fail	
	mov r0, #1
	b mutex_exit	
trymutex_fail:
	mov r0, #0
mutex_exit:
	bx  lr

.global lockMutex
.type	lockMutex STT_FUNC
@ r0 : mutex adr
lockMutex:
  mov r1, r0    
  mov r2, #1
mutex_loop:
  swp r0,r2, [r1]
  cmp r0,r2
  beq mutex_loop    
  mov r0, #1	
  bx  lr



.global unlockMutex
.type	unlockMutex STT_FUNC
@ r0 : mutex adr
unlockMutex:  
	mov r1, #0
	str r1, [r0]
	bx  lr
