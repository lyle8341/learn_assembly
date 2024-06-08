; 如何得知字符串长度
;用0作为结尾，则不需要知道字符串长度

assume cs:code
data segment
         db 'conversation',0    ;
data ends
code segment
    start:  mov  ax, data
            mov  ds, ax
            mov  si, 0
            call capital
            mov  ax, 4c00h
            int  21h

    capital:mov  cl, [si]
            mov  ch , 0
            jcxz ok                          ;字符串结尾0
            and  byte ptr [si], 11011111b
            inc  si
            jmp  short capital
    ok:     ret
code ends
ends start