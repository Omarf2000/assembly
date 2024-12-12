.model small
.stack 100h
.data 
msgM db  "                          MADE BY",0ah,0dh,"    ~~~OMAR MOHAMED ABDELFATTAH HASSAN EMARA~~~ SEC--> 4 ",0dh,0ah,"$"      
rule     db '=== Rock Paper Scissors Game ===', 13, 10
        db 'Game Rules:', 13, 10
        db '  1 = Rock', 13, 10
        db '  2 = Paper', 13, 10
        db '  3 = Scissors', 13, 10,'$'
        
MSG     db 'Enter your choice (1-3): $'
OO      db 'Player chose: $'
PC      db 'Computer chose: $'
INVALID db 'Invalid input! Please enter 1, 2, or 3 only.',13,10,'$'
PlayerWin db '  Player wins!$'
PCWin   db '  Computer wins!$'
tie     db "It's a tie!$"
PLAY_AGAIN db 13,10,'Play again? Press ENTER $'
CHOICE1 db 'Rock',13,10,'$'
CHOICE2 db 'Paper',13,10,'$'
CHOICE3 db 'Scissors',13,10,'$'
NL      db 13,10,'$'
SCORE   db 'Score -> Player: $'
SCORE2  db '  Computer: $'
P_SCORE db '0$'        ; Player score as string
C_SCORE db '0',13,10,'$' ; Computer score as string
P_NUM   db 0          ; Player score as number
C_NUM   db 0          ; Computer score as number 

.code
main proc
    mov ax,@data
    mov ds,ax
    
game_start:
    MOV AX, 0003h    ;clear the screen every time i play again
    INT 10h
    
    lea dx,msgm  
    mov ah, 9
    int 21h
    
    lea DX, rule     ; display welcome message
    mov AH, 9
    int 21h
    
    lea dx, SCORE 
    mov ah, 9
    int 21h 
    
    lea dx, P_SCORE
    mov ah, 9
    int 21h
    
    lea dx, SCORE2
    mov ah, 9
    int 21h
    
    lea dx, C_SCORE 
    mov ah, 9
    int 21h
     
Take_input:
    lea dx, MSG 
    mov ah, 9
    int 21h 
    
    ;get input
    mov ah, 1
    int 21h 
    mov bl, al
    
    ;validate 
    cmp bl, '1'
    jb invalid_input
    cmp bl, '3'
    ja invalid_input
    
    ;new line
    lea dx, NL
    mov ah, 09
    int 21h
    
    lea dx, OO      ;player choice
    mov ah, 09
    int 21h
           
    cmp bl, '1'
    je ROCK
    cmp bl, '2'
    je PAPER
    jmp SCISSORS 
    
ROCK:
    lea dx, CHOICE1
    jmp display
PAPER:
    lea dx, CHOICE2
    jmp display
SCISSORS:
    lea dx, CHOICE3
display:
    mov ah, 9
    int 21h 
    
    ; computer choice
    mov ah, 00h
    int 1ah
    mov ax, dx
    mov dx, 0
    mov cx, 3
    div cx 
    add dl, '1'
    mov bh, dl
    
    ;print pc choice 
    lea dx, PC
    mov ah, 9
    int 21h
    
    cmp bh, '1'
    je rock2
    cmp bh, '2'
    je paper2
    jmp scissors2
    
rock2:
    lea dx, CHOICE1
    jmp display2
paper2:    
    lea dx, CHOICE2 
    jmp display2 
scissors2:    
    lea dx, CHOICE3
display2:
    mov ah, 9
    int 21h
    
    ;compare choices
    cmp bl, bh
    je equal
    
    ;determine winner
    mov al, bl
    mov ah, bh 
    cmp al, '1'    ;if rock
    je check_rock
    cmp al, '2'    ;if paper
    je check_paper
    jmp check_scissors
    
check_rock:
    cmp ah, '2'
    je pc_win
    jmp player_win
    
check_paper:
    cmp ah, '3'
    je pc_win
    jmp player_win
    
check_scissors:
    cmp ah, '1'
    je pc_win 
    jmp player_win
     
equal:
    lea dx, tie
    mov ah, 9
    int 21h
    jmp PlayAgain
    
player_win:
    inc P_NUM 
    mov al, P_NUM
    add al, '0'
    mov P_SCORE, al
     
    lea dx, PlayerWin
    mov ah, 9
    int 21h 
    jmp PlayAgain
    
pc_win:
    inc C_NUM 
    mov al, C_NUM
    add al, '0'
    mov C_SCORE, al
    
    lea dx, PCWin
    mov ah, 9
    int 21h 
    jmp PlayAgain
    
PlayAgain:
    lea dx, PLAY_AGAIN
    mov ah, 9
    int 21h 
    
    mov ah, 1
    int 21h
    
    cmp al, 0dh
    je game_start
    
    jmp EXIT
    
invalid_input:  
    lea dx, INVALID
    mov ah, 09
    int 21h 
    jmp Take_input
    
EXIT:
    MOV AH, 4Ch
    INT 21h 
    
main endp
end main