// ***************************************************************************************
// Filename        :    onboard_cmd_copy.sv
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

module onboard_cmd_copy #(
    parameter VENDER_ID                 = "Intel"                       ,
    parameter DEVICE_ID                 = "Agilex"                      , 
    parameter BRAM_TYPE                 = "M20K"                        ,
    parameter FIFO_PARITY               = "FALSE"                       ,
    parameter PARITY_DLY                = "FALSE"                   
)  (
    input                               afu_pcie_core_clk               ,
    input                               afu_pcie_core_rst               ,
    input       [ 31:0]                 reg_work_mode                   ,
    input                               reg_work_en                     ,
    input       [  7:0]                 reg_function_num                ,

    input                               copy_cmd_valid                  ,
    input       [ 63:0]                 copy_rd_addr                    ,
    input       [ 63:0]                 copy_wr_addr                    ,
    input       [ 31:0]                 copy_size                       ,
    input       [  1:0]                 copy_mode                       ,
    input       [ 11:0]                 copy_seed                       ,
    output reg  [  1:0]                 copy_status                     ,
    output reg  [ 31:0]                 copy_time_cost                  ,

    output                              wr_cmd_fifo_valid               ,
    output      [143:0]                 wr_cmd_fifo_data                ,
    input                               wr_cmd_fifo_afull               ,
    output                              wr_data_fifo_valid              ,
    output      [513:0]                 wr_data_fifo_data               ,
    input                               wr_data_fifo_afull              ,
    output                              rd_cmd_fifo_valid               ,
    output      [143:0]                 rd_cmd_fifo_data                ,
    input                               rd_cmd_fifo_afull               ,
    input                               wr_data_fifo_ren                ,
    input                               axi_rd_data_valid               ,
    input       [512:0]                 axi_rd_data                     ,
    output      [  7:0]                 rd_random_fifo_stat             ,
    output reg  [ 15:0]                 copy_gen_rd_cmd_cnt             ,
    output reg  [ 15:0]                 copy_wr_last_cnt                ,
    output      [  7:0]                 stat                        
);

//===================================================================
//  parameters
//===================================================================
    localparam  CMD_FIFO_MODE           = 4'h0                          ;
    localparam  CMD_COPY_MODE           = 4'h1                          ;
    localparam  IDLE                    = 2'b01                         ;
    localparam  COPY                    = 2'b10                         ;

//===================================================================
//  signals
//===================================================================
    reg         [  1:0]                 cur_state                       ;
    reg         [  1:0]                 nxt_state                       ;
    wire                                st_idle                         ;
    wire                                st_copy                         ;
    reg         [  4:0]                 st_idle_dly                     ;
    reg         [ 63:0]                 cfg_copy_rd_addr                ;
    reg         [ 63:0]                 cfg_copy_wr_addr                ;
    reg         [ 31:0]                 cfg_copy_size                   ;
    reg         [  1:0]                 cfg_copy_mode                   ;
    reg         [ 11:0]                 cfg_copy_seed                   ;
    reg         [ 63:0]                 addr_cnt                        ;
    wire        [ 63:0]                 addr_end                        ;
    wire        [ 63:0]                 addr_end_1                      ;
    reg         [ 31:0]                 len_left                        ;
    reg         [ 15:0]                 len_max                         ;
    reg         [ 15:0]                 len_random                      ;
    wire                                lfsr_enable                     ;
    wire                                lfsr_seed_enable                ;
    wire        [ 11:0]                 lfsr_o                          ;
    reg         [ 15:0]                 wr_data_burst_cnt               ;
    reg                                 rd_random_fifo_wen              ;
    reg         [143:0]                 rd_random_fifo_wdata            ;
    wire                                rd_random_fifo_empty            ;
    wire        [  8:0]                 rd_random_fifo_usedw            ;
    reg                                 rd_random_fifo_ren              ;
    wire        [143:0]                 rd_random_fifo_rdata            ;
    wire                                rd_random_fifo_afull            ;
//===================================================================
//  rx data output fsm
//===================================================================
    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            cur_state                   <= IDLE;
        end
        else begin
            cur_state                   <= nxt_state;
        end
    end
    
    always @(*) begin
        if (afu_pcie_core_rst) begin
            nxt_state                   = IDLE;
        end
        else begin
            case (cur_state)
                IDLE : begin
                    if (reg_work_mode[3:0]==CMD_COPY_MODE && reg_work_en) begin
                        nxt_state       = COPY;
                    end
                    else begin
                        nxt_state       = IDLE;
                    end
                end
                
                COPY : begin
                    if (len_random==len_left && ~rd_random_fifo_afull) begin
                        nxt_state       = IDLE;
                    end
                    else begin
                        nxt_state       = COPY;
                    end
                end
                
                default : begin
                    nxt_state           = IDLE ;
                end
               
            endcase
        end
    end
    
    assign st_idle                      = cur_state[0];
    assign st_copy                      = cur_state[1];

//===================================================================
//  cmd generate
//===================================================================
    assign lfsr_enable                  = lfsr_seed_enable || st_copy && ~rd_random_fifo_afull;
    assign lfsr_seed_enable             = st_idle && reg_work_mode[3:0]==CMD_COPY_MODE && reg_work_en;
    // assign len_max                      = 16'h1000 - addr_cnt[11:0];
    assign len_random                   = (lfsr_o==0) ? len_max : ((len_max<lfsr_o) ? len_max : {4'h0, lfsr_o});
    assign addr_end                     = addr_cnt + len_random - 1'b1;
    assign addr_end_1                   = addr_cnt + len_random;
    assign stat                         = {cur_state, 3'b0, rd_random_fifo_empty};

    always @(posedge afu_pcie_core_clk) begin
        if (copy_cmd_valid) begin
            cfg_copy_rd_addr            <= copy_rd_addr;
            cfg_copy_wr_addr            <= copy_wr_addr;
            cfg_copy_size               <= copy_size;
            cfg_copy_mode               <= copy_mode;
            cfg_copy_seed               <= (copy_seed==12'h0) ? 12'h1 : copy_seed;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle) begin
            len_left                    <= cfg_copy_size;
        end
        else if (st_copy && ~rd_random_fifo_afull) begin
            len_left                    <= len_left - len_random;
        end
    end
    
    always @(posedge afu_pcie_core_clk) begin
        if (st_idle) begin
            addr_cnt                    <= 64'h0;
            len_max                     <= 16'h0;
        end
        else if (st_copy && ~rd_random_fifo_afull) begin
            addr_cnt                    <= addr_cnt + len_random;
            len_max                     <= 16'h1000 - addr_end_1[11:0];
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        rd_random_fifo_wen              <= st_copy && ~rd_random_fifo_afull;
        rd_random_fifo_wdata[79:0]      <= {64'h0, len_random, addr_cnt};
        rd_random_fifo_wdata[95:80]     <= addr_end[63:6] - addr_cnt[63:6] + 1;
        rd_random_fifo_wdata[143:96]    <= 48'h0;
    end
 
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
        .wen                            ( rd_random_fifo_wen        ),   //i1:
        .wdata                          ( rd_random_fifo_wdata      ),   //i[FIFO_WIDTH]:
        .ren                            ( rd_random_fifo_ren        ),   //i1:
        .rdata                          ( rd_random_fifo_rdata      ),   //o[FIFO_WIDTH]:
        .full                           (                           ),   //o1:
        .empty                          ( rd_random_fifo_empty      ),   //o1:
        .usedw                          ( rd_random_fifo_usedw      ),   //o[FIFO_DEEP]:
        .afull                          ( rd_random_fifo_afull      ),   //o1: almost full>=AFULL_OVFL_THD(reg)
        .aempty                         (                           ),   //o1: almost empty < AEMPTY_THD(wire)
        .parity_err                     (                           ),   //o1: even parity. 1-parity error,0-parity ok, 1 cycle pulse sync with rdata.
        .fifo_stat                      ( rd_random_fifo_stat       )    //o8:[0]:~empty;[1]:~aempty;[2]:full;[3]:afull,[4]:underflow;[5]:overflow;[6]:parity_err;[7]:rsv
    );

//===================================================================
//  send cmd
//===================================================================
    assign wr_data_fifo_valid           = axi_rd_data_valid && reg_work_mode[3:0]==CMD_COPY_MODE;
    assign wr_data_fifo_data            = {axi_rd_data[512], 1'b0, axi_rd_data[511:0]};
    assign wr_cmd_fifo_valid            = rd_random_fifo_ren;
    assign rd_cmd_fifo_valid            = rd_random_fifo_ren;
    assign wr_cmd_fifo_data[63:0]       = rd_random_fifo_rdata[63:0] + cfg_copy_wr_addr;
    assign rd_cmd_fifo_data[63:0]       = rd_random_fifo_rdata[63:0] + cfg_copy_rd_addr;
    assign wr_cmd_fifo_data[79:64]      = rd_random_fifo_rdata[79:64];
    assign rd_cmd_fifo_data[79:64]      = rd_random_fifo_rdata[79:64];
    assign wr_cmd_fifo_data[143:80]     = {56'h0, reg_function_num};
    assign rd_cmd_fifo_data[143:80]     = {56'h0, reg_function_num};

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            rd_random_fifo_ren          <= 1'b0;
        end
        else if (~rd_random_fifo_empty && ~rd_random_fifo_ren && wr_data_burst_cnt<16'd480) begin
            rd_random_fifo_ren          <= 1'b1;
        end
        else begin
            rd_random_fifo_ren          <= 1'b0;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            wr_data_burst_cnt           <= 16'h0;
        end
        else if (rd_random_fifo_ren && wr_data_fifo_ren && reg_work_mode[3:0]==CMD_COPY_MODE) begin
            wr_data_burst_cnt           <= wr_data_burst_cnt + rd_random_fifo_rdata[95:80] - 1'b1;
        end
        else if (rd_random_fifo_ren) begin
            wr_data_burst_cnt           <= wr_data_burst_cnt + rd_random_fifo_rdata[95:80];
        end
        else if (wr_data_fifo_ren && reg_work_mode[3:0]==CMD_COPY_MODE) begin
            wr_data_burst_cnt           <= wr_data_burst_cnt - 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        st_idle_dly                     <= {st_idle_dly[3:0], st_idle && reg_work_mode[3:0]==CMD_COPY_MODE && reg_work_en};
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        copy_status[1]                  <= 1'b0;
        if (afu_pcie_core_rst) begin
            copy_status[0]              <= 1'b1;
        end
        else if (|st_idle_dly) begin
            copy_status[0]              <= 1'b0;
        end
        else if (wr_data_burst_cnt==0 && rd_random_fifo_empty) begin
            copy_status[0]              <= 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk or posedge afu_pcie_core_rst) begin
        if (afu_pcie_core_rst) begin
            copy_time_cost              <= 32'h0;
        end
        else if (|st_idle_dly) begin
            copy_time_cost              <= 32'h0;
        end
        else if (~copy_status[0]) begin
            copy_time_cost              <= copy_time_cost + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle && reg_work_mode[3:0]==CMD_COPY_MODE && reg_work_en) begin
            copy_gen_rd_cmd_cnt         <= 16'h0;
        end
        else if (rd_random_fifo_wen) begin
            copy_gen_rd_cmd_cnt         <= copy_gen_rd_cmd_cnt + 1'b1;
        end
    end

    always @(posedge afu_pcie_core_clk) begin
        if (st_idle && reg_work_mode[3:0]==CMD_COPY_MODE && reg_work_en) begin
            copy_wr_last_cnt            <= 16'h0;
        end
        else if (wr_data_fifo_valid && wr_data_fifo_data[513]) begin
            copy_wr_last_cnt            <= copy_wr_last_cnt + 1'b1;
        end
    end

endmodule