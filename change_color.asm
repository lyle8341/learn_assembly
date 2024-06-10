; 编写int 9中断例程改变显示的颜色
; 按下ESC键后改变显示的颜色

assume cs:code
stack segment
          db 128 dup(0)
stack ends
data segment
         dw 0,0    ;存储原来中断向量
data ends
code segment
    start:  
            mov   ax, stack
            mov   ss, ax
            mov   sp, 128                           ;
            mov   ax, data
            mov   ds, ax
    
    ;改中断例程入口地址
            mov   ax, 0
            mov   es,ax
    ;存储原中断例程的IP
            push  es:[9*4]
            pop   ds:[0]
    ;  mov   ds:[0], es:[9*4] 这种写法是错误的（Improper operand type）
    ;存储原中断例程的CS
            push  es:[9*4+2]
            pop   ds:[2]
    ; mov   ds:[2], es:[9*4+2] 这种写法是错误的（Improper operand type）
    ;改中断例程入口地址
            mov   word ptr es:[9*4], offset int9
            mov   es:[9*4+2], cs

    ;显示'a'~'z'
            mov   ax, 0b800h
            mov   es, ax
            mov   ah, 'a'
    s:      mov   es:[160*12+40*2], ah              ;字符字节
            call  delay
            inc   ah
            cmp   ah, 'z'
            jna   s
            mov   ax, 0
            mov   es, ax

    ;恢复原来的中断向量地址
            push  ds:[0]
            pop   es:[9*4]
            push  ds:[2]
            pop   es:[9*4+2]

            mov   ax, 4c00h
            int   21h
          
    ;定义延迟程序
    delay:  
            push  ax
            push  dx
    ;延时逻辑;
    ;100000h次，用两个16位寄存器存放32位的循环次数
            mov   dx, 10h
            mov   ax, 0
    s1:     sub   ax,1
            sbb   dx, 0
            cmp   ax, 0
            jne   s1
            cmp   dx, 0
            jne   s1

            pop   dx
            pop   ax
            ret


    ;定义中断例程
    int9:   
            push  ax
            push  bx
            push  es
            in    al, 60h
            pushf
            pushf
            pop   bx
            and   bh, 11111100b
            push  bx
            popf
            call  dword ptr ds:[0]                  ;原有中断例程逻辑

            cmp   al, 1                             ;ESC扫描码1
            jne   int9ret
    ;改变颜色
            mov   ax, 0b800h
            mov   es, ax
            inc   byte ptr es:[160*12+40*2+1]       ;属性字节

    int9ret:pop   es
            pop   bx
            pop   ax
            iret

code ends
end start