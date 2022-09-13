//=======================================================
//prbs31 generate
//
//
//
//
//
//=======================================================

module ddr_prbs31_gen# (
    CH_NUM    = 16           ,
    DATA_INIT = 32'hffff_ffff
    
    )(
    input                   clk_sys     ,   // Clock
    input                   reset       ,   // Asynchronous reset active low
    input                   prbs_en     ,   //
    output  reg             prbs_vld    ,   // prbs valid 
    output  reg [31:0]      prbs_data_o     // prbs valid data
);

//=======================================================
//  signals
//=======================================================


//=======================================================
//  logic
//=======================================================
always@(posedge clk_sys or posedge reset)
begin
    if(reset == 1'b1) begin
        prbs_vld    <= 1'b0;
        prbs_data_o <= DATA_INIT;
    end
    else if(prbs_en == 1'b1) begin
        prbs_vld <= 1'b1;
        prbs_data_o[0]     <= prbs_data_o[24] ^ prbs_data_o[30];
        prbs_data_o[1]     <= prbs_data_o[0] ^ prbs_data_o[25] ^ prbs_data_o[28];
        prbs_data_o[2]     <= prbs_data_o[1] ^ prbs_data_o[26] ^ prbs_data_o[29];
        prbs_data_o[3]     <= prbs_data_o[2] ^ prbs_data_o[27] ^ prbs_data_o[30];
        prbs_data_o[4]     <= prbs_data_o[0] ^ prbs_data_o[3];
        prbs_data_o[5]     <= prbs_data_o[1] ^ prbs_data_o[4];
        prbs_data_o[6]     <= prbs_data_o[2] ^ prbs_data_o[5];
        prbs_data_o[7]     <= prbs_data_o[3] ^ prbs_data_o[6];
        prbs_data_o[8]     <= prbs_data_o[4] ^ prbs_data_o[7];
        prbs_data_o[9]     <= prbs_data_o[5] ^ prbs_data_o[8];
        prbs_data_o[10]    <= prbs_data_o[6] ^ prbs_data_o[9];
        prbs_data_o[11]    <= prbs_data_o[7] ^ prbs_data_o[10];
        prbs_data_o[12]    <= prbs_data_o[8] ^ prbs_data_o[11];
        prbs_data_o[13]    <= prbs_data_o[9] ^ prbs_data_o[12];
        prbs_data_o[14]    <= prbs_data_o[10] ^ prbs_data_o[13];
        prbs_data_o[15]    <= prbs_data_o[11] ^ prbs_data_o[14];
        prbs_data_o[16]    <= prbs_data_o[12] ^ prbs_data_o[15];
        prbs_data_o[17]    <= prbs_data_o[13] ^ prbs_data_o[16];
        prbs_data_o[18]    <= prbs_data_o[14] ^ prbs_data_o[17];
        prbs_data_o[19]    <= prbs_data_o[15] ^ prbs_data_o[18];
        prbs_data_o[20]    <= prbs_data_o[16] ^ prbs_data_o[19];
        prbs_data_o[21]    <= prbs_data_o[17] ^ prbs_data_o[20];
        prbs_data_o[22]    <= prbs_data_o[18] ^ prbs_data_o[21];
        prbs_data_o[23]    <= prbs_data_o[19] ^ prbs_data_o[22];
        prbs_data_o[24]    <= prbs_data_o[20] ^ prbs_data_o[23];
        prbs_data_o[25]    <= prbs_data_o[21] ^ prbs_data_o[24];
        prbs_data_o[26]    <= prbs_data_o[22] ^ prbs_data_o[25];
        prbs_data_o[27]    <= prbs_data_o[23] ^ prbs_data_o[26];
        prbs_data_o[28]    <= prbs_data_o[24] ^ prbs_data_o[27];
        prbs_data_o[29]    <= prbs_data_o[25] ^ prbs_data_o[28];
        prbs_data_o[30]    <= prbs_data_o[26] ^ prbs_data_o[29];
        prbs_data_o[31]    <= prbs_data_o[27] ^ prbs_data_o[30];
    end
    else begin
        prbs_vld    <= 1'b0;    
    end
end        
endmodule
