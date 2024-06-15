; 接受用户的键盘输入
; 输入“r” 将屏幕上的字符设置为红色
; 输入“g” 将屏幕上的字符设置为绿色
; 输入“b” 将屏幕上的字符设置为蓝色
;7     6     5     4     3     2     1     0
;BL    R     G     B     I     R     G     B
;闪烁  -----背景----     高亮    -----前景----



assume cs:code
code segment
      start:
      ;调用中断，等待输入
            mov  ah, 0
            int  16h
      ;识别按键
            mov  ah, 1                            ;
            cmp  al, 'r'
            je   red
            cmp  al, 'g'
            je   green
            cmp  al, 'b'
            je   blue
            jmp  short sret

      ;设置屏幕颜色
      red:  shl  ah, 1
      green:shl  ah, 1
      blue: mov  bx, 0b800h
            mov  es, bx
            mov  bx, 1
            mov  cx, 2000
      s:    and  byte ptr es:[bx], 11111000b
            or   es:[bx], ah
            add  bx, 2
            loop s

      sret: mov  ax, 4c00h
            int  21h
code ends
end start