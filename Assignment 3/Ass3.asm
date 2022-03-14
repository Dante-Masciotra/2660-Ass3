; Name: Dante Masciotra
; ID: 110042203

; Name: Zach Wasylyk
; ID: 110045471

; Name: Jamie Groeneweg
; ID: 

INCLUDE Irvine32.inc
INCLUDELIB	Irvine32.lib
.data
Vector DWORD 50 DUP(?)
VectorCount DWORD 1


InputVectorStr BYTE "what is the sizestr N of Vector?> ",0

msg1 BYTE "What are the ",0
msg2 BYTE " values in Vector?> ",0
msg3 BYTE "Size of Vector is N = ",0
msg4 BYTE "Vector = ",0

AtoSmsg1 BYTE "Vector is  ",0
AtoSmsg2 BYTE "Stack is ",0
AtoSmsg3 BYTE "before ArrayToStack",0
AtoSmsg4 BYTE "after ArrayToStack",0

EmptyStack BYTE "Stack is empty",0
FilledStack BYTE "Stack not empty",0

spacing BYTE "   ",0
.code
main PROC
	call FillArray
	call Crlf
	call ArrayToStack
		exit
main ENDP

FillArray PROC
mov edx, OFFSET InputVectorStr	;peompt user to input array size
	call WriteString
	call ReadInt		
	mov VectorCount,eax
	call Crlf

	;cmp VectorCount,0
	;jle Error1


	mov edx, OFFSET msg1	;prompts user to insert N elements into array
	call WriteString
	mov eax,VectorCount
    call WriteDec	
	mov edx, OFFSET msg2	
	call WriteString
	
	mov eax,0
	mov esi, OFFSET Vector
	mov ecx,VectorCount
	readVectors:
		call ReadInt		;loop to read elements
		mov [esi],eax
		add esi,2
	loop readVectors
	call Crlf


	mov edx, OFFSET msg3	 ;prints size of array
	call WriteString
	mov eax,VectorCount
    call WriteDec	
	call Crlf

	mov edx, OFFSET msg4	;prints each element of array
	call WriteString
	mov eax,0
	mov esi, OFFSET Vector
	mov ecx,VectorCount
	writeVectors:
		mov ax,[esi]		;loop to print array elements
		movsx eax,ax
		call WriteDec
		mov edx, OFFSET spacing	
		call WriteString
		add esi,2
	loop writeVectors
	RET
FillArray ENDP

ArrayToStack PROC
	mov edx, OFFSET AtoSmsg1 ;write vector	
	call WriteString
	mov esi, OFFSET Vector
	mov ecx,VectorCount
	writeVectors:
		mov ax,[esi]		;loop to print array elements
		movsx eax,ax
		call WriteDec
		mov edx, OFFSET spacing	
		call WriteString
		add esi,2
	loop writeVectors
	mov edx, OFFSET AtoSmsg3 ;write before stacking	
	call WriteString
	call Crlf


	mov esi, OFFSET Vector
	mov ecx,VectorCount
	stackArray:			;Write array to Stack
		mov ax,[esi]
		movsx eax,ax
		push eax
		add esi,2
	loop stackArray

	mov edx, OFFSET AtoSmsg2 ;write stack	
	call WriteString
	mov ecx,VectorCount
	writeStack:			;write stack to ouput
		pop eax
		call WriteDec
		mov edx, OFFSET spacing	
		call WriteString
		inc esi
	loop writeStack
	mov edx, OFFSET AtoSmsg4 ;write after stacking	
	call WriteString
	call Crlf

	mov esi, OFFSET Vector
	mov ecx,VectorCount
	Restack:			;restack after writing
		mov ax,[esi]
		movsx eax,ax
		push eax
		add esi,2
	loop Restack

	mov esi, OFFSET Vector
	mov ecx,VectorCount
	clearArray:
		mov eax,0		;clear the array after stacking it
		mov [esi],eax
		add esi,2
	loop clearArray


	mov edx, OFFSET AtoSmsg1 ;write array	
	call WriteString
	mov esi, OFFSET Vector
	mov ecx,VectorCount
	writeVectors2:
		mov ax,[esi]		;loop to print array elements
		movsx eax,ax
		call WriteDec
		mov edx, OFFSET spacing	
		call WriteString
		add esi,2
	loop writeVectors2
	mov edx, OFFSET AtoSmsg4 ;write after stacking	
	call WriteString

	call Crlf

	mov edx, OFFSET FilledStack ;write state of stack	
	call WriteString
	RET					;return to main
ArrayToStack ENDP

END main