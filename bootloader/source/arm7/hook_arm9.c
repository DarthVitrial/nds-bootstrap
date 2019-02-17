#include <string.h> // memcpy
#include <stdio.h>
#include <nds/ndstypes.h>
#include <nds/debug.h>
#include <nds/system.h>
#include "hook.h"
#include "common.h"
#include "find.h"
#include "cardengine_header_arm9.h"

static const int MAX_HANDLER_LEN = 50;

// same as arm7
static const u32 handlerStartSig[5] = {
	0xe92d4000, 	// push {lr}
	0xe3a0c301, 	// mov  ip, #0x4000000
	0xe28cce21,		// add  ip, ip, #0x210
	0xe51c1008,		// ldr	r1, [ip, #-8]
	0xe3510000		// cmp	r1, #0
};

// same as arm7
static const u32 handlerEndSig[4] = {
	0xe59f1008, 	// ldr  r1, [pc, #8]	(IRQ Vector table address)
	0xe7910100,		// ldr  r0, [r1, r0, lsl #2]
	0xe59fe004,		// ldr  lr, [pc, #4]	(IRQ return address)
	0xe12fff10		// bx   r0
};

static u32* hookInterruptHandler(const u32* start, size_t size) {
	// Find the start of the handler
	u32* addr = findOffset(
		start, size,
		handlerStartSig, 5
	);
	if (!addr) {
        dbg_printf("ERR_HOOK_9 : handlerStartSig\n");
		return NULL;
	}
    
    dbg_printf("handlerStartSig\n");
    dbg_hexa(addr);
    dbg_printf("\n");

	// Find the end of the handler
	addr = findOffset(
		addr, MAX_HANDLER_LEN*sizeof(u32),
		handlerEndSig, 4
	);
	if (!addr) {
        dbg_printf("ERR_HOOK_9 : handlerEndSig\n");
		return NULL;
	}
    
    
    
    dbg_printf("handlerEndSig\n");
    dbg_hexa(addr);
    dbg_printf("\n");

	// Now find the IRQ vector table
	// Make addr point to the vector table address pointer within the IRQ handler
	addr += sizeof(handlerEndSig)/sizeof(handlerEndSig[0]);

	// Use relative and absolute addresses to find the location of the table in RAM
	u32 tableAddr = addr[0];
    dbg_printf("tableAddr\n");
    dbg_hexa(tableAddr);
    dbg_printf("\n");
    
	u32 returnAddr = addr[1];
    dbg_printf("returnAddr\n");
    dbg_hexa(returnAddr);
    dbg_printf("\n");
    
	u32* actualReturnAddr = addr + 2;
	u32* actualTableAddr = actualReturnAddr + (tableAddr - returnAddr)/sizeof(u32);

	// The first entry in the table is for the Vblank handler, which is what we want
	return tableAddr;
	// 2     LCD V-Counter Match
}

int hookNdsRetailArm9(
	cardengineArm9* ce9,
	const module_params_t* moduleParams,
	u32 ROMinRAM,
	u32 dsiMode, // SDK 5
	u32 enableExceptionHandler,
	u32 consoleModel
) {
	dbg_printf("hookNdsRetailArm9\n");

	ce9->moduleParams           = moduleParams;
	ce9->ROMinRAM               = ROMinRAM;
	ce9->dsiMode                = dsiMode; // SDK 5
	ce9->enableExceptionHandler = enableExceptionHandler;
	ce9->consoleModel           = consoleModel;
    
    u32* tableAddr = hookInterruptHandler((u32*)ndsHeader->arm9destination, 0x00300000);
    
    if (!tableAddr) {
		dbg_printf("ERR_HOOK_9\n");
		return ERR_HOOK;
	}
    
    /*u32* vblankHandler = hookLocation;
    u32* dma0Handler = hookLocation + 8;
    u32* dma1Handler = hookLocation + 9;
    u32* dma2Handler = hookLocation + 10;
    u32* dma3Handler = hookLocation + 11;
    u32* ipcSyncHandler = hookLocation + 16;
    u32* cardCompletionIrq = hookLocation + 19;*/
    
    ce9->irqTable   = tableAddr;
    
    /*dbg_printf("vblankHandler\n");
    dbg_hexa(vblankHandler);
    dbg_printf(" : ");   
    dbg_hexa(*vblankHandler);
    dbg_printf("\n");
    
    dbg_printf("dma0Handler\n");
    dbg_hexa(dma0Handler);
    dbg_printf(" : ");   
    dbg_hexa(*dma0Handler);
    dbg_printf("\n");
    
    dbg_printf("ipcSyncHandler\n");
    dbg_hexa(ipcSyncHandler);
    dbg_printf(" : ");   
    dbg_hexa(*ipcSyncHandler);
    dbg_printf("\n");
    
    dbg_printf("cardCompletionIrq\n");
    dbg_hexa(cardCompletionIrq);
    dbg_printf(" : ");   
    dbg_hexa(*cardCompletionIrq);
    dbg_printf("\n");
    
    dbg_printf("ce9->patches->fifoHandler\n");
    dbg_hexa(ce9->patches->fifoHandler);
    dbg_printf("\n");       
    
    if (!ROMinRAM) {
		*ipcSyncHandler = ce9->patches->fifoHandler;
	}*/

	dbg_printf("NO_ERROR_HOOK_9\n");
	return ERR_NONE;
}
