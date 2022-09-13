# afu_interrupt
## 功能说明
通过用户侧中断接口向指定中断接口发送中断。
## 中断接口说明
```Verilog
  output              user_msix_valid,              //拉高触发中断
  input               user_msix_ready,              //当valid和ready均为高电平时表明中断已被处理
  output     [4:0]    user_msix_payload_vec,        //指定中断向量号
  output     [7:0]    user_msix_payload_func        //指定待上送中断设备，填0
```
## 寄存器说明
寄存器 |地址 | 位宽 | 默认值 |属性 | 说明
---------|---------|----------|---------|---------|---------
 DFH | 0 | 64 | 64'h0x1000010000000000|RO|AFU DFH
 UUID |0x8 | 128 | 128'hc6aa954a9b914a37abc11d9f0709dcc4 |RO | AFU UUID,与JSON中的uuid值对应。
 interruptId| 0x30 | 5 | 0|RW |待触发的中断向量号
 interruptTrigger|0x38|1|0|RW|启动指令,host写1触发中断发送，发送完成后逻辑自动清零
 ## 逻辑工程运行方式
 GUI模式运行工程
```shell
faasRtlUtil.sh -f afu_interrupt.json -s afu_interrupt_source.txt -m gui
```
命令行模式运行工程
```shell
faasRtlUtil.sh -f afu_interrupt.json -s afu_interrupt_source.txt -m batch
```