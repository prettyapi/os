#####################################################
.text
.globl _start
.code16                                  #指明生成16位的代码，很关键
_start:
jmp code            
msg:
.string "Hello world!\0"
code:
#######################################################
mov     $0x0000, %ax           #这两行是瞎鼓捣的，因为发现这样可以将BIOS
int       $0x10                      #输出到屏幕上的信息清除掉，并使光标处于屏幕最左上方
#######################################################
mov     $0x03, %ah               # 其实可以肤浅的理解为，将信息输出的位置置于光标处，如果不这样做
int       $0x10                     # 的话，输出的东西会乱跑（其实就是寄存器没初始化啦）
#######################################################
mov     $12, %cx                  #因为我们要输出的信息有12个字符嘛！
#######################################################
mov     $0x0005, %bx            # 设置输出字符的属性，一般设置为0x0007,设置为0x0005表示显示紫色
mov     $msg, %bp                #当然是在设置要输出的信息的地址啦！
mov     $0x1301, %ax            # 这个表示输出，然后移动光标
int      $0x10
#######################################################
.org 0x1fe, 0x90                   #这两行非常关键，因为我们的启动设备第一个扇区的
.word 0xaa55                        #第511和512个字符必须为aa和55，不然系统不认为它是可启动设备
#######################################################
