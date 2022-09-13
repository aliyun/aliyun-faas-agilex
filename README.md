# 使用前准备
## FaaS HDK RPM包安装
在创建工程之前，用户需进行FaaS IOFS RPM包安装(RPM包位于该repo/rpm目录下)：
```bash
#进入rpm目录执行如下指令解压出rpm包：
sh-4.2$ sudo cat faas_hdk-1.0.0-0.tar.gz.* | tar -zxv
x faas_hdk-1.0.0-0.x86_64.rpm

#RPM包安装
sh-4.2$ sudo rpm -ivh faas_hdk-1.0.0-0.x86_64.rpm 
Preparing...                          ################################# [100%]
Updating / installing...
   1:faas_hdk-1.0.0-1.el7             ################################# [100%]
```

## EDA工具安装
用户需安装Intel Quartus开发套件，版本为22.1。

## 命令行工具
在安装完FaaS HDK RPM包工具安装后，用户可通过faasRtlUtil.sh进行工程的创建，运行及删除：
```bash
faasRtlUtil.sh [options] 

Example of how to use built-in getopts.
Options are:

-h                          Print help.
--help
-c                          Clean Project
--clean
-f                          Specify the json file
--file
-s                          Specify the source.txt
--source
-m                          Specify the operation mode:GUI|BATCH
```
# 用户接口
## 时钟与复位信号
| Port name                      | Direction | Width   | Description |
| ------------------------------ | --------- | ------- | ----------- |
| afu_pcie_core_clk              | input     |     1   |  PCIe总线时钟(350MHz)           |
| afu_pcie_core_rst              | input     |     1   |  PCIe总线复位信号，高电平复同步复位           |
| afu_sys_100m_clk               | input     |     1   |  管理时钟(100MHz) |
| afu_sys_100m_rst               | input     |     1   |   管理时钟复位信号,高电平复同步复位|
| afu_user_clk                   | input     |     1   |  用户可配置时钟1(时钟可重配置,默认400MHz,配置范围200MHz～400MHz，步进2MHz)           |
| afu_user_rst                   | input     |     1   | 用户可配置时钟1复位信号，高电平复同步复位            |
| afu_user_div2_clk              | input     |     1   |  用户可配置时钟2(时钟可重配置,默认200MHz,时钟频率为用户可配置时钟1的一半)           |
| afu_user_div2_rst              | input     |     1   | 用户可配置时钟2复位信号，高电平复同步复位            |
| afu_c0_emif_clk                | input     |     1   | emif0时钟(333MHz)            |
| afu_c0_emif_user_rst           | input     |     1   | emif0时钟域复位信号，高电平复同步复位            |
| afu_c1_emif_clk                | input     |     1   | emif1时钟(333MHz)            |
| afu_c1_emif_user_rst           | input     |     1   | mif1时钟域复位信号，高电平复同步复位            |
| afu_c2_emif_clk                | input     |     1   | emif2时钟(333MHz)            |
| afu_c2_emif_user_rst           | input     |     1   | mif2时钟域复位信号，高电平复同步复位            |
| afu_c3_emif_clk                | input     |     1   | emif3时钟(333MHz)            |
| afu_c3_emif_user_rst           | input     |     1   | mif3时钟域复位信号，高电平复同步复位            |
## 总线接口
FaaS F5 IOFS将FPGA板卡接口抽象封装成统一的标准总线提供给用户使用，结合不同的PIM组件，为用户提供AXI4、Avalon接口选择。 

| 功能      | green_top | Amba PIM   | Avalon PIM | 时钟 |
| --------- | --------- | ------- | ----------- | ----------- |
|pcie 数据通路| axi4    | axi4  |avalon mm| afu_pcie_core_clk|
|pcie mmio通路|axi4-lite| axi4-lite|avalon mm|afu_pcie_core_clk|
|emif0数据通路| avalon mm | axi4 |avalon mm |afu_c0_emif_clk|
|emif1数据通路| avalon mm | axi4 |avalon mm |afu_c1_emif_clk|
|emif2数据通路| avalon mm | axi4 |avalon mm |afu_c2_emif_clk|
|emif3数据通路| avalon mm | axi4 |avalon mm |afu_c3_emif_clk|
## 其他信号
| Port name                      | Direction | Width   | Description |
| ------------------------------ | --------- | ------- | ----------- |
| afu_c0_emif_init_done          | input     |     1   |  为1表示emif0校准完成，afu_c0_emif_clk时钟域|
| afu_c2_emif_init_done          | input     |     1   |  为1表示emif1校准完成，afu_c1_emif_clk时钟域|
| afu_c3_emif_init_done          | input     |     1   |  为1表示emif2校准完成，afu_c2_emif_clk时钟域|
| afu_c4_emif_init_done          | input     |     1   |  为1表示emif3校准完成，afu_c3_emif_clk时钟域|
# 工程管理
## 工程组建格式要求
在使用用户FaaS HDK时，用户设计创建需按照一定格式进行组织。以01_hello_world为例:

```bash
sh-4.2$ tree ./
.
├── hw
│   ├── amba_hello_world.json       #amba example json
│   ├── amba_source.txt             #amba source 
│   ├── avalon_hello_world.json     #avalon example json
│   ├── avalon_source.txt           #avalon source
│   └── rtl
│       ├── amba
│       │   └── user_logic.sv
│       └── avalon
│           └── user_logic.sv
└── sw
```
用户的逻辑设计相关代码在hw下。用户工程除代码文件外，还需提供json文件及包代码文件路径的txt文件:
1. *.txt文件和.json文件需在同一目录下。
2. *.txt中需提供代码文件相对与*.txt的相对路径。  

### JSON文件格式  

硬件设计为兼容Intel OPAE软件栈，用户需设置配置文件，以工程目录下的hello_world.json为例:

```JSON

{
   "version": 1,
   "afu-image": {
      "power": 0,
      "interface-uuid": "a8e5df1e-9f31-11e7-8158-847bebdbf5a0",
      "clock-frequency-high": 400,
      "clock-frequency-low": 200,
      "afu-top-interface":
         {
            "name": "AMBA"
         },
      "accelerator-clusters":
         [
            {
               "name": "hello_intr_afu",
               "total-contexts": 1,
               "accelerator-type-uuid": "850adcc2-6ceb-4b22-9722-d43375b61c66"
            }
         ]
   },
   "platform-name": "aliyun-f5"
}

```
* **version**:用户逻辑版本，支持0～15
* **clock-frequency-high**: afu_user_clk时钟频率设置值。配置范围200MHz～500MHz，步进2MHz。当设置为"auto"时将按照布局布线后的最大时钟频率设置
* **low**: afu_user_div2_clk时钟频率设置值。时钟频率需设置为clock-frequency-high一半。当设置为"auto"时将按照布局布线后的最大时钟频率设置，但满足为clock-frequency-high的一半
* **afu-top-interface**: 指定用户接口类型。支持AMBA/AVALON/ADMAMM/ADMAST256四种选项。在创建工程时会自动选择对应的PIM组建。
* **accelerator-type-uuid**: 用户设计工程的UUID，软件在进行编译及运行时依赖该对象。
  
&emsp;&emsp;**若工程上板时采用OPAE软件栈,则accelerator-type-uuid需与逻辑中uuid保持一致。**
    
### 用户寄存器空间分配 
用户在进行逻辑设计时，寄存器地址空间分配需遵循如下原则:
* **AFU DFH**: AFU DFH需放置在user logic mmio地址空间0x0处。软件在AFU初始化阶段将会扫描AFU DFH建立DFL。
* **AFU ID**: 该值需与JSON中UUID定义保持一致，低64bit放置于地址0x8处(Avalon 总线对应0x1)，高64bit放置于地址0x10处(Avalon 总线位于0x2)，host将通过UUID来识别AFU。
  
### Avalon与Axi4接口使用注意事项
提供给用户的接口无论是Avalon接口还是Axi4均遵循对应的标准协议。值得注意的一点是Axi4接口地址是按照字节来组织的，而Avalon接口中的地址是按照word来组织。下面的地址是等价的

接口 | axi4_addr | avalon_addr
---------|----------|---------
 mmio | 0x8 | 0x1
 pcie_data | 0x64 | 0x1
 ddr | 0x64 | 0x1
  
### DFH
OEAE通过DFH对硬件进行扫描，鉴别硬件支持的特性。DFH结构如下表所示:

| Bitfield Name      | Range | Access   | Description |
| ---------| --------- | ------- | ----------- |
|FeatureType|63:60|RO|4’b0000 – Reserved<br>4’b0001 – AFU
|Reserved	|59:41|Rsvd|Reserved|
|EOL|40|RO|End of DFH List<br>1'b0=No other feature header beyond this one<br>1'b1=This is the last feature header
NextDFHByteOffset|39:16|RO|Next DFH byte offset<br>Next DFH Address= Current DFH address + Next DFH byte offset. You can also use this value as an indication of the maximum size of the MMIO region occupied by this feature.
|FeatureRev|15:12|RO|For AFU Feature type= AFU major version number that is user defined.
FeatureID|11:0|RO|For AFU feature type= CoreFIM version number

驱动在加载时会从设备地址0开始进行扫描DFH用于组建DFL。在F5实例中，用户Port用到的DFH如下所示:   
```bash
$sudo reg_rw -s 86:00.0 -o 0x0 
ReadValue=0x4000000010001001 #NextDFHByteOffset为0x1000，下一个DFH位置在0x0+0x1000处
$sudo reg_rw -s 86:00.0 -o 0x1000
ReadValue=0x3000000030000012 #NextDFHByteOffset为0x3000，下一个DFH位置在0x1000+0x3000处
$sudo reg_rw -s 86:00.0 -o 0x4000
ReadValue=0x3000010fb0002013 #EOL为1，表示最后一个DFH
```

F5实例中Port寄存器列表入下表所示：

地址 | 位宽 | 默认值 | 定义
---------|----------|----------|---------
 0x0 | 64 |0x4000000010001001| **PORT_DFH**<br>[63:60] Feature Type = FIU(0x4)<br>[40]: EOL <br>[39:16] Next DFH Byte Offset <br>[15:12] AfuMajVersion<br>[11:0] CorefimVersion
 0x8 | 64 | 0x9642b06c6b355b87 |**PORT_AFU_ID_L**
 0x10| 64 | 0x3ab49893138d42eb |**PORT_AFU_ID_H**
 0x18 | 64 | 0x100000          |**FIRST_AFU_OFFSET**<br>[23:0] 指定第一个AFU地址偏移,F5中为0x100000
 0x30 | 64 | 0x800240000       |**PORT_CAPABILITY**<br> [35:32] 支持的中段个数<br>[23:8]AFU可以使用的MMIO空间大小(单位KB)，共9MB
 0x38 | 64 | 0x4               |**PORT_CONTROL**<br>bit[4] PortSoftResetAck,复位响应信号<br>bit0 PortSoftReset,Host可通过该位置1复位整个AFU。
 0x1000| 64|0x3000000030000012| **PORT_UINT_DFH**<br>[63:60] Feature Type = Private Feature<br>[40]: EOL <br>[39:16] Next DFH Byte Offset <br>[15:12] FeatureRev<br>[11:0] FeatureID
 0x1008|64 |0x8 |**PORT_UINT_CAPABILITY**<br>[23:12] BaseInterruptVectorNumber:AFU起始中断向量。[11:0] NumbSuppInterrupt AFU中断向量个数
 0x4000|64 |0x3000010fb0002013|**PORT_STP_DFH**<br>[63:60] Feature Type = Private Feature<br>[40]: EOL <br>[39:16] Next DFH Byte Offset <br>[15:12] FeatureRev<br>[11:0] FeatureID

 如上表所示，AFU对应的起始地址范围为0x100000，共计9MB，以hello_world工程为例，在软件代码中：

 ```C
 fpgaWriteMMIO64(accel_handle, 0, 0x18, buf_pa);
 ```
 访问的真实地址是0x100018，地址的映射关系由OPAE及FIM完成。

### txt文件格式
txt文件用于提供文件代码路径。以01_hello_world工程中amba_source.txt为例：
```
./rtl/amba/user_logic.sv
```
**该文件中所存储的路径需为相对于amba_source.txt的相对路径，否则工程创建会导致无法正常运行**
该文件内容也可为空。
支持文件类型： sv、v、ip、tcl、sdx、qsys

## 工程创建与运行
工程创建通过faasRtlUtil.sh工具进行创建。工程运行支持GUI图形界面和命令行模式进行。以01_hello_world为例。 **用户的工程创建需在json文件所在的同一目录下创建。**

### GUI模式下运行
如果用户想要通过在GUI图形界面下进行工程的运行，可通过如下指令进行工程创建：
```bash
sh-4.2$ faasRtlUtil.sh -f amba_hello_world.json -s amba_source.txt
JSOM File: amba_hello_world.json
Sourece File: amba_source.txt
Porject is created in ./faasIofs
AFU Will Use AMBA Bus
now you can run project in ./faasIofs by Quartus GUI
```
执行完成后进入faasIofs目录即可通过Quartus进行工程运行。
### Batch命令行模式
用户也可以在命令行下进行工程的运行，通过如下指令进行工程创建和运行：
```bash
sh-4.2$ faasRtlUtil.sh -f hello_world.json -s amba_source.txt -m batch
JSOM File: hello_world.json
Sourece File: amba_source.txt
Porject is created in ./faasIofs
AFU Will Use AMBA Bus
Info: *******************************************************************
Info: Running Quartus Prime Shell
    Info: Version 21.2.0 Build 72 06/14/2021 SC Pro Edition
    Info: Copyright (C) 2021  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions 
    Info: and other software and tools, and any partner logic 
    Info: functions, and any output files from any of the foregoing 
    Info: (including device programming or simulation files), and any 
    Info: associated documentation or information are expressly subject 
    Info: to the terms and conditions of the Intel Program License 
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Thu Aug 19 10:54:16 2021
    Info: System process ID: 111660
Info: Command: quartus_sh -t /opt/faasHdk/iofsRun.tcl 27231
Info: Quartus(args): 27231
SEED:27231
……
```
batch模式下逻辑工程可自动创建和运行。
### 工程删除
可执行下面的指令进行工程的清理：
```bash
sh-4.2$ faasRtlUtil.sh -c
project clean
```

### PR文件生成
&emsp;&emsp;在提供的HDK中提供了一个packager的工具用于生成PR文件。PR文件类型为GBS。当quartus工程跑完后，在faasIofs/output_files目录下会生成一个f5_faasIofs.f5_green_top.rbf文件。生成GBS文件需要该文件以及在创建工程时制定的JSON文件。生成GBS指令为:
```Bash
packager create-gbs --rbf=./faasIofs/output_files/f5_faasIofs.f5_green_top.rbf  --afu=amba_hello_world.json --gbs=./hello_world.gbs
```
&emsp;&emsp;如果你在json中指定时钟频率为“auto”,那么当quartus工程跑完后会在faasIofs/output_files/目录下生成user_clock_freq.txt文件，里面指定了工程最终的时钟约束频率。需要将真实的时钟频率更改至JSON文件后再生成PR文件。