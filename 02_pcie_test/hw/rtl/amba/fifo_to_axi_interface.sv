// ***************************************************************************************
// Filename        :    fifo_to_axi_interface.sv
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

module fifo_to_axi_interface #(
    parameter VENDER_ID                 = "Intel"                   ,
    parameter DEVICE_ID                 = "Agilex"                  , 
    parameter BRAM_TYPE                 = "M20K"                    ,
    parameter FIFO_PARITY               = "FALSE"                   ,
    parameter PARITY_DLY                = "FALSE"                   
) (
    input                           afu_pcie_core_clk                   ,
    input                           afu_pcie_core_rst                   ,
    input       [ 31:0]             reg_work_mode                   ,

    input                           fmode_wr_cmd_fifo_valid         ,
    input       [143:0]             fmode_wr_cmd_fifo_data          ,
    output                          fmode_wr_cmd_fifo_afull         ,
    input                           fmode_wr_data_fifo_valid        ,
    input       [513:0]             fmode_wr_data_fifo_data         ,
    output                          fmode_wr_data_fifo_afull        ,
    input                           fmode_rd_cmd_fifo_valid         ,
    input       [143:0]             fmode_rd_cmd_fifo_data          ,
    output                          fmode_rd_cmd_fifo_afull         ,
    input                           cmode_wr_cmd_fifo_valid         ,
    input       [143:0]             cmode_wr_cmd_fifo_data          ,
    output                          cmode_wr_cmd_fifo_afull         ,
    input                           cmode_wr_data_fifo_valid        ,
    input       [513:0]             cmode_wr_data_fifo_data         ,
    output                          cmode_wr_data_fifo_afull        ,
    input                           cmode_rd_cmd_fifo_valid         ,
    input       [143:0]             cmode_rd_cmd_fifo_data          ,
    output                          cmode_rd_cmd_fifo_afull         ,
    output                          wr_data_fifo_ren                ,
    output                          axi_rd_data_valid               ,
    output      [512:0]             axi_rd_data                     ,
    //axi4 write interface(user -> pcie bridge)
    //write address channel
    output      [  3:0]             afu_axi4_awid                  ,
    output      [ 63:0]             afu_axi4_awaddr                ,
    output      [  7:0]             afu_axi4_awlen                 ,
    output      [  2:0]             afu_axi4_awsize                ,
    output      [  1:0]             afu_axi4_awburst               ,
    output      [ 63:0]             afu_axi4_awuser                ,
    output                          afu_axi4_awlock                ,
    output      [  3:0]             afu_axi4_awcache               ,
    output      [  2:0]             afu_axi4_awprot                ,
    output      [  3:0]             afu_axi4_awqos                 ,
    output                          afu_axi4_awvalid               ,
    input                           afu_axi4_awready               ,
    //write channel
    output      [511:0]             afu_axi4_wdata                 ,
    output      [  3:0]             afu_axi4_wuser                 ,   //not used
    output      [ 63:0]             afu_axi4_wstrb                 ,
    output                          afu_axi4_wlast                 ,
    output                          afu_axi4_wvalid                ,
    input                           afu_axi4_wready                , 
    //write response channel
    input       [  3:0]             afu_axi4_bid                   ,
    input       [  1:0]             afu_axi4_bresp                 ,
    input                           afu_axi4_bvalid                ,
    input       [ 63:0]             afu_axi4_buser                 ,   //same as awuser
    output                          afu_axi4_bready                ,

    //axi4 read interface(user -> pcie bridge)       
    output      [  3:0]             afu_axi4_arid                  ,
    output      [ 63:0]             afu_axi4_araddr                ,
    output      [  7:0]             afu_axi4_arlen                 ,
    output      [  2:0]             afu_axi4_arsize                ,
    output      [  1:0]             afu_axi4_arburst               ,
    output      [ 63:0]             afu_axi4_aruser                ,   //same as awuser
    output                          afu_axi4_arlock                ,
    output      [  3:0]             afu_axi4_arcache               ,
    output      [  2:0]             afu_axi4_arprot                ,
    output      [  3:0]             afu_axi4_arqos                 ,
    output                          afu_axi4_arvalid               ,
    input                           afu_axi4_arready               ,
    input       [  3:0]             afu_axi4_rid                   ,
    input       [511:0]             afu_axi4_rdata                 ,
    input       [  1:0]             afu_axi4_rresp                 ,
    input       [ 63:0]             afu_axi4_ruser                 ,   //same as awuser
    input                           afu_axi4_rlast                 ,
    input                           afu_axi4_rvalid                ,
    output                          afu_axi4_rready                ,   //always be high

    output      [  7:0]             wr_cmd_fifo_stat                ,
    output      [  7:0]             wr_data_fifo_stat               ,
    output      [  7:0]             rd_cmd_fifo_stat                ,
    output      [  7:0]             wr_strb_fifo_stat               ,
    output reg  [ 15:0]             axi_wr_cmd_cnt                  ,
    output reg  [ 15:0]             axi_rd_cmd_cnt                  ,
    output reg  [ 31:0]             axi_wr_burst_cnt                ,
    output reg  [ 31:0]             axi_rd_burst_cnt                ,
    output      [ 11:0]             stat
);
//===================================================================
//  parameter
//===================================================================
    localparam  CMD_FIFO_MODE           = 4'h0                          ;
    localparam  CMD_COPY_MODE           = 4'h1                          ;
    localparam  IDLE_W                  = 3'b001                        ;
    localparam  AXI_AW                  = 3'b010                        ;
    localparam  AXI_W                   = 3'b100                        ;
    localparam  IDLE_R                  = 2'b01                         ;
    localparam  AXI_AR                  = 2'b10                         ;
//===================================================================
//  signals
//===================================================================
    reg     [  2:0]                     w_cur_state                     ;
    reg     [  2:0]                     w_nxt_state                     ;
    reg     [  1:0]                     r_cur_state                     ;
    reg     [  1:0]                     r_nxt_state                     ;
    wire                                st_idle_w                       ;
    wire                                st_axi_aw                       ;
    wire                                st_axi_w                        ;
    wire                                st_idle_r                       ;
    wire                                st_axi_ar                       ;
    wire                                wcmd_fifo_empty                 ;
    wire                                wcmd_fifo_ren                   ;
    wire    [  9:0]                     wcmd_fifo_pkg_cnt               ;
    wire                                wdata_fifo_empty                ;
    wire                                wdata_fifo_ren                  ;
    reg     [  3:0]                     wdata_fifo_pkg_dly              ;
    reg     [  9:0]                     wdata_fifo_pkg_cnt              ;
    wire                                rcmd_fifo_empty                 ;
    wire                                rcmd_fifo_ren                   ;
    wire    [143:0]                     rcmd_fifo_dout                  ;
    wire    [  9:0]                     rcmd_fifo_pkg_cnt               ;
    wire                                rdata_fifo_wen                  ;
    wire    [575:0]                     rdata_fifo_din                  ;
    reg                                 rd_data_sop                     ;
    wire    [ 63:0]                     wcmd_addr_end                   ;
    wire    [ 63:0]                     rcmd_addr_end                   ;
    //input fifo
    wire                                wr_cmd_fifo_wen                 ;
    wire                                wr_cmd_fifo_ren                 ;
    wire    [143:0]                     wr_cmd_fifo_wdata               ;
    wire    [143:0]                     wr_cmd_fifo_rdata               ;
    wire                                wr_cmd_fifo_empty               ;
    wire                                wr_cmd_fifo_afull               ;
    wire    [  8:0]                     wr_cmd_fifo_usedw               ;
    reg                                 wr_strb_fifo_wen                ;
    wire                                wr_strb_fifo_ren                ;
    reg     [127:0]                     wr_strb_fifo_wdata              ;
    wire    [127:0]                     wr_strb_fifo_rdata              ;
    wire                                wr_strb_fifo_empty              ;
    wire                                wr_strb_fifo_afull              ;
    wire    [  8:0]                     wr_strb_fifo_usedw              ;
    wire                                rd_cmd_fifo_wen                 ;
    wire                                rd_cmd_fifo_ren                 ;
    wire    [143:0]                     rd_cmd_fifo_wdata               ;
    wire    [143:0]                     rd_cmd_fifo_rdata               ;
    wire                                rd_cmd_fifo_empty               ;
    wire                                rd_cmd_fifo_afull               ;
    wire    [  8:0]                     rd_cmd_fifo_usedw               ;
    wire                                wr_data_fifo_wen                ;
    // wire                                wr_data_fifo_ren                ;
    wire    [513:0]                     wr_data_fifo_wdata              ;
    wire    [513:0]                     wr_data_fifo_rdata              ;
    wire                                wr_data_fifo_empty              ;
    wire                                wr_data_fifo_afull              ;

    reg     [  7:0]                     wvalid_cnt                      ;
    wire    [ 63:0]                     addr_start                      ;
    wire    [ 15:0]                     byte_len                        ;
    wire    [ 64:0]                     addr_end                        ; // because the addr_start is 64-bit, then addr_end should be 65-bit
    wire    [ 63:0]                     wstrb_1st                       ; // because the wdata is 512-bit, then the number of data byte lane is 64
    wire    [ 63:0]                     wstrb_last                      ;

//===================================================================
//  get the value for standard wstrb 
//===================================================================
    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            wvalid_cnt <= 'b0;
        end else if (afu_axi4_wvalid && afu_axi4_wready && afu_axi4_wlast) begin
            wvalid_cnt <= 'b0;
        end else if (afu_axi4_wvalid && afu_axi4_wready ) begin
            wvalid_cnt  <= wvalid_cnt + 1'b1;
        end
    end

    assign afu_axi4_wstrb = (afu_axi4_wvalid && wvalid_cnt == 'b0)? wr_strb_fifo_rdata[63:0]:
                            (afu_axi4_wvalid && afu_axi4_wlast)? wr_strb_fifo_rdata[127:64]:
                            64'hffff_ffff_ffff_ffff;


//===================================================================
    assign afu_axi4_awvalid            = ~wr_cmd_fifo_empty;
    assign afu_axi4_awid               = 4'h0;
    assign afu_axi4_awaddr             = wr_cmd_fifo_rdata[63:0];
    assign wcmd_addr_end               = wr_cmd_fifo_rdata[63:0] + wr_cmd_fifo_rdata[79:64] - 1;
    assign afu_axi4_awlen              = wcmd_addr_end[63:6] - wr_cmd_fifo_rdata[63:6];
    // assign afu_axi4_awlen              = wr_cmd_fifo_rdata[77:70] + |wr_cmd_fifo_rdata[69:64] - 1;
    assign afu_axi4_awsize             = 3'b110;
    assign afu_axi4_awburst            = 2'b01;
    assign afu_axi4_awuser             = {40'h0, wr_cmd_fifo_rdata[87:64]};
    assign afu_axi4_awlock             = 1'b0;
    assign afu_axi4_awcache            = 4'h1;
    assign afu_axi4_awprot             = 3'h0;
    assign afu_axi4_awqos              = 4'h0;
    assign afu_axi4_wvalid             = ~wr_data_fifo_empty && ~wr_strb_fifo_empty;
    assign afu_axi4_wdata              = wr_data_fifo_rdata[511:0];
    //assign afu_axi4_wstrb              = 64'hffff_ffff_ffff_ffff;
    assign afu_axi4_wuser              = 4'h0;
    assign afu_axi4_wlast              = wr_data_fifo_rdata[513];
    assign afu_axi4_bready             = 1'b1;

//===================================================================
//  axi rd fsm
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
                    if (~rcmd_fifo_empty) begin
                        r_nxt_state     = AXI_AR;
                    end
                    else begin
                        r_nxt_state     = IDLE_R;
                    end
                end
                
                AXI_AR : begin
                    if (afu_axi4_arready && rcmd_fifo_pkg_cnt>2) begin
                        r_nxt_state     = AXI_AR;
                    end
                    else if (afu_axi4_arready) begin
                        r_nxt_state     = IDLE_R;
                    end
                    else begin
                        r_nxt_state     = AXI_AR;
                    end
                end
                
                default : begin
                    r_nxt_state         = IDLE_R ;
                end
               
            endcase
        end
    end

    assign st_idle_r                    = r_cur_state[0];
    assign st_axi_ar                    = r_cur_state[1];

    assign afu_axi4_arvalid            = st_axi_ar;
    assign afu_axi4_arid               = 4'h0;
    assign afu_axi4_araddr             = rcmd_fifo_dout[63:0];
    assign rcmd_addr_end                = rcmd_fifo_dout[63:0] + rcmd_fifo_dout[79:64] - 1;
    assign afu_axi4_arlen              = rcmd_addr_end[63:6] - rcmd_fifo_dout[63:6];
    // assign afu_axi4_arlen              = rcmd_fifo_dout[77:70] + |rcmd_fifo_dout[69:64] - 1;
    assign afu_axi4_arsize             = 3'b110;
    assign afu_axi4_arburst            = 2'b01;
    assign afu_axi4_aruser             = {40'h0, rcmd_fifo_dout[87:64]};
    assign afu_axi4_arlock             = 1'b0;
    assign afu_axi4_arcache            = 4'h1;
    assign afu_axi4_arprot             = 3'h0;
    assign afu_axi4_arqos              = 4'h0;
    assign afu_axi4_rready             = 1'b1;

    assign rcmd_fifo_ren                = st_axi_ar && afu_axi4_arready;

    assign axi_rd_data_valid            = afu_axi4_rvalid;
    assign axi_rd_data                  = {afu_axi4_rlast, afu_axi4_rdata};

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            rd_data_sop                 <= 1'b1;
        end
        else if (afu_axi4_rlast && afu_axi4_rvalid) begin
            rd_data_sop                 <= 1'b1;
        end
        else if (afu_axi4_rvalid) begin
            rd_data_sop                 <= 1'b0;
        end
    end
    

//===================================================================
//  cmd
//===================================================================
    assign addr_start                   = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_cmd_fifo_data[63:0]  : fmode_wr_cmd_fifo_data[63:0];
    assign byte_len                     = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_cmd_fifo_data[79:64] : fmode_wr_cmd_fifo_data[79:64];
    assign addr_end                     = byte_len + addr_start - 64'b1;
    assign wstrb_1st                    = (addr_end[63:6]!=addr_start[63:6]) ? (64'hffff_ffff_ffff_ffff<<addr_start[5:0]) :
                                          (64'hffff_ffff_ffff_ffff<<addr_start[5:0]) & (64'hffff_ffff_ffff_ffff>>(63-addr_end[5:0]));
    assign wstrb_last                   = 64'hffff_ffff_ffff_ffff>>(63-addr_end[5:0]);
    assign wr_cmd_fifo_wen              = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_cmd_fifo_valid : fmode_wr_cmd_fifo_valid;
    assign wr_cmd_fifo_wdata            = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_cmd_fifo_data : fmode_wr_cmd_fifo_data;
    assign wr_cmd_fifo_ren              = afu_axi4_awvalid && afu_axi4_awready;
    // assign wr_strb_fifo_wen             = (reg_work_mode==CMD_COPY_MODE) ? cmode_wr_cmd_fifo_valid : fmode_wr_cmd_fifo_valid;
    // assign wr_strb_fifo_wdata           = {wstrb_last, wstrb_1st};
    assign wr_strb_fifo_ren             = afu_axi4_wvalid && afu_axi4_wready && afu_axi4_wlast;
    assign fmode_wr_cmd_fifo_afull      = wr_cmd_fifo_afull;
    assign cmode_wr_cmd_fifo_afull      = wr_cmd_fifo_afull;

    assign wr_data_fifo_wen             = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_data_fifo_valid : fmode_wr_data_fifo_valid ;
    assign wr_data_fifo_wdata           = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_data_fifo_data  : fmode_wr_data_fifo_data;  
    assign wr_data_fifo_ren             = afu_axi4_wvalid && afu_axi4_wready;
    assign fmode_wr_data_fifo_afull     = wr_data_fifo_afull;
    assign cmode_wr_data_fifo_afull     = wr_data_fifo_afull;

    assign rd_cmd_fifo_wen              = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_rd_cmd_fifo_valid : fmode_rd_cmd_fifo_valid;
    assign rd_cmd_fifo_wdata            = (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_rd_cmd_fifo_data  : fmode_rd_cmd_fifo_data ;
    assign rd_cmd_fifo_ren              = rcmd_fifo_ren;
    assign fmode_rd_cmd_fifo_afull      = rd_cmd_fifo_afull;
    assign cmode_rd_cmd_fifo_afull      = rd_cmd_fifo_afull;
    assign rcmd_fifo_empty              = rd_cmd_fifo_empty;
    assign rcmd_fifo_dout               = rd_cmd_fifo_rdata;
    assign rcmd_fifo_pkg_cnt            = {1'b0, rd_cmd_fifo_usedw};

    assign stat                         = {r_cur_state, 1'b0, w_cur_state, 1'b0, rd_cmd_fifo_empty, wr_data_fifo_empty, wr_cmd_fifo_empty};

    always @(posedge afu_pcie_core_clk) begin
            wr_strb_fifo_wen            <= (reg_work_mode[3:0]==CMD_COPY_MODE) ? cmode_wr_cmd_fifo_valid : fmode_wr_cmd_fifo_valid;
            wr_strb_fifo_wdata          <= {wstrb_last, wstrb_1st};
    end
    
    always @(posedge afu_pcie_core_clk) begin
        wdata_fifo_pkg_dly              <= {wdata_fifo_pkg_dly[2:0], wr_data_fifo_wen && wr_data_fifo_wdata[513]};
    end
    
    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            wdata_fifo_pkg_cnt          <= 10'h0;
        end
        // else if (wr_data_fifo_wen && wr_data_fifo_wdata[513] && wr_data_fifo_ren && wr_data_fifo_rdata[513]) begin
        //     wdata_fifo_pkg_cnt          <= wdata_fifo_pkg_cnt;
        // end
        // else if (wr_data_fifo_wen && wr_data_fifo_wdata[513]) begin
        //     wdata_fifo_pkg_cnt          <= wdata_fifo_pkg_cnt + 1'b1;
        // end
        else if (wdata_fifo_pkg_dly[3] && wr_data_fifo_ren && wr_data_fifo_rdata[513]) begin
            wdata_fifo_pkg_cnt          <= wdata_fifo_pkg_cnt;
        end
        else if (wdata_fifo_pkg_dly[3]) begin
            wdata_fifo_pkg_cnt          <= wdata_fifo_pkg_cnt + 1'b1;
        end
        else if (wr_data_fifo_ren && wr_data_fifo_rdata[513]) begin
            wdata_fifo_pkg_cnt          <= wdata_fifo_pkg_cnt - 1'b1;
        end
    end
        
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
        .afull                          ( wr_cmd_fifo_afull         ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      ( wr_cmd_fifo_stat          )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
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
        .FIFO_WIDTH                     ( 128                       ),   //
        .FIFO_DEEP                      ( 9                         ),   //2**M
        .AFULL_OVFL_THD                 ( 448                       ),   //afull set threshold. afull=1,used>=SET_THD.
        .AFULL_UNFL_THD                 ( 448                       ),   //afull clear threshold. afull=0,used<CLR_THD.
        .AEMPTY_THD                     ( 2                         )    //aempty =1, used=<THD;else 0.

    ) wr_strb_fifo ( 
        .clk_sys                        ( afu_pcie_core_clk         ),   //i1:
        .reset                          ( afu_pcie_core_rst         ),   //i1:
        .wen                            ( wr_strb_fifo_wen          ),   //i1:
        .wdata                          ( wr_strb_fifo_wdata        ),   //i[FIFO_WIDTH]:
        .ren                            ( wr_strb_fifo_ren          ),   //i1:
        .rdata                          ( wr_strb_fifo_rdata        ),   //o[FIFO_WIDTH]:
        .full                           (                           ),   //o1:
        .empty                          ( wr_strb_fifo_empty        ),   //o1:
        .usedw                          ( wr_strb_fifo_usedw        ),   //o[FIFO_DEEP]:
        .afull                          ( wr_strb_fifo_afull        ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      ( wr_strb_fifo_stat         )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
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
        .FIFO_WIDTH                     ( 514                       ),   //
        .FIFO_DEEP                      ( 9                         ),   //2**M
        .AFULL_OVFL_THD                 ( 448                       ),   //afull set threshold. afull=1,used>=SET_THD.
        .AFULL_UNFL_THD                 ( 448                       ),   //afull clear threshold. afull=0,used<CLR_THD.
        .AEMPTY_THD                     ( 2                         )    //aempty =1, used=<THD;else 0.

    ) wr_data_fifo ( 
        .clk_sys                        ( afu_pcie_core_clk             ),   //i1:
        .reset                          ( afu_pcie_core_rst             ),   //i1:
        .wen                            ( wr_data_fifo_wen          ),   //i1:
        .wdata                          ( wr_data_fifo_wdata        ),   //i[FIFO_WIDTH]:
        .ren                            ( wr_data_fifo_ren          ),   //i1:
        .rdata                          ( wr_data_fifo_rdata        ),   //o[FIFO_WIDTH]:
        .full                           (                           ),   //o1:
        .empty                          ( wr_data_fifo_empty        ),   //o1:
        .usedw                          (                           ),   //o[FIFO_DEEP]:
        .afull                          ( wr_data_fifo_afull        ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      ( wr_data_fifo_stat         )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
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
        .afull                          ( rd_cmd_fifo_afull         ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      ( rd_cmd_fifo_stat          )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
    );

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_wr_cmd_cnt              <= 16'h0;
        end
        else if (afu_axi4_awvalid && afu_axi4_awready) begin
            axi_wr_cmd_cnt              <= axi_wr_cmd_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_rd_cmd_cnt              <= 16'h0;
        end
        else if (afu_axi4_arvalid && afu_axi4_arready) begin
            axi_rd_cmd_cnt              <= axi_rd_cmd_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_wr_burst_cnt              <= 32'h0;
        end
        else if (afu_axi4_wvalid && afu_axi4_wready) begin
            axi_wr_burst_cnt              <= axi_wr_burst_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            axi_rd_burst_cnt              <= 32'h0;
        end
        else if (afu_axi4_rvalid && afu_axi4_rready) begin
            axi_rd_burst_cnt              <= axi_rd_burst_cnt + 1'b1;
        end
    end

endmodule

