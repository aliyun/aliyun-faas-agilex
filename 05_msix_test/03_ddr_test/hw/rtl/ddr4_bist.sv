// ***************************************************************************************
//
// Filename        :    ddr4_bist.v
// Projectname     :    F5
// Version         :    1.0
//
// ***************************************************************************************
`timescale 1ps/1ps 
module ddr4_bist #(
  parameter AXI_ID_WIDTH     = 16       ,
  parameter AXI_ADDR_WIDTH   = 34       , 
  parameter AXI_DATA_WIDTH   = 512      ,
  parameter AXI_END_ADDR     = 34'h3_ffff_fe00   
)(
    input                                   s_axi_aclk             ,
    input                                   s_axi_aresetn          ,
    input                                   prbs_mode_sel          ,//1-prbs 4K burst; 0-prbs all ddr burst
    input                                   prbs_mode_start        ,
    input  [31:0]                           test_mode              ,
    input  [31:0]                           REQ_LEN                ,
    input                                   ddr_cal_done           ,//ddr calibration done
    
    // AXI write address channel signals
    input                                   axi_awready            ,// Indicates slave is ready to accept a 
    output [AXI_ID_WIDTH-1:0]               axi_awid               ,// Write ID
    output reg [AXI_ADDR_WIDTH-1:0]         axi_awaddr             ,// Write address
    output [7:0]                            axi_awlen              ,// Write Burst Length
    output [2:0]                            axi_awsize             ,// Write Burst size
    output [1:0]                            axi_awburst            ,// Write Burst type
    output                                  axi_awlock             ,// Write lock type
    output [3:0]                            axi_awcache            ,// Write Cache type
    output [2:0]                            axi_awprot             ,// Write Protection type
    output reg                              axi_awvalid            ,// Write address valid
    // AXI write data channel signals
    input                                   axi_wready             ,// Write data ready
    output wire [AXI_DATA_WIDTH-1:0]        axi_wdata              ,// Write data
    output [AXI_DATA_WIDTH/8-1:0]           axi_wstrb              ,// Write strobes
    output wire                             axi_wlast              ,// Last write transaction
    output reg                              axi_wvalid             ,// Write valid
    // AXI write response channel signals      
    input  [AXI_ID_WIDTH-1:0]               axi_bid                ,// Response ID
    input  [1:0]                            axi_bresp              ,// Write response
    input                                   axi_bvalid             ,// Write reponse valid
    output wire                             axi_bready             ,// Response ready
    // AXI read address channel signals    
    input                                   axi_arready            ,// Read address ready
    output [AXI_ID_WIDTH-1:0]               axi_arid               ,// Read ID
    output reg [AXI_ADDR_WIDTH-1:0]         axi_araddr             ,// Read address
    output [7:0]                            axi_arlen              ,// Read Burst Length
    output [2:0]                            axi_arsize             ,// Read Burst size
    output [1:0]                            axi_arburst            ,// Read Burst type
    output                                  axi_arlock             ,// Read lock type
    output [3:0]                            axi_arcache            ,// Read Cache type
    output [2:0]                            axi_arprot             ,// Read Protection type
    output reg                              axi_arvalid            ,// Read address valid 
    // AXI read data channel signals       
    input  [AXI_ID_WIDTH-1:0]               axi_rid                ,// Response ID
    input  [1:0]                            axi_rresp              ,// Read response
    input                                   axi_rvalid             ,// Read reponse valid
    input  [AXI_DATA_WIDTH-1:0]             axi_rdata              ,// Read data
    input                                   axi_rlast              ,// Read last
    output                                  axi_rready             ,// Read Response ready
    //error signals//all are sticky
    input        [2:0]                      rw_mode                ,
    output  reg  [63:0]                     round_time             ,
    output  reg                             bist_running           ,//
    output  reg                             bist_cplt              ,//
    output  reg  [31:0]                     wr_cycle_cnt           ,
    output  reg  [31:0]                     rd_cycle_cnt           ,
    output  wire [3:0]                      curr_state_r           ,// curr state 
    output  wire [31:0]                     prbs_syn               ,// prbs synchronous flag    
    output  wire [32:0]                     bist_err_flag          ,// [16]-9 step error; [15:0] prbs error flag
    output  reg  [31:0]                     wr_burst_cnt           ,
    output  reg  [31:0]                     rd_req_cnt             ,
    output  reg  [31:0]                     wr_prbs_burst_cnt      ,
    output  reg  [31:0]                     rd_prbs_req_cnt        ,
    output  reg  [31:0]                     rd_back_cnt            ,
    output  reg  [31:0]                     wr_data_cnt            ,
    output  reg  [31:0]                     rd_data_cnt            ,
    output  reg  [3: 0]                     ddr_bist_done          ,
    output  reg  [71:0]                     rd_data_00             ,
    output  reg  [71:0]                     rd_data_ff             ,
    output       [4:0]                      slice_error            ,
    output  reg  [31:0]                     rd_pkg_cnt             ,
    output  wire [511:0]                    prbs_rx_dcnt           ,// prbs receive data counter
    output  wire [511:0]                    prbs_rx_ecnt            // prbs receive data error counter
);

//=======================================================
//  parameter
//=======================================================
localparam  INIT_ZERO   = 4'd0 ,
            IDLE        = 4'd1 ,
            WR_ZERO     = 4'd2 ,
            RD_ZERO     = 4'd3 ,
            WR_FIVE     = 4'd4 ,
            RD_FIVE     = 4'd5 ,
            WR_TEN      = 4'd6 ,
            RD_TEN      = 4'd7 ,
            WR_F        = 4'd8 ,
            RD_F        = 4'd9 ,
            WR_PRBS     = 4'd10,
            RD_PRBS     = 4'd11;
            
//localparam  REQ_LEN     = 2 ** (AXI_ADDR_WIDTH - 10); //
//localparam  REQ_LEN     = 128; //
//localparam  REQ_LEN     = 4; //
localparam  PRBS_4K_LEN = 4 ;
//localparam  ADDR_OFFSET = 16'h400;
//localparam  ADDR_OFFSET = 16*(AXI_DATA_WIDTH/8);
localparam  ADDR_OFFSET = (AXI_DATA_WIDTH==576) ? 16'h10 : 16'h400;
localparam  BIST_CPLT_NUM = 32'd300300;
localparam  ERR_LEN = AXI_DATA_WIDTH/16;
localparam  CH_NUM  = AXI_DATA_WIDTH/32;
//=======================================================
//  signals
//=======================================================
reg     [3:0]   curr_state                  ;
reg     [3:0]   next_state                  ;
reg     [3:0]   curr_state_1dly  = 4'h0     ;

reg             ddr_cal_done_1dly   = 1'b0  ;
reg             ddr_cal_done_2dly   = 1'b0  ;
reg             ddr_cal_done_3dly   = 1'b0  ;
reg             ddr_cal_done_4dly   = 1'b0  ;
reg             ddr_cal_done_5dly   = 1'b0  ;
wire            ddr_cal_pos                 ;
    
//reg     [31:0]  wr_burst_cnt                ;
//reg     [31:0]  rd_req_cnt                  ;
//reg     [31:0]  wr_prbs_burst_cnt           ;
//reg     [31:0]  rd_prbs_req_cnt             ;
//reg     [31:0]  rd_back_cnt                 ;

reg     [7:0]   wsize_cnt                   ;
reg             prbs_mode_start_1dly= 1'b0  ;
reg             prbs_mode_start_2dly= 1'b0  ;
reg             prbs_mode_start_3dly= 1'b0  ;
reg             prbs_mode_start_4dly= 1'b0  ;
reg             prbs_mode_start_5dly= 1'b0  ;

reg             test_error                  ;
reg     [3:0]   test_error_state            ;
reg             rd_ddr_done_1dly   = 1'b0   ;
reg             rd_ddr_done_2dly   = 1'b0   ;

reg             wr_ddr_done_1dly   = 1'b0   ;
reg             wr_ddr_done_2dly   = 1'b0   ;

reg             prbs_mode_sel_1dly = 1'b0   ;
reg             prbs_mode_sel_2dly = 1'b0   ;
reg             prbs_mode_sel_3dly = 1'b0   ;

wire    [31:0]  rpbs_burst_len              ;// prbs module burst len

reg             wr_ddr_done                 ;
reg             rd_ddr_done                 ;
reg             wr_prbs_done                ;
reg             rd_prbs_done                ;
reg             rd_prbs_done_1dly   = 1'b0  ;
reg             rd_prbs_done_2dly   = 1'b0  ;
reg             wr_prbs_done_1dly   = 1'b0  ;
reg             nine_step_cplt     = 1'b0   ;

reg             cycle_flag                  ;//0-fist cycle; 1-sec cycle
reg             prbs_mode_start_pos_1dly    ;

wire            prbs_mode_start_pos         ;
wire    [AXI_DATA_WIDTH-1:0] prbs_wdata     ;
reg     [15:0]               wr_resp_ecnt   ;
wire    [31:0]               prbs_err_flag  ;
reg     [AXI_DATA_WIDTH-1:0] wr_nsetp_data  ;// 55/ aa data
reg                          prbs_flag      ;
reg                          rd_prbs_done_d1;
reg                          axi_rlast_flag ;
reg     [AXI_DATA_WIDTH-1:0] test_err       ;
wire    [16*8-1:0]           slice0_err     ;
wire    [16*8-1:0]           slice1_err     ;
wire    [16*8-1:0]           slice2_err     ;
wire    [16*8-1:0]           slice3_err     ;
wire    [16*8-1:0]           slice4_err     ;
reg     [AXI_DATA_WIDTH-1:0] axi_rdata_d1   ;
reg                          axi_rvalid_d1  ;
always @(posedge s_axi_aclk)
begin
  axi_rdata_d1  <= axi_rdata;
  axi_rvalid_d1 <= axi_rvalid;
end

genvar i;
generate
  for(i=0;i<8;i++)
    if(AXI_DATA_WIDTH==576)
      begin
        assign slice0_err[16*i+:16] = test_err[(72*i+16*0)+:16];
        assign slice1_err[16*i+:16] = test_err[(72*i+16*1)+:16];
        assign slice2_err[16*i+:16] = test_err[(72*i+16*2)+:16];
        assign slice3_err[16*i+:16] = test_err[(72*i+16*3)+:16];
        assign slice4_err[16*i+:16] = {8'h0,test_err[(72*i+16*4)+:8]};
      end
    else
      begin
        assign slice0_err[16*i+:16] = test_err[(64*i+16*0)+:16];
        assign slice1_err[16*i+:16] = test_err[(64*i+16*1)+:16];
        assign slice2_err[16*i+:16] = test_err[(64*i+16*2)+:16];
        assign slice3_err[16*i+:16] = test_err[(64*i+16*3)+:16];
        assign slice4_err[16*i+:16] = 16'h0;
      end
endgenerate
assign slice_error ={{|slice4_err},{|slice3_err},{|slice2_err},{|slice1_err},{|slice0_err}};

//=======================================================
//  logic
//=======================================================
//AXI write address channel signals
assign  axi_awlen   = 8'hf  ;   //16*64B= 1KB/once request
assign  axi_awsize  = 3'h6  ;   //64B request
assign  axi_awburst = 2'h1  ;
assign  axi_awlock  = 1'b0  ;
assign  axi_awcache = 4'h0  ;
assign  axi_awprot  = 3'h0  ;
assign  axi_awid    = {AXI_ID_WIDTH{1'b0}};

//AXI write data channel signals
assign  axi_wstrb   = {(AXI_DATA_WIDTH/8){1'b1}};

//AXI read address channel signals  
assign  axi_arlen    = 8'hf ; //16*64B= 1KB/once request        
assign  axi_arsize   = 3'h6 ; //64B request        
assign  axi_arburst  = 2'h1 ; 
assign  axi_arlock   = 1'b0 ; 
assign  axi_arcache  = 4'h0 ; 
assign  axi_arprot   = 3'h0 ;
assign  axi_arid     = {AXI_ID_WIDTH{1'b0}} ;

//AXI read back
assign  axi_rready   = 1'b1;

//
assign rpbs_burst_len = prbs_mode_sel_3dly ? PRBS_4K_LEN : REQ_LEN;

//
assign  ddr_cal_pos = (ddr_cal_done_4dly == 1'b1) && (ddr_cal_done_5dly == 1'b0);
always @(posedge s_axi_aclk)
begin
    ddr_cal_done_1dly   <= ddr_cal_done     ;
    ddr_cal_done_2dly   <= ddr_cal_done_1dly;
    ddr_cal_done_3dly   <= ddr_cal_done_2dly;
    ddr_cal_done_4dly   <= ddr_cal_done_3dly;
    ddr_cal_done_5dly   <= ddr_cal_done_4dly;
end

always @(posedge s_axi_aclk)
begin
    ddr_bist_done = {wr_ddr_done,rd_ddr_done,wr_prbs_done,rd_prbs_done};
end          
//
always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        curr_state <= 4'h0;
    end
    else begin
        curr_state <= next_state;
    end
end

always @(*)
begin
    case(curr_state)
    INIT_ZERO  :  begin
        if(wr_ddr_done == 1'b1) begin
            next_state = IDLE;
        end
        else begin
            next_state = INIT_ZERO;
        end
    end
    IDLE       : begin
        if(prbs_mode_start_pos == 1'b1) begin
          if(test_mode[0])
            next_state = WR_PRBS;
          else if(test_mode[1])
            next_state = RD_PRBS;
          else
            next_state = WR_ZERO;
        end
        else if(prbs_mode_start_5dly) begin
          if(test_mode[0])
            next_state = WR_PRBS;
          else if(test_mode[1])
            next_state = RD_PRBS;
          else
            next_state = WR_ZERO;
        end 
        else begin
            next_state = IDLE;
        end
    end
    WR_ZERO    : begin
        if(wr_ddr_done == 1'b1) begin
          next_state = RD_ZERO;
        end
        else begin
            next_state = WR_ZERO;
        end
    end
    RD_ZERO    : begin
        if(rd_ddr_done_1dly == 1'b1) begin
            next_state = WR_FIVE;
        end
        else begin
            next_state = RD_ZERO;
        end
    end
    WR_FIVE    : begin
        if(wr_ddr_done == 1'b1) begin
            next_state = RD_FIVE;
        end
        else begin
            next_state = WR_FIVE;
        end
    end
    RD_FIVE    : begin
        if(rd_ddr_done_1dly == 1'b1) begin
            next_state = WR_TEN;
        end
        else begin
            next_state = RD_FIVE;
        end
    end
    WR_TEN     : begin
        if(wr_ddr_done == 1'b1) begin
            next_state = RD_TEN;
        end
        else begin
            next_state = WR_TEN;
        end
    end
    RD_TEN     : begin
        if(rd_ddr_done_1dly == 1'b1) begin
            next_state = WR_F;
        end
        else begin
            next_state = RD_TEN;
        end        
    end
    WR_F       : begin
        if(wr_ddr_done == 1'b1) begin
            next_state = RD_F;
        end
        else begin
            next_state = WR_F;
        end
    end
    RD_F       : begin
        if(rd_ddr_done_1dly == 1'b1 && cycle_flag == 1'b0) begin
            next_state = WR_ZERO;
        end
        else if(rd_ddr_done_1dly == 1'b1) begin
            next_state = WR_PRBS;
        end
        else begin
            next_state = RD_F;
        end        
    end
    WR_PRBS    : begin
        if(wr_prbs_done&prbs_mode_start_5dly) begin
          if(test_mode[0])
            next_state = IDLE;
          else if(test_mode[1])
            next_state = IDLE;
          else
            next_state = RD_PRBS;
        end
        else if(wr_prbs_done == 1'b1) begin
          if(test_mode[0])
            next_state = IDLE;
          else if(test_mode[1])
            next_state = IDLE;
          else
            next_state = RD_PRBS;
        end
        else begin
            next_state = WR_PRBS;
        end
        
    end
    RD_PRBS    : begin
        if(rd_prbs_done == 1'b1 && prbs_mode_start_5dly == 1'b1) begin
          if(test_mode[0])
            next_state = IDLE;
          else if(test_mode[1])
            next_state = IDLE;
          else
            next_state = WR_PRBS;
        end
        else if(rd_prbs_done == 1'b1) begin
            next_state = IDLE;
        end
        else begin
            next_state = RD_PRBS;
        end
    end
    default : next_state = IDLE;
    endcase
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        axi_awaddr           <= {AXI_ADDR_WIDTH{1'b0}};
        axi_araddr           <= {AXI_ADDR_WIDTH{1'b0}};
        axi_awvalid          <= 1'b0 ;
        axi_arvalid          <= 1'b0 ;
        axi_wvalid           <= 1'b0 ;
        test_error           <= 1'b0 ;
        test_err             <= 'd0  ;
        test_error_state     <= 4'h0 ;
        cycle_flag           <= 1'b0 ;
        wr_nsetp_data        <= {AXI_DATA_WIDTH{1'b0}};
        rd_data_00           <= 72'h0;      
        rd_data_ff           <= 72'h0;      
    end
    else begin
    case (curr_state)
    INIT_ZERO   : begin
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awvalid <= 1'b0;
        end
        else if(ddr_cal_pos == 1'b1) begin
            axi_awvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 && wr_burst_cnt < REQ_LEN) begin
            axi_awvalid <= 1'b1;
        end
        else ;
        
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awaddr <= axi_awaddr + ADDR_OFFSET;
        end
        else ;
        
        //
        wr_nsetp_data <= {AXI_DATA_WIDTH{1'b0}};
        if(ddr_cal_pos == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(wr_ddr_done == 1'b1) begin
            axi_wvalid <= 1'b0;
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 )begin
            axi_wvalid <= 1'b0;
        end
        else ;
        
    end
    IDLE        : begin
        axi_arvalid          <= 1'b0 ;
        axi_awvalid          <= 1'b0 ;
        axi_wvalid           <= 1'b0 ;
        cycle_flag           <= 1'b0 ;
        axi_awaddr           <= {AXI_ADDR_WIDTH{1'b0}};
        axi_araddr           <= {AXI_ADDR_WIDTH{1'b0}};
        
    end
    WR_ZERO     : begin
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awvalid <= 1'b0;
        end
        else if(prbs_mode_start_pos_1dly == 1'b1 || rd_ddr_done_2dly == 1'b1) begin
            axi_awvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 && wr_burst_cnt < REQ_LEN) begin
            axi_awvalid <= 1'b1;
        end
        else ;
        
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awaddr <= axi_awaddr + ADDR_OFFSET;
        end
        else ;
        //
        wr_nsetp_data <= {ERR_LEN{16'h0000}};
        if(prbs_mode_start_pos_1dly == 1'b1 || rd_ddr_done_2dly == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(wr_ddr_done == 1'b1) begin
            axi_wvalid <= 1'b0;
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 )begin
            axi_wvalid <= 1'b0;
        end
        else ;
        if(prbs_mode_start_pos_1dly)
          test_err <= 'd0;
        else
          test_err <= test_err;
    end
    RD_ZERO : begin
        if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_arvalid <= 1'b0;
        end
        else if(wr_ddr_done_1dly == 1'b1) begin
            axi_arvalid <= 1'b1;
        end
        else if(axi_arvalid == 1'b0 && rd_req_cnt < REQ_LEN ) begin
            axi_arvalid <= 1'b1;
        end
        else;
        
        axi_awaddr <= {AXI_ADDR_WIDTH{1'b0}};
        if(rd_ddr_done_1dly == 1'b1) begin
            axi_araddr <= {AXI_ADDR_WIDTH{1'b0}};
        end
        else if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_araddr <= axi_araddr + ADDR_OFFSET;
        end
        else ;
   
        if(axi_rvalid == 1'b1) begin
            rd_data_00 <= axi_rdata[71:0];      
        end
        else;
   
        if(axi_rvalid & test_error) begin
            test_err <= (axi_rdata_d1 ^ {ERR_LEN{16'h0000}});
        end
        else;

 
        if(axi_rvalid == 1'b1 && axi_rdata != {ERR_LEN{16'h0000}}) begin
            //test_err <= (axi_rdata_d1 ^ {ERR_LEN{16'h0000}});
            test_error <= 1'b1;
            test_error_state <= RD_ZERO;
        end
        else;
 
    end
    WR_FIVE     : begin
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awvalid <= 1'b0;
        end
        else if(rd_ddr_done_2dly == 1'b1) begin
            axi_awvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 && wr_burst_cnt < REQ_LEN) begin
            axi_awvalid <= 1'b1;
        end
        else ;
        
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awaddr <= axi_awaddr + ADDR_OFFSET;
        end
        else ;
        //
        wr_nsetp_data <= {ERR_LEN{16'h5555}};
        if(rd_ddr_done_2dly == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(wr_ddr_done == 1'b1) begin
            axi_wvalid <= 1'b0;
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 )begin
            axi_wvalid <= 1'b0;
        end
        else ;
    end
    RD_FIVE     : begin //axi_araddr 
        if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_arvalid <= 1'b0;
        end
        else if(wr_ddr_done_1dly == 1'b1) begin
            axi_arvalid <= 1'b1;
        end
        else if(axi_arvalid == 1'b0 && rd_req_cnt < REQ_LEN ) begin
            axi_arvalid <= 1'b1;
        end
        else;
        
        axi_awaddr <= {AXI_ADDR_WIDTH{1'b0}};
        if(rd_ddr_done_1dly == 1'b1) begin
            axi_araddr <= {AXI_ADDR_WIDTH{1'b0}};
        end
        else if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_araddr <= axi_araddr + ADDR_OFFSET;
        end
        else ;


        if(axi_rvalid == 1'b1 && axi_rdata != {ERR_LEN{16'h5555}}) begin
            test_error <= 1'b1;
            test_error_state <= RD_FIVE;
        end
        else;
    end
    WR_TEN      : begin
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awvalid <= 1'b0;
        end
        else if(rd_ddr_done_2dly == 1'b1) begin
            axi_awvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 && wr_burst_cnt < REQ_LEN) begin
            axi_awvalid <= 1'b1;
        end
        else ;

        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awaddr <= axi_awaddr + ADDR_OFFSET;
        end
        else ;
        //
        wr_nsetp_data <= {ERR_LEN{16'haaaa}};
        if(rd_ddr_done_2dly == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(wr_ddr_done == 1'b1) begin
            axi_wvalid <= 1'b0;
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 )begin
            axi_wvalid <= 1'b0;
        end
        else ;
        
    end    //wr_burst_cnt
    RD_TEN      : begin
        if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_arvalid <= 1'b0;
        end
        else if(wr_ddr_done_1dly == 1'b1) begin
            axi_arvalid <= 1'b1;
        end
        else if(axi_arvalid == 1'b0 && rd_req_cnt < REQ_LEN ) begin
            axi_arvalid <= 1'b1;
        end
        else;
        
        axi_awaddr <= {AXI_ADDR_WIDTH{1'b0}};
        if(rd_ddr_done_1dly == 1'b1) begin
            axi_araddr <= {AXI_ADDR_WIDTH{1'b0}};
        end
        else if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_araddr <= axi_araddr + ADDR_OFFSET;
        end
        else ;
       

        if(axi_rvalid == 1'b1 && axi_rdata != {ERR_LEN{16'haaaa}}) begin
            test_error <= 1'b1;
            test_error_state <= RD_TEN;
        end
        else;
 
    end
   
    WR_F        : begin
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awvalid <= 1'b0;
        end
        else if(rd_ddr_done_2dly == 1'b1) begin
            axi_awvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 && wr_burst_cnt < REQ_LEN) begin
            axi_awvalid <= 1'b1;
        end
        else ;

        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awaddr <= axi_awaddr + ADDR_OFFSET;
        end
        else ;
        //
        wr_nsetp_data <= {ERR_LEN{16'hFFFF}};
        if(rd_ddr_done_2dly == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(wr_ddr_done == 1'b1) begin
            axi_wvalid <= 1'b0;
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 )begin
            axi_wvalid <= 1'b0;
        end
        else ;
        
    end    //wr_burst_cnt
    RD_F        : begin
        if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_arvalid <= 1'b0;
        end
        else if(wr_ddr_done_1dly == 1'b1) begin
            axi_arvalid <= 1'b1;
        end
        else if(axi_arvalid == 1'b0 && rd_req_cnt < REQ_LEN ) begin
            axi_arvalid <= 1'b1;
        end
        else;
        
        axi_awaddr <= {AXI_ADDR_WIDTH{1'b0}};
        if(rd_ddr_done_1dly == 1'b1) begin
            axi_araddr <= {AXI_ADDR_WIDTH{1'b0}};
        end
        else if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_araddr <= axi_araddr + ADDR_OFFSET;
        end
        else ;
        
        if(axi_rvalid & test_error) begin
            test_err <= (axi_rdata_d1 ^ {ERR_LEN{16'hFFFF}});
        end
        else;

        if(axi_rvalid == 1'b1) begin
            rd_data_ff  <= axi_rdata[71:0];      
        end
        else;

        if(axi_rvalid == 1'b1 && axi_rdata != {ERR_LEN{16'hFFFF}}) begin
            //test_err <= (axi_rdata_d1 ^ {ERR_LEN{16'hFFFF}});
            test_error <= 1'b1;
            test_error_state <= RD_F;
        end
        else;
        
        if(rd_ddr_done_1dly == 1'b1) begin
            cycle_flag <= 1'b1;
        end
        else ;
        
    end
    
    WR_PRBS     : begin
        if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awvalid <= 1'b0;
        end
        else if(rd_prbs_done_2dly == 1'b1 || nine_step_cplt == 1'b1 | (curr_state_1dly==IDLE)) begin
            axi_awvalid <= 1'b1;
        end
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 && wr_prbs_burst_cnt < rpbs_burst_len) begin
            axi_awvalid <= 1'b1;
        end
        else ;
        
        if((axi_awaddr == AXI_END_ADDR) && (axi_awvalid == 1'b1) && (axi_awready == 1'b1)) begin
            axi_awaddr <= {AXI_ADDR_WIDTH{1'b0}};
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_awaddr <= axi_awaddr + ADDR_OFFSET;
        end
        else ;
        
        if(rd_prbs_done_2dly|| nine_step_cplt|wr_ddr_done_2dly) begin
            axi_wvalid <= 1'b1;
        end
        else if(wr_prbs_done == 1'b1) begin
            axi_wvalid <= 1'b0;
        end
        else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
            axi_wvalid <= 1'b1;
        end
        //else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1  && (!axi_awready))begin
        else if(axi_wlast == 1'b1 && axi_wready == 1'b1 && axi_wvalid == 1'b1 )begin
            axi_wvalid <= 1'b0;
        end
        else ;
        
    end
    RD_PRBS     : begin
        if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_arvalid <= 1'b0;
        end
        else if(wr_prbs_done_1dly |(curr_state_1dly==IDLE)) begin
            axi_arvalid <= 1'b1;
        end
        else if(axi_arvalid == 1'b0 && rd_prbs_req_cnt < rpbs_burst_len ) begin
            axi_arvalid <= 1'b1;
        end
        else;
        
        if((axi_araddr == AXI_END_ADDR) && (axi_arvalid == 1'b1) && (axi_arready == 1'b1)) begin
            axi_araddr <= {AXI_ADDR_WIDTH{1'b0}};
        end
        else if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
            axi_araddr <= axi_araddr + ADDR_OFFSET;
        end
        else ;
    end
    default:;
    endcase
    end
end

assign axi_wdata = prbs_flag ? prbs_wdata : wr_nsetp_data;

always @(posedge s_axi_aclk)
begin
    wr_ddr_done  <= (axi_wlast == 1'b1) && (axi_wready == 1'b1) && (axi_wvalid == 1'b1) && (wr_burst_cnt == REQ_LEN);
end
//assign wr_ddr_done  = (axi_wlast == 1'b1) && (axi_wready == 1'b1) && (axi_wvalid == 1'b1) && (wr_burst_cnt == REQ_LEN);
assign axi_wlast   = (wsize_cnt == axi_awlen);
always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        wsize_cnt   <= 8'h0;
    end
    else if((axi_wready == 1'b1) && (axi_wvalid == 1'b1) && (wsize_cnt == axi_awlen)) begin
        wsize_cnt   <= 8'h0;
    end
    else if((axi_wready == 1'b1) && (axi_wvalid == 1'b1))begin
        wsize_cnt   <= wsize_cnt + 1'b1;
    end
    else;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (s_axi_aresetn == 1'b0 ) begin
        wr_burst_cnt <= 32'h0;
    end
    else if(wr_ddr_done == 1'b1 || prbs_mode_start_pos == 1'b1) begin
        wr_burst_cnt <= 32'h0;
    end
    else if(axi_awvalid == 1'b1 && axi_awready == 1'b1) begin
        wr_burst_cnt  <= wr_burst_cnt + 1'b1; 
    end
    else;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (s_axi_aresetn == 1'b0 ) begin
        rd_req_cnt <= 32'h0;
    end
    else if(rd_ddr_done_2dly == 1'b1 || prbs_mode_start_pos == 1'b1) begin
        rd_req_cnt <= 32'h0;
    end
    else if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
        rd_req_cnt  <= rd_req_cnt + 1'b1; 
    end
    else;
end
always @(posedge s_axi_aclk)
begin
    rd_ddr_done <= axi_rlast_flag && (rd_back_cnt == REQ_LEN -1) ;
end
//assign rd_ddr_done = (axi_rvalid == 1'b1) && (axi_rlast == 1'b1) && (rd_back_cnt == REQ_LEN -1) ;

always @(posedge s_axi_aclk)
begin
    axi_rlast_flag <= axi_rvalid && axi_rlast;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (s_axi_aresetn == 1'b0 ) begin
        rd_back_cnt <= 32'h0;
    end
    else if(rd_ddr_done_2dly == 1'b1 || prbs_mode_start_pos == 1'b1) begin
        rd_back_cnt <= 32'h0;
    end
    else if(axi_rlast_flag) begin
        rd_back_cnt  <= rd_back_cnt + 1'b1; 
    end
    else ;
end


//prbs mode
always @(posedge s_axi_aclk)
begin
    wr_prbs_done <= (axi_wlast == 1'b1) && (axi_wready == 1'b1) && (axi_wvalid == 1'b1) && (wr_prbs_burst_cnt == rpbs_burst_len);
end
//assign wr_prbs_done = (axi_wlast == 1'b1) && (axi_wready == 1'b1) && (axi_wvalid == 1'b1) && (wr_prbs_burst_cnt == rpbs_burst_len);

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (s_axi_aresetn == 1'b0 ) begin
        wr_prbs_burst_cnt <= 32'h0;
    end
    else if(wr_prbs_done == 1'b1 || prbs_mode_start_pos == 1'b1) begin
        wr_prbs_burst_cnt <= 32'h0;
    end
    else if(axi_awvalid == 1'b1 && axi_awready == 1'b1 && (curr_state == WR_PRBS || curr_state == RD_PRBS)) begin
        wr_prbs_burst_cnt  <= wr_prbs_burst_cnt + 1'b1; 
    end
    else;
end

always @(posedge s_axi_aclk)
begin
    rd_prbs_done <= (axi_arready == 1'b1) && (axi_arvalid == 1'b1) && (rd_prbs_req_cnt == rpbs_burst_len - 1);
end
//assign rd_prbs_done = (axi_arready == 1'b1) && (axi_arvalid == 1'b1) && (rd_prbs_req_cnt == rpbs_burst_len - 1);
always @(posedge s_axi_aclk)
begin
    rd_prbs_done_d1 <= rd_prbs_done; 
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if (s_axi_aresetn == 1'b0 ) begin
        rd_prbs_req_cnt <= 32'h0;
    end
    else if(rd_prbs_done == 1'b1 || prbs_mode_start_pos == 1'b1) begin
        rd_prbs_req_cnt <= 32'h0;
    end
    else if(axi_arvalid == 1'b1 && axi_arready == 1'b1 && (curr_state == WR_PRBS || curr_state == RD_PRBS)) begin
        rd_prbs_req_cnt  <= rd_prbs_req_cnt + 1'b1; 
    end
    else;
end

assign curr_state_r = curr_state_1dly;
always @(posedge s_axi_aclk)
begin
    rd_ddr_done_1dly        <= rd_ddr_done          ;
    rd_ddr_done_2dly        <= rd_ddr_done_1dly     ;

    wr_ddr_done_1dly        <= wr_ddr_done          ;
    wr_ddr_done_2dly        <= wr_ddr_done_1dly     ;  

    prbs_mode_start_1dly    <= prbs_mode_start      ;
    prbs_mode_start_2dly    <= prbs_mode_start_1dly ;
    prbs_mode_start_3dly    <= prbs_mode_start_2dly ;
    prbs_mode_start_4dly    <= prbs_mode_start_3dly ;
    prbs_mode_start_5dly    <= prbs_mode_start_4dly ; 
    
    prbs_mode_start_pos_1dly<= prbs_mode_start_pos  ;

    prbs_mode_sel_1dly      <= prbs_mode_sel        ;
    prbs_mode_sel_2dly      <= prbs_mode_sel_1dly   ;
    prbs_mode_sel_3dly      <= prbs_mode_sel_2dly   ;
    
    rd_prbs_done_1dly       <= rd_prbs_done         ;
    rd_prbs_done_2dly       <= rd_prbs_done_1dly    ;
    
    wr_prbs_done_1dly       <= wr_prbs_done         ;
    curr_state_1dly         <= curr_state           ;
end


always @(posedge s_axi_aclk)
begin
    if(curr_state == RD_F  && rd_ddr_done_1dly == 1'b1 && cycle_flag == 1'b1) begin
        nine_step_cplt <= 1'b1;
    end
    else begin
        nine_step_cplt <= 1'b0;
    end
end


assign  prbs_mode_start_pos = prbs_mode_start_4dly == 1'b1 && prbs_mode_start_5dly == 1'b0;

wire [CH_NUM-1:0] ddr_prbs_gen_en;
wire        ddr_prbs_chk_en;

wire        bist_cmd_cplt               ;
reg         bist_cplt_timeout           ;
reg [31:0]  bist_cmd_cplt_cnt = 32'h0   ; //
assign  bist_cmd_cplt = rd_prbs_done == 1'b1 && prbs_mode_start_5dly == 1'b0 && curr_state == RD_PRBS;

always @(posedge s_axi_aclk)
begin
    if(bist_cmd_cplt == 1'b1) begin
        bist_cmd_cplt_cnt <= 31'd1;
    end
    else if(bist_cmd_cplt_cnt > BIST_CPLT_NUM) begin
        bist_cmd_cplt_cnt <= 31'h0;
    end
    else if(bist_cmd_cplt_cnt != 32'h0) begin
        bist_cmd_cplt_cnt <= bist_cmd_cplt_cnt + 1'b1;
    end
    else;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        bist_cplt_timeout <= 1'b0;
    end
    else if(bist_cmd_cplt_cnt > BIST_CPLT_NUM) begin
        bist_cplt_timeout <= 1'b1;
    end
    else begin
        bist_cplt_timeout <= 1'b0;    
    end
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        prbs_flag <= 1'b0;
    end
    else if(rd_ddr_done_1dly == 1'b1 && cycle_flag == 1'b1 && curr_state == RD_F) begin
        prbs_flag <= 1'b1;
    end
    else if(bist_cplt_timeout == 1'b1) begin
        prbs_flag <= 1'b0;
    end
    else;
end



assign ddr_prbs_gen_en      = (prbs_flag == 1'b1) ? {CH_NUM{axi_wvalid & axi_wready}} : {CH_NUM{1'b0}};
assign ddr_prbs_chk_en      = (prbs_flag == 1'b1) ? axi_rvalid : 1'b0;

////
assign  axi_bready  = 1'b1;
always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        wr_resp_ecnt <= 16'h0;
    end
    else if(axi_bresp != 2'b0 && axi_bvalid == 1'b1) begin
        wr_resp_ecnt <= wr_resp_ecnt + 1'b1;
    end
    else;
end
    
assign bist_err_flag = {test_error,prbs_err_flag};


always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        bist_running    <= 1'b0;
        bist_cplt       <= 1'b0;
    end
    else begin
        if(curr_state_r > IDLE ) begin
            bist_running <= 1'b1;
        end
        else begin
            bist_running <= 1'b0;
        end
        
        
        if(curr_state_r == IDLE ) begin
            bist_cplt <= 1'b1;
        end
        else begin
            bist_cplt <= 1'b0;
        end
    end
end

//wr_cycle_cnt
always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) begin
        wr_cycle_cnt <= 32'h0;
        rd_cycle_cnt <= 32'h0;
    end
    else begin
        if(axi_awvalid == 1'b1 && axi_awaddr == AXI_END_ADDR && axi_awready == 1'b1 ) begin
            wr_cycle_cnt <= wr_cycle_cnt + 1'b1;
        end
        else;

        if(axi_arvalid == 1'b1 && axi_araddr == AXI_END_ADDR && axi_arready == 1'b1 ) begin
            rd_cycle_cnt <= rd_cycle_cnt + 1'b1;
        end
        else;
        
    end
end

reg [31:0]  prbs_vld_cnt   = 32'h0 ;
wire    prbs_vld;
always @(posedge s_axi_aclk)
begin
    if(prbs_vld == 1'b1) begin
        prbs_vld_cnt <= prbs_vld_cnt + 1'b1;
    end
    else ;
end

//=======================================================
//  instance
//=======================================================
ddr_prbs_gen    
#(
    .AXI_DATA_WIDTH      (AXI_DATA_WIDTH    )
)
u_ddr_prbs_gen(
    .clk_sys             (s_axi_aclk        ), // Clock
    .reset               (~s_axi_aresetn    ), // Asynchronous reset active low
    .prbs_en             (ddr_prbs_gen_en   ),//
    .prbs_vld            (prbs_vld          ), // prbs valid 
    .prbs_data_o         (prbs_wdata        )  // prbs valid data
);

ddr_prbs_chk 
#(
    .AXI_DATA_WIDTH      (AXI_DATA_WIDTH    )
)
u_ddr_prbs_chk(
    .clk_sys             (s_axi_aclk        ),   // Clock
    .reset               (~s_axi_aresetn    ),   // Asynchronous reset active low
    .prbs_vld_i          (ddr_prbs_chk_en   ),   // prbs valid 
    .prbs_data_i         (axi_rdata         ),   // prbs valid data
    .stat_clr            (prbs_mode_start_pos),               // static clear signals
    .prbs_syn            (prbs_syn          ),   // prbs synchronous flag
    .prbs_err_flag       (prbs_err_flag     ),   // prbs error flag
    .prbs_rx_dcnt        (prbs_rx_dcnt      ),   // prbs receive data counter
    .prbs_rx_ecnt        (prbs_rx_ecnt      )    // prbs receive data error counter
);
//-------------------------------------------------------------------
//--DFX
//-------------------------------------------------------------------
reg     [127:0] wr_data_0/* synthesis keep */; 
reg     [127:0] wr_data_1/* synthesis keep */; 
reg     [127:0] wr_data_2/* synthesis keep */; 
reg     [127:0] wr_data_3/* synthesis keep */; 
reg             wr_en/* synthesis keep */;   
reg     [127:0] rd_data_0/* synthesis keep */; 
reg     [127:0] rd_data_1/* synthesis keep */; 
reg     [127:0] rd_data_2/* synthesis keep */; 
reg     [127:0] rd_data_3/* synthesis keep */; 
reg             rd_vld/* synthesis keep */;   

always @(posedge s_axi_aclk)
begin
  wr_data_0 <= axi_wdata[127:  0];
  wr_data_1 <= axi_wdata[255:128];
  wr_data_2 <= axi_wdata[383:256];
  wr_data_3 <= axi_wdata[511:384];
  wr_en     <= axi_wready & axi_wvalid;
  rd_data_0 <= axi_rdata[127:  0];
  rd_data_1 <= axi_rdata[255:128];
  rd_data_2 <= axi_rdata[383:256];
  rd_data_3 <= axi_rdata[511:384];
  rd_vld    <= axi_rvalid;            
end

reg [63:0] state_time ;

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) 
      state_time <= 64'h0;
    else if((curr_state == IDLE) & (~prbs_mode_start_5dly))
      state_time  <= 64'h0;
    else
      state_time  <= state_time + 1;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(s_axi_aresetn == 1'b0) 
      round_time <= 64'h0;
    else if(curr_state == IDLE)
      begin
        if(test_mode[0]&wr_prbs_done_1dly) 
          begin
            if(~prbs_mode_start_5dly)
              round_time <= state_time;
            else
              round_time <= round_time;
          end
        else if(test_mode[1]&rd_prbs_done_d1) 
          begin
            if(~prbs_mode_start_5dly)
              round_time <= state_time;
            else
              round_time <= round_time;
          end
        else if(rd_prbs_done_d1)
          round_time <= state_time;
        else
          round_time <= round_time;
      end
    else
      round_time <= round_time ;
end


always @(posedge s_axi_aclk)
begin
    if(~s_axi_aresetn)
        wr_data_cnt <= 32'h0;
    else if(prbs_mode_start_pos)
        wr_data_cnt <= 32'h0;
    else if(wr_en)
        wr_data_cnt <= wr_data_cnt + 1;
    else
        wr_data_cnt <= wr_data_cnt;
end

always @(posedge s_axi_aclk)
begin
    if(~s_axi_aresetn)
        rd_data_cnt <= 32'h0;
    else if(prbs_mode_start_pos)
        rd_data_cnt <= 32'h0;
    else if(rd_vld)
        rd_data_cnt <= rd_data_cnt + 1;
    else
        rd_data_cnt <= rd_data_cnt;
end

always @(posedge s_axi_aclk)
begin
  if(~s_axi_aresetn)
    rd_pkg_cnt <= 32'h0;
  else if(prbs_mode_start_pos)
    rd_pkg_cnt <= 32'h0;
  else if(axi_rlast_flag) 
    rd_pkg_cnt <= rd_pkg_cnt + 1;
  else
    rd_pkg_cnt <= rd_pkg_cnt;
end

endmodule
