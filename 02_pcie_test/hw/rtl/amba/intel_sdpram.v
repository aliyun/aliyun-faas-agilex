// ***************************************************************************************
// Filename        :    intel_sdpram.sv
// Projectname     :    AliDMA
// Author          :    zhixuan
// Date            :    2021-03-31
// Version         :    1.0
//
// Description     :    intel simple dula port ram 
// Parameter:
// Modification History
// Date            By            Revision        Change Description
// ---------------------------------------------------------------------------------------
// 2021-03-31      lxc           1.0             Original
//
// ***************************************************************************************
module intel_sdpram #(
    parameter RAM_DEEP  =11,
    parameter RAM_WIDTH =8,
    parameter BRAM_TYPE = "M20K" ,       //
    parameter RAM_DO_REG =0
)(
    input                               clk_wr      ,   //i1:
    input                               clk_rd      ,   //i1:
    input                               reset       ,   //i1:
    input                               wren        ,   //i1:
    input           [RAM_DEEP - 1:0]    wraddress   ,   //col_index[RAM_WIDTH]:
    input           [RAM_WIDTH - 1:0]   data        ,   //col_index[RAM_WIDTH]:
    input                               rden        ,   //i1:
    input           [RAM_DEEP - 1:0]    rdaddress   ,   //col_index[RAM_WIDTH]:
    output  wire    [RAM_WIDTH - 1:0]   q               //o[RAM_WIDTH]:
);

//--------------------------
//  parameters
//--------------------------
localparam  RAM_DOUT_REG    = (RAM_DO_REG == 1) ? "CLOCK0" : "UNREGISTERED";

//--------------------------
//  signals
//--------------------------

//-------------------------------------------------------------
//  process
//-------------------------------------------------------------

    altsyncram  altsyncram_component (
                .wren_a     (wren       ),
                .wren_b     (1'b0       ),
                .rden_a     (1'b0       ),
                .rden_b     (rden       ),
                .data_a     (data       ),
                .data_b     (           ),
                .address_a  (wraddress  ),
                .address_b  (rdaddress  ),
                .clock0     (clk_wr     ),
                .clock1     (clk_rd     ),
                .clocken0   (1'b1       ),
                .clocken1   (1'b1       ),
                .clocken2   (1'b1       ),
                .clocken3   (1'b1       ),
                .aclr0      (1'b0       ),
                .aclr1      (1'b0       ),
                .byteena_a  (1'b1       ),
                .byteena_b  (1'b1       ),
                .addressstall_a (1'b0   ),
                .addressstall_b (1'b0   ),
                .q_a        (           ),
                .q_b        (q          ),
                .eccstatus  ());
    defparam
        altsyncram_component.clock_enable_input_a = "BYPASS",
        altsyncram_component.clock_enable_input_b = "BYPASS",
        altsyncram_component.enable_ecc = "FALSE",
        altsyncram_component.intended_device_family = "Agilex",
        altsyncram_component.lpm_type = "altera_syncram",
        altsyncram_component.ram_block_type = BRAM_TYPE,
        altsyncram_component.numwords_a = 2**RAM_DEEP,
        altsyncram_component.numwords_b = 2**RAM_DEEP,
        altsyncram_component.operation_mode = "DUAL_PORT",
        altsyncram_component.outdata_aclr_a = "NONE",
        altsyncram_component.outdata_aclr_b = "NONE",
        altsyncram_component.outdata_reg_a = RAM_DOUT_REG,
        altsyncram_component.outdata_reg_b = RAM_DOUT_REG,
        altsyncram_component.read_during_write_mode_port_a = "OLD_DATA",
        altsyncram_component.read_during_write_mode_port_b = "OLD_DATA",
        altsyncram_component.power_up_uninitialized = "FALSE",
        altsyncram_component.widthad_a = RAM_DEEP,
        altsyncram_component.widthad_b = RAM_DEEP,
        altsyncram_component.width_a = RAM_WIDTH,
        altsyncram_component.width_b = RAM_WIDTH,
        altsyncram_component.width_byteena_a = 1;

endmodule
