;******************************************************************************
; <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
;******************************************************************************
Stack   EQU     0x00000100

;******************************************************************************
; <o> Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
;******************************************************************************
Heap    EQU     0x00000000

;******************************************************************************
; Allocate space for the stack.
;******************************************************************************
        AREA    STACK, NOINIT, READWRITE, ALIGN=3
StackMem
        SPACE   Stack
__initial_sp

;******************************************************************************
; Allocate space for the heap.
;******************************************************************************
        AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
HeapMem
        SPACE   Heap
__heap_limit

;******************************************************************************
; Indicate that the code in this file preserves 8-byte alignment of the stack.
;******************************************************************************
        PRESERVE8

;******************************************************************************
; Place code into the reset code section.
;******************************************************************************
        AREA    RESET, CODE, READONLY
        THUMB

;******************************************************************************
; The vector table.
;******************************************************************************
        EXPORT  __Vectors
__Vectors
        DCD      StackMem + Stack       ; Top of Stack
        DCD      Reset_Handler          ; Reset Handler
		DCD      NmiSR                  ; -14 NMI Handler
		DCD      FaultISR               ; -13 Hard Fault Handler
		DCD      0                      ; -12 MPU Fault Handler
		DCD      0                      ; -11 Bus Fault Handler
		DCD      0                      ; -10 Usage Fault Handler
		DCD      0                      ;     Reserved
		DCD      0                      ;     Reserved
		DCD      0                      ;     Reserved
		DCD      0                      ;     Reserved
		DCD      0                      ;  -5 SVCall Handler
		DCD      0                      ;  -4 Debug Monitor Handler
		DCD      0                      ;     Reserved
		DCD      0                      ;  -2 PendSV Handler
		DCD      0                      ;  -1 SysTick Handler
        ; Interrupts
        DCD      Interrupt0_Handler     ;   0 Interrupt 0
        SPACE    (223 * 4)              ; Interrupts 1 .. 224 are left out
;******************************************************************************
;
; This is the code that gets called when the processor first starts execution
; following a reset event.
;
;******************************************************************************
        EXPORT  Reset_Handler
Reset_Handler
        IMPORT  __main

        IF      {CPU} = "Cortex-M4.fp"
        LDR     R0, =0xE000ED88           ; Enable CP10,CP11
        LDR     R1,[R0]
        ORR     R1,R1,#(0xF << 20)
        STR     R1,[R0]
        ENDIF

        B       __main

;******************************************************************************
;
; This is the code that gets called when the processor receives a NMI.  This
; simply enters an infinite loop, preserving the system state for examination
; by a debugger.
;
;******************************************************************************
NmiSR
        B       NmiSR

;******************************************************************************
;
; This is the code that gets called when the processor receives a fault
; interrupt.  This simply enters an infinite loop, preserving the system state
; for examination by a debugger.
;
;******************************************************************************
FaultISR
        B       FaultISR

;******************************************************************************
;
; This is the code that gets called when the processor receives an unexpected
; interrupt.  This simply enters an infinite loop, preserving the system state
; for examination by a debugger.
;
;******************************************************************************
Interrupt0_Handler
        B       Interrupt0_Handler

;******************************************************************************
;
; Make sure the end of this section is aligned.
;
;******************************************************************************
        ALIGN

;******************************************************************************
;
; Some code in the normal code section for initializing the heap and stack.
;
;******************************************************************************
        AREA    |.text|, CODE, READONLY

;******************************************************************************
;
; The function expected of the C library startup code for defining the stack
; and heap memory locations.  For the C library version of the startup code,
; provide this function so that the C library initialization code can find out
; the location of the stack and heap.
;
;******************************************************************************
    IF :DEF: __MICROLIB
        EXPORT  __initial_sp
        EXPORT  __heap_base
        EXPORT __heap_limit
    ELSE
;        IMPORT  __use_two_region_memory
        EXPORT  __user_initial_stackheap
__user_initial_stackheap
        LDR     R0, =HeapMem
        LDR     R1, =(StackMem + Stack)
        LDR     R2, =(HeapMem + Heap)
        LDR     R3, =StackMem
        BX      LR
    ENDIF

;******************************************************************************
;
; Make sure the end of this section is aligned.
;
;******************************************************************************
        ALIGN

;******************************************************************************
;
; Tell the assembler that we're done.
;
;******************************************************************************
        END
