//=======================================================
//prbs check
//
//
//
//=======================================================
module ddr_prbs_chk 
#(
    parameter     AXI_DATA_WIDTH = 512
)
(
    input                                    clk_sys         ,   // Clock
    input                                    reset           ,   // Asynchronous reset active low
    input                                    prbs_vld_i      ,   // prbs valid 
    input         [AXI_DATA_WIDTH-1:0]       prbs_data_i     ,   // prbs valid data
    input                                    stat_clr        ,   // static clear signals
    output  wire  [(AXI_DATA_WIDTH/16)-1:0]  prbs_syn        ,   // prbs synchronous flag
    output  wire  [(AXI_DATA_WIDTH/16)-1:0]  prbs_err_flag   ,   // prbs error flag
    output  wire  [511:0]                    prbs_rx_dcnt    ,   // prbs receive data counter
    output        [511:0]                    prbs_rx_ecnt        // prbs receive data error counter
);
localparam CH_NUM = AXI_DATA_WIDTH/32;
//=======================================================
//  signals
//=======================================================
wire [31:0]                    prbs_rx_dcnt_tmp[CH_NUM-1:0]  ;
wire [31:0]                    prbs_rx_ecnt_tmp[CH_NUM-1:0]  ;
wire [(AXI_DATA_WIDTH/16)-1:0] prbs_err_flag_tmp ;
wire [(AXI_DATA_WIDTH/16)-1:0] prbs_syn_tmp      ;

//=======================================================
//  logic
//=======================================================
assign prbs_syn = prbs_syn_tmp  ;
assign prbs_err_flag = prbs_err_flag_tmp ;
assign prbs_rx_dcnt = {prbs_rx_dcnt_tmp[15],prbs_rx_dcnt_tmp[14],prbs_rx_dcnt_tmp[13],prbs_rx_dcnt_tmp[12],
                       prbs_rx_dcnt_tmp[11],prbs_rx_dcnt_tmp[10],prbs_rx_dcnt_tmp[9],prbs_rx_dcnt_tmp[8],
                       prbs_rx_dcnt_tmp[7],prbs_rx_dcnt_tmp[6],prbs_rx_dcnt_tmp[5],prbs_rx_dcnt_tmp[4],
                       prbs_rx_dcnt_tmp[3],prbs_rx_dcnt_tmp[2],prbs_rx_dcnt_tmp[1],prbs_rx_dcnt_tmp[0]
                       };

assign prbs_rx_ecnt = {prbs_rx_ecnt_tmp[15],prbs_rx_ecnt_tmp[14],prbs_rx_ecnt_tmp[13],prbs_rx_ecnt_tmp[12],
                       prbs_rx_ecnt_tmp[11],prbs_rx_ecnt_tmp[10],prbs_rx_ecnt_tmp[9],prbs_rx_ecnt_tmp[8],
                       prbs_rx_ecnt_tmp[7],prbs_rx_ecnt_tmp[6],prbs_rx_ecnt_tmp[5],prbs_rx_ecnt_tmp[4],
                       prbs_rx_ecnt_tmp[3],prbs_rx_ecnt_tmp[2],prbs_rx_ecnt_tmp[1],prbs_rx_ecnt_tmp[0]
                       };
//=======================================================
//  instance
//=======================================================
//defparam u0_prbs31_chk.DATA_INIT = 32'hffff_ffff;           
//defparam u1_prbs31_chk.DATA_INIT = 32'h5555_aaaa;
//defparam u2_prbs31_chk.DATA_INIT = 32'haaaa_5555;
//defparam u3_prbs31_chk.DATA_INIT = 32'haaaa_aaaa;
//defparam u4_prbs31_chk.DATA_INIT = 32'h5555_5555;
//defparam u5_prbs31_chk.DATA_INIT = 32'hffff_5555;
//defparam u6_prbs31_chk.DATA_INIT = 32'h5555_ffff;
//defparam u7_prbs31_chk.DATA_INIT = 32'hffff_aaaa;
//defparam u8_prbs31_chk.DATA_INIT = 32'haaaa_ffff;
//defparam u9_prbs31_chk.DATA_INIT = 32'hffff_0000;
//defparam ua_prbs31_chk.DATA_INIT = 32'h0000_ffff;
//defparam ub_prbs31_chk.DATA_INIT = 32'h9999_ffff;
//defparam uc_prbs31_chk.DATA_INIT = 32'hffff_9999;
//defparam ud_prbs31_chk.DATA_INIT = 32'hffff_6666;
//defparam ue_prbs31_chk.DATA_INIT = 32'h6666_ffff;
//defparam uf_prbs31_chk.DATA_INIT = 32'h6666_6666;

genvar i;
generate
  for(i=0;i<CH_NUM;i++)
  begin:prbs_chk_loop 
    ddr_prbs31_chk prbs31_chk(
        .clk_sys         (clk_sys                  ),   // Clock
        .reset           (reset                    ),   // Asynchronous reset active low
        .prbs_vld_i      (prbs_vld_i               ),   // prbs valid 
        .prbs_data_i     (prbs_data_i[32*i+:32]    ),   // prbs valid data
        .stat_clr        (stat_clr                 ),   // static clear signals
        .prbs_syn        (prbs_syn_tmp[i*2+:2]     ),   // prbs synchronous flag
        .prbs_err_flag   (prbs_err_flag_tmp[i*2+:2]),   // prbs error flag
        .prbs_rx_dcnt    (prbs_rx_dcnt_tmp[i]      ),   // prbs receive data counter
        .prbs_rx_ecnt    (prbs_rx_ecnt_tmp[i]      )    // prbs receive data error counter
    );
  end
endgenerate

endmodule // prbs
