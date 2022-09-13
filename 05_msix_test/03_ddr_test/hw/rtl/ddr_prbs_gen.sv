//=======================================================
//prbs generate
//
//
//
//=======================================================
module ddr_prbs_gen 
#(
    parameter     AXI_DATA_WIDTH = 512
)
(
    input                                  clk_sys     ,   // Clock
    input                                  reset       ,   // Asynchronous reset active low
    input       [(AXI_DATA_WIDTH/32)-1:0]  prbs_en     ,   //
    output  wire                           prbs_vld    ,   // prbs valid 
    output  wire [AXI_DATA_WIDTH-1:0]      prbs_data_o     // prbs valid data
);

localparam CH_NUM = AXI_DATA_WIDTH/32; 

//=======================================================
//  signals
//=======================================================
wire [CH_NUM-1:0] prbs_vld_tmp;
assign prbs_vld = & prbs_vld_tmp;
//=======================================================
//  instance
////=======================================================
//defparam u0_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u1_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u2_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u3_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u4_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u5_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u6_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u7_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u8_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u9_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam ua_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam ub_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam uc_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam ud_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam ue_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam uf_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u0_prbs_32gen.DATA_INIT = 32'hffff_ffff;
//defparam u1_prbs_32gen.DATA_INIT = 32'h5555_aaaa;
//defparam u2_prbs_32gen.DATA_INIT = 32'haaaa_5555;
//defparam u3_prbs_32gen.DATA_INIT = 32'haaaa_aaaa;
//defparam u4_prbs_32gen.DATA_INIT = 32'h5555_5555;
//defparam u5_prbs_32gen.DATA_INIT = 32'hffff_5555;
//defparam u6_prbs_32gen.DATA_INIT = 32'h5555_ffff;
//defparam u7_prbs_32gen.DATA_INIT = 32'hffff_aaaa;
//defparam u8_prbs_32gen.DATA_INIT = 32'haaaa_ffff;
//defparam u9_prbs_32gen.DATA_INIT = 32'hffff_0000;
//defparam ua_prbs_32gen.DATA_INIT = 32'h0000_ffff;
//defparam ub_prbs_32gen.DATA_INIT = 32'h9999_ffff;
//defparam uc_prbs_32gen.DATA_INIT = 32'hffff_9999;
//defparam ud_prbs_32gen.DATA_INIT = 32'hffff_6666;
//defparam ue_prbs_32gen.DATA_INIT = 32'h6666_ffff;
//defparam uf_prbs_32gen.DATA_INIT = 32'h6666_6666;

genvar i;
generate
  for(i=0;i<CH_NUM;i++)
  begin:prbs_gen_loop 
   ddr_prbs31_gen prbs_32gen(
       .clk_sys     (clk_sys               ),   // Clock
       .reset       (reset                 ),   // Asynchronous reset active low
       .prbs_en     (prbs_en[i]            ),   //
       .prbs_vld    (prbs_vld_tmp[i]       ),   // prbs valid 
       .prbs_data_o (prbs_data_o[32*i+:32] ) // prbs valid data
   );
  end
endgenerate

endmodule // prbs_gen
