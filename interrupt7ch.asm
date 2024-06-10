;求一个word型数据的平方
;参数： (ax)=要计算的数据
;返回值：dx， ax中存放结果的高、低16位
;
assume cs:code
code segment
    ;安装程序到指定位置
    start: mov  ax, cs
           mov  ds, ax
           mov  si ,offset sqr
           mov  ax, 0
           mov  es, ax
           mov  di, 200h
           mov  cx, offset sqrend - offset sqr
           cld                                    ;将标志寄存器的DF（Direction Flag）位设置为0
           rep  movsb
        
    ;中断例程入口写到中断向量表表项
           mov  ax, 0
           mov  es, ax
           mov  word ptr es:[7ch*4], 200h
           mov  word ptr es:[7ch*4+2],0

           mov  ax, 4c00h
           int  21h

    sqr:   mul  ax
           iret
    sqrend:nop

code ends
end start