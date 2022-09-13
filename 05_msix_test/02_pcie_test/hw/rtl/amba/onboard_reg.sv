// ***************************************************************************************
// Filename        :    onboard_reg.sv
// Projectname     :    AliDMA
// Author          :    yyc
// Date            :    2020-06-10
// Version         :    1.0
//
// Description     :    bridgeÃ¤Â¸ÂÃ¦ÂÂ¿Ã¦ÂµÂÃ¨Â¯ÂÃ©ÂÂ»Ã¨Â¾Â
// Parameter:
// Modification History
// Date            By            Revision        Change Description
// ---------------------------------------------------------------------------------------
// 2020-06-10      yyc           1.0             Original
// 2021-08-24      lry                           change the address and data width according to user logic code.
// ***************************************************************************************

module onboard_reg (
    input                               afu_pcie_core_clk               ,
    input                               afu_pcie_core_rst               ,
    //to qdma                   
    input                               afu_alite4_awvalid                ,
    output                              afu_alite4_awready                ,
    input      [ 63:0]                  afu_alite4_awaddr                 ,
    input                               afu_alite4_wvalid                 ,
    output                              afu_alite4_wready                 ,
    input      [ 63:0]                  afu_alite4_wdata                  ,
    input      [  7:0]                  afu_alite4_wstrb                  ,
    output reg                          afu_alite4_bvalid                 ,
    input                               afu_alite4_bready                 ,
    output     [  1:0]                  afu_alite4_bresp                  ,
    input                               afu_alite4_arvalid                ,
    output                              afu_alite4_arready                ,
    input      [ 63:0]                  afu_alite4_araddr                 ,
    output reg                          afu_alite4_rvalid                 ,
    input                               afu_alite4_rready                 ,
    output reg [ 63:0]                  afu_alite4_rdata                  ,
    output     [  1:0]                  afu_alite4_rresp                  ,
    // input                               hpi2qdma_rd                     ,
    // input                               hpi2qdma_wr                     ,
    // input       [ 31:0]                 hpi2qdma_addr                   ,
    // input       [ 31:0]                 hpi2qdma_wdata                  ,
    // output reg                          hpi2qdma_valid                  ,
    // output reg  [ 31:0]                 hpi2qdma_rdata                  ,
    //regs
    output      [ 31:0]                 reg_work_mode                   ,
    output                              reg_work_en                     ,
    output                              reg_work_stop                   ,

    output      [  7:0]                 reg_function_num                ,

    output reg                          fifo_wr_cmd_valid               ,
    output      [ 15:0]                 fifo_wr_cycle                   ,
    output      [ 63:0]                 fifo_wr_addr                    ,
    output      [ 15:0]                 fifo_wr_len                     ,
    output reg                          fifo_rd_cmd_valid               ,
    output      [ 15:0]                 fifo_rd_cycle                   ,
    output      [ 63:0]                 fifo_rd_addr                    ,
    output      [ 15:0]                 fifo_rd_len                     ,
    output                              fifo_rd_ren                     ,
    input       [511:0]                 fifo_rd_rdata                   ,
    input       [ 15:0]                 fifo_wr_cmd_num                 ,
    input       [ 15:0]                 fifo_rd_cmd_num                 ,
    input       [  1:0]                 fifo_status                     ,
    input       [ 63:0]                 fifo_wr_time_cost               ,
    input       [ 63:0]                 fifo_rd_time_cost               ,
    input       [ 63:0]                 fifo_wr_send_cnt                ,
    input       [ 63:0]                 fifo_rd_send_cnt                ,
    input       [ 31:0]                 fifo_rd_time_delay              ,
    input       [ 63:0]                 fifo_rd_total_time              ,
    output reg                          fifo_rd_data_storage            ,

    output reg                          copy_cmd_valid                  ,
    output      [ 63:0]                 copy_wr_addr                    ,
    output      [ 63:0]                 copy_rd_addr                    ,
    output      [ 31:0]                 copy_size                       ,
    output      [  1:0]                 copy_mode                       ,
    output      [ 11:0]                 copy_seed                       ,
    input       [  1:0]                 copy_status                     ,
    input       [ 31:0]                 copy_time_cost                  ,
    input       [  7:0]                 wr_cmd_fifo_stat                ,
    input       [  7:0]                 wr_data_fifo_stat               ,
    input       [  7:0]                 rd_cmd_fifo_stat                ,
    input       [  7:0]                 rd_random_fifo_stat             ,
    input       [  7:0]                 wr_strb_fifo_stat               ,
    input       [ 15:0]                 copy_gen_rd_cmd_cnt             ,
    input       [ 15:0]                 copy_wr_last_cnt                ,
    input       [ 15:0]                 axi_wr_cmd_cnt                  ,
    input       [ 15:0]                 axi_rd_cmd_cnt                  ,
    input       [ 31:0]                 axi_wr_burst_cnt                ,
    input       [ 31:0]                 axi_rd_burst_cnt                ,
    input       [ 31:0]                 stat 
);

//===================================================================
//  parameters
//===================================================================
    localparam  RSV                     = 32'h2020_0918;
    localparam  CMD_FIFO_MODE           = 32'h0;
    localparam  CMD_COPY_MODE           = 32'h1;
    localparam  WR_PFER_MODE            = 32'h2;
    localparam  RD_PFER_MODE            = 32'h3;


    //localparam  AFU_DFH                 = 64'h0000_0000_0000_0000;
    //localparam  AFU_ID_L                = 64'h0000_0000_0000_0008;
    //localparam  AFU_ID_H                = 64'h0000_0000_0000_0010;

    localparam  ADDR_AFU_DFH            = 16'h0000;
    localparam  ADDR_AFU_ID_L           = 16'h0008;
    localparam  ADDR_AFU_ID_H           = 16'h0010;
    localparam  ADDR_RSV                = 16'h0018;
    localparam  ADDR_WORK_MODE          = 16'h0020;
    localparam  ADDR_WORK_EN            = 16'h0028;
    localparam  ADDR_WORK_STOP          = 16'h0030;
    localparam  ADDR_WR_TEST_NUM        = 16'h0038;
    localparam  ADDR_WR_ADDR_H          = 16'h0040;
    localparam  ADDR_WR_ADDR_L          = 16'h0048;
    localparam  ADDR_WR_LEN             = 16'h0050;  
    localparam  ADDR_RD_TEST_NUM        = 16'h0058; 
    localparam  ADDR_RD_ADDR_H          = 16'h0060;
    localparam  ADDR_RD_ADDR_L          = 16'h0068;
    localparam  ADDR_RD_LEN             = 16'h0070;
    localparam  ADDR_FUNCTION_NUM       = 16'h0078;
    localparam  ADDR_RD_DATA_STORAGE    = 16'h0080;
    localparam  ADDR_RD_DATA_CLEAR      = 16'h0088;
    localparam  ADDR_RD_DATA            = 16'h0090;

    localparam  ADDR_FIFO_CMD_NUM       = 16'h0098; 
    localparam  ADDR_FIFO_STATUS        = 16'h00a0;
    localparam  ADDR_WR_TIME_COST_H     = 16'h00a8;
    localparam  ADDR_WR_TIME_COST_L     = 16'h00b0;
    localparam  ADDR_RD_TIME_COST_H     = 16'h00b8;
    localparam  ADDR_RD_TIME_COST_L     = 16'h00c0;
    localparam  ADDR_RD_TIME_DELAY      = 16'h00c8;
    localparam  ADDR_WR_SEND_CNT_H      = 16'h00d0;
    localparam  ADDR_WR_SEND_CNT_L      = 16'h00d8;
    localparam  ADDR_RD_SEND_CNT_H      = 16'h00e0;
    localparam  ADDR_RD_SEND_CNT_L      = 16'h00e8;
    localparam  ADDR_RD_TOTAL_TIME_H    = 16'h00f0;
    localparam  ADDR_RD_TOTAL_TIME_L    = 16'h00f8;

    localparam  ADDR_COPY_WR_ADDR_H     = 16'h0100;
    localparam  ADDR_COPY_WR_ADDR_L     = 16'h0108;
    localparam  ADDR_COPY_RD_ADDR_H     = 16'h0110;
    localparam  ADDR_COPY_RD_ADDR_L     = 16'h0118;
    localparam  ADDR_COPY_SIZE          = 16'h0120;
    localparam  ADDR_COPY_MODE          = 16'h0128;
    localparam  ADDR_COPY_SEED          = 16'h0130;
    localparam  ADDR_COPY_STATUS        = 16'h0138;
    localparam  ADDR_COPY_TIME_COST     = 16'h0140;
                                               
    localparam  ADDR_STAT               = 16'h0148;
    localparam  ADDR_FIFO_STAT_0        = 16'h0150;
    localparam  ADDR_FIFO_STAT_1        = 16'h0158;
    localparam  ADDR_FIFO_STAT_2        = 16'h0160;
    localparam  ADDR_FIFO_STAT_3        = 16'h0168;
    localparam  ADDR_FIFO_STAT          = 16'h0170;
    localparam  ADDR_COPY_CNT           = 16'h0178;
    localparam  ADDR_AXI_CMD_CNT        = 16'h0180;
    localparam  ADDR_AXI_WR_CNT         = 16'h0188;
    localparam  ADDR_AXI_RD_CNT         = 16'h0190;
    //===================================================================
    //  signals                                
    //===================================================================
    wire        [ 31:0]                 cfg_rsv1b0                      ;
    reg         [ 31:0]                 cfg_work_mode                   ;
    reg         [ 31:0]                 cfg_work_en                     ;
    reg         [ 31:0]                 cfg_work_stop                   ;
    reg         [ 31:0]                 cfg_function_num                ;
    reg         [ 31:0]                 cfg_wr_test_num                 ;
    reg         [ 31:0]                 cfg_wr_addr_H                   ;
    reg         [ 31:0]                 cfg_wr_addr_L                   ;
    reg         [ 31:0]                 cfg_wr_len                      ;
    reg         [ 31:0]                 cfg_rd_test_num                 ;
    reg         [ 31:0]                 cfg_rd_addr_H                   ;
    reg         [ 31:0]                 cfg_rd_addr_L                   ;
    reg         [ 31:0]                 cfg_rd_len                      ;
    //status [0]rd done; [1]wr done; [2]wr_cmd_fifo_empty [3]wr_data_fifo_empty [4]rd_cmd_fifo_empty [5]rd_data_fifo_empty
    reg         [ 31:0]                 cfg_wr_time_cost                ;
    reg         [ 31:0]                 cfg_rd_time_cost                ;
    reg         [ 31:0]                 cfg_rd_time_delay               ;
    wire        [ 31:0]                 cfg_rd_data                     ;

    reg         [ 31:0]                 cfg_copy_wr_addr_H              ;
    reg         [ 31:0]                 cfg_copy_wr_addr_L              ;
    reg         [ 31:0]                 cfg_copy_rd_addr_H              ;
    reg         [ 31:0]                 cfg_copy_rd_addr_L              ;
    reg         [ 31:0]                 cfg_copy_size                   ;
    reg         [ 31:0]                 cfg_copy_mode                   ;
    reg         [ 31:0]                 cfg_copy_seed                   ;
    //inner
    reg         [ 15:0]                 rd_fifo_ren_cnt                 ;
    reg         [511:0]                 rd_fifo_data                    ;
    reg                                 rd_data_en                      ;
    reg         [  3:0]                 rd_status_dly                   ;
    reg         [ 31:0]                 afu_alite4_awaddr_dly           ;
    reg         [ 15:0]                 axi_wr_cmd_fifo_overflow        ;
    reg         [ 15:0]                 axi_wr_cmd_fifo_underflow       ;
    reg         [ 15:0]                 axi_rd_cmd_fifo_overflow        ;
    reg         [ 15:0]                 axi_rd_cmd_fifo_underflow       ;
    reg         [ 15:0]                 axi_wr_data_fifo_overflow       ;
    reg         [ 15:0]                 axi_wr_data_fifo_underflow      ;
    reg         [ 15:0]                 axi_rd_random_fifo_overflow     ;
    reg         [ 15:0]                 axi_rd_random_fifo_underflow    ;

    reg         [ 63:0]                 userCD_DFH                      ;
    wire        [127:0]                 userCD_UUID                     ;

    assign cfg_rsv                      = RSV                           ;

    assign afu_alite4_awready             = 1'b1                          ;
    assign afu_alite4_wready              = 1'b1                          ;
    assign afu_alite4_arready             = 1'b1                          ;
    assign afu_alite4_bresp               = 2'b00                         ;
    assign afu_alite4_rresp               = 2'b00                         ;

    assign reg_work_mode                = cfg_work_mode                 ;
    assign reg_work_en                  = (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WORK_EN   && afu_alite4_wdata[0]) || (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WORK_EN   && afu_alite4_wdata[0]);
    assign reg_work_stop                = (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WORK_STOP && afu_alite4_wdata[0]) || (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WORK_STOP && afu_alite4_wdata[0]);
    assign reg_function_num             = cfg_function_num[7:0];
    assign fifo_wr_cycle                = cfg_wr_test_num[15:0];
    assign fifo_wr_addr                 = {cfg_wr_addr_H, cfg_wr_addr_L};
    assign fifo_wr_len                  = cfg_wr_len[15:0];
    assign fifo_rd_cycle                = cfg_rd_test_num[15:0];
    assign fifo_rd_addr                 = {cfg_rd_addr_H, cfg_rd_addr_L};
    assign fifo_rd_len                  = cfg_rd_len[15:0];
    assign copy_wr_addr                 = {cfg_copy_wr_addr_H, cfg_copy_wr_addr_L};
    assign copy_rd_addr                 = {cfg_copy_rd_addr_H, cfg_copy_rd_addr_L};
    assign copy_size                    = cfg_copy_size;
    assign copy_mode                    = cfg_copy_mode[1:0];
    assign copy_seed                    = cfg_copy_seed[11:0];
    assign fifo_rd_ren                  = rd_fifo_ren_cnt[3:0]==4'hf && afu_alite4_arvalid && afu_alite4_araddr[15:0]==ADDR_RD_DATA || afu_alite4_awvalid && afu_alite4_awaddr[15:0]==ADDR_RD_DATA_CLEAR;

//DFH
    function [63:0] zz_userCD_DFH(input dummy);
      begin
        zz_userCD_DFH = 64'h0;
        zz_userCD_DFH[60] = 1'b1;
        zz_userCD_DFH[40] = 1'b1;
      end
    endfunction
    wire [63:0] _zz_1;
    assign _zz_1 = zz_userCD_DFH(1'b0);
    always @(*) userCD_DFH = _zz_1;
//DFH

//uid
    assign userCD_UUID = 128'h6666_954a_9b91_4a37_abc1_1d9f_0709_6666;
//uid
       
    always @(posedge afu_pcie_core_clk) begin
        if (afu_alite4_awvalid) begin
            afu_alite4_awaddr_dly         <= afu_alite4_awaddr;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        afu_alite4_bvalid                 <= afu_alite4_wvalid;
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_work_mode               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WORK_MODE) begin
            cfg_work_mode               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WORK_MODE) begin
            cfg_work_mode               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_function_num            <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_FUNCTION_NUM) begin
            cfg_function_num            <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_FUNCTION_NUM) begin
            cfg_function_num            <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_work_en                 <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WORK_EN) begin
            cfg_work_en                 <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WORK_EN) begin
            cfg_work_en                 <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_work_stop               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WORK_STOP) begin
            cfg_work_stop               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WORK_STOP) begin
            cfg_work_stop               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_wr_test_num             <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WR_TEST_NUM) begin
            cfg_wr_test_num               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WR_TEST_NUM) begin
            cfg_wr_test_num             <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_wr_addr_H               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WR_ADDR_H) begin
            cfg_wr_addr_H               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WR_ADDR_H) begin
            cfg_wr_addr_H               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_wr_addr_L               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WR_ADDR_L) begin
            cfg_wr_addr_L               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WR_ADDR_L) begin
            cfg_wr_addr_L               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_wr_len                  <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WR_LEN) begin
            cfg_wr_len                  <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WR_LEN) begin
            cfg_wr_len                  <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_rd_test_num            <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_RD_TEST_NUM) begin
            cfg_rd_test_num            <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_RD_TEST_NUM) begin
            cfg_rd_test_num            <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_rd_addr_H               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_RD_ADDR_H) begin
            cfg_rd_addr_H               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_RD_ADDR_H) begin
            cfg_rd_addr_H               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_rd_addr_L               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_RD_ADDR_L) begin
            cfg_rd_addr_L               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_RD_ADDR_L) begin
            cfg_rd_addr_L               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_rd_len                  <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_RD_LEN) begin
            cfg_rd_len                  <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_RD_LEN) begin
            cfg_rd_len                  <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_wr_addr_H          <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_WR_ADDR_H) begin
            cfg_copy_wr_addr_H          <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_WR_ADDR_H) begin
            cfg_copy_wr_addr_H          <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_wr_addr_L          <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_WR_ADDR_L) begin
            cfg_copy_wr_addr_L          <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_WR_ADDR_L) begin
            cfg_copy_wr_addr_L          <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_rd_addr_H          <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_RD_ADDR_H) begin
            cfg_copy_rd_addr_H          <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_RD_ADDR_H) begin
            cfg_copy_rd_addr_H          <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_rd_addr_L          <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_RD_ADDR_L) begin
            cfg_copy_rd_addr_L          <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_RD_ADDR_L) begin
            cfg_copy_rd_addr_L          <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_size               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_SIZE) begin
            cfg_copy_size               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_SIZE) begin
            cfg_copy_size               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            fifo_rd_data_storage        <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_RD_DATA_STORAGE) begin
            fifo_rd_data_storage        <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_RD_DATA_STORAGE) begin
            fifo_rd_data_storage        <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_mode               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_MODE) begin
            cfg_copy_mode               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_MODE) begin
            cfg_copy_mode               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cfg_copy_seed               <= 32'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_SEED) begin
            cfg_copy_seed               <= afu_alite4_wdata;
        end
        else if (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_COPY_SEED) begin
            cfg_copy_seed               <= afu_alite4_wdata;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        rd_status_dly[0]                <= fifo_status[0];
        rd_status_dly[3:1]              <= rd_status_dly[2:0];
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            rd_fifo_ren_cnt             <= 16'h0;
        end
        else if (afu_alite4_awvalid && afu_alite4_awaddr[15:0]==ADDR_RD_DATA_CLEAR) begin
            rd_fifo_ren_cnt             <= 16'h0;
        end
        else if (afu_alite4_arvalid && afu_alite4_araddr[15:0]==ADDR_RD_DATA) begin
            rd_fifo_ren_cnt             <= rd_fifo_ren_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        rd_data_en                      <= afu_alite4_arvalid && afu_alite4_araddr[15:0]==ADDR_RD_DATA;
        if (~rd_status_dly[3]) begin
            rd_fifo_data                <= fifo_rd_rdata;
        end
        else if (rd_data_en && rd_fifo_ren_cnt[3:0]==0) begin
            rd_fifo_data                <= fifo_rd_rdata;
        end
        else if (rd_data_en) begin
            rd_fifo_data                <= {32'h0, rd_fifo_data[511:32]};
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            afu_alite4_rvalid             <= 1'b0;
        end
        else if (afu_alite4_arvalid) begin
            afu_alite4_rvalid             <= 1'b1;
        end
        else begin
            afu_alite4_rvalid             <= 1'b0;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        case(afu_alite4_araddr[15:0])
            ADDR_AFU_DFH        : afu_alite4_rdata   <= userCD_DFH            ;
            ADDR_AFU_ID_L       : afu_alite4_rdata   <= userCD_UUID[63:0]     ;
            ADDR_AFU_ID_H       : afu_alite4_rdata   <= userCD_UUID[127:64]   ;
            ADDR_RSV            : afu_alite4_rdata   <= cfg_rsv               ;
            ADDR_WORK_MODE      : afu_alite4_rdata   <= cfg_work_mode         ;
            ADDR_WORK_EN        : afu_alite4_rdata   <= cfg_work_en           ;
            ADDR_WORK_STOP      : afu_alite4_rdata   <= cfg_work_stop         ;
            ADDR_FUNCTION_NUM   : afu_alite4_rdata   <= cfg_function_num      ;
            ADDR_WR_TEST_NUM    : afu_alite4_rdata   <= cfg_wr_test_num       ;
            ADDR_WR_ADDR_H      : afu_alite4_rdata   <= cfg_wr_addr_H         ;
            ADDR_WR_ADDR_L      : afu_alite4_rdata   <= cfg_wr_addr_L         ;
            ADDR_WR_LEN         : afu_alite4_rdata   <= cfg_wr_len            ;
            ADDR_RD_TEST_NUM    : afu_alite4_rdata   <= cfg_rd_test_num       ;
            ADDR_RD_ADDR_H      : afu_alite4_rdata   <= cfg_rd_addr_H         ;
            ADDR_RD_ADDR_L      : afu_alite4_rdata   <= cfg_rd_addr_L         ;
            ADDR_RD_LEN         : afu_alite4_rdata   <= cfg_rd_len            ;
            ADDR_RD_DATA        : afu_alite4_rdata   <= rd_fifo_data[31:0]    ;
            ADDR_FIFO_CMD_NUM   : afu_alite4_rdata   <= {fifo_rd_cmd_num, fifo_wr_cmd_num};
            ADDR_FIFO_STATUS    : afu_alite4_rdata   <= {30'h0, fifo_status}  ;
            ADDR_WR_TIME_COST_H : afu_alite4_rdata   <= fifo_wr_time_cost[63:32]  ;
            ADDR_WR_TIME_COST_L : afu_alite4_rdata   <= fifo_wr_time_cost[31:0]   ;
            ADDR_RD_TIME_COST_H : afu_alite4_rdata   <= fifo_rd_time_cost[63:32]  ;
            ADDR_RD_TIME_COST_L : afu_alite4_rdata   <= fifo_rd_time_cost[31:0]   ;
            ADDR_WR_SEND_CNT_H  : afu_alite4_rdata   <= fifo_wr_send_cnt[63:32]   ;
            ADDR_WR_SEND_CNT_L  : afu_alite4_rdata   <= fifo_wr_send_cnt[31:0]    ;
            ADDR_RD_SEND_CNT_H  : afu_alite4_rdata   <= fifo_rd_send_cnt[63:32]   ;
            ADDR_RD_SEND_CNT_L  : afu_alite4_rdata   <= fifo_rd_send_cnt[31:0]    ;
            ADDR_RD_TIME_DELAY  : afu_alite4_rdata   <= fifo_rd_time_delay    ;
            ADDR_RD_TOTAL_TIME_H: afu_alite4_rdata   <= fifo_rd_total_time[63:32] ;
            ADDR_RD_TOTAL_TIME_L: afu_alite4_rdata   <= fifo_rd_total_time[31:0]  ;
            ADDR_COPY_WR_ADDR_H : afu_alite4_rdata   <= cfg_copy_wr_addr_H    ;
            ADDR_COPY_WR_ADDR_L : afu_alite4_rdata   <= cfg_copy_wr_addr_L    ;
            ADDR_COPY_RD_ADDR_H : afu_alite4_rdata   <= cfg_copy_rd_addr_H    ;
            ADDR_COPY_RD_ADDR_L : afu_alite4_rdata   <= cfg_copy_rd_addr_L    ;
            ADDR_COPY_SIZE      : afu_alite4_rdata   <= cfg_copy_size         ;
            ADDR_COPY_MODE      : afu_alite4_rdata   <= cfg_copy_mode         ;
            ADDR_COPY_SEED      : afu_alite4_rdata   <= cfg_copy_seed         ;
            ADDR_COPY_STATUS    : afu_alite4_rdata   <= {30'h0, copy_status}  ;
            ADDR_COPY_TIME_COST : afu_alite4_rdata   <= copy_time_cost        ;
            ADDR_RD_DATA_STORAGE: afu_alite4_rdata   <= {31'h0, fifo_rd_data_storage};
            ADDR_STAT           : afu_alite4_rdata   <= stat                  ;
            ADDR_FIFO_STAT_0    : afu_alite4_rdata   <= {axi_wr_cmd_fifo_overflow, axi_wr_cmd_fifo_underflow};
            ADDR_FIFO_STAT_1    : afu_alite4_rdata   <= {axi_rd_cmd_fifo_overflow, axi_rd_cmd_fifo_underflow};
            ADDR_FIFO_STAT_2    : afu_alite4_rdata   <= {axi_wr_data_fifo_overflow, axi_wr_data_fifo_underflow};
            ADDR_FIFO_STAT_3    : afu_alite4_rdata   <= {wr_strb_fifo_stat};
            ADDR_FIFO_STAT      : afu_alite4_rdata   <= {rd_random_fifo_stat, wr_data_fifo_stat, rd_cmd_fifo_stat, wr_cmd_fifo_stat};
            ADDR_COPY_CNT       : afu_alite4_rdata   <= {copy_gen_rd_cmd_cnt, copy_wr_last_cnt};
            ADDR_AXI_CMD_CNT    : afu_alite4_rdata   <= {axi_rd_cmd_cnt, axi_wr_cmd_cnt};
            ADDR_AXI_WR_CNT     : afu_alite4_rdata   <= {axi_wr_burst_cnt};
            ADDR_AXI_RD_CNT     : afu_alite4_rdata   <= {axi_rd_burst_cnt};
            default             : afu_alite4_rdata   <= 32'hdead              ;
        endcase
    end

    always @(posedge afu_pcie_core_clk) begin
        fifo_wr_cmd_valid               <= (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_WR_TEST_NUM && afu_alite4_wdata!=0) || (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_WR_TEST_NUM && afu_alite4_wdata!=0);
        fifo_rd_cmd_valid               <= (afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr[15:0]==ADDR_RD_TEST_NUM && afu_alite4_wdata!=0) || (~afu_alite4_awvalid && afu_alite4_wvalid && afu_alite4_awaddr_dly[15:0]==ADDR_RD_TEST_NUM && afu_alite4_wdata!=0);
        copy_cmd_valid                  <= afu_alite4_awvalid && afu_alite4_awaddr[15:0]==ADDR_COPY_MODE;
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_wr_cmd_fifo_overflow    <= 16'h0;
        end
        else if (wr_cmd_fifo_stat[5]) begin
            axi_wr_cmd_fifo_overflow    <= axi_wr_cmd_fifo_overflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_wr_cmd_fifo_underflow   <= 16'h0;
        end
        else if (wr_cmd_fifo_stat[4]) begin
            axi_wr_cmd_fifo_underflow   <= axi_wr_cmd_fifo_underflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_rd_cmd_fifo_overflow    <= 16'h0;
        end
        else if (rd_cmd_fifo_stat[5]) begin
            axi_rd_cmd_fifo_overflow    <= axi_rd_cmd_fifo_overflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_rd_cmd_fifo_underflow   <= 16'h0;
        end
        else if (rd_cmd_fifo_stat[4]) begin
            axi_rd_cmd_fifo_underflow   <= axi_rd_cmd_fifo_underflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_wr_data_fifo_overflow   <= 16'h0;
        end
        else if (wr_data_fifo_stat[5]) begin
            axi_wr_data_fifo_overflow   <= axi_wr_data_fifo_overflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_wr_data_fifo_underflow  <= 16'h0;
        end
        else if (wr_data_fifo_stat[4]) begin
            axi_wr_data_fifo_underflow  <= axi_wr_data_fifo_underflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_rd_random_fifo_overflow <= 16'h0;
        end
        else if (rd_random_fifo_stat[5]) begin
            axi_rd_random_fifo_overflow <= axi_rd_random_fifo_overflow + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_rd_random_fifo_underflow<= 16'h0;
        end
        else if (rd_random_fifo_stat[4]) begin
            axi_rd_random_fifo_underflow<= axi_rd_random_fifo_underflow + 1'b1;
        end
    end

endmodule

