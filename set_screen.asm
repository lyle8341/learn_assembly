;(1) 清屏
;(2) 设置前景色
;(3) 设置背景色
;(4) 向上滚动一行

assume cs:code
code segment
    start:    
              mov  ah, 3                          ; 设置功能号
              mov  al, 2
              call setscreen
              mov  ax, 4c00h
              int  21h
    setscreen:
              jmp  short set
    table     dw   sub1, sub2, sub3, sub4
    set:      
              push bx
              cmp  ah, 3                          ;判断传递的是否大于3；目前只支持3以内功能
              ja   sret
              mov  bl, ah
              mov  bh, 0
              add  bx,bx                          ;根据ah中的功能号计算对应子程序的地址在table表中的偏移
              call word ptr table[bx]             ;调用对应的子程序
    sret:     
              pop  bx
              ret

    ;功能子程序入口参数说明
    ;(1)用ah寄存器传递功能号，0 表示清屏，  1表示设置前景色， 2表示设置背景色， 3表示向上滚动一行
    ;(2)对于2、3号功能，用al传递颜色值

    ;功能子程序1：清屏
    sub1:     
              push bx
              push cx
              push es
              mov  bx, 0b800h
              mov  es, bx
              mov  bx, 0
              mov  cx, 2000
    sub1s:    
              mov  byte ptr es:[bx], ' '
              add  bx, 2
              loop sub1s
              pop  es
              pop  cx
              pop  bx
              ret                                 ; sub1 ends

    ;设置前景色
    sub2:     
              push bx
              push cx
              push es
              mov  bx, 0b800h
              mov  es, bx
              mov  bx, 1
              mov  cx, 2000

    sub2s:    
              and  byte ptr es:[bx], 11111000b
              or   es:[bx], al
              add  bx, 2
              loop sub2s

              pop  es
              pop  cx
              pop  bx
              ret                                 ;sub2 ends

    ;设置背景色
    sub3:     
              push bx
              push cx
              push es
              mov  cl, 4
              shl  al, cl
              mov  bx, 0b800h
              mov  es, bx
              mov  bx, 1
              mov  cx, 2000
    sub3s:    
              and  byte ptr es:[bx], 10001111b
              or   es:[bx], al
              add  bx, 2
              loop sub2s

              pop  es
              pop  cx
              pop  bx
              ret                                 ; sub3 ends

    ;向上滚动一行
    sub4:     
              push cx
              push si
              push di
              push es
              push ds

              mov  si, 0b800h
              mov  es, si
              mov  ds, si
              mov  si, 160                        ;ds:si 指向第n+1行
              mov  di, 0                          ; es:di指向第n行
              cld
              mov  ax, 24                         ;共复制24行

    sub4s:    
              push cx
              mov  cx, 160
              rep  movsb                          ;复制
              pop  cx
              loop sub4s

              mov  cx, 80
              mov  si, 0
    sub4s1:   
              mov  byte ptr es:[160*24+si], ' '
              add  si, 2
              loop sub4s1

              pop  ds
              pop  es
              pop  di
              pop  si
              pop  cx
              ret                                 ; sub4 ends
code ends
end start