;在屏幕的中间，白底蓝字显示 'Welcome to masm!'


assume cs:code, ds:data
data segment
         db 'Welcome to masm!'
data ends
code segment
    start:mov  ax, data
          mov  ds, ax
          mov  ax, 0B800h
          mov  es, ax
          mov  si, 0
          mov  di ,160*12+80-16    ; 一共25行第十三行开始：160*12； +80是屏幕正中间；显示内容是16个字符，左右各8个（16字节）

          mov  cx, 16
    w:    mov  al,[si]             ;低位是需要显示的字符
          mov  es:[di], al
          inc  di
          mov  al, 71H             ;色彩属性
          mov  es:[di], al
          inc  si
          inc  di
          loop w

          mov  ax, 4c00h
          int  21h
code ends
end start