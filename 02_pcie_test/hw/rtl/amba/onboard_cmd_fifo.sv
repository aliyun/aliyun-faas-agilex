// ***************************************************************************************
// Filename        :    onboard_cmd_fifo.sv
// Projectname     :    AliDMA
// Author          :    yyc

// Date            :    2020-06-10
// Version         :    1.0
//
// Description     :    bridgeÉÏ°å²âÊÔÂß¼­
// Parameter:
// Modification History
// Date            By            Revision        Change Description
// ---------------------------------------------------------------------------------------
// 2020-06-10      yyc           1.0             Original
//
// ***************************************************************************************

module onboard_cmd_fifo #(
    parameter VENDER_ID                 = "Intel"                   ,
    parameter DEVICE_ID                 = "Agilex"                  , 
    parameter BRAM_TYPE                 = "M20K"                    ,
    parameter FIFO_PARITY               = "FALSE"                   ,
    parameter PARITY_DLY                = "FALSE"                   
) (
    input                               afu_pcie_core_clk               ,
    input                               afu_pcie_core_rst               ,
    input       [ 31:0]                 reg_work_mode                   ,
    input                               reg_work_en                     ,
    input                               reg_work_stop                   ,
    input       [  7:0]                 reg_function_num                ,
    input       [ 11:0]                 copy_seed                       ,
    //config
    input                               fifo_wr_cmd_valid               ,
    input       [ 15:0]                 fifo_wr_cycle                   ,
    input       [ 63:0]                 fifo_wr_addr                    ,
    input       [ 15:0]                 fifo_wr_len                     ,
    input                               fifo_rd_cmd_valid               ,
    input       [ 15:0]                 fifo_rd_cycle                   ,
    input       [ 63:0]                 fifo_rd_addr                    ,
    input       [ 15:0]                 fifo_rd_len                     ,
    input                               fifo_rd_ren                     ,
    output      [511:0]                 fifo_rd_rdata                   ,
    output      [ 15:0]                 fifo_wr_cmd_num                 ,
    output      [ 15:0]                 fifo_rd_cmd_num                 ,
    output      [  1:0]                 fifo_status                     ,
    output reg  [ 63:0]                 fifo_wr_time_cost               ,
    output reg  [ 63:0]                 fifo_rd_time_cost               ,
    output reg  [ 63:0]                 fifo_wr_send_cnt                ,
    output reg  [ 63:0]                 fifo_rd_send_cnt                ,
    output reg  [ 31:0]                 fifo_rd_time_delay              ,
    output reg  [ 63:0]                 fifo_rd_total_time              ,
    input                               fifo_rd_data_storage            ,
    //axi
    output                              wr_cmd_fifo_valid               ,
    output      [143:0]                 wr_cmd_fifo_data                ,
    input                               wr_cmd_fifo_afull               ,
    output                              wr_data_fifo_valid              ,
    output      [513:0]                 wr_data_fifo_data               ,
    input                               wr_data_fifo_afull              ,
    output                              rd_cmd_fifo_valid               ,
    output      [143:0]                 rd_cmd_fifo_data                ,
    input                               rd_cmd_fifo_afull               ,
    input                               axi_rd_data_valid               ,
    input       [512:0]                 axi_rd_data                     ,
    output      [ 11:0]                 stat 
    );

//===================================================================
//  parameters
//===================================================================
    localparam  CMD_FIFO_MODE           = 32'h0                         ;
    localparam  CMD_COPY_MODE           = 32'h1                         ;
    localparam  WR_PERF_MODE            = 32'h2                         ;
    localparam  RD_PERF_MODE            = 32'h3                         ;
    localparam  WR_PERF_RAN_MODE        = 32'h4                         ;
    localparam  RD_PERF_RAN_MODE        = 32'h5                         ;
    localparam  RD_PERF_INC_MODE        = 32'h7                         ;
    localparam  RDWR_PERF_MODE          = 32'h8                         ;
    localparam  IDLE_W                  = 6'b000001                     ;
    localparam  WR_CMD                  = 6'b000010                     ;
    localparam  WR_DATA                 = 6'b000100                     ;
    localparam  WR_WAIT                 = 6'b001000                     ;
    localparam  PFER_WR_CMD             = 6'b010000                     ;
    localparam  PFER_WR_DATA            = 6'b100000                     ;
    localparam  IDLE_R                  = 4'b0001                       ;
    localparam  RD_CMD                  = 4'b0010                       ;
    localparam  RD_WAIT                 = 4'b0100                       ;
    localparam  PFER_RD_CMD             = 4'b1000                       ;
//===================================================================
//  signals
//===================================================================
    reg     [  5:0]                     w_cur_state                     ;
    reg     [  5:0]                     w_nxt_state                     ;
    reg     [  3:0]                     r_cur_state                     ;
    reg     [  3:0]                     r_nxt_state                     ;
    wire                                st_idle_w                       ;
    wire                                st_wr_cmd                       ;
    wire                                st_wr_data                      ;
    wire                                st_wr_wait                      ;
    wire                                st_pfer_wr_cmd                  ;
    wire                                st_pfer_wr_data                 ;
    wire                                st_idle_r                       ;
    wire                                st_rd_cmd                       ;
    wire                                st_rd_wait                      ;
    wire                                st_pfer_rd_cmd                  ;

    wire        [  7:0]                 wr_cmd_burst_len                ;
    wire                                wr_cmd_fifo_wen                 ;
    wire        [143:0]                 wr_cmd_fifo_wdata               ;
    wire                                wr_cmd_fifo_empty               ;
    wire        [  9:0]                 wr_cmd_fifo_usedw               ;
    wire                                wr_cmd_fifo_ren                 ;
    wire        [143:0]                 wr_cmd_fifo_rdata               ;
    wire                                rd_cmd_fifo_wen                 ;
    wire        [143:0]                 rd_cmd_fifo_wdata               ;
    wire                                rd_cmd_fifo_empty               ;
    wire        [  9:0]                 rd_cmd_fifo_usedw               ;
    wire                                rd_cmd_fifo_ren                 ;
    wire        [143:0]                 rd_cmd_fifo_rdata               ;
    wire                                rd_data_fifo_empty              ;
    wire        [  9:0]                 rd_data_fifo_usedw              ;

    wire        [ 63:0]                 wr_addr_start                   ;
    wire        [ 63:0]                 wr_addr_end                     ;
    reg         [ 15:0]                 wr_target_cycle                 ;
    reg         [ 15:0]                 wr_target_len                   ;
    reg         [ 63:0]                 wr_target_addr                  ;
    reg         [ 15:0]                 wr_burst_len                    ;
    reg         [ 15:0]                 wr_cmd_time_cnt                 ;
    reg         [ 15:0]                 wr_data_burst_cnt               ;
    reg         [ 15:0]                 rd_target_cycle                 ;
    reg         [ 15:0]                 rd_target_len                   ;
    reg         [ 63:0]                 rd_target_addr                  ;
    reg         [ 15:0]                 rd_cmd_time_cnt                 ;
    reg         [ 63:0]                 rd_cmd_send_cnt                 ;
    reg         [ 63:0]                 rd_cmd_recv_cnt                 ;
    reg                                 st_delay                        ;
    reg                                 rd_done                         ;
    reg         [  4:0]                 reg_work_en_dly                 ;

    reg                                 stop_lock                       ;
    wire        [ 11:0]                 cfg_copy_seed                   ;
    wire                                lfsr_seed_enable                ;
    wire                                lfsr_enable                     ;
    wire        [ 11:0]                 lfsr_o                          ;
    reg         [  7:0]                 wr_pfer_burst_len               ;
    reg         [  7:0]                 wr_pfer_burst_cnt               ;
    reg                                 wr_pfer_turn_flag               ;
    reg         [ 19:0]                 rd_pfer_turn_flag               ;
    wire        [ 19:0]                 rd_pfer_turn_flag_left          ;

//===================================================================
//  cmd input
//===================================================================

    assign cfg_copy_seed                = (copy_seed==12'h0) ? 12'h1 : copy_seed;
    assign lfsr_seed_enable             = reg_work_en;
    assign lfsr_enable                  = st_pfer_wr_cmd || st_pfer_rd_cmd;
    assign wr_addr_end                  = fifo_wr_addr[63:0] + fifo_wr_len[15:0] - 1;
    assign wr_cmd_burst_len             = wr_addr_end[63:6] - fifo_wr_addr[63:6] + 1;
    assign wr_cmd_fifo_wen              = fifo_wr_cmd_valid && reg_work_mode==CMD_FIFO_MODE;
    assign wr_cmd_fifo_wdata            = {wr_cmd_burst_len, fifo_wr_cycle, fifo_wr_len, fifo_wr_addr};
    assign fifo_wr_cmd_num              = {6'h0, wr_cmd_fifo_usedw};
    assign rd_cmd_fifo_wen              = fifo_rd_cmd_valid && reg_work_mode==CMD_FIFO_MODE;
    assign rd_cmd_fifo_wdata            = {fifo_rd_cycle, fifo_rd_len, fifo_rd_addr};
    assign fifo_rd_cmd_num              = {6'h0, rd_cmd_fifo_usedw};
    assign stat                         = {rd_cmd_fifo_empty, wr_cmd_fifo_empty, r_cur_state, w_cur_state};

    sfifo_cbb_enc   #(
        .VENDER_ID                      ( VENDER_ID                 ),   //Altera or Xilinx or Lattice
        .DEVICE_ID                      ( DEVICE_ID                 ),   //
        .BRAM_TYPE                      ( BRAM_TYPE                 ),   //
        .FIFO_PARITY                    ( FIFO_PARITY               ),   //"TRUE" or "FALSE"
        .PARITY_DLY                     ( PARITY_DLY                ),   //"TRUE" or "FALSE"
        .FIFO_DO_REG                    ( 1                         ),   //0-rdata output no reg,1-use reg and no delay.
        .RAM_DO_REG                     ( 1                         ),   //0-rdata output no reg,1-use blockram inter_reg of 1 delay.
        .FIFO_ATTR                      ( "ahead"                   ),   //normal or ahead
        .FIFO_WIDTH                     ( 144                       ),   //
        .FIFO_DEEP                      ( 9                         ),   //2**M
        .AFULL_OVFL_THD                 ( 448                       ),   //afull set threshold. afull=1,used>=SET_THD.
        .AFULL_UNFL_THD                 ( 448                       ),   //afull clear threshold. afull=0,used<CLR_THD.
        .AEMPTY_THD                     ( 2                         )    //aempty =1, used=<THD;else 0.

    ) wr_cmd_fifo ( 
        .clk_sys                        ( afu_pcie_core_clk             ),   //i1:
        .reset                          ( afu_pcie_core_rst             ),   //i1:
        .wen                            ( wr_cmd_fifo_wen           ),   //i1:
        .wdata                          ( wr_cmd_fifo_wdata         ),   //i[FIFO_WIDTH]:
        .ren                            ( wr_cmd_fifo_ren           ),   //i1:
        .rdata                          ( wr_cmd_fifo_rdata         ),   //o[FIFO_WIDTH]:
        .full                           (                           ),   //o1:
        .empty                          ( wr_cmd_fifo_empty         ),   //o1:
        .usedw                          ( wr_cmd_fifo_usedw         ),   //o[FIFO_DEEP]:
        .afull                          (                           ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      (                           )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
    );
 
    sfifo_cbb_enc   #(
        .VENDER_ID                      ( VENDER_ID                 ),   //Altera or Xilinx or Lattice
        .DEVICE_ID                      ( DEVICE_ID                 ),   //
        .BRAM_TYPE                      ( BRAM_TYPE                 ),   //
        .FIFO_PARITY                    ( FIFO_PARITY               ),   //"TRUE" or "FALSE"
        .PARITY_DLY                     ( PARITY_DLY                ),   //"TRUE" or "FALSE"
        .FIFO_DO_REG                    ( 1                         ),   //0-rdata output no reg,1-use reg and no delay.
        .RAM_DO_REG                     ( 1                         ),   //0-rdata output no reg,1-use blockram inter_reg of 1 delay.
        .FIFO_ATTR                      ( "ahead"                   ),   //normal or ahead
        .FIFO_WIDTH                     ( 144                       ),   //
        .FIFO_DEEP                      ( 9                         ),   //2**M
        .AFULL_OVFL_THD                 ( 448                       ),   //afull set threshold. afull=1,used>=SET_THD.
        .AFULL_UNFL_THD                 ( 448                       ),   //afull clear threshold. afull=0,used<CLR_THD.
        .AEMPTY_THD                     ( 2                         )    //aempty =1, used=<THD;else 0.

    ) rd_cmd_fifo ( 
        .clk_sys                        ( afu_pcie_core_clk             ),   //i1:
        .reset                          ( afu_pcie_core_rst             ),   //i1:
        .wen                            ( rd_cmd_fifo_wen           ),   //i1:
        .wdata                          ( rd_cmd_fifo_wdata         ),   //i[FIFO_WIDTH]:
        .ren                            ( rd_cmd_fifo_ren           ),   //i1:
        .rdata                          ( rd_cmd_fifo_rdata         ),   //o[FIFO_WIDTH]:
        .full                           (                           ),   //o1:
        .empty                          ( rd_cmd_fifo_empty         ),   //o1:
        .usedw                          ( rd_cmd_fifo_usedw         ),   //o[FIFO_DEEP]:
        .afull                          (                           ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      (                           )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
    );

    sfifo_cbb_enc   #(
        .VENDER_ID                      ( VENDER_ID                 ),   //Altera or Xilinx or Lattice
        .DEVICE_ID                      ( DEVICE_ID                 ),   //
        .BRAM_TYPE                      ( BRAM_TYPE                 ),   //
        .FIFO_PARITY                    ( FIFO_PARITY               ),   //"TRUE" or "FALSE"
        .PARITY_DLY                     ( PARITY_DLY                ),   //"TRUE" or "FALSE"
        .FIFO_DO_REG                    ( 1                         ),   //0-rdata output no reg,1-use reg and no delay.
        .RAM_DO_REG                     ( 1                         ),   //0-rdata output no reg,1-use blockram inter_reg of 1 delay.
        .FIFO_ATTR                      ( "ahead"                   ),   //normal or ahead
        .FIFO_WIDTH                     ( 512                       ),   //
        .FIFO_DEEP                      ( 10                        ),   //2**M
        .AFULL_OVFL_THD                 ( 448                       ),   //afull set threshold. afull=1,used>=SET_THD.
        .AFULL_UNFL_THD                 ( 448                       ),   //afull clear threshold. afull=0,used<CLR_THD.
        .AEMPTY_THD                     ( 2                         )    //aempty =1, used=<THD;else 0.

    ) rd_data_fifo ( 
        .clk_sys                        ( afu_pcie_core_clk             ),   //i1:
        .reset                          ( afu_pcie_core_rst             ),   //i1:
        .wen                            ( axi_rd_data_valid && fifo_rd_data_storage && reg_work_mode==CMD_FIFO_MODE),   //i1:
        .wdata                          ( axi_rd_data               ),   //i[FIFO_WIDTH]:
        .ren                            ( fifo_rd_ren               ),   //i1:
        .rdata                          ( fifo_rd_rdata             ),   //o[FIFO_WIDTH]:
        .full                           (                           ),   //o1:
        .empty                          ( rd_data_fifo_empty        ),   //o1:
        .usedw                          ( rd_data_fifo_usedw        ),   //o[FIFO_DEEP]:
        .afull                          (                           ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      (                           )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
    );

    lfsr # (
        .NUM_BITS                       ( 12                        )
    ) lfsr (
        .i_Clk                          ( afu_pcie_core_clk             ),
        .i_Enable                       ( lfsr_enable               ),
        .i_Seed_DV                      ( lfsr_seed_enable          ),
        .i_Seed_Data                    ( cfg_copy_seed             ),
        .o_LFSR_Data                    ( lfsr_o                    ),
        .o_LFSR_Done                    (                           )
    );

//===================================================================
//  wr fsm
//===================================================================
    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            w_cur_state                 <= IDLE_W;
        end
        else begin
            w_cur_state                 <= w_nxt_state;
        end
    end
    
    always @(*) begin
        if (afu_pcie_core_rst) begin
            w_nxt_state                 = IDLE_W;
        end
        else begin
            case (w_cur_state)
                IDLE_W : begin
                    if (reg_work_en && reg_work_mode==CMD_FIFO_MODE && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull && ~wr_cmd_fifo_empty) begin
                        w_nxt_state     = WR_CMD;
                    end
                    else if (reg_work_en && (reg_work_mode==WR_PERF_MODE || reg_work_mode==WR_PERF_RAN_MODE || reg_work_mode==RDWR_PERF_MODE) && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
                        w_nxt_state     = PFER_WR_CMD;
                    end
                    else begin
                        w_nxt_state     = IDLE_W;
                    end
                end
                
                WR_CMD : begin
                    if (wr_burst_len==16'h1 && wr_cmd_time_cnt==(wr_target_cycle-1) && ~wr_cmd_fifo_empty && (wr_cmd_fifo_afull || wr_data_fifo_afull)) begin
                        w_nxt_state     = WR_WAIT;
                    end
                    else if (wr_burst_len==16'h1 && wr_cmd_time_cnt==(wr_target_cycle-1) && ~wr_cmd_fifo_empty) begin
                        w_nxt_state     = WR_CMD;
                    end
                    else if (wr_burst_len==16'h1 && wr_cmd_time_cnt==(wr_target_cycle-1)) begin
                        w_nxt_state     = IDLE_W;
                    end
                    else if (wr_burst_len==16'h1 && (wr_cmd_fifo_afull || wr_data_fifo_afull)) begin
                        w_nxt_state     = WR_WAIT;
                    end
                    else if (wr_burst_len==16'h1) begin
                        w_nxt_state     = WR_CMD;
                    end
                    else begin
                        w_nxt_state     = WR_DATA;
                    end
                end
                
                WR_DATA : begin
                    if (wr_data_burst_cnt==(wr_burst_len-1) && wr_cmd_time_cnt==(wr_target_cycle-1) && ~wr_cmd_fifo_empty && (wr_cmd_fifo_afull || wr_data_fifo_afull)) begin
                        w_nxt_state     = WR_WAIT;
                    end
                    else if (wr_data_burst_cnt==(wr_burst_len-1) && wr_cmd_time_cnt==(wr_target_cycle-1) && ~wr_cmd_fifo_empty) begin
                        w_nxt_state     = WR_CMD;
                    end
                    else if (wr_data_burst_cnt==(wr_burst_len-1) && wr_cmd_time_cnt==(wr_target_cycle-1)) begin
                        w_nxt_state     = IDLE_W;
                    end
                    else if (wr_data_burst_cnt==(wr_burst_len-1) && (wr_cmd_fifo_afull || wr_data_fifo_afull)) begin
                        w_nxt_state     = WR_WAIT;
                    end
                    else if (wr_data_burst_cnt==(wr_burst_len-1)) begin
                        w_nxt_state     = WR_CMD;
                    end
                    else begin
                        w_nxt_state     = WR_DATA;
                    end
                end
                
                WR_WAIT : begin
                    if (reg_work_mode==CMD_FIFO_MODE && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
                        w_nxt_state     = WR_CMD;
                    end
                    else if (~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
                        w_nxt_state     = PFER_WR_CMD;
                    end
                    else begin
                        w_nxt_state     = WR_WAIT;
                    end
                end
                
                PFER_WR_CMD : begin
                    if (wr_pfer_burst_len==1 && stop_lock) begin
                        w_nxt_state     = IDLE_W ;
                    end
                    else if (wr_pfer_burst_len==1 && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
                        w_nxt_state     = PFER_WR_CMD;
                    end
                    else if (wr_pfer_burst_len==1) begin
                        w_nxt_state     = WR_WAIT;
                    end
                    else begin
                        w_nxt_state     = PFER_WR_DATA;
                    end
                end
                
                PFER_WR_DATA : begin
                    if (wr_pfer_burst_cnt==(wr_pfer_burst_len-1) && stop_lock) begin
                        w_nxt_state     = IDLE_W ;
                    end
                    else if (wr_pfer_burst_cnt==(wr_pfer_burst_len-1) && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
                        w_nxt_state     = PFER_WR_CMD;
                    end
                    else if (wr_pfer_burst_cnt==(wr_pfer_burst_len-1)) begin
                        w_nxt_state     = WR_WAIT;
                    end
                    else begin
                        w_nxt_state     = PFER_WR_DATA;
                    end
                end
                
                default : begin
                    w_nxt_state         = IDLE_W ;
                end
               
            endcase
        end
    end
    
    assign st_idle_w                    = w_cur_state[0];
    assign st_wr_cmd                    = w_cur_state[1];
    assign st_wr_data                   = w_cur_state[2];
    assign st_wr_wait                   = w_cur_state[3];
    assign st_pfer_wr_cmd               = w_cur_state[4];
    assign st_pfer_wr_data              = w_cur_state[5];

    assign wr_cmd_fifo_ren              = st_idle_w  && reg_work_en && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull ||
                                          st_wr_cmd  && wr_burst_len==16'h1 && ~wr_cmd_fifo_empty && wr_cmd_time_cnt==(wr_target_cycle-1) ||
                                          st_wr_data && wr_data_burst_cnt==(wr_burst_len-1) && wr_cmd_time_cnt==(wr_target_cycle-1) && ~wr_cmd_fifo_empty;
    assign wr_cmd_fifo_valid            = st_wr_cmd || st_pfer_wr_cmd;
    assign wr_cmd_fifo_data             = (reg_work_mode==CMD_FIFO_MODE) ? {reg_function_num, wr_target_len, wr_target_addr} 
                                        : (reg_work_mode==WR_PERF_MODE)  ? {reg_function_num, fifo_wr_len, fifo_wr_addr[63:24], lfsr_o[10:0], fifo_rd_addr[12], 12'b0}
                                        // : (reg_work_mode==WR_PERF_MODE) ? {reg_function_num, 16'h10, fifo_wr_addr[63:24], lfsr_o[10:0], fifo_rd_addr[12], 12'b0}
                                        : {reg_function_num, fifo_wr_len, fifo_wr_addr[63:12], 12'b0};
    assign wr_data_fifo_valid           = st_wr_cmd || st_wr_data || st_pfer_wr_cmd || st_pfer_wr_data;
    assign wr_data_fifo_data[511:0]     = {64{wr_data_burst_cnt[7:0]}};
    assign wr_data_fifo_data[512]       = (reg_work_mode==CMD_FIFO_MODE) ? (wr_data_burst_cnt==0) : (wr_pfer_burst_cnt==0);
    assign wr_data_fifo_data[513]       = (reg_work_mode==CMD_FIFO_MODE) ? (wr_data_burst_cnt==(wr_burst_len-1)) : (wr_pfer_burst_cnt==(wr_pfer_burst_len-1));
    assign fifo_status[1]               = st_idle_w;


    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            stop_lock                   <= 1'b0;
        end
        else if (reg_work_en) begin
            stop_lock                   <= 1'b0;
        end
        else if ((reg_work_mode==WR_PERF_MODE || reg_work_mode==WR_PERF_RAN_MODE || reg_work_mode==RD_PERF_MODE || reg_work_mode==RD_PERF_INC_MODE || reg_work_mode==RD_PERF_RAN_MODE || reg_work_mode==RDWR_PERF_MODE) && reg_work_stop) begin
            stop_lock                   <= 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            wr_pfer_turn_flag           <= 'b0;
        end
        else if (st_pfer_wr_cmd) begin
            wr_pfer_turn_flag           <= ~wr_pfer_turn_flag;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        wr_pfer_burst_len               <= fifo_wr_len[15:6];
    end

    always @(posedge afu_pcie_core_clk) begin
        if (wr_cmd_fifo_ren) begin
            wr_target_cycle             <= wr_cmd_fifo_rdata[95:80];
            wr_target_len               <= wr_cmd_fifo_rdata[79:64];
            wr_target_addr              <= wr_cmd_fifo_rdata[63:0];
            wr_burst_len                <= wr_cmd_fifo_rdata[103:96];
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_w) begin
            wr_cmd_time_cnt             <= 'b0;
        end
        else if (st_wr_cmd && wr_burst_len==16'h1 && wr_cmd_time_cnt==(wr_target_cycle-1)) begin
            wr_cmd_time_cnt             <= 'b0;
        end
        else if (st_wr_cmd && wr_burst_len==16'h1) begin
            wr_cmd_time_cnt             <= wr_cmd_time_cnt + 1'b1;
        end
        else if (st_wr_data && wr_data_burst_cnt==(wr_burst_len-1) && wr_cmd_time_cnt==(wr_target_cycle-1)) begin
            wr_cmd_time_cnt             <= 'b0;
        end
        else if (st_wr_data && wr_data_burst_cnt==(wr_burst_len-1)) begin
            wr_cmd_time_cnt             <= wr_cmd_time_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_w) begin
            wr_data_burst_cnt           <= 'b0;
        end
        else if (st_wr_cmd && wr_burst_len==16'h1) begin
            wr_data_burst_cnt           <= 16'h0;
        end
        else if (st_wr_data && wr_data_burst_cnt==(wr_burst_len-1)) begin
            wr_data_burst_cnt           <= 16'h0;
        end
        else if (st_wr_cmd || st_wr_data) begin
            wr_data_burst_cnt           <= wr_data_burst_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_w) begin
            wr_pfer_burst_cnt           <= 'b0;
        end
        else if (st_pfer_wr_cmd && wr_pfer_burst_len==16'h1) begin
            wr_pfer_burst_cnt           <= 16'h0;
        end
        else if (st_pfer_wr_data && wr_pfer_burst_cnt==(wr_pfer_burst_len-1)) begin
            wr_pfer_burst_cnt           <= 16'h0;
        end
        else if (st_pfer_wr_cmd || st_pfer_wr_data) begin
            wr_pfer_burst_cnt           <= wr_pfer_burst_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_w && reg_work_en && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
            fifo_wr_time_cost           <= 64'h0;
        end
        else if (st_wr_cmd || st_wr_data || st_wr_wait || st_pfer_wr_cmd || st_pfer_wr_data) begin
            fifo_wr_time_cost           <= fifo_wr_time_cost + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_w && reg_work_en && ~wr_cmd_fifo_afull && ~wr_data_fifo_afull) begin
            fifo_wr_send_cnt            <= 64'b0;
        end
        else if (st_pfer_wr_cmd) begin
            fifo_wr_send_cnt            <= fifo_wr_send_cnt + 1'b1;
        end
    end

//===================================================================
//  rd fsm
//===================================================================
    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            r_cur_state                 <= IDLE_R;
        end
        else begin
            r_cur_state                 <= r_nxt_state;
        end
    end
    
    always @(*) begin
        if (afu_pcie_core_rst) begin
            r_nxt_state                 = IDLE_R;
        end
        else begin
            case (r_cur_state)
                IDLE_R : begin
                    if (reg_work_en && reg_work_mode==CMD_FIFO_MODE && ~rd_cmd_fifo_afull && ~rd_cmd_fifo_empty) begin
                        r_nxt_state     = RD_CMD;
                    end
                    else if (reg_work_en && (reg_work_mode==RD_PERF_MODE || reg_work_mode==RD_PERF_RAN_MODE || reg_work_mode==RD_PERF_INC_MODE || reg_work_mode==RDWR_PERF_MODE) && ~rd_cmd_fifo_afull) begin
                        r_nxt_state     = PFER_RD_CMD;
                    end
                    else begin
                        r_nxt_state     = IDLE_R;
                    end
                end
                
                RD_CMD : begin
                    if (~rd_cmd_fifo_empty && rd_cmd_time_cnt==(rd_target_cycle-1) && rd_cmd_fifo_afull) begin
                        r_nxt_state     = RD_WAIT;
                    end
                    else if (rd_cmd_fifo_empty && rd_cmd_time_cnt==(rd_target_cycle-1)) begin
                        r_nxt_state     = IDLE_R;
                    end
                    else begin
                        r_nxt_state     = RD_CMD;
                    end
                end
                
                RD_WAIT : begin
                    if (reg_work_mode==CMD_FIFO_MODE && ~rd_cmd_fifo_afull) begin
                        r_nxt_state     = RD_CMD;
                    end
                    else if (~rd_cmd_fifo_afull) begin
                        r_nxt_state     = PFER_RD_CMD;
                    end
                    else begin
                        r_nxt_state     = RD_WAIT;
                    end
                end
                
                PFER_RD_CMD : begin
                    if (stop_lock) begin
                        r_nxt_state     = IDLE_R ;
                    end
                    else if (rd_cmd_fifo_afull) begin
                        r_nxt_state     = RD_WAIT;
                    end
                    else begin
                        r_nxt_state     = PFER_RD_CMD;
                    end
                end
                
                default : begin
                    r_nxt_state         = IDLE_R ;
                end
               
            endcase
        end
    end
    
    assign st_idle_r                    = r_cur_state[0];
    assign st_rd_cmd                    = r_cur_state[1];
    assign st_rd_wait                   = r_cur_state[2];
    assign st_pfer_rd_cmd               = r_cur_state[3];

    assign rd_cmd_fifo_ren              = st_idle_r && reg_work_en && ~rd_cmd_fifo_afull && ~rd_cmd_fifo_empty ||
                                          st_rd_cmd && ~rd_cmd_fifo_empty && rd_cmd_time_cnt==(rd_target_cycle-1);
    assign rd_cmd_fifo_valid            = st_rd_cmd || st_pfer_rd_cmd;
    assign rd_cmd_fifo_data             = (reg_work_mode==CMD_FIFO_MODE) ? {reg_function_num, rd_target_len, rd_target_addr} 
                                        : (reg_work_mode==RD_PERF_RAN_MODE || reg_work_mode==RDWR_PERF_MODE) ? {reg_function_num, fifo_rd_len, fifo_rd_addr[63:20], lfsr_o[6:0], fifo_rd_addr[12], 12'b0}
                                        : (reg_work_mode==RD_PERF_INC_MODE) ? {reg_function_num, fifo_rd_len, fifo_rd_addr[63:20], rd_pfer_turn_flag}
                                        : {reg_function_num, fifo_rd_len, fifo_rd_addr[63:12], 12'b0};
    assign fifo_status[0]               = rd_done;
    assign rd_pfer_turn_flag_left       = 21'h100000 - fifo_rd_len;

    always @(posedge afu_pcie_core_clk) begin
        if (reg_work_en) begin
            rd_pfer_turn_flag           <= fifo_rd_addr[19:0];
        end
        else if (st_pfer_rd_cmd && (rd_pfer_turn_flag == rd_pfer_turn_flag_left)) begin
            rd_pfer_turn_flag           <= fifo_rd_addr[19:0];
        end
        else if (st_pfer_rd_cmd) begin
            rd_pfer_turn_flag           <= rd_pfer_turn_flag + fifo_rd_len;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (rd_cmd_fifo_ren) begin
            rd_target_cycle             <= rd_cmd_fifo_rdata[95:80];
            rd_target_len               <= rd_cmd_fifo_rdata[79:64];
            rd_target_addr              <= rd_cmd_fifo_rdata[63:0];
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_r) begin
            rd_cmd_time_cnt             <= 16'h0;
        end
        else if (st_rd_cmd && rd_cmd_time_cnt==(rd_target_cycle-1)) begin
            rd_cmd_time_cnt             <= 16'h0;
        end
        else if (st_rd_cmd) begin
            rd_cmd_time_cnt             <= rd_cmd_time_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_r && reg_work_en && ~rd_cmd_fifo_afull) begin
            fifo_rd_time_cost           <= 64'h0;
        end
        else if (st_rd_cmd || st_rd_wait || st_pfer_rd_cmd) begin
            fifo_rd_time_cost           <= fifo_rd_time_cost + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_w && reg_work_en && ~rd_cmd_fifo_afull) begin
            fifo_rd_send_cnt            <= 64'b0;
        end
        else if (st_pfer_rd_cmd) begin
            fifo_rd_send_cnt            <= fifo_rd_send_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_r && reg_work_en) begin
            rd_cmd_send_cnt            <= 64'h0;
        end
        else if (rd_cmd_fifo_valid) begin
            rd_cmd_send_cnt            <= rd_cmd_send_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_r && reg_work_en) begin
            rd_cmd_recv_cnt             <= 64'h0;
        end
        else if (axi_rd_data_valid && axi_rd_data[512]) begin
            rd_cmd_recv_cnt             <= rd_cmd_recv_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        reg_work_en_dly                 <= {reg_work_en_dly[3:0], reg_work_en};
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            rd_done                     <= 1'b1;
        end
        else if (|reg_work_en_dly) begin
            rd_done                     <= 1'b0;
        end
        else if (rd_cmd_recv_cnt==rd_cmd_send_cnt) begin
            rd_done                     <= 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (|reg_work_en_dly) begin
            fifo_rd_total_time          <= 64'b0;
        end
        else if (~rd_done) begin
            fifo_rd_total_time          <= fifo_rd_total_time + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_r && reg_work_en && reg_work_mode==CMD_FIFO_MODE && ~rd_cmd_fifo_afull && ~rd_cmd_fifo_empty) begin
            st_delay                    <= 1'b1;
        end
        else if (st_idle_r && reg_work_en && (reg_work_mode==RD_PERF_MODE || reg_work_mode==RD_PERF_RAN_MODE || reg_work_mode==RD_PERF_INC_MODE || reg_work_mode==RDWR_PERF_MODE) && ~rd_cmd_fifo_afull) begin
            st_delay                    <= 1'b1;
        end
        else if (axi_rd_data_valid) begin
            st_delay                    <= 1'b0;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle_r && reg_work_en && ~rd_cmd_fifo_afull && ~rd_cmd_fifo_empty) begin
            fifo_rd_time_delay          <= 32'h0;
        end
        else if (st_idle_r && reg_work_en && (reg_work_mode==RD_PERF_MODE || reg_work_mode==RD_PERF_RAN_MODE || reg_work_mode==RD_PERF_INC_MODE || reg_work_mode==RDWR_PERF_MODE) && ~rd_cmd_fifo_afull) begin
            fifo_rd_time_delay          <= 32'b1;
        end
        else if (st_delay) begin
            fifo_rd_time_delay          <= fifo_rd_time_delay + 1'b1;
        end
    end

endmodule