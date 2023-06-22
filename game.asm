Comment!
Muhammad Umair Khalid		21I-0455
Abtaal Aatif				21I-2990
!
;============================================================Structure Creation============================================================

brick struct
xcoord dw 0
ycoord dw 0
color db 12
hits db 1
len dw 40
breadth dw 15
diff1 dw 0
diff2 dw 0
loopvar dw 0
brick ends


;============================================================Start of Data Set=============================================================

.model small
.stack 100h
.data
ballcx dw 1
ballcy dw 1
Welcome db "WELCOME TO BRICK SHREDER GAME"
KeyCont db "=========Press Any Key To Continue========"
Congratulations db "Congratulations"
HighPrint db "=========HighScore LeaderBoard========="
YouWin db "Game Over"
Visit db "More Games Here"
HighScoreCounted db "HighScore Recorded"
Logo db 'B','R','I','C','K',' ','S','H','R','E','D','D','E','R',' ',' ','G','A','M','E'
NameOutput db 'E','N','T','E','R',' ','Y','O','U','R',' ','N','A','M','E',':',' ',' '
LeaderBoard_Output db 'L','E','A','D','E','R','B','O','A','R','D',':'
Umair db "Umair Khalid   21I-0455"
Abtaal db "Abtaal Aatif   21I-2990"
Project db "A Project By:"
NewOutput db 'N','E','W',' ','G','A','M','E'
InsOutput db 'I','N','S','T','R','U','C','T','I','O','N','S'
HighOutput db 'H','I','G','H','S','C','O','R','E'
ExitOutput db 'E','X','I','T'
ins_title db "INSTRUCTIONS"
LivesStr db "Lives$"
ScoreStr db "Score : $"
LevelStr db "Level : $"
LevelCount db 0
ScoreCount dw 0
NameStr db 30 dup('$')
Para1 db "The player has a total of3 lives shown by hearts, Press right and left key to move the paddle right left to prevent the ball from falling, if the ballfalls 1 life is deducted once the live count goes to 0 its game over.       "
;once you complete 3 levels your score is automatically recorded in the leaderboard."
Para2 db "There are a total of 3 levels, each level is more difficult    than the previous.   Level1 is the easiestas it takes only one hit from the ball to break a brick once   all the bricks are   broken the Level getscompleted.           "
Para3 db "As you advance to thenext levels of the   game, the difficulty level increases whichincludes the speed ofthe ball increased,  the paddle length    decreased and the hitcount required to    break a brick will beincreased by a factorof 1.           "
Para4 db "     "
rownum db 0
iterator db 27
count db 0
ite db 0
idx db 0
limit db 0
p1 dw 0
p2 dw 0
p3 dw 0
p4 dw 0
tempcount db 0
resetvar db 0 
temp1 dw 0
colorvar db 1111b
s1 dw 0
s2 dw 0
s3 dw 0
s4 dw 0
s5 dw 0
s6 dw 0
tempidx1 dw 0
tempidx2 dw 0
pdidx1 dw 0
pdidx2 dw 0
pdidx3 dw 0
pdidx4 dw 0
counter db 0
centerx dw 100
centery dw 100
b_limit1 dw 0
b_limit2 dw 0

;2*length + 4 for distance between centres of bricks in a row
;2*breadth + 4 for distance between centres of bricks in a column
brick1 brick <120,64,13,1>, <204,64,11,1>, <288,64,13,1>, <372,64,11,1>, <456,64,13,1>, <540,64,11,1>
brick2 brick <120,96,14,1>, <204,96,12,1>, <288,96,14,1>, <372,96,12,1>, <456,96,14,1>, <540,96,12,1>
brick3 brick <120,128,9,1>, <204,128,10,1>, <288,128,9,1>, <372,128,10,1>, <456,128,9,1>, <540,128,10,1>
brick4 brick <120,160,13,1>, <204,160,11,1>, <288,160,13,1>, <372,160,11,1>, <456,160,13,1>, <540,160,11,1>
bvar dw 0
brow dw 0	;size of one row of bricks
bsize dw 0	;size of one brick
livecount dw 5
sidex1 dw 0
sidex2 dw 0
bx3 dw 0
sidey1 dw 0
sidey2 dw 0
by3 dw 0
filename db "Leaderboard.txt",0
buffer db 200 dup ("$")
filehandler dw 0
buffclear db 200
divisor db 10
fileinput db 5																		;Static change everytime
fileoutput dw 0

Pausestr db "Your Game Has Been Paused$"
Pausestr1 db "Hopefully You're Having Fun...Right? :)$"
Pausestr2 db "Press ESC Key to Go Back$"
ballcolor db 0
paddlecolor db 0
counte db 0
;pdiff dw 4
setpaddle dw 176
spaces db "           $"

;============================================================Start of .Code============================================================

.code
emptybuff macro	;used to clear buffer
mov buffclear, 100
mov si, offset buffer
mov al, '$'
buffloop:
mov [si], al
inc si
dec buffclear
cmp buffclear, 0
jne buffloop
mov ax, 0
endm

mov ax,@data
mov ds,ax
mov ax,0

jmp main


;============================================================Destroy Brick Function 1=====================================================

destroybrick1 proc	;turns brick black when hit counter turns 0
push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
add scorecount,5
mov [brick1 + bx].color, 0
mov cx, [brick1 + bx].xcoord
add cx, [brick1 + bx].len
mov [brick1 + bx].diff1, cx
sub cx, [brick1 + bx].len
sub cx, [brick1 + bx].len
mov dx, [brick1 + bx].ycoord
add dx, [brick1 + bx].breadth
mov [brick1 + bx].diff2, dx
sub dx, [brick1 + bx].breadth
sub dx, [brick1 + bx].breadth
mov ax, [brick1 + bx].breadth
add ax, [brick1 + bx].breadth
mov [brick1 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick1 + bx].color
destroy2:
destroy1:
int 10h
inc cx
cmp cx, [brick1 + bx].diff1
jbe destroy1
mov cx, [brick1 + bx].xcoord
sub cx, [brick1 + bx].len
inc dx
dec [brick1 + bx].loopvar
cmp [brick1 + bx].loopvar, 0
jne destroy2

call printtop

pop ax
pop bx
pop cx
pop dx

ret
destroybrick1 endp

rebrick1 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
;add scorecount,5
dec [brick1 + bx].color

mov cx, [brick1 + bx].xcoord
add cx, [brick1 + bx].len
mov [brick1 + bx].diff1, cx
sub cx, [brick1 + bx].len
sub cx, [brick1 + bx].len
mov dx, [brick1 + bx].ycoord
add dx, [brick1 + bx].breadth
mov [brick1 + bx].diff2, dx
sub dx, [brick1 + bx].breadth
sub dx, [brick1 + bx].breadth
mov ax, [brick1 + bx].breadth
add ax, [brick1 + bx].breadth
mov [brick1 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick1 + bx].color
re2:
re1:
int 10h
inc cx
cmp cx, [brick1 + bx].diff1
jbe re1
mov cx, [brick1 + bx].xcoord
sub cx, [brick1 + bx].len
inc dx
dec [brick1 + bx].loopvar
cmp [brick1 + bx].loopvar, 0
jne re2

call printtop
pop ax
pop bx
pop cx
pop dx

ret
rebrick1 endp


;============================================================Start of Destroy Function 2======================================================

destroybrick2 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
add scorecount,5

mov [brick2 + bx].color, 0
mov cx, [brick2 + bx].xcoord
add cx, [brick2 + bx].len
mov [brick2 + bx].diff1, cx
sub cx, [brick2 + bx].len
sub cx, [brick2 + bx].len
mov dx, [brick2 + bx].ycoord
add dx, [brick2 + bx].breadth
mov [brick2 + bx].diff2, dx
sub dx, [brick2 + bx].breadth
sub dx, [brick2 + bx].breadth
mov ax, [brick2 + bx].breadth
add ax, [brick2 + bx].breadth
mov [brick2 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick2 + bx].color
destroy4:
destroy3:
int 10h
inc cx
cmp cx, [brick2 + bx].diff1
jbe destroy3
mov cx, [brick2 + bx].xcoord
sub cx, [brick2 + bx].len
inc dx
dec [brick2 + bx].loopvar
cmp [brick2 + bx].loopvar, 0
jne destroy4

call printtop
pop ax
pop bx
pop cx
pop dx

ret
destroybrick2 endp

rebrick2 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
;add scorecount,5
dec [brick2 + bx].color

mov cx, [brick2 + bx].xcoord
add cx, [brick2 + bx].len
mov [brick2 + bx].diff1, cx
sub cx, [brick2 + bx].len
sub cx, [brick2 + bx].len
mov dx, [brick2 + bx].ycoord
add dx, [brick2 + bx].breadth
mov [brick2 + bx].diff2, dx
sub dx, [brick2 + bx].breadth
sub dx, [brick2 + bx].breadth
mov ax, [brick2 + bx].breadth
add ax, [brick2 + bx].breadth
mov [brick2 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick2 + bx].color
re4:
re3:
int 10h
inc cx
cmp cx, [brick2 + bx].diff1
jbe re3
mov cx, [brick2 + bx].xcoord
sub cx, [brick2 + bx].len
inc dx
dec [brick2 + bx].loopvar
cmp [brick2 + bx].loopvar, 0
jne re4

call printtop
pop ax
pop bx
pop cx
pop dx

ret
rebrick2 endp


;============================================================Start of Destroy Brick Function 3====================================================

destroybrick3 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
add scorecount,5

mov [brick3 + bx].color, 0
mov cx, [brick3 + bx].xcoord
add cx, [brick3 + bx].len
mov [brick3 + bx].diff1, cx
sub cx, [brick3 + bx].len
sub cx, [brick3 + bx].len
mov dx, [brick3 + bx].ycoord
add dx, [brick3 + bx].breadth
mov [brick3 + bx].diff2, dx
sub dx, [brick3 + bx].breadth
sub dx, [brick3 + bx].breadth
mov ax, [brick3 + bx].breadth
add ax, [brick3 + bx].breadth
mov [brick3 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick3 + bx].color
destroy6:
destroy5:
int 10h
inc cx
cmp cx, [brick3 + bx].diff1
jbe destroy5
mov cx, [brick3 + bx].xcoord
sub cx, [brick3 + bx].len
inc dx
dec [brick3 + bx].loopvar
cmp [brick3 + bx].loopvar, 0
jne destroy6

call printtop
pop ax
pop bx
pop cx
pop dx

ret
destroybrick3 endp

rebrick3 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
;add scorecount,5
dec [brick3 + bx].color

mov cx, [brick3 + bx].xcoord
add cx, [brick3 + bx].len
mov [brick3 + bx].diff1, cx
sub cx, [brick3 + bx].len
sub cx, [brick3 + bx].len
mov dx, [brick3 + bx].ycoord
add dx, [brick3 + bx].breadth
mov [brick3 + bx].diff2, dx
sub dx, [brick3 + bx].breadth
sub dx, [brick3 + bx].breadth
mov ax, [brick3 + bx].breadth
add ax, [brick3 + bx].breadth
mov [brick3 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick3 + bx].color
re6:
re5:
int 10h
inc cx
cmp cx, [brick3 + bx].diff1
jbe re5
mov cx, [brick3 + bx].xcoord
sub cx, [brick3 + bx].len
inc dx
dec [brick3 + bx].loopvar
cmp [brick3 + bx].loopvar, 0
jne re6

call printtop
pop ax
pop bx
pop cx
pop dx

ret
rebrick3 endp


;============================================================Start of Destroy Brick 4=========================================================

destroybrick4 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
add scorecount,5

mov [brick4 + bx].color, 0
mov cx, [brick4 + bx].xcoord
add cx, [brick4 + bx].len
mov [brick4 + bx].diff1, cx
sub cx, [brick4 + bx].len
sub cx, [brick4 + bx].len
mov dx, [brick4 + bx].ycoord
add dx, [brick4 + bx].breadth
mov [brick4 + bx].diff2, dx
sub dx, [brick4 + bx].breadth
sub dx, [brick4 + bx].breadth
mov ax, [brick4 + bx].breadth
add ax, [brick4 + bx].breadth
mov [brick4 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick4 + bx].color
destroy8:
destroy7:
int 10h
inc cx
cmp cx, [brick4 + bx].diff1
jbe destroy7
mov cx, [brick4 + bx].xcoord
sub cx, [brick4 + bx].len
inc dx
dec [brick4 + bx].loopvar
cmp [brick4 + bx].loopvar, 0
jne destroy8

call printtop
pop ax
pop bx
pop cx
pop dx

ret
destroybrick4 endp

rebrick4 proc	;turns brick black when hit counter turns 0

push ax
push bx
push cx
push dx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, di
;add scorecount,5
dec [brick4 + bx].color

mov cx, [brick4 + bx].xcoord
add cx, [brick4 + bx].len
mov [brick4 + bx].diff1, cx
sub cx, [brick4 + bx].len
sub cx, [brick4 + bx].len
mov dx, [brick4 + bx].ycoord
add dx, [brick4 + bx].breadth
mov [brick4 + bx].diff2, dx
sub dx, [brick4 + bx].breadth
sub dx, [brick4 + bx].breadth
mov ax, [brick4 + bx].breadth
add ax, [brick4 + bx].breadth
mov [brick4 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick4 + bx].color
re8:
re7:
int 10h
inc cx
cmp cx, [brick4 + bx].diff1
jbe re7
mov cx, [brick4 + bx].xcoord
sub cx, [brick4 + bx].len
inc dx
dec [brick4 + bx].loopvar
cmp [brick4 + bx].loopvar, 0
jne re8

call printtop
pop ax
pop bx
pop cx
pop dx

ret
rebrick4 endp



;============================================================Structure Creation============================================================

clear proc

Comment!
mov ah, 6
mov al, 0
mov bh, 0     ;color
mov ch, 0     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 24     ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h
!

Comment!
mov ah,10h
int 10h
!
mov ah, 0
mov al, 10h
int 10h

mov ax,0
mov bx,0
mov cx,0
mov dx,0

ret
clear endp


;============================================================Start of Music Function============================================================

Music proc
push ax

mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        mov     ax, 4560        ; Frequency number (in decimal)
                                 ;for middle C.
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al
        in      al, 61h         ; Turn on note (get value from
                                 ;port 61h).
        or      al, 00000011b   ; Set bits 1 and 0.
        out     61h, al         ; Send new value.
        mov     bx, 2          ; Pause for duration of note.
    pauseLabel1:
        mov     cx, 65535
    pauseLabel2:
        dec     cx
        jne     pauseLabel2
        dec     bx
        jne     pauseLabel1
        in      al, 61h         ; Turn off note (get value from
                                ;port 61h).
        and     al, 11111100b   ; Reset bits 1 and 0.
        out     61h, al         ; Send new value.
	

	pop ax
    ret
    Music endp


;============================================================Start of FileCreate Function===========================================================

filecreate proc	;creates the leaderboard file

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

mov ah, 3ch
mov cl, 0
mov dx, offset filename
int 21h

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

ret
filecreate endp


;============================================================Start of Filewrite Function============================================================

filewrite proc	;writes into the leader board file

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

;copying necessary data to buffer
mov ax, 0
mov ax, scorecount
mov bl, divisor
div bl
mov di, 2
add ah, '0'
mov [buffer + di], ah
mov ah, 0
div bl
dec di
add ah, '0'
mov [buffer + di], ah
mov ah, 0
div bl
dec di
add ah, '0'
mov [buffer + di], ah

mov di, 0
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

;opening an existing file
mov ah, 3dh
mov al, 2
mov dx, offset filename
int 21h
mov filehandler, ax

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
;move pointer to end of file
mov ah, 42h
mov al, 2
mov bx, filehandler
int 21h

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

;writing into a file
mov ah, 40h
mov bx, filehandler
mov cx, 30	;size of name string is 30
mov dx, offset namestr
int 21h

mov ah, 40h
mov bx, filehandler
mov cx, 4	;size of score is max 3 digits and then 1 digit for '$'
mov dx, offset buffer
int 21h

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

;closing a file
mov ah, 3eh
mov bx, filehandler
int 21h

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
emptybuff	;emptying the buffer
inc fileinput

ret
filewrite endp


;============================================================Start of FileRead Function============================================================


fileread proc	;used to read file

emptybuff
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
;---------------------------------------------------------------------------new
mov al, fileinput
mov bx, 34
mul bl
mov fileoutput, ax
mov ax, 0
mov bx, 0
;------------------------------------------------------------------------------
;opening an existing file
mov ah, 3dh
mov al, 2
mov dx, offset filename
int 21h
mov filehandler, ax

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

;reading from file
mov ah, 3Fh
mov cx, fileoutput
mov dx, offset buffer
mov bx, filehandler
int 21h

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

;closing a file
mov ah, 3eh
mov bx, filehandler
int 21h

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0


ret
fileread endp


;============================================================Staer of Print Pattern============================================================

printpattern proc

Pattern:

mov cx,s1
mov dx,s4
mov al,1111b
mov ah,0ch
int 10h

mov cx,s2
mov dx,s5
mov al,1111b
mov ah,0ch
int 10h

mov cx,s3
mov dx,s5
mov al,1111b
mov ah,0ch
int 10h

mov cx,s1
mov dx,s6
mov al,1111b
mov ah,0ch
int 10h

inc tempcount
add s1,60
add s2,60
add s3,60
cmp tempcount,11
jne Pattern

sub s1,660
sub s2,660
sub s3,660
mov tempcount,0
ret
printpattern endp

;============================================================Start of Brick Make============================================================

brickmake proc
mov bx, 0
mov ax, type brick1
mov bsize, ax
mov bx, 5	;number of bricks in a row - 1
mul bl
mov brow, ax
mov ax, 0
mov bx, 0

;for row 1
mov bx, brow
printrow:
mov ax, 0
cmp [brick1.hits + bx], 0
je hitif
mov cx, [brick1 + bx].xcoord
add cx, [brick1 + bx].len
mov [brick1 + bx].diff1, cx
sub cx, [brick1 + bx].len
sub cx, [brick1 + bx].len
mov dx, [brick1 + bx].ycoord
add dx, [brick1 + bx].breadth
mov [brick1 + bx].diff2, dx
sub dx, [brick1 + bx].breadth
sub dx, [brick1 + bx].breadth
mov ax, [brick1 + bx].breadth
add ax, [brick1 + bx].breadth
mov [brick1 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick1 + bx].color
brickloop2:
brickloop:
int 10h
inc cx
cmp cx, [brick1 + bx].diff1
jbe brickloop
mov cx, [brick1 + bx].xcoord
sub cx, [brick1 + bx].len
inc dx
dec [brick1 + bx].loopvar
cmp [brick1 + bx].loopvar, 0
jne brickloop2
hitif:
sub bx, bsize
cmp bx, 0
jge printrow

;for row 2
mov bx, brow
printrow2:
mov ax, 0
cmp [brick2.hits + bx], 0
je hitif2
mov cx, [brick2 + bx].xcoord
add cx, [brick2 + bx].len
mov [brick2 + bx].diff1, cx
sub cx, [brick2 + bx].len
sub cx, [brick2 + bx].len
mov dx, [brick2 + bx].ycoord
add dx, [brick2 + bx].breadth
mov [brick2 + bx].diff2, dx
sub dx, [brick2 + bx].breadth
sub dx, [brick2 + bx].breadth
mov ax, [brick2 + bx].breadth
add ax, [brick2 + bx].breadth
mov [brick2 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick2 + bx].color
brickloop4:
brickloop3:
int 10h
inc cx
cmp cx, [brick2 + bx].diff1
jbe brickloop3
mov cx, [brick2 + bx].xcoord
sub cx, [brick2 + bx].len
inc dx
dec [brick2 + bx].loopvar
cmp [brick2 + bx].loopvar, 0
jne brickloop4
hitif2:
sub bx, bsize
cmp bx, 0
jge printrow2

;for row 3
mov bx, brow
printrow3:
mov ax, 0
cmp [brick3.hits + bx], 0
je hitif3
mov cx, [brick3 + bx].xcoord
add cx, [brick3 + bx].len
mov [brick3 + bx].diff1, cx
sub cx, [brick3 + bx].len
sub cx, [brick3 + bx].len
mov dx, [brick3 + bx].ycoord
add dx, [brick3 + bx].breadth
mov [brick3 + bx].diff2, dx
sub dx, [brick3 + bx].breadth
sub dx, [brick3 + bx].breadth
mov ax, [brick3 + bx].breadth
add ax, [brick3 + bx].breadth
mov [brick3 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick3 + bx].color
brickloop6:
brickloop5:
int 10h
inc cx
cmp cx, [brick3 + bx].diff1
jbe brickloop5
mov cx, [brick3 + bx].xcoord
sub cx, [brick3 + bx].len
inc dx
dec [brick3 + bx].loopvar
cmp [brick3 + bx].loopvar, 0
jne brickloop6
hitif3:
sub bx, bsize
cmp bx, 0
jge printrow3

;for row 4
mov bx, brow
printrow4:
mov ax, 0
cmp [brick4.hits + bx], 0
je hitif4
mov cx, [brick4 + bx].xcoord
add cx, [brick4 + bx].len
mov [brick4 + bx].diff1, cx
sub cx, [brick4 + bx].len
sub cx, [brick4 + bx].len
mov dx, [brick4 + bx].ycoord
add dx, [brick4 + bx].breadth
mov [brick4 + bx].diff2, dx
sub dx, [brick4 + bx].breadth
sub dx, [brick4 + bx].breadth
mov ax, [brick4 + bx].breadth
add ax, [brick4 + bx].breadth
mov [brick4 + bx].loopvar, ax
mov ax, 0
mov ah, 0ch
mov al, [brick4 + bx].color
brickloop8:
brickloop7:
int 10h
inc cx
cmp cx, [brick4 + bx].diff1
jbe brickloop7
mov cx, [brick4 + bx].xcoord
sub cx, [brick4 + bx].len
inc dx
dec [brick4 + bx].loopvar
cmp [brick4 + bx].loopvar, 0
jne brickloop8
hitif4:
sub bx, bsize
cmp bx, 0
jge printrow4

ret
brickmake endp


;============================================================Start of Print Box============================================================

box proc
MOV CX, p1    ;x-cordinate (column)
MOV DX, p3    ;y-cordinate (row)
MOV AL, 1110b  ;yellow color
L1:
MOV AH, 0CH 
INT 10H
inc cx
cmp cx,p2
jne L1


MOV CX, p1    ;x-cordinate (column)
MOV DX, p3    ;y-cordinate (row)
MOV AL, 1110b  ;yellow color
L2:
MOV AH, 0CH 
INT 10H
inc dx
cmp dx,p4
jne L2


MOV CX, p1    ;x-cordinate (column)
MOV DX, p4    ;y-cordinate (row)
MOV AL, 1110b  ;yellow color
inc p2
L3:
MOV AH, 0CH 
INT 10H
inc cx
cmp cx,p2
jne L3

dec p2
MOV CX, p2    ;x-cordinate (column)
MOV DX, p3    ;y-cordinate (row)
MOV AL, 1110b  ;yellow color
L4:
MOV AH, 0CH 
INT 10H
inc dx
cmp dx,p4
jne L4

ret
box endp


;============================================================Start of Print Character============================================================

printchar proc

PrintLogo:

mov ah, 2
mov dh, idx     ;row
mov dl, ite   ;column
int 10h

mov al,[si]    ;ASCII code of Character 
mov bx,0
mov bl,colorvar   ;White color
mov cx,1       ;repetition count
mov ah,09h
int 10h
inc ite
inc si

mov bx,0
mov bl,limit
cmp ite,bl
jne PrintLogo


mov ax,0
mov bx,0
mov cx,0
mov dx,0

ret
printchar endp


;============================================================Start of Print Pattern============================================================

printpat proc
Patout:

Patin:
mov ah, 2
mov dh, idx     ;row
mov dl, ite   ;column
int 10h
mov al,'D'    ;ASCII code of Character 
sub al,63
mov bx,0
mov bl,1111b   ;White color
mov cx,1       ;repetition count
mov ah,09h
int 10h

add ite,8
inc resetvar

cmp resetvar,10
jne Patin

mov ite,0
mov resetvar,0
add tempcount,4
mov al,tempcount
add ite,al
add idx,2
cmp idx,26
jne Patout

ret
printpat endp


;============================================================Start of Take Input Function============================================================

TakeInput proc


mov si,offset Namestr
Input:

mov dl,0
mov ah,1
int 21h

cmp al,13
je InputEnd
mov [si],al
inc si

jmp Input


InputEnd:
ret
TakeInput endp


;============================================================First Screen Function============================================================

FirstScreen proc

mov ah, 6
mov al, 0
mov bh, 9     ;color
mov ch, 6     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 10    ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h

mov bx,0
mov si,offset Welcome
mov idx,8
mov limit,53
mov ite,24
call printchar


mov si,offset KeyCont
mov idx,14
mov limit,58
mov ite,16
mov colorvar,1110b
call printchar
mov colorvar,1111b

mov ah,0
int 16h
call Music
call clear


;call printpat



mov s1,20
mov s2,12
mov s3,28
mov s4,10
mov s5,18
mov s6,26
mov resetvar,0
mov tempcount,0

PatLoop:
call printpattern
add s1,26
add s2,26
add s3,26
add s4,28
add s5,28
add s6,28
inc resetvar
cmp resetvar,12

jne PatLoop


mov ax,0
mov bx,0
mov cx,0
mov dx,0

mov p1,200
mov p2,400
mov p3,64
mov p4,88
call box

mov si,offset Logo
mov idx,5
mov limit,47
mov ite,27
call printchar


mov si,offset LeaderBoard_Output
mov idx,13
mov limit,20
mov ite,8
call printchar


mov ah, 02h
mov dh, 15     ;row
mov dl, 8     ;column
int 10h

call fileread


mov cl,fileinput
mov dx,offset buffer
mov bx,0
mov bl,0

Lloop:

add bl,2
mov ah,9
int 21h
add dx,30

push dx
mov dx,offset spaces
mov ah,9
int 21h
pop dx

mov ah,9
int 21h
add dx,4
push dx

mov ah, 02h
mov dh, 15     ;row
add dh,bl
mov dl, 8     ;column
int 10h

pop dx

Loop Lloop

mov p1,380
mov p2,639
mov p3,216
mov p4,290
call box



mov si,offset Umair
mov idx,18
mov limit,78
mov ite,55
call printchar

mov si,offset Abtaal
mov idx,19
mov limit,78
mov ite,55
call printchar

mov si,offset Project
mov idx,16
mov limit,63
mov ite,50
call printchar


mov si,offset NameOutput
mov idx,10
mov limit,36
mov ite,18
call printchar


mov temp1,0
mov ah,2
mov dh,10     ;row
mov dl,35   ;column
int 10h

call TakeInput

ret
FirstScreen endp


;============================================================Start of Instruction Page============================================================

InstructionPage proc

jmp StartInsPage

printpara proc

para:

mov ah, 2
mov dh, idx     ;row
mov dl, ite   ;column
int 10h

mov al,[si]    ;ASCII code of Character 
mov bx,0
mov bl,1111b   ;White color
mov cx,1       ;repetition count
mov ah,09h
int 10h
inc ite
inc si

mov bx,0
mov bl,limit
cmp ite,bl
je nextline

backpara::

mov cx,0
mov cl,rownum
cmp tempcount,cl
jne para


mov ax,0
mov bx,0
mov cx,0
mov dx,0

ret
printpara endp


nextline::
inc tempcount
inc idx

mov bx,0
mov bl,resetvar
mov ite,bl
jmp backpara


;============================================================Start of Print Line Function============================================================

printline proc

MOV CX, 0    ;x-cordinate (column)
MOV DX, 0    ;y-cordinate (row)
MOV AL, 1111b  ;yellow color

Outline:

mov cx,0
mov cl,resetvar

Line:
MOV AH, 0CH 
INT 10H
add cx,50

cmp cx,800
jl Line

add resetvar,10
add dx,20
inc tempcount

cmp tempcount,40
jne Outline

mov ax,0
mov bx,0
mov cx,0
mov dx,0

ret
printline endp



StartInsPage:

mov ah, 6
mov al, 0
mov bh, 0     ;color
mov ch, 0     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 24     ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h


mov resetvar,0
mov tempcount,0
call printline


mov ax,0
mov bx,0
mov cx,0
mov dx,0


mov p1,20
mov p2,160
mov p3,36
mov p4,60
call box

mov si,offset ins_title
mov idx,3
mov limit,16
mov ite,4
call printchar


mov p1,400
mov p2,620
mov p3,30
mov p4,190
call box

mov si,offset Para1
mov idx,3
mov limit,156
mov ite,131
mov tempcount,0
mov resetvar,131
mov rownum,9
call printpara


mov p1,208
mov p2,386
mov p3,150
mov p4,340
call box


mov si,offset Para2
mov idx,12
mov limit,48
mov ite,27
mov tempcount,0
mov resetvar,27
mov rownum,11
call printpara


mov p1,20
mov p2,196
mov p3,80
mov p4,280
call box

mov si,offset Para3
mov idx,7
mov limit,24
mov ite,3
mov tempcount,0
mov resetvar,3
mov rownum,12
call printpara

InsTempLabel:
mov ah,0
int 16h
call Music
cmp al,8
jne InsTempLabel

;call BoxSelection

ret
InstructionPage endp


;============================================================Start of HighScore Function============================================================

HighScorePage proc

call clear

mov s1,20
mov s2,12
mov s3,28
mov s4,10
mov s5,18
mov s6,26
mov resetvar,0
mov tempcount,0

PatLoop:
call printpattern
add s1,26
add s2,26
add s3,26
add s4,28
add s5,28
add s6,28
inc resetvar
cmp resetvar,12

jne PatLoop

mov ah, 6
mov al, 0
mov bh, 9     ;color
mov ch, 4     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 8    ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h


mov bx,0
mov si,offset HighPrint
mov idx,6
mov limit,59
mov ite,20
call printchar

mov p1,140
mov p2,490
mov p3,78
mov p4,102
call box


mov p1,200
mov p2,460
mov p3,140
mov p4,320
call box


mov ah, 02h
mov dh, 11     ;row
mov dl, 28     ;column
int 10h

call fileread


mov cl,fileinput
mov dx,offset buffer
mov bx,0
mov bl,0

Ploop:

add bl,2
mov ah,9
int 21h
add dx,30

push dx
mov dx,offset spaces
mov ah,9
int 21h
pop dx

mov ah,9
int 21h
add dx,4
push dx

mov ah, 02h
mov dh, 11     ;row
add dh,bl
mov dl, 28     ;column
int 10h

pop dx

Loop Ploop


HighTempLabel:
mov ah,0
int 16h
call Music
cmp al,8
jne HighTempLabel

;call BoxSelection


ret
HighScorePage endp


;============================================================Start of Print Top Function============================================================

PrintTop proc


mov ah, 6
mov al, 0
mov bh, 0     ;color
mov ch, 0     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 2     ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h

MOV CX, 0    ;x-cordinate (column)
MOV DX, 46    ;y-cordinate (row)
MOV AL, 1110b  ;yellow color
LineLabel:
MOV AH, 0CH 
INT 10H
inc cx
cmp cx,640
jne LineLabel


mov ah, 2
mov dh, 1
mov dl, 1
mov bx, 0
int 10h

mov dx, offset LivesStr
mov ah, 9
int 21h
mov dh, 0
mov dl, 10
mov ah, 2
int 21h
mov dl, 13
int 21h


mov ah, 2
mov dh, 2
mov dl, 1
mov bx, 0
int 10h

mov ah, 9
mov al, 3
mov bh, 0
mov cx, livecount
mov bl, 12
int 10h

mov ah, 2
mov dh, 2
mov dl, 14
mov bx, 0
int 10h
mov dx, offset LevelStr
mov ah, 9
int 21h
mov dl, LevelCount
add dl,48
mov ah, 2
int 21h

mov ah, 2
mov dh, 2
mov dl, 34
mov bx, 0
int 10h
mov dx, offset ScoreStr
mov ah, 9
int 21h


 mov dx, 0
	MOV AX, ScoreCount
	MOV Bx, 10
	L1:
          mov dx, 0
		CMP Ax, 0
		JE DISP
		DIV Bx
		MOV cx, dx
		PUSH CX
		inc counte
		MOV AH, 0
		JMP L1

		DISP:
	CMP counte, 0
	JE EXIT
	POP DX
	ADD DX, 48
	MOV AH, 02H
	INT 21H
	dec counte
	JMP DISP
EXIT:

Comment!
mov dl, ScoreCount
add dl,48
mov ah, 2
int 21h
!


mov counter,0

mov ah, 2
mov dh, 2
mov dl, 60
mov bx, 0
int 10h
mov dx, offset NameStr
mov ah, 9
int 21h 

ret
PrintTop endp

;============================================================Start of DrawBall Function============================================================

drawBall proc 
	
	mov cx, centerx	
	mov dx, centery
	mov al, ballcolor 

	mov b_limit1, 8
	mov b_limit2, 0
	add cx, 2

	Ball1:
	Ball2:
	mov ah, 0Ch  
	int 10h
	inc dx
	mov ah, 0Ch  
	int 10h
	dec dx
	inc cx
	dec b_limit1
	cmp b_limit1, 0
	jne Ball2

	mov b_limit1,12
	sub cx, 10
	inc dx
	inc dx
	inc b_limit2
	cmp b_limit2, 2
	jne Ball1



	mov b_limit2, 0
	add cx,12
	Ball3:
	sub cx, 16
	mov b_limit1, 16

	Ball4:
	mov ah, 0Ch
	int 10h
	inc cx
	dec b_limit1
	cmp b_limit1, 0
	jne Ball4

	inc dx
	inc b_limit2
	cmp b_limit2, 6
	jne Ball3



	
	mov b_limit1, 12
	mov b_limit2, 0
	sub cx, 14

	Ball5:
	Ball6:
	mov ah, 0Ch  
	int 10h
	inc dx
	mov ah, 0Ch  
	int 10h
	dec dx
	inc cx
	dec b_limit1
	cmp b_limit1, 0
	jne Ball6

	mov b_limit1, 8
	sub cx, 10
	inc dx
	inc dx
	inc b_limit2
	cmp b_limit2, 2
	jne Ball5



	ret
drawBall endp


;============================================================Start of PausePage Function============================================================

Pausepage proc

call clear


mov ah, 6
mov al, 0
mov bh, 9     ;color
mov ch, 6     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 10    ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h


mov ah, 2
mov dh, 8
mov dl, 20
mov bx, 0
int 10h
mov dx, offset PauseStr
mov ah, 9
int 21h 


mov ah, 2
mov dh, 12
mov dl, 20
mov bx, 0
int 10h
mov dx, offset PauseStr2
mov ah, 9
int 21h 


mov p1,300
mov p2,620
mov p3,240
mov p4,270
call box
mov ah, 2
mov dh, 18
mov dl, 38
mov bx, 0
int 10h
mov dx, offset PauseStr1
mov ah, 9
int 21h 

pauseLabel:

mov ah,0
int 16h
call Music
cmp al,27
jne pauseLabel

call clear
call brickmake
ret 
Pausepage endp



;============================================================Initializer Function============================================================

initialiser proc

inc levelcount
cmp levelcount,4
je l4end

;inc ballcx
;inc ballcy
mov centerx,280
mov centery,230
sub setpaddle,10
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
mov livecount, 4
mov al, levelcount
add livecount, ax
mov ax, 0
mov cl, levelcount
mov bx, bsize
;row1
mov [brick1].hits, cl
mov [brick1].color, 13
mov [brick1 + bx].hits, cl
mov [brick1 + bx].color, 11
add bx, bsize
mov [brick1 + bx].hits, cl
mov [brick1 + bx].color, 13
add bx, bsize
mov [brick1 + bx].hits, cl
mov [brick1 + bx].color, 11
add bx, bsize
mov [brick1 + bx].hits, cl
mov [brick1 + bx].color, 13
add bx, bsize
mov [brick1 + bx].hits, cl
mov [brick1 + bx].color, 11
mov bx, 0
;row2
mov bx, bsize
mov [brick2].hits, cl
mov [brick2].color, 14
mov [brick2 + bx].hits, cl
mov [brick2 + bx].color, 12
add bx, bsize
mov [brick2 + bx].hits, cl
mov [brick2 + bx].color, 14
add bx, bsize
mov [brick2 + bx].hits, cl
mov [brick2 + bx].color, 12
add bx, bsize
mov [brick2 + bx].hits, cl
mov [brick2 + bx].color, 14
add bx, bsize
mov [brick2 + bx].hits, cl
mov [brick2 + bx].color, 12
mov bx, 0
mov bx, bsize
;row3
mov [brick3].hits, cl
mov [brick3].color, 13
mov [brick3 + bx].hits, cl
mov [brick3 + bx].color, 11
add bx, bsize
mov [brick3 + bx].hits, cl
mov [brick3 + bx].color, 13
add bx, bsize
mov [brick3 + bx].hits, cl
mov [brick3 + bx].color, 11
add bx, bsize
mov [brick3 + bx].hits, cl
mov [brick3 + bx].color, 13
add bx, bsize
mov [brick3 + bx].hits, cl
mov [brick3 + bx].color, 11
mov bx, 0
;row4
mov bx, bsize
mov [brick4].hits, cl
mov [brick4].color, 14
mov [brick4 + bx].hits, cl
mov [brick4 + bx].color, 12
add bx, bsize
mov [brick4 + bx].hits, cl
mov [brick4 + bx].color, 14
add bx, bsize
mov [brick4 + bx].hits, cl
mov [brick4 + bx].color, 12
add bx, bsize
mov [brick4 + bx].hits, cl
mov [brick4 + bx].color, 14
add bx, bsize
mov [brick4 + bx].hits, cl
mov [brick4 + bx].color, 12
mov bx, 0

jmp initend

l4end:
call Winpage
pop cx
jmp Endlevel


initend:

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
ret
initialiser endp

;============================================================Main Generic Level Function============================================================

Level Proc

Lstart:

call initialiser
call clear


mov pdidx1,90
mov ax,setpaddle
mov pdidx2,ax
mov pdidx3,330
mov pdidx4,334
call brickmake						;only once
call PrintTop
jmp LevelLabel


Paddle proc

PaddleOuter:

MOV CX, pdidx1    ;x-cordinate (column)
MOV DX, pdidx3    ;y-cordinate (row)
MOV AL, paddlecolor  ;yellow color
PaddleInner:
MOV AH, 0CH 
INT 10H
inc cx
cmp cx,pdidx2
jne PaddleInner


inc pdidx3
mov ax,pdidx4
cmp pdidx3,ax
jne PaddleOuter

ret
Paddle endp

LevelLabel:

Comment!
MOV     CX, 01H
MOV     DX, 10H
MOV     AH, 86H
INT     15H
!

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
;call Music
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
;call clear
;call PrintTop						;only call when top changed

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0


mov pdidx3,330
mov pdidx4,334
mov paddlecolor,7
call Paddle

mov ballcolor,0
call drawBall
mov cx, ballcx
add centerx,cx
mov cx, ballcy
add centery,cx
mov cx, 0

.if (centerx < 20)
neg ballcx
.elseif (centerx > 610)
neg ballcx
.elseif (centery > 330)
neg ballcy
cmp livecount, 0
je nolife
sub livecount, 1
cmp livecount, 0
jne nolife2

jmp EndLevel

nolife2:
call PrintTop
nolife:
.elseif (centery < 60)
neg ballcy
.else
mov cx, pdidx3
sub cx, 22
mov ax, pdidx1
mov dx, pdidx2
.if ((centery >= cx) && (centerx >= ax) && (centerx <= dx))
neg ballcy
.endif
.endif
mov ax, type brick
mov bsize, ax
mov bx, 5	;number of bricks in a row - 1
mul bl
mov brow, ax
mov ax, 0
mov cx, 0
mov bx, 0
mov dx, 0

mov si, 7
mov bx, brow
colish1:
mov ax, [brick1 + bx].xcoord
sub ax, [brick1 + bx].len
mov sidex1, ax
mov ax, [brick1 + bx].xcoord
add ax, [brick1 + bx].len
mov sidex2, ax
mov ax, 0
mov cx, [brick1 + bx].ycoord
mov dx, cx
sub cx, [brick1 + bx].breadth
sub cx, 18
add dx, [brick1 + bx].breadth
add dx, 18
mov sidey1, cx
mov sidey2, dx
mov cx, 0
mov dx, 0
;sidex1 for left side of block
;sidex2 for right side of block
;sidey1 for top of block
;sidey2 for bottom of block
mov di, bx
mov cx, sidex1
mov dx, sidex2
mov ax, sidey1
mov bx, [brick1 + di].ycoord
.if ((centerx > cx) && (centerx < dx) && (centery > ax) && (centery < bx) && ([brick1 + di].hits > 0))	;top
neg ballcy
.if ([brick1 + di].color == 12)
add scorecount, 10
.endif
dec [brick1 + di].color
dec [brick1 + di].hits
call Music
.if ((levelcount > 1) && ([brick1 + di].hits > 0))
call rebrick1
.endif
.if ([brick1 + di].hits == 0)
call destroybrick1
.endif
.endif
mov ax, sidey2
.if ((centerx > cx) && (centerx < dx) && (centery < ax) && (centery > bx) && ([brick1 + di].hits > 0))	;bottom
neg ballcy
.if ([brick1 + di].color == 12)
add scorecount, 10
.endif
dec [brick1 + di].color
dec [brick1 + di].hits
call Music
.if ((levelcount > 1) && ([brick1 + di].hits > 0))
call rebrick1
.endif
.if ([brick1 + di].hits == 0)
call destroybrick1
.endif
.endif
add sidey1, 18
sub sidey2, 18
add sidex2, 6
sub sidex1, 6
mov ax, sidey1
mov bx, sidey2
mov cx, sidex1
mov dx, [brick1 + di].xcoord
.if ((centery > ax) && (centery < bx) && (centerx > cx) && (centerx < dx) && ([brick1 + di].hits > 0))
neg ballcx
.if ([brick1 + di].color == 12)
add scorecount, 10
.endif
dec [brick1 + di].color
dec [brick1 + di].hits
call Music
.if ((levelcount > 1) && ([brick1 + di].hits > 0))
call rebrick1
.endif
.if ([brick1 + di].hits == 0)
call destroybrick1
.endif
.endif
mov cx, sidex2
.if ((centery > ax) && (centery < bx) && (centerx < cx) && (centerx > dx) && ([brick1 + di].hits > 0))
neg ballcx
.if ([brick1 + di].color == 12)
add scorecount, 10
.endif
dec [brick1 + di].color
dec [brick1 + di].hits
call Music
.if ((levelcount > 1) && ([brick1 + di].hits > 0))
call rebrick1
.endif
.if ([brick1 + di].hits == 0)
call destroybrick1
.endif
.endif
mov bx, di
mov di, 0
mov ax, 0
mov cx, 0
mov dx, 0
sub bx, bsize
dec si
cmp si, 0
ja colish1
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
mov si, 0
mov di, 0
mov sidex1, 0
mov sidex2, 0
mov sidey1, 0
mov sidey2, 0

mov si, 7
mov bx, brow
colish2:
mov ax, [brick2 + bx].xcoord
sub ax, [brick2 + bx].len
mov sidex1, ax
mov ax, [brick2 + bx].xcoord
add ax, [brick2 + bx].len
mov sidex2, ax
mov ax, 0
mov cx, [brick2 + bx].ycoord
mov dx, cx
sub cx, [brick2 + bx].breadth
sub cx, 18
add dx, [brick2 + bx].breadth
add dx, 18
mov sidey1, cx
mov sidey2, dx
mov cx, 0
mov dx, 0
;sidex1 for left side of block
;sidex2 for right side of block
;sidey1 for top of block
;sidey2 for bottom of block
mov di, bx
mov cx, sidex1
mov dx, sidex2
mov ax, sidey1
mov bx, [brick2 + di].ycoord
.if ((centerx > cx) && (centerx < dx) && (centery > ax) && (centery < bx) && ([brick2 + di].hits > 0))	;top
neg ballcy
.if ([brick2 + di].color == 12)
add scorecount, 10
.endif
dec [brick2 + di].color
dec [brick2 + di].hits
call Music
.if ((levelcount > 1) && ([brick2 + di].hits > 0))
call rebrick2
.endif
.if ([brick2 + di].hits == 0)
call destroybrick2
.endif
.endif
mov ax, sidey2
.if ((centerx > cx) && (centerx < dx) && (centery < ax) && (centery > bx) && ([brick2 + di].hits > 0))	;bottom
neg ballcy
.if ([brick2 + di].color == 12)
add scorecount, 10
.endif
dec [brick2 + di].color
dec [brick2 + di].hits
call Music
.if ((levelcount > 1) && ([brick2 + di].hits > 0))
call rebrick2
.endif
.if ([brick2 + di].hits == 0)

call destroybrick2
.endif
.endif
add sidey1, 18
sub sidey2, 18
add sidex2, 6
sub sidex1, 6
mov ax, sidey1
mov bx, sidey2
mov cx, sidex1
mov dx, [brick2 + di].xcoord
.if ((centery > ax) && (centery < bx) && (centerx > cx) && (centerx < dx) && ([brick2 + di].hits > 0))
neg ballcx
.if ([brick2 + di].color == 12)
add scorecount, 10
.endif
dec [brick2 + di].color
dec [brick2 + di].hits
call Music
.if ((levelcount > 1) && ([brick2 + di].hits > 0))
call rebrick2
.endif
.if ([brick2 + di].hits == 0)
call destroybrick2
.endif
.endif
mov cx, sidex2
.if ((centery > ax) && (centery < bx) && (centerx < cx) && (centerx > dx) && ([brick2 + di].hits > 0))
neg ballcx
.if ([brick2 + di].color == 12)
add scorecount, 10
.endif
dec [brick2 + di].color
dec [brick2 + di].hits
call Music
.if ((levelcount > 1) && ([brick2 + di].hits > 0))
call rebrick2
.endif
.if ([brick2 + di].hits == 0)


;update score here

call destroybrick2
.endif
.endif
mov bx, di
mov di, 0
mov ax, 0
mov cx, 0
mov dx, 0
sub bx, bsize
dec si
cmp si, 0
ja colish2
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
mov si, 0
mov di, 0
mov sidex1, 0
mov sidex2, 0
mov sidey1, 0
mov sidey2, 0

mov si, 7
mov bx, brow
colish3:
mov ax, [brick3 + bx].xcoord
sub ax, [brick3 + bx].len
mov sidex1, ax
mov ax, [brick3 + bx].xcoord
add ax, [brick3 + bx].len
mov sidex2, ax
mov ax, 0
mov cx, [brick3 + bx].ycoord
mov dx, cx
sub cx, [brick3 + bx].breadth
sub cx, 18
add dx, [brick3 + bx].breadth
add dx, 18
mov sidey1, cx
mov sidey2, dx
mov cx, 0
mov dx, 0
;sidex1 for left side of block
;sidex2 for right side of block
;sidey1 for top of block
;sidey2 for bottom of block
mov di, bx
mov cx, sidex1
mov dx, sidex2
mov ax, sidey1
mov bx, [brick3 + di].ycoord
.if ((centerx > cx) && (centerx < dx) && (centery > ax) && (centery < bx) && ([brick3 + di].hits > 0))	;top
neg ballcy
.if ([brick3 + di].color == 12)
add scorecount, 10
.endif
dec [brick3 + di].color
dec [brick3 + di].hits
call Music
.if ((levelcount > 1) && ([brick3 + di].hits > 0))
call rebrick3
.endif
.if ([brick3 + di].hits == 0)
call destroybrick3
.endif
.endif
mov ax, sidey2
.if ((centerx > cx) && (centerx < dx) && (centery < ax) && (centery > bx) && ([brick3 + di].hits > 0))	;bottom
neg ballcy
.if ([brick3 + di].color == 12)
add scorecount, 10
.endif
dec [brick3 + di].color
dec [brick3 + di].hits
call Music
.if ((levelcount > 1) && ([brick3 + di].hits > 0))
call rebrick3
.endif
.if ([brick3 + di].hits == 0)
call destroybrick3
.endif
.endif
add sidey1, 18
sub sidey2, 18
add sidex2, 6
sub sidex1, 6
mov ax, sidey1
mov bx, sidey2
mov cx, sidex1
mov dx, [brick3 + di].xcoord
.if ((centery > ax) && (centery < bx) && (centerx > cx) && (centerx < dx) && ([brick3 + di].hits > 0))
neg ballcx
.if ([brick3 + di].color == 12)
add scorecount, 10
.endif
dec [brick3 + di].color
dec [brick3 + di].hits
call Music
.if ((levelcount > 1) && ([brick3 + di].hits > 0))
call rebrick3
.endif
.if ([brick3 + di].hits == 0)
call destroybrick3
.endif
.endif
mov cx, sidex2
.if ((centery > ax) && (centery < bx) && (centerx < cx) && (centerx > dx) && ([brick3 + di].hits > 0))
neg ballcx
.if ([brick3 + di].color == 12)
add scorecount, 10
.endif
dec [brick3 + di].color
dec [brick3 + di].hits
call Music
.if ((levelcount > 1) && ([brick3 + di].hits > 0))
call rebrick3
.endif
.if ([brick3 + di].hits == 0)
call destroybrick3
.endif
.endif
mov bx, di
mov di, 0
mov ax, 0
mov cx, 0
mov dx, 0
sub bx, bsize
dec si
cmp si, 0
ja colish3
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
mov si, 0
mov di, 0
mov sidex1, 0
mov sidex2, 0
mov sidey1, 0
mov sidey2, 0

mov si, 7
mov bx, brow
colish4:
mov ax, [brick4 + bx].xcoord
sub ax, [brick4 + bx].len
mov sidex1, ax
mov ax, [brick4 + bx].xcoord
add ax, [brick4 + bx].len
mov sidex2, ax
mov ax, 0
mov cx, [brick4 + bx].ycoord
mov dx, cx
sub cx, [brick4 + bx].breadth
sub cx, 18
add dx, [brick4 + bx].breadth
add dx, 18
mov sidey1, cx
mov sidey2, dx
mov cx, 0
mov dx, 0
;sidex1 for left side of block
;sidex2 for right side of block
;sidey1 for top of block
;sidey2 for bottom of block
mov di, bx
mov cx, sidex1
mov dx, sidex2
mov ax, sidey1
mov bx, [brick4 + di].ycoord
.if ((centerx > cx) && (centerx < dx) && (centery > ax) && (centery < bx) && ([brick4 + di].hits > 0))	;top
neg ballcy
.if ([brick4 + di].color == 12)
add scorecount, 10
.endif
dec [brick4 + di].color
dec [brick4 + di].hits
call Music
.if ((levelcount > 1) && ([brick4 + di].hits > 0))
call rebrick4
.endif
.if ([brick4 + di].hits == 0)
call destroybrick4
.endif
.endif
mov ax, sidey2
.if ((centerx > cx) && (centerx < dx) && (centery < ax) && (centery > bx) && ([brick4 + di].hits > 0))	;bottom
neg ballcy
.if ([brick4 + di].color == 12)
add scorecount, 10
.endif
dec [brick4 + di].color
dec [brick4 + di].hits
call Music
.if ((levelcount > 1) && ([brick4 + di].hits > 0))
call rebrick4
.endif
.if ([brick4 + di].hits == 0)
call destroybrick4
.endif
.endif
add sidey1, 18
sub sidey2, 18
add sidex2, 6
sub sidex1, 6
mov ax, sidey1
mov bx, sidey2
mov cx, sidex1
mov dx, [brick4 + di].xcoord
.if ((centery > ax) && (centery < bx) && (centerx > cx) && (centerx < dx) && ([brick4 + di].hits > 0))
neg ballcx
.if ([brick4 + di].color == 12)
add scorecount, 10
.endif
dec [brick4 + di].color
dec [brick4 + di].hits
call Music
.if ((levelcount > 1) && ([brick4 + di].hits > 0))
call rebrick4
.endif
.if ([brick4 + di].hits == 0)
call destroybrick4
.endif
.endif
mov cx, sidex2
.if ((centery > ax) && (centery < bx) && (centerx < cx) && (centerx > dx) && ([brick4 + di].hits > 0))
neg ballcx
.if ([brick4 + di].color == 12)
add scorecount, 10
.endif
dec [brick4 + di].color
dec [brick4 + di].hits
call Music
.if ((levelcount > 1) && ([brick4 + di].hits > 0))
call rebrick4
.endif
.if ([brick4 + di].hits == 0)
call destroybrick4
.endif
.endif
mov bx, di
mov di, 0
mov ax, 0
mov cx, 0
mov dx, 0
sub bx, bsize
dec si
cmp si, 0
ja colish4
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
mov si, 0
mov di, 0

mov ballcolor,12
call drawBall

cmp scorecount,120
je Lstart

cmp scorecount,240
je Lstart

mov pdidx3,330
mov pdidx4,334
mov paddlecolor,0
call Paddle

mov ah,1
int 16h

jz PaddleReturn

mov ah,0
int 16h
cmp ah,4bh
je PaddleRight

cmp ah,4dh
je PaddleLeft

cmp al,112
je callpause

cmp al,102
je Lstart

PaddleReturn:

cmp al,08
jne LevelLabel


jmp cwin

PaddleRight:

cmp pdidx1,6
jle PaddleRightEnd

;mov cx,pdiff
sub pdidx1,8
sub pdidx2,8

PaddleRightEnd:

jmp PaddleReturn

PaddleLeft:

cmp pdidx2,636
jge PaddleLeftEnd

;mov cx,pdiff
add pdidx1,8
add pdidx2,8

PaddleLeftEnd:

jmp PaddleReturn

callpause:

call Pausepage

jmp PaddleReturn


cwin:
call Winpage

EndLevel::

ret
Level endp



;============================================================Main Box Selection Function============================================================

BoxSelection proc

Recur:
call clear

call MainScreen


mov p1,200
mov p2,400
mov ax,tempidx1
mov p3,ax
mov ax,tempidx2
mov p4,ax
call box


mov ax,0

mov ah,0 
int 16h
call Music

cmp ah,28
je RecurEnd


cmp ah,48h
je BoxUp

cmp ah,50h
je BoxDown

RecurBack:

;call clear
mov ax,0
cmp ax,2
jne Recur


jmp RecurEnd


BoxUp:
cmp tempidx1,148
je BoxUpEnd

sub tempidx1,42
sub tempidx2,42
BoxUpEnd:
jmp RecurBack


BoxDown:
cmp tempidx1,274
je BoxDownEnd


add tempidx1,42
add tempidx2,42
BoxDownEnd:
jmp RecurBack


RecurEnd:


call clear
mov livecount,4
mov scorecount,0
mov levelcount,0
mov setpaddle,176
call MakeDecision


ret
BoxSelection endp


;============================================================Make Decission Function============================================================

MakeDecision proc

cmp tempidx1,148
je lvlcall

cmp tempidx1,190
je inscall

cmp tempidx1,232
je highcall

cmp tempidx1,274
je EndGame

jmp MakeDecisionEnd


inscall:
call InstructionPage
jmp MakeDecisionEnd

highcall:
call HighScorePage
jmp MakeDecisionEnd

lvlcall:
mov centerx,280
mov centery,230
call Level
jmp MakeDecisionEnd

MakeDecisionEnd:
call BoxSelection

EndGame:

ret
MakeDecision endp


;============================================================Main Screen Function============================================================

MainScreen Proc
comment!
mov ah, 6
mov al, 0
mov bh, 9     ;color
mov ch, 0     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 24     ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h
!


mov s1,0
mov s2,0
mov s3,0
mov s4,30
mov s5,38
mov s6,46
mov resetvar,0
mov tempcount,0

PatLoop:
call printpattern
add s1,26
add s2,26
add s3,26
add s4,28
add s5,28
add s6,28
inc resetvar
cmp resetvar,12

jne PatLoop
mov resetvar,0
mov tempcount,0


mov ax,0
mov bx,0
mov cx,0
mov dx,0


mov p1,200
mov p2,400
mov p3,64
mov p4,88
call box


mov si,offset Logo
mov idx,5
mov limit,47
mov ite,27
call printchar


mov si,offset NewOutput
mov idx,11
mov limit,35
mov ite,27
mov colorvar,3
call printchar
mov colorvar,1111b


mov si,offset InsOutput
mov idx,14
mov limit,38
mov ite,27
mov colorvar,9
call printchar
mov colorvar,1111b


mov si,offset HighOutput
mov idx,17
mov limit,36
mov ite,27
mov colorvar,1110b
call printchar
mov colorvar,1111b


mov si,offset ExitOutput
mov idx,20
mov limit,31
mov ite,27
mov colorvar,4
call printchar
mov colorvar,1111b

ret
MainScreen endp


;============================================================Win Page Function============================================================

Winpage proc

call clear
;call filecreate
call filewrite
mov livecount,4
mov scorecount,0
mov levelcount,0
;mov ballcx, 0
;mov ballcy, 0

mov ah, 6
mov al, 0
mov bh, 9     ;color
mov ch, 4     ;top row of window
mov cl, 22     ;left most column of window
mov dh, 22     ;Bottom row of window
mov dl, 50     ;Right most column of window
int 10h


mov bx,0
mov si,offset Congratulations
mov idx,6
mov limit,43
mov ite,28
call printchar


mov si,offset YouWin
mov idx,8
mov limit,41
mov ite,32
call printchar


mov si,offset HighScoreCounted
mov idx,12
mov limit,44
mov ite,26
mov colorvar,4
call printchar
mov colorvar,1111b


mov pdidx1,256
mov pdidx2,320
mov pdidx3,250
mov pdidx4,254
call paddle

mov si,offset Visit
mov idx,21
mov limit,50
mov ite,35
mov colorvar,6
call printchar
mov colorvar,1111b

mov centerx,280
mov centery,230
call drawBall


Comment!
mov iterator,27
mov count, 0
mov ite, 0
mov idx, 0
mov limit, 0
mov tempcount, 0
mov resetvar, 0 
call printpat

mov ah, 6
mov al, 0
mov bh, 9     ;color
mov ch, 6     ;top row of window
mov cl, 0     ;left most column of window
mov dh, 11    ;Bottom row of window
mov dl, 80     ;Right most column of window
int 10h


mov bx,0
mov si,offset Congratulations
mov idx,7
mov limit,59
mov ite,20
call printchar


mov si,offset YouWin
mov idx,10
mov limit,43
mov ite,36
call printchar


mov si,offset HighScoreCounted
mov idx,16
mov limit,53
mov ite,20
mov colorvar,4
call printchar
mov colorvar,1111b


mov si,offset Visit
mov idx,22
mov limit,79
mov ite,45
mov colorvar,6
call printchar
mov colorvar,1111b
!

mov ah,0
int 16h
call Music

ret
Winpage endp


;============================================================Main Procedure Function============================================================

main proc

;call filecreate	;uncomment when making file for the first time, otherwise use old file
mov ah, 0
mov al, 10h
int 10h

call FirstScreen
call clear


mov p1,200
mov p2,400
mov p3,148
mov p4,172
mov tempidx1,148
mov tempidx2,172

mov tempcount,0
call BoxSelection
call clear


;call filecreate
;call filewrite


mov ah, 02h
mov dh, 24     ;row
mov dl, 24     ;column
int 10h


main endp


;===========================================================End of Function============================================================

mov ah,4ch
int 21h

end