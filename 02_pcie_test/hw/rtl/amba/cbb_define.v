
`define FIFO_PARITY    "TRUE"       //"TRUE" or "FALSE". "TRUE"-FIFO support even parity,"FALSE"-no parity 
`define PARITY_DLY     "FALSE"      //"TRUE" or "FALSE". "TRUE"-FIFO output data bypassed,and delay 1 cycle to make parity,"FALSE" no delay.

`define ALTERA_FPGA
`ifndef ALTERA_FPGA
    `define XILINX_FPGA
`endif
    
//Altera
//Device:Stratix V,IV,III,II GX;Cyclone V,IV GX,III,II;Arria V,II GX,GX;
//BRAM_TYPE: M9K,M20K,M144K,MLAB

//Xilinx
//Device: 7SERIES , SPARTAN6 , 
//BRAM_TYPE: 7SERIES (18Kb ,36Kb) , SPARTAN6 (9Kb , 18Kb)
`ifdef ALTERA_FPGA
//Altera
`define		VENDER_ID	"Intel"		//Altera or Xilinx or Lattice
`define		DEVICE_ID	"Agilex"
`define		BRAM_TYPE	"M20K"	        //"M9K" or "MLAB"

`else
//Xilinx
`define		VENDER_ID	"Xilinx"		//Altera or Xilinx or Lattice
`define		DEVICE_ID	"vu9p"
`define		BRAM_TYPE	"block"	        //"18Kb" or "MLAB"
`define     URAM_TYPE   "ultra"

`endif
