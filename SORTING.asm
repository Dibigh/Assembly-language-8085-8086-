CLEAR MACRO
    MOV AX, 0600H  
    MOV BH, 61H  
    MOV CX, 0000H  
    MOV DX, 184FH  
    INT 10H
ENDM       
.MODEL SMALL
.STACK 64
.DATA
ARR1 DB 12,51,19,29,45,22,21,11,9,20   
.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS,AX
    LEA SI,ARR1
    MOV CX,9
    MOV BL,[SI]   
    MOV DL,BL
    INC SI
    LOOP1: CMP BL,[SI]
    JNC SMAL   
    CMP DL,[SI]
    JB BIG1
    JMP LOW 
    BIG1:MOV DL,[SI]
    LOW:INC SI
    LOOP LOOP1  
    JMP BODY
    SMAL: CMP DL,[SI]
    JB BIG2  
    JMP HI
    BIG2: MOV DL,[SI] 
    HI:MOV BL,[SI]
    INC SI
    LOOP LOOP1   
   BODY: MOV BH,0
   MOV BP,DX    
   CLEAR        
    MOV AX,BX  
    CALL DISPLAY
    MOV AX,0
    MOV AX,BP
    CALL DISPLAY
    MOV AX,4C00H
    INT 21H     
    MAIN ENDP
DISPLAY PROC NEAR
    MOV AH,0
    MOV BX,0
    MOV DX,0
    MOV CX,10
    L1:DIV CX
    PUSH DX
    INC BX
    XOR DX,DX
    CMP AX,0
    JNE L1
    SKIP:POP DX
    ADD DX,48  
    MOV AH,02H
    INT 21H
    DEC BX   
    JNZ SKIP
    MOV AH,02H
    MOV DL,0AH
    INT 21H  
    MOV AH, 02H
    MOV DL,0DH
    INT 21H 
    RET
    DISPLAY ENDP
END MAIN                         