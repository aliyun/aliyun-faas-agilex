# hello_world
## 功能说明
该示例硬件逻辑向Host指定定存区域写入"Hello world! From Alibaba".
## 工程目录说明
工程整体目录结构入下所示:
```shell 
sh-4.2$ tree ./
./
├── hw
│   ├── amba_hello_world.json   
│   ├── amba_source.txt
│   ├── avalon_hello_world.json
│   ├── avalon_source.txt
│   └── rtl
│       ├── amba
│       │   └── user_logic.sv
│       └── avalon
│           └── user_logic.sv
├── README.md
└── sw
    ├── hello_world.c
    └── Makefile
```
该example hw目录下包含了AMBA总线实现及Avalon总线实现。
## 寄存器列表
寄存器 |地址 | 位宽 | 默认值 |属性 | 说明
---------|---------|----------|---------|---------|---------
 DFH | 0 | 64 | 64'h0x1000010000000000|RO|AFU DFH
 UUID |0x8 | 128 | 128'hc6aa954a9b914a37abc11d9f0709dcc3 |RO | AFU UUID,与JSON中的uuid值对应。
 targetAddr| 0x18 | 64 | 0|RW |待写入host内存地址，有host进行配置
 start|0x20|1|0|RW|启动指令,host写1启动逻辑数据发送，发送完成后逻辑自动清零
 done|0x28|1|0 |RO| 数据发送完成标志。Host启动数据发送时逻辑自动清零，数据发送完成后逻辑自动置1.

## 逻辑工程创建运行方式
逻辑工程创建需进入hw目录下
### AMBA工程
GUI模式运行工程
```shell
faasRtlUtil.sh -f amba_hello_world.json -s amba_source.txt -m gui
```
命令行模式运行工程
```shell
faasRtlUtil.sh -f amba_hello_world.json -s amba_source.txt -m batch
```
### Avalon工程
GUI模式运行工程
```shell
faasRtlUtil.sh -f avalon_hello_world.json -s avalon_source.txt -m gui
```
命令行模式运行工程
```shell
faasRtlUtil.sh -f avalon_hello_world.json -s avalon_source.txt -m batch
```