; 在屏幕的5行12列显示3个红底高亮闪烁绿色的'a'

assume cs:code
code segment
    ;设置光标位置
         mov ah, 2            ;功能号2:置光标功能
         mov bh, 0            ;第0页
         mov dh, 5            ; 行号
         mov dl, 12           ;列号
         int 10h

         mov ah, 9            ;显示字符功能
         mov al, 'a'          ;字符
         mov bl, 11001010b    ; 颜色属性
         mov bh, 0            ; 第0页
         mov cx, 3            ;字符重复个数
         int 10h

         mov ax, 4c00h
         int 21h
code ends
end