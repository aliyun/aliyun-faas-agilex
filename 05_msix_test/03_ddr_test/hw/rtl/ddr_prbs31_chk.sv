`timescale 1ns / 1ps


//=======================================================
//prbs31 check
//
//
//
//
//=======================================================

module ddr_prbs31_chk# (
    DATA_INIT = 32'hffff_ffff
    )(
    input                   clk_sys         ,   // Clock
    input                   reset           ,   // Asynchronous reset active low
    input                   prbs_vld_i      ,   // prbs valid 
    input       [31:0]      prbs_data_i     ,   // prbs valid data
    input                   stat_clr        ,   // static clear signals
    output  reg [1 :0]      prbs_syn        ,   // prbs synchronous flag
    output  reg [1 :0]      prbs_err_flag   ,   // prbs error flag
    output  reg [31:0]      prbs_rx_dcnt    ,   // prbs receive data counter
    output  reg [31:0]      prbs_rx_ecnt        // prbs receive data error counter
);

//=======================================================
//  signals
//=======================================================
reg         prbs_vld_tmp    ;
reg [31:0]  prbs_data_tmp   ;
reg [31:0]  prbs_data_chk;
reg         prbs_vld_chk;
reg         prbs_vld_tmp_1dly    ;
reg [31:0]  prbs_data_tmp_1dly   ;


//=======================================================
//  logic
//=======================================================
always@(posedge clk_sys or posedge reset)
begin
    if(reset == 1'b1) begin
        prbs_vld_tmp    <= 1'b0;
        prbs_data_tmp   <= 32'h0;
        prbs_vld_tmp_1dly <= 1'b0;
        prbs_data_tmp_1dly <= 32'h0;
    end
    else begin
        prbs_vld_tmp    <= prbs_vld_i;
        prbs_data_tmp   <= prbs_data_i;
        prbs_vld_tmp_1dly <= prbs_vld_tmp;
        prbs_data_tmp_1dly <= prbs_data_tmp;        
    end
end


always@(posedge clk_sys or posedge reset)
begin
    if(reset == 1'b1) begin
        prbs_vld_chk    <= 1'b0;
        prbs_data_chk   <= DATA_INIT;
    end
    else if(prbs_vld_tmp == 1'b1) begin
        prbs_vld_chk    <= 1'b1;
        prbs_data_chk[0]     <= prbs_data_chk[24] ^ prbs_data_chk[30];
        prbs_data_chk[1]     <= prbs_data_chk[0] ^ prbs_data_chk[25] ^ prbs_data_chk[28];
        prbs_data_chk[2]     <= prbs_data_chk[1] ^ prbs_data_chk[26] ^ prbs_data_chk[29];
        prbs_data_chk[3]     <= prbs_data_chk[2] ^ prbs_data_chk[27] ^ prbs_data_chk[30];
        prbs_data_chk[4]     <= prbs_data_chk[0] ^ prbs_data_chk[3];
        prbs_data_chk[5]     <= prbs_data_chk[1] ^ prbs_data_chk[4];
        prbs_data_chk[6]     <= prbs_data_chk[2] ^ prbs_data_chk[5];
        prbs_data_chk[7]     <= prbs_data_chk[3] ^ prbs_data_chk[6];
        prbs_data_chk[8]     <= prbs_data_chk[4] ^ prbs_data_chk[7];
        prbs_data_chk[9]     <= prbs_data_chk[5] ^ prbs_data_chk[8];
        prbs_data_chk[10]    <= prbs_data_chk[6] ^ prbs_data_chk[9];
        prbs_data_chk[11]    <= prbs_data_chk[7] ^ prbs_data_chk[10];
        prbs_data_chk[12]    <= prbs_data_chk[8] ^ prbs_data_chk[11];
        prbs_data_chk[13]    <= prbs_data_chk[9] ^ prbs_data_chk[12];
        prbs_data_chk[14]    <= prbs_data_chk[10] ^ prbs_data_chk[13];
        prbs_data_chk[15]    <= prbs_data_chk[11] ^ prbs_data_chk[14];
        prbs_data_chk[16]    <= prbs_data_chk[12] ^ prbs_data_chk[15];
        prbs_data_chk[17]    <= prbs_data_chk[13] ^ prbs_data_chk[16];
        prbs_data_chk[18]    <= prbs_data_chk[14] ^ prbs_data_chk[17];
        prbs_data_chk[19]    <= prbs_data_chk[15] ^ prbs_data_chk[18];
        prbs_data_chk[20]    <= prbs_data_chk[16] ^ prbs_data_chk[19];
        prbs_data_chk[21]    <= prbs_data_chk[17] ^ prbs_data_chk[20];
        prbs_data_chk[22]    <= prbs_data_chk[18] ^ prbs_data_chk[21];
        prbs_data_chk[23]    <= prbs_data_chk[19] ^ prbs_data_chk[22];
        prbs_data_chk[24]    <= prbs_data_chk[20] ^ prbs_data_chk[23];
        prbs_data_chk[25]    <= prbs_data_chk[21] ^ prbs_data_chk[24];
        prbs_data_chk[26]    <= prbs_data_chk[22] ^ prbs_data_chk[25];
        prbs_data_chk[27]    <= prbs_data_chk[23] ^ prbs_data_chk[26];
        prbs_data_chk[28]    <= prbs_data_chk[24] ^ prbs_data_chk[27];
        prbs_data_chk[29]    <= prbs_data_chk[25] ^ prbs_data_chk[28];
        prbs_data_chk[30]    <= prbs_data_chk[26] ^ prbs_data_chk[29];
        prbs_data_chk[31]    <= prbs_data_chk[27] ^ prbs_data_chk[30];
    end
    else ;
end

//prbs syn 
wire prbs_sync_l;
wire prbs_sync_h;
assign prbs_sync_l = (prbs_data_chk[15:0] == prbs_data_tmp[15:0]);
assign prbs_sync_h = (prbs_data_chk[31:16] == prbs_data_tmp[31:16]);
always @(posedge clk_sys or posedge reset) 
begin 
    if(reset|stat_clr ) begin
        prbs_syn    <= 2'b11;
    end 
    else if(prbs_vld_tmp == 1'b1)begin
        prbs_syn <= {prbs_sync_h,prbs_sync_l};
    end
    else ;
end

//
reg  [1:0]       prbs_syn_1dly   ;
reg  [1:0]       prbs_syn_2dly   ;
wire [1:0]       prbs_syn_neg    ;
assign  prbs_syn_neg[0] = (prbs_syn_1dly[0] == 1'b0) && (prbs_syn_2dly[0] == 1'b1);
assign  prbs_syn_neg[1] = (prbs_syn_1dly[0] == 1'b0) && (prbs_syn_2dly[0] == 1'b1);
always @(posedge clk_sys or posedge reset) 
begin 
  prbs_syn_1dly <= prbs_syn;
  prbs_syn_2dly <= prbs_syn_1dly;
end

// prbs error flag
always@(posedge clk_sys or posedge reset)
begin
    if(reset == 1'b1) begin
        prbs_err_flag   <= 2'b0;
    end
    else if(stat_clr == 1'b1) begin
        prbs_err_flag   <= 2'b0;
    end
    else 
        case(prbs_syn_neg)
        2'b00:prbs_err_flag<= prbs_err_flag;
        2'b01:prbs_err_flag<= {prbs_err_flag[1],1'b1};
        2'b10:prbs_err_flag<= {1'b1,prbs_err_flag[0]};
        2'b11:prbs_err_flag<= 2'b11;
        default:prbs_err_flag<= prbs_err_flag;  
        endcase
end

//prbs_rx_dcnt
always @(posedge clk_sys or posedge reset)
begin
    if(reset == 1'b1) begin
        prbs_rx_dcnt <= 32'h0;
    end
    else if(stat_clr == 1'b1) begin
        prbs_rx_dcnt <= 32'h0;
    end
    else if(prbs_vld_tmp == 1'b1) begin
        prbs_rx_dcnt <= prbs_rx_dcnt + 1'b1;
    end
    else;
end

//prbs_rx_ecnt
always @(posedge clk_sys or posedge reset)
begin
    if(reset == 1'b1) begin
        prbs_rx_ecnt <= 32'h0;
    end
    else if(stat_clr == 1'b1) begin
        prbs_rx_ecnt <= 32'h0;
    end
    else if(prbs_syn_neg == 1'b1) begin
        prbs_rx_ecnt <= prbs_rx_ecnt + 1'b1;
    end
    else;
end

endmodule
