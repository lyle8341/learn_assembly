;音符和发音频率的对应关系
assume cs:code, ds:data,ss:stack
data segment
    ;新年好
    mus_freq  dw 262,262,262,196
              dw 330,330,330,262
              dw 262,330,392,392
              dw 349,330,294
              dw 294,330,349,349
              dw 330,294,330,262
              dw 262,330,294,196
              dw 247,294,262,-1
    mus_time  dw 3 dup(12,12,25,25),12,12,50
              dw 3 dup(12,12,25,25),12,12,50

    ;九儿
    mus_freq2 dw 440,587,587,523,494,440,392
              dw 440,294
              dw 440,587,587,523,494,392,440,492,440,-1
    mus_time2 dw 25,50,25,25,25,25,25
              dw 50,150
              dw 25,50,25,25,25,12,12,50,175

data ends
stack segment
          db 100h dup(0)
stack ends
code segment
    start:                         ;主程序
             mov  ax, stack
             mov  ss, ax
             mov  sp, 100h
             mov  ax, data
             mov  ds, ax
             lea  si, mus_freq2     ;lea
             lea  di, mus_time2
    play:    
             mov  dx, [si]
             cmp  dx, -1
             je   end_play
             call sound
             add  si, 2
             add  di, 2
             jmp  play
    end_play:
             mov  ax, 4c00h
             int  21h
    ;子程序
    ;入口参数：si-音符的频率的地址
    ;         di-音符的音长的地址
    sound:   
             push ax
             push dx
             push cx
    ;8253芯片（定时/计数器）的设置
             mov  al, 0b6h
             out  43h, al
             mov  dx, 12h
             mov  ax, 34dch
             div  word ptr [si]
             out  42h, al
             mov  al, ah
             out  42h, al
    ;设置8255芯片，控制扬声器的开/关
             in   al, 61h
             mov  ah, al           ;临时保存al的值
             or   al, 3
             out  61h, al
    ;延时一定的时长
             mov  dx, [di]         ;外循环时间
    wait1:   mov  cx, 28000        ;内循环次数
    delay:   
             nop
             loop delay
             dec  dx
             jnz  wait1
    ;恢复扬声器端口原值
             mov  al, ah
             out  61h, al

             pop  cx
             pop  dx
             pop  ax
             ret
code ends
end start