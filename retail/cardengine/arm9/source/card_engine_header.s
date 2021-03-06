@---------------------------------------------------------------------------------
	.section ".init"
@---------------------------------------------------------------------------------
	.global _start
	.global ce9
	.align	4
	.arm

#define ICACHE_SIZE	0x2000
#define DCACHE_SIZE	0x1000
#define CACHE_LINE_SIZE	32

ce9 :
	.word	ce9
patches_offset:
	.word	patches
thumbPatches_offset:
	.word	thumbPatches
intr_fifo_orig_return:
	.word	0x00000000
moduleParams:
	.word	0x00000000
fileCluster:
	.word	0x00000000
cardStruct0:
	.word	0x00000000
cacheStruct:
	.word	0x00000000
ROMinRAM:
	.word	0x00000000
dsiMode:
	.word	0x00000000
enableExceptionHandler:
	.word	0x00000000
consoleModel:
	.word	0x00000000

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

card_engine_start:

patches:
.word	card_read_arm9
.word	card_pull_out_arm9
.word	0x0
.word	card_id_arm9
.word	card_dma_arm9
.word	cardStructArm9
.word   card_pull
.word   cacheFlushRef
.word   0x0 @sleepRef
.word   terminateForPullOutRef
needFlushDCCache:
.word   0x0
thumbPatches:
.word	thumb_card_read_arm9
.word	thumb_card_pull_out_arm9
.word	0x0
.word	thumb_card_id_arm9
.word	thumb_card_dma_arm9
.word	cardStructArm9
.word   thumb_card_pull
.word   cacheFlushRef
thumbSleepRef:
.word   0x0 @sleepRef
.word   terminateForPullOutRef


@---------------------------------------------------------------------------------
card_read_arm9:
@---------------------------------------------------------------------------------
	stmfd   sp!, {r4-r11,lr}

	ldr		r6, cardReadRef1
    ldr     r7, ce9location1
    add     r6, r6, r7
    
	bl		_blx_r6_stub_card_read

	ldmfd   sp!, {r4-r11,pc}
	bx      lr
_blx_r6_stub_card_read:
	bx	r6
.pool
cardStructArm9:
.word    0x00000000     
cacheFlushRef:
.word    0x00000000  
terminateForPullOutRef:
.word    0x00000000  
cacheRef:
.word    0x00000000
ce9location1:
.word   ce9
cardReadRef1:
.word   cardRead-ce9 	  
	.thumb
@---------------------------------------------------------------------------------
thumb_card_read_arm9:
@---------------------------------------------------------------------------------
	push	{r3-r7, lr}

	ldr		r6, cardReadRef2
    ldr     r7, ce9location2
    add     r6, r6, r7

	bl		_blx_r6_stub_thumb_card_read	

	pop	{r3-r7, pc}
	bx      lr
_blx_r6_stub_thumb_card_read:
	bx	r6	
.pool
.align	4
ce9location2:
.word   ce9
cardReadRef2:
.word   cardRead-ce9 	
	.arm
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
card_id_arm9:
@---------------------------------------------------------------------------------
    stmfd   sp!, {r1-r11,lr}

	ldr		r6, cardReadRef3
    ldr     r7, ce9location3
    add     r6, r6, r7

	bl		_blx_r6_stub_card_id	
    

	ldmfd   sp!, {r1-r11,pc}
	bx      lr
_blx_r6_stub_card_id:
	bx	r6	
.pool
ce9location3:
.word   ce9
cardReadRef3:
.word   cardId-ce9 
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
card_dma_arm9:
@---------------------------------------------------------------------------------
    stmfd   sp!, {r1-r11,lr}

	ldr		r6, cardReadRef4
    ldr     r7, ce9location4
    add     r6, r6, r7

	bl		_blx_r6_stub_card_read_dma	
    

	ldmfd   sp!, {r1-r11,pc}
	mov r0, #0
	bx      lr
_blx_r6_stub_card_read_dma:
	bx	r6	
.pool
ce9location4:
.word   ce9
cardReadRef4:
.word   cardReadDma-ce9 
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
card_pull_out_arm9:
@---------------------------------------------------------------------------------
	bx      lr
@	stmfd   sp!, {lr}
@	sub     sp, sp, #4
@	ldr		r6, cardPullOutRef
@    ldr     r7, ce9location5
@    add     r6, r6, r7
    
@	bl		_blx_r6_stub_card_pull_out

@	add     sp, sp, #4
@	ldmfd   sp!, {lr}
@	bx      lr
@_blx_r6_stub_card_pull_out:
@	bx	r6
@.pool
@ce9location5:
@.word   ce9
@cardPullOutRef:
@.word   cardPullOut-ce9
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
card_pull:
@---------------------------------------------------------------------------------
	bx      lr
	.thumb
@---------------------------------------------------------------------------------
thumb_card_id_arm9:
@---------------------------------------------------------------------------------
    push	{r1-r7, lr}

	ldr		r6, cardReadRef6
    ldr     r7, ce9location6
    add     r6, r6, r7

	bl		_blx_r6_stub_card_id_thumb	
    

    pop	{r1-r7, pc}
	bx      lr
_blx_r6_stub_card_id_thumb:
	bx	r6	
.pool
.align	4
ce9location6:
.word   ce9
cardReadRef6:
.word   cardId-ce9 
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
thumb_card_dma_arm9:
@---------------------------------------------------------------------------------
    push	{r1-r7, lr}
    
	ldr		r6, cardReadRef7
    ldr     r7, ce9location7
    add     r6, r6, r7

	bl		_blx_r6_stub_thumb_card_read_dma	

    pop	{r1-r7, pc}
    mov r0, #0
	bx      lr
_blx_r6_stub_thumb_card_read_dma:
	bx	r6	
.pool
.align	4
ce9location7:
.word   ce9
cardReadRef7:
.word   cardReadDma-ce9 
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
thumb_card_pull_out_arm9:
@---------------------------------------------------------------------------------
	bx      lr
@---------------------------------------------------------------------------------

@---------------------------------------------------------------------------------
thumb_card_pull:
@---------------------------------------------------------------------------------
	bx      lr

	.arm
    
.global callSleepThumb
.type	callSleepThumb STT_FUNC
callSleepThumb:
    push	{r1-r7, lr}
    ldr     r6, thumbSleepRef
    add     r6, #1
    bl		_blx_r6_stub_callSleepThumb	
    pop	    {r1-r7, pc}
	bx      lr
_blx_r6_stub_callSleepThumb:
	bx	r6	
.pool

/*.global patchPdash
.type	patchPdash STT_FUNC
patchPdash:
    nop
@ r0 cardstruct like struct, to be copied to cardstruct
    push	{r1-r7, lr}
    mov     r1, #0x28
    mov     r2, #0
    ldr     r3, cardstruct
loop_patchPdash:
    ldr     r4, [r0, r2]
    str     r4, [r3, r2]
    add     r2,r2,#4
    cmp     r2,r1
    bne     loop_patchPdash
    ldr     r3, cardRead
    blx     r3     
    pop	    {r1-r7, pc}
    mov     r0,#1
    bx      lr     
cardstruct:
.word   0x20DA600
cardRead:
.word   0x20A4778*/ 

//---------------------------------------------------------------------------------
.global  IC_InvalidateAll
.type	 IC_InvalidateAll STT_FUNC
/*---------------------------------------------------------------------------------
	Clean and invalidate entire data cache
---------------------------------------------------------------------------------*/
IC_InvalidateAll:
	mov	r0, #0
	mcr	p15, 0, r0, c7, c5, 0
	bx	lr

//---------------------------------------------------------------------------------
.global IC_InvalidateRange
.type	IC_InvalidateRange STT_FUNC
/*---------------------------------------------------------------------------------
	Invalidate a range
---------------------------------------------------------------------------------*/
IC_InvalidateRange:
	add	r1, r1, r0
	bic	r0, r0, #CACHE_LINE_SIZE - 1
.invalidate:
	mcr	p15, 0, r0, c7, c5, 1
	add	r0, r0, #CACHE_LINE_SIZE
	cmp	r0, r1
	blt	.invalidate
	bx	lr

@---------------------------------------------------------------------------------        
.global cacheFlush
.type	cacheFlush STT_FUNC
/*---------------------------------------------------------------------------------
	Flush dcache and icache
---------------------------------------------------------------------------------*/
cacheFlush:
	stmfd   sp!, {r0-r11,lr}

	@disable interrupt
	ldr r8,= 0x4000208
	ldr r11,[r8]
	mov r7, #0
	str r7, [r8]
//---------------------------------------------------------------------------------
// IC_InvalidateAll:
/*---------------------------------------------------------------------------------
	Clean and invalidate entire data cache
---------------------------------------------------------------------------------*/
	mcr	p15, 0, r7, c7, c5, 0
//---------------------------------------------------------------------------------
//DC_FlushAll:
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
//DC_WaitWriteBufferEmpty:
//---------------------------------------------------------------------------------               
	MCR     p15, 0, R7,c7,c10, 4

	@restore interrupt
	str r11, [r8]

	ldmfd   sp!, {r0-r11,lr}
	bx      lr
	.pool

card_engine_end:
