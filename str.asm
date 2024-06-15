; 设计一个最基本的字符串输入程序
; 1.再输入的同时需要显示这个字符串
; 2.一般在输入回车符后，字符串输入结束
; 3.能够删除已经输入的字符--用退格键


;程序的处理过程
; (1).调用int16h读取键盘输入
; (2).如果不是字符，
;   ①如果是退格键，从字符栈中弹出一个字符，显示字符栈中的所有字符，继续执行(1)
;   ②如果是Enter键，向字符栈中压入0，返回
; (3).如果是字符键：字符入栈；显示栈中所有字符，继续执行(1)


assume cs:code, ds:data
data segment
         db 32 dup(?)    ;栈空间
data ends
code segment
    start:    
              mov  ax, data
              mov  ds, ax
              mov  si, 0
              mov  dh, 12                         ;对于2号功能表示屏幕上显示的行
              mov  dl, 20                         ;对于2号功能表示屏幕上显示的列
              call getstr

    return:   mov  ax, 4c00h
              int  21h

    getstr:   push ax
    
    ;读取键盘输入
    getstrs:  mov  ah, 0
              int  16h

              cmp  al, 20h                        ;al中是键盘输入的ASCII码
              jb   nochar                         ;小于20h为非字符
    ;字符入栈
              mov  ah, 0
              call charstack

    ;显示栈中的字符
              mov  ah, 2
              call charstack
              jmp  getstrs
    nochar:   
              cmp  ah, 0eh                        ;退格键的扫描码
              je   backspace
              cmp  ah, 1ch                        ;回车键的扫描码
              je   enter
              jmp  getstrs


    ;对退格键、回车键处理

    backspace:
    ;字符出栈
              mov  ah, 1
              call charstack
    ;显示栈中的字符
              mov  ah, 2
              call charstack
              jmp  getstrs
    enter:    
    ;0字符入栈
              mov  al, 0                          ;此处是0字符的ASCII码，屏幕不显示或看不见
              mov  ah, 0
              call charstack
    ;显示栈中的字符
              mov  ah, 2
              call charstack
              pop  ax
              ret                                 ; getstr结束

    charstack:
              jmp  short charstart
    table     dw   charpush, charpop, charshow
    top       dw   0                              ;栈顶
    charstart:
              push bx
              push dx
              push di
              push es
    
    ;实现各功能，功能号：0->入栈 (al)=入栈字符   1->出栈 (al)=返回的字符     2->显示 ds:si 指向字符串的空间
              cmp  ah, 2
              ja   sret
              mov  bl, ah
              mov  bh, 0
              add  bx, bx
              jmp  word ptr table[bx]             ;定位到功能代码地址

    charpush: mov  bx, top
              mov  [si][bx], al
              inc  top
              jmp  sret

    charpop:  cmp  top, 0
              je   sret
              dec  top
              mov  bx, top
              mov  al, [si][bx]
              jmp  sret
    charshow:                                     ;在dh行dl列显示
              mov  bx, 0b800h
              mov  es, bx
              mov  al, 160
              mov  ah, 0
              mul  dh
              mov  di, ax
              add  dl, dl
              mov  dh, 0
              add  di, dx
    
              mov  bx, 0

    charshows:cmp  bx, top                        ;;若为结尾，显示' '，进入结束阶段
              jne  noempty
              mov  byte ptr es:[di], ' '
              jmp  sret

    noempty:  mov  al, [si][bx]
              mov  es:[di], al
              mov  byte ptr es:[di+2], ' '        ;后面一个字符置空
              inc  bx
              add  di, 2
              jmp  charshows

    sret:     pop  es
              pop  di
              pop  dx
              pop  bx
              ret
code ends
end start