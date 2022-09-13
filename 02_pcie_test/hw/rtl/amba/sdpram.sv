// ***************************************************************************************
// Filename        :    sdram.sv
// Projectname     :    F3
// Author          :    lxc
// Date            :    2020-05-18
// Version         :    1.0
//
// Description     :    simple dual port ram
// Parameter:
// Modification History
// Date            By            Revision        Change Description
// ---------------------------------------------------------------------------------------
// 2020-05-18      lxc           1.0             Original
//
// ***************************************************************************************
`include "cbb_define.v"

module sdpram #(
    parameter VENDER_ID =`VENDER_ID   ,
    parameter DEVICE_ID =`DEVICE_ID   ,
    parameter BRAM_TYPE =`BRAM_TYPE   ,
    parameter RAM_DEEP  =10           ,
    parameter RAM_WIDTH =8            ,
    parameter R_LATENCY =1            
)(
    input                               clk_wr      ,   
    input                               clk_rd      ,   
    input                               reset       ,   
    input                               wren        ,   
    input           [RAM_DEEP - 1:0]    wraddress   ,   
    input           [RAM_WIDTH - 1:0]   data        ,   
    input                               rden        ,   
    input           [RAM_DEEP - 1:0]    rdaddress   ,   
    output  wire    [RAM_WIDTH - 1:0]   q               
);
    localparam RAM_DO_REG               = (R_LATENCY==1) ? 0 : 1;
generate;
    if(VENDER_ID=="Intel") begin:Intel_sdpram
    defparam    u_intel_dpram.RAM_WIDTH     = RAM_WIDTH    ,
                u_intel_dpram.RAM_DO_REG    = RAM_DO_REG   ,
                u_intel_dpram.RAM_DEEP      = RAM_DEEP     ;
    intel_sdpram   u_intel_dpram (
                    .reset      (reset      ),  //i1:
                    .clk_wr     (clk_wr     ),  //i1:
                    .clk_rd     (clk_rd     ),  //i1:
                    .wren       (wren       ),  //i1:
                    .wraddress  (wraddress  ),  //col_index[FIFO_WIDTH]:
                    .data       (data       ),  //col_index[FIFO_WIDTH]:
                    .rden       (rden       ),  //i1:
                    .rdaddress  (rdaddress  ),  //col_index[FIFO_WIDTH]:
                    .q          (q          )   //o[FIFO_WIDTH]:
                    );
    end
    else begin:Xilinx_sdpram
    xilinx_sdpram # (
        .RAM_DEEP         (RAM_DEEP ),
        .RAM_WIDTH        (RAM_WIDTH),
        .R_LATENCY        (R_LATENCY),
        .BRAM_TYPE         (BRAM_TYPE)
        
    ) u_xilinx_sdpram      (
        .clk_wr           (clk_wr   ),
        .clk_rd           (clk_rd   ),
        .reset            (reset    ),

        .wren             (wren     ),
        .wraddress        (wraddress),
        //col_index[RAM_WIDTH]:
        .data             (data     ),
        //col_index[RAM_WIDTH]:
        .rden             (rden     ),
        .rdaddress        (rdaddress),
        //col_index[RAM_WIDTH]:
        //o[RAM_WIDTH]:
        .q                (q        )
    ); 
    end
endgenerate
endmodule
