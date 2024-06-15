; 改写中断例程 int9
; 任务：安装一个新的int9中断例程
; 在DOS下，按F1键后改变当前屏幕的显示颜色，其他的键照常处理
; 1)改变屏幕的显示颜色
;    改变从B800开始的4000个字节中的奇地址单元中的内容，当前屏幕的颜色即发生变化


assume cs:code
stack segment
          db 128 dup(0)
stack ends
code segment
    start:  
    ;设置各段地址
            mov   ax, stack
            mov   ss, ax
            mov   sp, 128
            push  cs                                  ;ds与cs相同
            pop   ds
            mov   ax, 0
            mov   es, ax
    ;安装新程序
            mov   si, offset int9
            mov   di, 204h
            mov   cx, offset int9end - offset int9
            cld
            rep   movsb
    ;将原中断地址保存在0:200单元处
            push  es:[9*4]
            pop   es:[200h]
            push  es:[9*4+2]
            pop   es:[202h]
    ;改变后中断的入口地址
            cli                                       ;禁止中断响应（执行下面代码禁止打断）
            mov   word ptr es:[9*4], 204h
            mov   word ptr es:[9*4+2],0
            sti                                       ;恢复中断响应
            mov   ax, 4c00h
            int   21h
    ;定义新中断例程
    int9:   
            push  ax
            push  bx
            push  cx
            push  es

            in    al, 60h                             ;通过60h端口把按键扫描码取到al中

            pushf

    ;调用旧中断例程
            call  dword ptr cs:[200h]                 ;!!!此时(CS)=0

    ;处理F1键
            cmp   al, 3bh
            jne   int9ret

            mov   ax, 0b800h
            mov   es, ax
            mov   bx, 1
            mov   cx, 2000
    s:      inc   byte ptr es:[bx]
            add   bx, 2
            loop  s
    int9ret:pop   es
            pop   cx
            pop   bx
            pop   ax
            iret
    int9end:nop
code ends
end start