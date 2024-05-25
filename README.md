# Learn Assembly Language

## 环境

- VSCodeUserSetup-x64-1.68.1
- win8.1

## 指令和数据

- 指令和数据，都是二进制信息
- 二进制信息 1000100111011000 是数据还是指令
  - 1000100111011000 -> 89D8H(数据)
  - 1000100111011000 -> MOV AX,BX(程序)
- 数据如何表示
  - 1000100111011000**B**（二进制）
  - 89D8**H**（十六进制）

    ```
    四位二进制对应一位十六进制位
    1000-1001-1101-1000
    8----9----D----8
    ```
  - 104730**O**（八进制）
  - 35288**D**（十进制）

## 内存地址空间

- 8086CPU的地址总线宽度为20

+ **堆栈**是向***低端***地址生长的

## 8086CPU架构

![8086 cpu架构](images/architecture_of_8086.jpg)

## 寄存器

8086CPU有14个寄存器

1. 通用寄存器
   1. **AX**(Accumulator Register), and preferred for most operations.
   2. **BX**(Base Register), typically used to hold the address of a procedure or variable.
   3. **CX**(Counter Register), typically used for looping.
   4. **DX**(Data Register), typically used for multiplication and division.
   5. **最大值** FFFFH
2. 变址寄存器
   1. **SI**(Source Index), used for copying strings, segment register varies
   2. **DI**(Destination Index), used for destination for copying strings
3. 指针寄存器
   1. **SP**(Stack Pointer), offset from SS register as to the location of the stack's top
   2. **BP**(Base Pointer), offset from SS register to locate variables on the stack
4. 指令指针寄存器
   1. **IP**(Instruction Pointer), offset from the CS for the next instrunction to excute
5. 段寄存器
   1. **CS**(Code Segment), base location of program code
   2. **SS**(Stack Segment), base location of the stack
   3. **DS**(Data Segment), base location for variables
   4. **ES**(Extra Segment), additional base location for variables in memory
6. 标志寄存器 **PSW**(Program Status Word , also called Flag register)
   1. **Program Status Word** , also called Flag **register**

8086CPU所有寄存器都是***16***位的，可以存放两个***字节***

## 8086内存使用情况

![memory usage](images/memory_usage.png)


## 32位EAX,EBX, ECX, and EDX registers'

> The new registers are prefaced with an “E” to indicate that they are the “Extended” registers.


## 汇编指令

mov ax, 18  	寄存器AX = 18

add ax, 8 	AX = AX + 8

mov ax, bx	AX = BX

add ax, bx	AX = AX + BX
