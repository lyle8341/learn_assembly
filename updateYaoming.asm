; seg:60 +00    'Yao'       'Yao'
;        +03    '19800912'  '19800912'
;        +0C    15          11
;        +0E    32          13
;        +10    'SHH'       'HOU'

assume ds:data, cs:code
data segment
         dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
         db 'Yao'
         db '19800912'
         db 0 ;
         dw 15
         dw 32
         db 'SHH'
data ends
code segment
    start:mov ax, data
          mov ds, ax
          mov bx, 60h
          mov word ptr [bx+0ch], 11
          mov word ptr [bx+0eh], 13

          mov si, 0
          mov byte ptr [bx+10h+si],'H'
          inc si
          mov byte ptr [bx+10h+si], 'O'
          inc si
          mov byte ptr [bx+10h+si], 'U'

          mov ax, 4c00h
          int 21h
code ends
end start


