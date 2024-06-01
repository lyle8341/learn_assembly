;将data段中每个单词改为大写字母
;使用 [bx+si]

;！！！！！！！！！！！！！！高危高危高危高危高危高危高危高危
; 一个cx两层循环


assume cs:code, ds:data
data segment
         db 'ibm             '
         db 'dec             '
         db 'dos             '
         db 'vax             '
data ends

code segment
    start:
          mov  ax, data
          mov  ds, ax
          mov  bx,0
          mov  cx, 4
    s0:   mov  si,0
          mov  cx, 3
    s:    mov  al,[bx+si]
          and  al, 11011111b
          mov  [bx+si], al
          inc  si
          loop s
          add  bx, 16
          loop s0

          mov  ax, 4c00h
          int  21h
code ends
end start


