// ***************************************************************************************
//
// Filename        :    usr_ddr_access.v

module ddr_test_hpi
#(
  parameter AXI_ADDR_WIDTH   = 34       
)
(
    input                 s_axi_aclk      ,
    input                 s_axi_aresetn   ,
    //-- AXI Master Write Address Channel  
    input [9 : 0]         s_axi_awaddr    ,
    input [2 : 0]         s_axi_awprot    , 
    input                 s_axi_awvalid   ,
    output reg            s_axi_awready   ,
    //-- AXI Master Write Data Channel
    input [63 : 0]        s_axi_wdata     ,
    input [3 : 0]         s_axi_wstrb     ,
    input                 s_axi_wvalid    ,
    output reg            s_axi_wready    ,
    //-- AXI Master Write Response Channel 
    output reg [1 : 0]    s_axi_bresp     ,
    output reg            s_axi_bvalid    ,
    input                 s_axi_bready    ,
    //-- AXI Master Read Address Channel 
    input [9 : 0]         s_axi_araddr    ,
    input [2 : 0]         s_axi_arprot    ,  
    input                 s_axi_arvalid   ,
    output reg            s_axi_arready   ,
    //-- AXI Master Read Data Channel
    output reg [63 : 0]   s_axi_rdata     ,
    output reg [1 : 0]    s_axi_rresp     ,
    output reg            s_axi_rvalid    ,
    input                 s_axi_rready    ,
    //debug
    output  reg [3:0]     prbs_mode_start ,
    output  reg [3:0]     prbs_mode_sel   ,
    output  reg [31:0]    REQ_LEN         ,
    input       [63:0]    c0_round_time   ,
    output  reg [31:0]    test_mode       ,
    
    input     [31:0]      c0_txcmd_cnt    ,
    input     [31:0]      c0_rxcmd_cnt    ,
    input     [32:0]      c0_err          ,
    input     [63:0]      c0_syn          , 
    
    input    [3:0]       bist_running     ,
    input    [3:0]       bist_cplt        ,    
    input    [31:0]      c0_wr_cycle_cnt  ,
    input    [31:0]      c0_rd_cycle_cnt  ,     
    
    input     [3:0]       c0_curr_state_r ,
    
    input     [9 :0]      c0_vld_rdy          ,
    input     [31:0]      c0_wr_burst_cnt     ,
    input     [31:0]      c0_rd_req_cnt       ,
    input     [31:0]      c0_wr_prbs_burst_cnt,
    input     [31:0]      c0_rd_prbs_req_cnt  ,
    input     [31:0]      c0_rd_back_cnt      ,
    input     [3: 0]      c0_ddr_bist_done    ,
    input                 ddr_cal_done        ,
    input     [31:0]      c0_wr_data_cnt      ,
    input     [31:0]      c0_rd_data_cnt      ,
    input     [71:0]      c0_rdata_00         ,
    input     [71:0]      c0_rdata_ff         ,
    input     [4:0]       c0_slice_error      ,

    input     [31:0]      c0_rd_pkg_cnt       ,

    output    [ 7:0]      ddr_err_info        ,
    output    [31:0]      ddr_err_location    ,

    input                 usr_int_en      ,   //the clock domain kernel_clk_300m
    output   reg [15:0]   usr_int_req     ,
    input    [15:0]       usr_int_ack     
  
);
//=======================================================
//  parameter
//=======================================================
localparam  F5_VERSION = 32'hf5_0010    ;
localparam  F5_DATA    = 32'h2111_2300  ;
//localparam  REQ_MAX_LEN= 2 ** (AXI_ADDR_WIDTH - 10); //
localparam  REQ_MAX_LEN= 24'h400000;

localparam  IDLE       = 3'h0 ,
            WR_DATA    = 3'h1 ,
            WR_RES     = 3'h2 ,
            RD_ADDR    = 3'h3 ,
            RD_DATA    = 3'h4 ,
            RD_RES     = 3'h5 ;
//=======================================================
//  signals
//=======================================================
reg     [9:0]       waddr                   ;
reg     [9:0]       raddr                   ;
reg                 wen                     ;
reg                 ren                     ;
reg     [63:0]      rdata                   ;
reg     [63:0]      wdata                   ;

reg     [2:0]      curr_state               ;//
reg     [67:0]     c0_err_1dly              ;
reg     [67:0]     c0_err_2dly              ;

reg     [31:0]     c0_syn_1dly              ;

reg                ddr_cal_done_1dly        ;
reg                ddr_cal_done_2dly        ;
reg                ddr_cal_done_3dly        ;
reg                ddr_cal_done_4dly        ;
reg     [3:0]      prbs_mode_cplt_1dly      ;
reg     [3:0]      prbs_mode_cplt_2dly      ;
reg     [15:0]     int_req                  ;
reg     [31:0]     REQ_LEN_CFG              ;
reg     [31:0]     REQ_LEN_CFG_DLY1         ;
reg     [31:0]     REQ_LEN_CFG_DLY2         ;
reg     [4 :0]     c0_ddr_err_location      ;
//=======================================================
//  signals
//=======================================================

//write operation
always @(posedge s_axi_aclk or negedge s_axi_aresetn) 
begin
    if(s_axi_aresetn == 1'b0) begin
        curr_state    <= IDLE;
        s_axi_awready <= 1'b1;
        s_axi_wready  <= 1'b1;
        s_axi_bresp   <= 2'h0;
        s_axi_bvalid  <= 1'b0;
        s_axi_arready <= 1'b1; 
        s_axi_rdata   <= 64'h0;
        s_axi_rresp   <= 2'h0;
        s_axi_rvalid  <= 1'b0;
        wen           <= 1'b0;
        ren           <= 1'b0;
        wdata         <= 64'h0;
        waddr         <= 10'h0;
        raddr         <= 10'h0;        
    end 
    else begin
        wen           <= 1'b0;
        ren           <= 1'b0;
        s_axi_bvalid  <= 1'b0;           
        s_axi_rvalid  <= 1'b0;
        s_axi_awready <= 1'b0;
        s_axi_wready  <= 1'b0;
        s_axi_arready <= 1'b0;    
        case(curr_state) 
        IDLE: begin
            if(s_axi_awvalid == 1'b1) begin
                curr_state    <= WR_DATA;
                waddr         <= s_axi_awaddr ;
                s_axi_awready <= 1'b1;  
            end
            else if(s_axi_arvalid == 1'b1) begin
                curr_state    <= RD_DATA;
                raddr         <= s_axi_araddr;
                ren           <= 1'b1; 
                s_axi_arready <= 1'b1;
            end
            else begin
                curr_state <= IDLE;
            end
        end
        WR_DATA: begin
            if(s_axi_wvalid == 1'b1) begin
                curr_state    <= WR_RES;
                wen           <= 1'b1;
                wdata         <= s_axi_wdata;
                s_axi_wready  <= 1'b1;
            end
            else begin
                curr_state    <= WR_DATA;
                wen           <= 1'b0;              
            end
        end
        WR_RES: begin
            if((s_axi_bready == 1'b1) && (s_axi_bvalid == 1'b1)) begin
                curr_state   <= IDLE;
                s_axi_bvalid <= 1'b0;
            end
            else begin
                curr_state   <= WR_RES;
                s_axi_bvalid <= 1'b1;
            end
        end  
        RD_DATA: begin
            curr_state    <= RD_RES;
            ren           <= 1'b0; 
        end
        RD_RES: begin
            if((s_axi_rready == 1'b1) && (s_axi_rvalid == 1'b1)) begin
                curr_state    <= IDLE;
                s_axi_rdata   <= rdata;
                s_axi_rvalid  <= 1'b0;
            end
            else begin
                curr_state    <= RD_RES;
                s_axi_rvalid  <= 1'b1;
                s_axi_rdata   <= rdata;
            end
        end
        default: ;
        endcase
    end
end


//write operation
always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (~s_axi_aresetn) begin
        test_mode           <= 32'h0;
        prbs_mode_start     <= 4'b0;
        prbs_mode_sel       <= 4'b0;
        int_req             <= 16'h0;
        REQ_LEN_CFG         <= REQ_MAX_LEN;
    end
    else begin
        int_req <= 16'h0;    
        if (wen == 1'b1) begin
            case(waddr)
            10'h10: REQ_LEN_CFG         <= wdata;
            10'h18: test_mode           <= wdata;
            10'h20: prbs_mode_start     <= wdata[3:0];
            10'h28: prbs_mode_sel       <= wdata[3:0];  
            10'h60: int_req             <= wdata[15:0];
            default;
            endcase
        end
        else;
    end
end

always @(posedge s_axi_aclk)
begin
  REQ_LEN_CFG_DLY1 <= REQ_LEN_CFG;
  REQ_LEN_CFG_DLY2 <= REQ_LEN_CFG_DLY1;
  REQ_LEN          <= REQ_LEN_CFG_DLY2;
end

always @(posedge s_axi_aclk) 
begin
    c0_err_1dly <= c0_err       ;
    c0_err_2dly <= c0_err_1dly  ;
    ddr_cal_done_1dly <= ddr_cal_done;
    ddr_cal_done_2dly <= ddr_cal_done_1dly;
    ddr_cal_done_3dly <= ddr_cal_done_2dly;
    ddr_cal_done_4dly <= ddr_cal_done_3dly;  
    c0_syn_1dly <= c0_syn       ;
end

always @(posedge s_axi_aclk)
begin
    prbs_mode_cplt_1dly      <=  bist_cplt                  ;
    prbs_mode_cplt_2dly      <=  prbs_mode_cplt_1dly        ;
end

genvar i;
generate
for(i=0; i<16;i=i+1) begin
    always @(posedge s_axi_aclk or negedge s_axi_aresetn)
    begin
        if(s_axi_aresetn == 1'b0) begin
            usr_int_req[i] <= 1'b0;
        end
        else if(usr_int_en == 1'b1) begin
            if(int_req[i] == 1'b1) begin
                usr_int_req[i] <= 1'b1;
            end
            else if(usr_int_ack[i] == 1'b1) begin
                usr_int_req[i] <= 1'b0;
            end
            else;
        end
        else begin
            usr_int_req[i] <= 1'b0;
        end
    end
end    
endgenerate

assign c0_ddr_err_location[0] = ( (~(&c0_rdata_ff[15:0 ])) | (|c0_rdata_00[15:0 ]) );
assign c0_ddr_err_location[1] = ( (~(&c0_rdata_ff[31:16])) | (|c0_rdata_00[31:16]) );
assign c0_ddr_err_location[2] = ( (~(&c0_rdata_ff[47:32])) | (|c0_rdata_00[47:32]) );
assign c0_ddr_err_location[3] = ( (~(&c0_rdata_ff[63:48])) | (|c0_rdata_00[63:48]) );
assign c0_ddr_err_location[4] = ( (~(&c0_rdata_ff[71:64])) | (|c0_rdata_00[71:64]) );

assign ddr_err_info           = {|c0_err_2dly, ddr_cal_done};
assign ddr_err_location       = {3'b0,c0_slice_error};

//read operation
always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (~s_axi_aresetn) begin
        rdata <= 64'h0;
    end
    else if(ren == 1'b1)begin
      case(raddr)
          10'h0  : rdata <= F5_VERSION       ;
          10'h8  : rdata <= F5_DATA          ;
          10'h10 : rdata <= REQ_LEN_CFG      ;
          10'h18 : rdata <= test_mode        ;
          10'h20 : rdata <= prbs_mode_start  ;
          10'h28 : rdata <= prbs_mode_sel    ;
          10'h30 : rdata <= prbs_mode_cplt_2dly;
          10'h38 : rdata <= bist_running     ;
          10'h40 : rdata <= {c0_err_2dly[32]};
          10'h48 : rdata <= c0_err_2dly[31:0];
          10'h50 : rdata <= c0_txcmd_cnt[31:0];
          10'h58 : rdata <= c0_rxcmd_cnt[31:0];
          10'h60 : rdata <= ddr_cal_done_2dly;
          10'h68 : rdata <= {3'b0,c0_slice_error};
          10'h70 : rdata <= c0_syn_1dly    ;
          10'h78 : rdata <= {28'b0,c0_curr_state_r};
          10'h80 : rdata <= c0_wr_cycle_cnt ;
          10'h88 : rdata <= c0_rd_cycle_cnt ;
          10'h90 : rdata <= {22'b0,c0_vld_rdy};
          10'h98 : rdata <= c0_round_time[31:0 ];
          10'ha0:  rdata <= c0_round_time[63:32];
          10'ha8:  rdata <= {c0_ddr_bist_done}  ;
          10'hb0:  rdata <= c0_wr_burst_cnt     ;
          10'hb8:  rdata <= c0_rd_req_cnt       ;
          10'hc0:  rdata <= c0_wr_prbs_burst_cnt;
          10'hc8:  rdata <= c0_rd_prbs_req_cnt  ;
          10'hd0:  rdata <= c0_rd_back_cnt      ;
          10'hd8:  rdata <= c0_wr_data_cnt      ;
          10'he0:  rdata <= c0_rd_data_cnt      ;
          10'he8:  rdata <= c0_err_2dly[63:32]  ;
          10'hf0:  rdata <= c0_rdata_ff[31:0] ;
          10'hf8:  rdata <= c0_rdata_ff[63:32];
          10'h100:  rdata <= c0_rd_pkg_cnt  ;
          10'h108:  rdata <= {c0_rdata_ff[71:64]};
          default: rdata <= 64'haaaa  ;
      endcase
    end
    else;
end
endmodule 
