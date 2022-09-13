// ***************************************************************************************
// Filename        :    user logic code revised based on onboard_top.sv
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
// 2021-08-24      lry                           change the address and data width according to user logic code.
// ***************************************************************************************

module user_logic (
    input                               afu_pcie_core_clk                   ,
    input                               afu_pcie_core_rst                   ,    
    input                               afu_sys_100m_clk                    ,
    input                               afu_sys_100m_rst                    ,        
// ***************************************************************************************
    //add additional port
    input                               afu_user_clk                         ,
    input                               afu_user_rst                         ,
    input                               afu_user_div2_clk                    ,
    input                               afu_user_div2_rst                    ,
    input                               afu_c0_emif_clk                     ,
    input                               afu_c0_emif_user_rst                 ,
    input                               afu_c0_emif_init_done               ,
    input                               afu_c1_emif_clk                     ,
    input                               afu_c1_emif_user_rst                 ,
    input                               afu_c1_emif_init_done               ,
    input                               afu_c2_emif_clk                     ,
    input                               afu_c2_emif_user_rst                 ,
    input                               afu_c2_emif_init_done               ,
    input                               afu_c3_emif_clk                     ,
    input                               afu_c3_emif_user_rst                 ,
    input                               afu_c3_emif_init_done               ,
    output                              afu_c0_emif_axi_awvalid             ,
    input                               afu_c0_emif_axi_awready             ,
    output     [63:0]                   afu_c0_emif_axi_awaddr              , 
    output     [7:0]                    afu_c0_emif_axi_awid                , 
    output     [7:0]                    afu_c0_emif_axi_awlen               , 
    output     [2:0]                    afu_c0_emif_axi_awsize              , 
    output     [1:0]                    afu_c0_emif_axi_awburst             ,
    output     [0:0]                    afu_c0_emif_axi_awlock              , 
    output     [3:0]                    afu_c0_emif_axi_awcache             ,
    output     [3:0]                    afu_c0_emif_axi_awqos               , 
    output     [63:0]                   afu_c0_emif_axi_awuser              , 
    output     [2:0]                    afu_c0_emif_axi_awprot              , 
    output                              afu_c0_emif_axi_wvalid              , 
    input                               afu_c0_emif_axi_wready              , 
    output     [511:0]                  afu_c0_emif_axi_wdata               , 
    output     [63:0]                   afu_c0_emif_axi_wstrb               , 
    output     [3:0]                    afu_c0_emif_axi_wuser               , 
    output                              afu_c0_emif_axi_wlast               , 
    input                               afu_c0_emif_axi_bvalid              , 
    output                              afu_c0_emif_axi_bready              , 
    input      [7:0]                    afu_c0_emif_axi_bid                 , 
    input      [1:0]                    afu_c0_emif_axi_bresp               , 
    input      [63:0]                   afu_c0_emif_axi_buser               , 
    output                              afu_c0_emif_axi_arvalid             ,
    input                               afu_c0_emif_axi_arready             ,
    output     [63:0]                   afu_c0_emif_axi_araddr              , 
    output     [7:0]                    afu_c0_emif_axi_arid                , 
    output     [7:0]                    afu_c0_emif_axi_arlen               , 
    output     [2:0]                    afu_c0_emif_axi_arsize              , 
    output     [1:0]                    afu_c0_emif_axi_arburst             ,
    output     [0:0]                    afu_c0_emif_axi_arlock              , 
    output     [3:0]                    afu_c0_emif_axi_arcache             ,
    output     [3:0]                    afu_c0_emif_axi_arqos               , 
    output     [63:0]                   afu_c0_emif_axi_aruser              , 
    output     [2:0]                    afu_c0_emif_axi_arprot              , 
    input                               afu_c0_emif_axi_rvalid              , 
    output                              afu_c0_emif_axi_rready              , 
    input      [511:0]                  afu_c0_emif_axi_rdata               , 
    input      [7:0]                    afu_c0_emif_axi_rid                 , 
    input      [1:0]                    afu_c0_emif_axi_rresp               , 
    input                               afu_c0_emif_axi_rlast               , 
    input      [63:0]                   afu_c0_emif_axi_ruser               , 
    output                              afu_c1_emif_axi_awvalid             ,
    input                               afu_c1_emif_axi_awready             ,
    output     [63:0]                   afu_c1_emif_axi_awaddr              , 
    output     [7:0]                    afu_c1_emif_axi_awid                , 
    output     [7:0]                    afu_c1_emif_axi_awlen               , 
    output     [2:0]                    afu_c1_emif_axi_awsize              , 
    output     [1:0]                    afu_c1_emif_axi_awburst             ,
    output     [0:0]                    afu_c1_emif_axi_awlock              , 
    output     [3:0]                    afu_c1_emif_axi_awcache             ,
    output     [3:0]                    afu_c1_emif_axi_awqos               , 
    output     [63:0]                   afu_c1_emif_axi_awuser              , 
    output     [2:0]                    afu_c1_emif_axi_awprot              , 
    output                              afu_c1_emif_axi_wvalid              , 
    input                               afu_c1_emif_axi_wready              , 
    output     [511:0]                  afu_c1_emif_axi_wdata               , 
    output     [63:0]                   afu_c1_emif_axi_wstrb               , 
    output     [3:0]                    afu_c1_emif_axi_wuser               , 
    output                              afu_c1_emif_axi_wlast               , 
    input                               afu_c1_emif_axi_bvalid              , 
    output                              afu_c1_emif_axi_bready              , 
    input      [7:0]                    afu_c1_emif_axi_bid                 , 
    input      [1:0]                    afu_c1_emif_axi_bresp               , 
    input      [63:0]                   afu_c1_emif_axi_buser               , 
    output                              afu_c1_emif_axi_arvalid             ,
    input                               afu_c1_emif_axi_arready             ,
    output     [63:0]                   afu_c1_emif_axi_araddr              , 
    output     [7:0]                    afu_c1_emif_axi_arid                , 
    output     [7:0]                    afu_c1_emif_axi_arlen               , 
    output     [2:0]                    afu_c1_emif_axi_arsize              , 
    output     [1:0]                    afu_c1_emif_axi_arburst             ,
    output     [0:0]                    afu_c1_emif_axi_arlock              , 
    output     [3:0]                    afu_c1_emif_axi_arcache             ,
    output     [3:0]                    afu_c1_emif_axi_arqos               , 
    output     [63:0]                   afu_c1_emif_axi_aruser              , 
    output     [2:0]                    afu_c1_emif_axi_arprot              , 
    input                               afu_c1_emif_axi_rvalid              , 
    output                              afu_c1_emif_axi_rready              , 
    input      [511:0]                  afu_c1_emif_axi_rdata               , 
    input      [7:0]                    afu_c1_emif_axi_rid                 , 
    input      [1:0]                    afu_c1_emif_axi_rresp               , 
    input                               afu_c1_emif_axi_rlast               , 
    input      [63:0]                   afu_c1_emif_axi_ruser               , 
    output                              afu_c2_emif_axi_awvalid             ,
    input                               afu_c2_emif_axi_awready             ,
    output     [63:0]                   afu_c2_emif_axi_awaddr              , 
    output     [7:0]                    afu_c2_emif_axi_awid                , 
    output     [7:0]                    afu_c2_emif_axi_awlen               , 
    output     [2:0]                    afu_c2_emif_axi_awsize              , 
    output     [1:0]                    afu_c2_emif_axi_awburst             ,
    output     [0:0]                    afu_c2_emif_axi_awlock              , 
    output     [3:0]                    afu_c2_emif_axi_awcache             ,
    output     [3:0]                    afu_c2_emif_axi_awqos               , 
    output     [63:0]                   afu_c2_emif_axi_awuser              , 
    output     [2:0]                    afu_c2_emif_axi_awprot              , 
    output                              afu_c2_emif_axi_wvalid              , 
    input                               afu_c2_emif_axi_wready              , 
    output     [511:0]                  afu_c2_emif_axi_wdata               , 
    output     [63:0]                   afu_c2_emif_axi_wstrb               , 
    output     [3:0]                    afu_c2_emif_axi_wuser               , 
    output                              afu_c2_emif_axi_wlast               , 
    input                               afu_c2_emif_axi_bvalid              , 
    output                              afu_c2_emif_axi_bready              , 
    input      [7:0]                    afu_c2_emif_axi_bid                 , 
    input      [1:0]                    afu_c2_emif_axi_bresp               , 
    input      [63:0]                   afu_c2_emif_axi_buser               , 
    output                              afu_c2_emif_axi_arvalid             ,
    input                               afu_c2_emif_axi_arready             ,
    output     [63:0]                   afu_c2_emif_axi_araddr              , 
    output     [7:0]                    afu_c2_emif_axi_arid                , 
    output     [7:0]                    afu_c2_emif_axi_arlen               , 
    output     [2:0]                    afu_c2_emif_axi_arsize              , 
    output     [1:0]                    afu_c2_emif_axi_arburst             ,
    output     [0:0]                    afu_c2_emif_axi_arlock              , 
    output     [3:0]                    afu_c2_emif_axi_arcache             ,
    output     [3:0]                    afu_c2_emif_axi_arqos               , 
    output     [63:0]                   afu_c2_emif_axi_aruser              , 
    output     [2:0]                    afu_c2_emif_axi_arprot              , 
    input                               afu_c2_emif_axi_rvalid              , 
    output                              afu_c2_emif_axi_rready              , 
    input      [511:0]                  afu_c2_emif_axi_rdata               , 
    input      [7:0]                    afu_c2_emif_axi_rid                 , 
    input      [1:0]                    afu_c2_emif_axi_rresp               , 
    input                               afu_c2_emif_axi_rlast               , 
    input      [63:0]                   afu_c2_emif_axi_ruser               , 
    output                              afu_c3_emif_axi_awvalid             ,
    input                               afu_c3_emif_axi_awready             ,
    output     [63:0]                   afu_c3_emif_axi_awaddr              , 
    output     [7:0]                    afu_c3_emif_axi_awid                , 
    output     [7:0]                    afu_c3_emif_axi_awlen               , 
    output     [2:0]                    afu_c3_emif_axi_awsize              , 
    output     [1:0]                    afu_c3_emif_axi_awburst             ,
    output     [0:0]                    afu_c3_emif_axi_awlock              , 
    output     [3:0]                    afu_c3_emif_axi_awcache             ,
    output     [3:0]                    afu_c3_emif_axi_awqos               , 
    output     [63:0]                   afu_c3_emif_axi_awuser              , 
    output     [2:0]                    afu_c3_emif_axi_awprot              , 
    output                              afu_c3_emif_axi_wvalid              , 
    input                               afu_c3_emif_axi_wready              , 
    output     [511:0]                  afu_c3_emif_axi_wdata               , 
    output     [63:0]                   afu_c3_emif_axi_wstrb               , 
    output     [3:0]                    afu_c3_emif_axi_wuser               , 
    output                              afu_c3_emif_axi_wlast               , 
    input                               afu_c3_emif_axi_bvalid              , 
    output                              afu_c3_emif_axi_bready              , 
    input      [7:0]                    afu_c3_emif_axi_bid                 , 
    input      [1:0]                    afu_c3_emif_axi_bresp               , 
    input      [63:0]                   afu_c3_emif_axi_buser               , 
    output                              afu_c3_emif_axi_arvalid             ,
    input                               afu_c3_emif_axi_arready             ,
    output     [63:0]                   afu_c3_emif_axi_araddr              , 
    output     [7:0]                    afu_c3_emif_axi_arid                , 
    output     [7:0]                    afu_c3_emif_axi_arlen               , 
    output     [2:0]                    afu_c3_emif_axi_arsize              , 
    output     [1:0]                    afu_c3_emif_axi_arburst             ,
    output     [0:0]                    afu_c3_emif_axi_arlock              , 
    output     [3:0]                    afu_c3_emif_axi_arcache             ,
    output     [3:0]                    afu_c3_emif_axi_arqos               , 
    output     [63:0]                   afu_c3_emif_axi_aruser              , 
    output     [2:0]                    afu_c3_emif_axi_arprot              , 
    input                               afu_c3_emif_axi_rvalid              , 
    output                              afu_c3_emif_axi_rready              , 
    input      [511:0]                  afu_c3_emif_axi_rdata               , 
    input      [7:0]                    afu_c3_emif_axi_rid                 , 
    input      [1:0]                    afu_c3_emif_axi_rresp               , 
    input                               afu_c3_emif_axi_rlast               , 
    input      [63:0]                   afu_c3_emif_axi_ruser               , 

    output                              user_msix_valid                     ,
    input                               user_msix_ready                     ,
    output     [4:0]                    user_msix_payload_vec               ,
    output     [7:0]                    user_msix_payload_func              ,
// ***************************************************************************************
    //from mgntpf top
    input                               afu_alite4_awvalid                  ,
    output                              afu_alite4_awready                  ,
    input      [ 63:0]                  afu_alite4_awaddr                   ,
    input                               afu_alite4_wvalid                   ,
    output                              afu_alite4_wready                   ,
    input      [ 63:0]                  afu_alite4_wdata                    , //change the data width
    input      [  7:0]                  afu_alite4_wstrb                    , //change width
    output                              afu_alite4_bvalid                   ,
    input                               afu_alite4_bready                   ,
    output     [  1:0]                  afu_alite4_bresp                    ,
    input                               afu_alite4_arvalid                  ,
    output                              afu_alite4_arready                  ,
    input      [ 63:0]                  afu_alite4_araddr                   ,
    output                              afu_alite4_rvalid                   ,
    input                               afu_alite4_rready                   ,
    output     [ 63:0]                  afu_alite4_rdata                    , //change the data width
    output     [  1:0]                  afu_alite4_rresp                    ,
// additional axi4 lite signal
    input      [2:0]                    afu_alite4_awprot                   ,
    input      [31:0]                   afu_alite4_awuser                   ,
    input      [2:0]                    afu_alite4_arprot                   ,
    input      [31:0]                   afu_alite4_aruser                   ,

// ***************************************************************************************
    //axi4 write interface(user -> pcie bridge)
    output      [  3:0]                 afu_axi4_awid                       ,
    output      [ 63:0]                 afu_axi4_awaddr                     ,
    output      [  7:0]                 afu_axi4_awlen                      ,
    output      [  2:0]                 afu_axi4_awsize                     ,
    output      [  1:0]                 afu_axi4_awburst                    ,
    output      [ 63:0]                 afu_axi4_awuser                     ,
    output                              afu_axi4_awlock                     ,
    output      [  3:0]                 afu_axi4_awcache                    ,
    output      [  2:0]                 afu_axi4_awprot                     ,
    output      [  3:0]                 afu_axi4_awqos                      ,
    output                              afu_axi4_awvalid                    ,
    input                               afu_axi4_awready                    ,
    output      [511:0]                 afu_axi4_wdata                      ,
    output      [  3:0]                 afu_axi4_wuser                      ,   //not used
    output      [ 63:0]                 afu_axi4_wstrb                      ,
    output                              afu_axi4_wlast                      ,
    output                              afu_axi4_wvalid                     ,
    input                               afu_axi4_wready                     , 
    input       [  3:0]                 afu_axi4_bid                        ,
    input       [  1:0]                 afu_axi4_bresp                      ,
    input                               afu_axi4_bvalid                     ,
    input       [ 63:0]                 afu_axi4_buser                      ,   //same as awuser
    output                              afu_axi4_bready                     ,

    //axi4 read interface(user -> pcie bridge)       
    output      [  3:0]                 afu_axi4_arid                       ,
    output      [ 63:0]                 afu_axi4_araddr                     ,
    output      [  7:0]                 afu_axi4_arlen                      ,
    output      [  2:0]                 afu_axi4_arsize                     ,
    output      [  1:0]                 afu_axi4_arburst                    ,
    output      [ 63:0]                 afu_axi4_aruser                     ,   //same as awuser
    output                              afu_axi4_arlock                     ,
    output      [  3:0]                 afu_axi4_arcache                    ,
    output      [  2:0]                 afu_axi4_arprot                     ,
    output      [  3:0]                 afu_axi4_arqos                      ,
    output                              afu_axi4_arvalid                    ,
    input                               afu_axi4_arready                    ,
    input       [  3:0]                 afu_axi4_rid                        ,
    input       [511:0]                 afu_axi4_rdata                      ,
    input       [  1:0]                 afu_axi4_rresp                      ,
    input       [ 63:0]                 afu_axi4_ruser                      ,   //same as awuser
    input                               afu_axi4_rlast                      ,
    input                               afu_axi4_rvalid                     ,
    output                              afu_axi4_rready                    //always be high
);
//the wire between fifo and shell
    wire        [  3:0]                 afu_axi4_awid_shell                  ;
    wire        [ 63:0]                 afu_axi4_awaddr_shell                ;
    wire        [  7:0]                 afu_axi4_awlen_shell                 ;
    wire        [  2:0]                 afu_axi4_awsize_shell                ;
    wire        [  1:0]                 afu_axi4_awburst_shell               ;
    wire        [ 63:0]                 afu_axi4_awuser_shell                ;
    wire                                afu_axi4_awlock_shell                ;
    wire        [  3:0]                 afu_axi4_awcache_shell               ;
    wire        [  2:0]                 afu_axi4_awprot_shell                ;
    wire        [  3:0]                 afu_axi4_awqos_shell                 ;
    wire                                afu_axi4_awvalid_shell               ;
    wire                                afu_axi4_awready_shell               ;

    wire        [511:0]                 afu_axi4_wdata_shell                 ;
    wire        [  3:0]                 afu_axi4_wuser_shell                 ;   //not used
    wire        [ 63:0]                 afu_axi4_wstrb_shell                 ;
    wire                                afu_axi4_wlast_shell                 ;
    wire                                afu_axi4_wvalid_shell                ;
    wire                                afu_axi4_wready_shell                ;

    wire        [  3:0]                 afu_axi4_bid_shell                   ;
    wire        [  1:0]                 afu_axi4_bresp_shell                 ;
    wire                                afu_axi4_bvalid_shell                ;
    wire        [ 63:0]                 afu_axi4_buser_shell                 ;   //same as awuser
    wire                                afu_axi4_bready_shell                ;

    //axi4 read interface(user -> pcie bridge)       
    wire        [  3:0]                 afu_axi4_arid_shell                  ;
    wire        [ 63:0]                 afu_axi4_araddr_shell                ;
    wire        [  7:0]                 afu_axi4_arlen_shell                 ;
    wire        [  2:0]                 afu_axi4_arsize_shell                ;
    wire        [  1:0]                 afu_axi4_arburst_shell               ;
    wire        [ 63:0]                 afu_axi4_aruser_shell                ;   //same as awuser
    wire                                afu_axi4_arlock_shell                ;
    wire        [  3:0]                 afu_axi4_arcache_shell               ;
    wire        [  2:0]                 afu_axi4_arprot_shell                ;
    wire        [  3:0]                 afu_axi4_arqos_shell                 ;
    wire                                afu_axi4_arvalid_shell               ;
    wire                                afu_axi4_arready_shell               ;

    wire        [  3:0]                 afu_axi4_rid_shell                   ;
    wire        [511:0]                 afu_axi4_rdata_shell                 ;
    wire        [  1:0]                 afu_axi4_rresp_shell                 ;
    wire        [ 63:0]                 afu_axi4_ruser_shell                 ;   //same as awuser
    wire                                afu_axi4_rlast_shell                 ;
    wire                                afu_axi4_rvalid_shell                ;
    wire                                afu_axi4_rready_shell                ;   //always be high
//the wire between fifo and shell

    wire        [ 31:0]                 reg_work_mode                        ;
    wire                                reg_work_en                          ;
    wire                                reg_work_stop                        ;
    wire        [  7:0]                 reg_function_num                     ;
    wire                                fifo_wr_cmd_valid                    ;
    wire        [ 15:0]                 fifo_wr_cycle                        ;
    wire        [ 63:0]                 fifo_wr_addr                         ;
    wire        [ 15:0]                 fifo_wr_len                          ;
    wire                                fifo_rd_cmd_valid                    ;
    wire        [ 15:0]                 fifo_rd_cycle                        ;
    wire        [ 63:0]                 fifo_rd_addr                         ;
    wire        [ 15:0]                 fifo_rd_len                          ;
    wire                                fifo_rd_ren                          ;
    wire        [511:0]                 fifo_rd_rdata                        ;
    wire        [ 15:0]                 fifo_wr_cmd_num                      ;
    wire        [ 15:0]                 fifo_rd_cmd_num                      ;
    wire        [  1:0]                 fifo_status                          ;
    wire        [ 63:0]                 fifo_wr_time_cost                    ;
    wire        [ 63:0]                 fifo_rd_time_cost                    ;
    wire        [ 63:0]                 fifo_wr_send_cnt                     ;
    wire        [ 63:0]                 fifo_rd_send_cnt                     ;
    wire        [ 31:0]                 fifo_rd_time_delay                   ;
    wire        [ 63:0]                 fifo_rd_total_time                   ;
    wire                                fifo_rd_data_storage                 ;
    wire                                copy_cmd_valid                       ;
    wire        [ 63:0]                 copy_wr_addr                         ;
    wire        [ 63:0]                 copy_rd_addr                         ;
    wire        [ 31:0]                 copy_size                            ;
    wire        [  1:0]                 copy_mode                            ;
    wire        [ 11:0]                 copy_seed                            ;
    wire        [  1:0]                 copy_status                          ;
    wire        [ 31:0]                 copy_time_cost                       ;
    
    wire                                afu_alite4_pcieclk_awvalid           ;
    wire                                afu_alite4_pcieclk_awready           ;
    wire        [ 31:0]                 afu_alite4_pcieclk_awaddr            ;
    wire                                afu_alite4_pcieclk_wvalid            ;
    wire                                afu_alite4_pcieclk_wready            ;
    wire        [ 31:0]                 afu_alite4_pcieclk_wdata             ;
    wire        [  3:0]                 afu_alite4_pcieclk_wstrb             ;
    wire                                afu_alite4_pcieclk_bvalid            ;
    wire                                afu_alite4_pcieclk_bready            ;
    wire        [  1:0]                 afu_alite4_pcieclk_bresp             ;
    wire                                afu_alite4_pcieclk_arvalid           ;
    wire                                afu_alite4_pcieclk_arready           ;
    wire        [ 31:0]                 afu_alite4_pcieclk_araddr            ;
    wire                                afu_alite4_pcieclk_rvalid            ;
    wire                                afu_alite4_pcieclk_rready            ;
    wire        [ 31:0]                 afu_alite4_pcieclk_rdata             ;
    wire        [  1:0]                 afu_alite4_pcieclk_rresp             ;

    wire                                fmode_wr_cmd_fifo_valid              ;
    wire        [143:0]                 fmode_wr_cmd_fifo_data               ;
    wire                                fmode_wr_cmd_fifo_afull              ;
    wire                                fmode_wr_data_fifo_valid             ;
    wire        [513:0]                 fmode_wr_data_fifo_data              ;
    wire                                fmode_wr_data_fifo_afull             ;
    wire                                fmode_rd_cmd_fifo_valid              ;
    wire        [143:0]                 fmode_rd_cmd_fifo_data               ;
    wire                                fmode_rd_cmd_fifo_afull              ;
    wire                                cmode_wr_cmd_fifo_valid              ;
    wire        [143:0]                 cmode_wr_cmd_fifo_data               ;
    wire                                cmode_wr_cmd_fifo_afull              ;
    wire                                cmode_wr_data_fifo_valid             ;
    wire        [513:0]                 cmode_wr_data_fifo_data              ;
    wire                                cmode_wr_data_fifo_afull             ;
    wire                                cmode_rd_cmd_fifo_valid              ;
    wire        [143:0]                 cmode_rd_cmd_fifo_data               ;
    wire                                cmode_rd_cmd_fifo_afull              ;
    wire        [  8:0]                 wr_data_fifo_usedw                   ;
    wire                                axi_rd_data_valid                    ;
    wire        [512:0]                 axi_rd_data                          ;
    wire        [  7:0]                 wr_cmd_fifo_stat                     ;
    wire        [  7:0]                 wr_data_fifo_stat                    ;
    wire        [  7:0]                 rd_cmd_fifo_stat                     ;
    wire        [  7:0]                 rd_random_fifo_stat                  ;
    wire        [  7:0]                 wr_strb_fifo_stat                    ;
    wire        [ 15:0]                 copy_gen_rd_cmd_cnt                  ;
    wire        [ 15:0]                 copy_wr_last_cnt                     ;
    wire        [ 15:0]                 axi_wr_cmd_cnt                       ;
    wire        [ 15:0]                 axi_rd_cmd_cnt                       ;
    wire        [ 31:0]                 axi_wr_burst_cnt                     ;
    wire        [ 31:0]                 axi_rd_burst_cnt                     ;
    wire        [ 31:0]                 stat                                 ;

//additional signals: following are output signals
    assign                              afu_c0_emif_axi_awvalid     = 'b0    ;
    assign                              afu_c0_emif_axi_awaddr      = 'b0    ; 
    assign                              afu_c0_emif_axi_awid        = 'b0    ; 
    assign                              afu_c0_emif_axi_awlen       = 'b0    ; 
    assign                              afu_c0_emif_axi_awsize      = 'b0    ; 
    assign                              afu_c0_emif_axi_awburst     = 'b0    ;
    assign                              afu_c0_emif_axi_awlock      = 'b0    ; 
    assign                              afu_c0_emif_axi_awcache     = 'b0    ;
    assign                              afu_c0_emif_axi_awqos       = 'b0    ; 
    assign                              afu_c0_emif_axi_awuser      = 'b0    ; 
    assign                              afu_c0_emif_axi_awprot      = 'b0    ; 
    assign                              afu_c0_emif_axi_wvalid      = 'b0    ; 
    assign                              afu_c0_emif_axi_wdata       = 'b0    ; 
    assign                              afu_c0_emif_axi_wstrb       = 'b0    ; 
    assign                              afu_c0_emif_axi_wuser       = 'b0    ; 
    assign                              afu_c0_emif_axi_wlast       = 'b0    ; 
    assign                              afu_c0_emif_axi_bready      = 'b0    ; 
    assign                              afu_c0_emif_axi_arvalid     = 'b0    ;
    assign                              afu_c0_emif_axi_araddr      = 'b0    ; 
    assign                              afu_c0_emif_axi_arid        = 'b0    ; 
    assign                              afu_c0_emif_axi_arlen       = 'b0    ; 
    assign                              afu_c0_emif_axi_arsize      = 'b0    ; 
    assign                              afu_c0_emif_axi_arburst     = 'b0    ;
    assign                              afu_c0_emif_axi_arlock      = 'b0    ; 
    assign                              afu_c0_emif_axi_arcache     = 'b0    ;
    assign                              afu_c0_emif_axi_arqos       = 'b0    ; 
    assign                              afu_c0_emif_axi_aruser      = 'b0    ; 
    assign                              afu_c0_emif_axi_arprot      = 'b0    ; 
    assign                              afu_c0_emif_axi_rready      = 'b0    ; 
    assign                              afu_c1_emif_axi_awvalid     = 'b0    ;
    assign                              afu_c1_emif_axi_awaddr      = 'b0    ; 
    assign                              afu_c1_emif_axi_awid        = 'b0    ; 
    assign                              afu_c1_emif_axi_awlen       = 'b0    ; 
    assign                              afu_c1_emif_axi_awsize      = 'b0    ; 
    assign                              afu_c1_emif_axi_awburst     = 'b0    ;
    assign                              afu_c1_emif_axi_awlock      = 'b0    ; 
    assign                              afu_c1_emif_axi_awcache     = 'b0    ;
    assign                              afu_c1_emif_axi_awqos       = 'b0    ; 
    assign                              afu_c1_emif_axi_awuser      = 'b0    ; 
    assign                              afu_c1_emif_axi_awprot      = 'b0    ; 
    assign                              afu_c1_emif_axi_wvalid      = 'b0    ; 
    assign                              afu_c1_emif_axi_wdata       = 'b0    ; 
    assign                              afu_c1_emif_axi_wstrb       = 'b0    ; 
    assign                              afu_c1_emif_axi_wuser       = 'b0    ; 
    assign                              afu_c1_emif_axi_wlast       = 'b0    ; 
    assign                              afu_c1_emif_axi_bready      = 'b0    ; 
    assign                              afu_c1_emif_axi_arvalid     = 'b0    ;
    assign                              afu_c1_emif_axi_araddr      = 'b0    ; 
    assign                              afu_c1_emif_axi_arid        = 'b0    ; 
    assign                              afu_c1_emif_axi_arlen       = 'b0    ; 
    assign                              afu_c1_emif_axi_arsize      = 'b0    ; 
    assign                              afu_c1_emif_axi_arburst     = 'b0    ;
    assign                              afu_c1_emif_axi_arlock      = 'b0    ; 
    assign                              afu_c1_emif_axi_arcache     = 'b0    ;
    assign                              afu_c1_emif_axi_arqos       = 'b0    ; 
    assign                              afu_c1_emif_axi_aruser      = 'b0    ; 
    assign                              afu_c1_emif_axi_arprot      = 'b0    ; 
    assign                              afu_c1_emif_axi_rready      = 'b0    ; 
    assign                              afu_c2_emif_axi_awvalid     = 'b0    ;
    assign                              afu_c2_emif_axi_awaddr      = 'b0    ; 
    assign                              afu_c2_emif_axi_awid        = 'b0    ; 
    assign                              afu_c2_emif_axi_awlen       = 'b0    ; 
    assign                              afu_c2_emif_axi_awsize      = 'b0    ; 
    assign                              afu_c2_emif_axi_awburst     = 'b0    ;
    assign                              afu_c2_emif_axi_awlock      = 'b0    ; 
    assign                              afu_c2_emif_axi_awcache     = 'b0    ;
    assign                              afu_c2_emif_axi_awqos       = 'b0    ; 
    assign                              afu_c2_emif_axi_awuser      = 'b0    ; 
    assign                              afu_c2_emif_axi_awprot      = 'b0    ; 
    assign                              afu_c2_emif_axi_wvalid      = 'b0    ; 
    assign                              afu_c2_emif_axi_wdata       = 'b0    ; 
    assign                              afu_c2_emif_axi_wstrb       = 'b0    ; 
    assign                              afu_c2_emif_axi_wuser       = 'b0    ; 
    assign                              afu_c2_emif_axi_wlast       = 'b0    ; 
    assign                              afu_c2_emif_axi_bready      = 'b0    ; 
    assign                              afu_c2_emif_axi_arvalid     = 'b0    ;
    assign                              afu_c2_emif_axi_araddr      = 'b0    ; 
    assign                              afu_c2_emif_axi_arid        = 'b0    ; 
    assign                              afu_c2_emif_axi_arlen       = 'b0    ; 
    assign                              afu_c2_emif_axi_arsize      = 'b0    ; 
    assign                              afu_c2_emif_axi_arburst     = 'b0    ;
    assign                              afu_c2_emif_axi_arlock      = 'b0    ; 
    assign                              afu_c2_emif_axi_arcache     = 'b0    ;
    assign                              afu_c2_emif_axi_arqos       = 'b0    ; 
    assign                              afu_c2_emif_axi_aruser      = 'b0    ; 
    assign                              afu_c2_emif_axi_arprot      = 'b0    ; 
    assign                              afu_c2_emif_axi_rready      = 'b0    ; 
    assign                              afu_c3_emif_axi_awvalid     = 'b0    ;
    assign                              afu_c3_emif_axi_awaddr      = 'b0    ; 
    assign                              afu_c3_emif_axi_awid        = 'b0    ; 
    assign                              afu_c3_emif_axi_awlen       = 'b0    ; 
    assign                              afu_c3_emif_axi_awsize      = 'b0    ; 
    assign                              afu_c3_emif_axi_awburst     = 'b0    ;
    assign                              afu_c3_emif_axi_awlock      = 'b0    ; 
    assign                              afu_c3_emif_axi_awcache     = 'b0    ;
    assign                              afu_c3_emif_axi_awqos       = 'b0    ; 
    assign                              afu_c3_emif_axi_awuser      = 'b0    ; 
    assign                              afu_c3_emif_axi_awprot      = 'b0    ; 
    assign                              afu_c3_emif_axi_wvalid      = 'b0    ; 
    assign                              afu_c3_emif_axi_wdata       = 'b0    ; 
    assign                              afu_c3_emif_axi_wstrb       = 'b0    ; 
    assign                              afu_c3_emif_axi_wuser       = 'b0    ; 
    assign                              afu_c3_emif_axi_wlast       = 'b0    ; 
    assign                              afu_c3_emif_axi_bready      = 'b0    ; 
    assign                              afu_c3_emif_axi_arvalid     = 'b0    ;
    assign                              afu_c3_emif_axi_araddr      = 'b0    ; 
    assign                              afu_c3_emif_axi_arid        = 'b0    ; 
    assign                              afu_c3_emif_axi_arlen       = 'b0    ; 
    assign                              afu_c3_emif_axi_arsize      = 'b0    ; 
    assign                              afu_c3_emif_axi_arburst     = 'b0    ;
    assign                              afu_c3_emif_axi_arlock      = 'b0    ; 
    assign                              afu_c3_emif_axi_arcache     = 'b0    ;
    assign                              afu_c3_emif_axi_arqos       = 'b0    ; 
    assign                              afu_c3_emif_axi_aruser      = 'b0    ; 
    assign                              afu_c3_emif_axi_arprot      = 'b0    ; 
    assign                              afu_c3_emif_axi_rready      = 'b0    ; 
    assign                              user_msix_valid             = 'b0    ;
    assign                              user_msix_payload_vec       = 'b0    ;
    assign                              user_msix_payload_func      = 'b0    ;

//    assign                              afu_axi4_awuser             = 'b0    ; 
//    assign                              afu_axi4_aruser             = 'b0    ;

//additional signals

    onboard_reg      onboard_reg     (      //you will revise this part.
        .afu_pcie_core_clk                  ( afu_pcie_core_clk                 ) ,//(i)
        .afu_pcie_core_rst                  ( afu_pcie_core_rst                 ) ,//(i)
        .afu_alite4_awvalid                 ( afu_alite4_awvalid                ) ,//(o)
        .afu_alite4_awready                 ( afu_alite4_awready                ) ,//(i)
        .afu_alite4_awaddr                  ( afu_alite4_awaddr                 ) ,//(o)
        .afu_alite4_wvalid                  ( afu_alite4_wvalid                 ) ,//(o)
        .afu_alite4_wready                  ( afu_alite4_wready                 ) ,//(i)
        .afu_alite4_wdata                   ( afu_alite4_wdata                  ) ,//(o)
        .afu_alite4_wstrb                   ( afu_alite4_wstrb                  ) ,//(o)
        .afu_alite4_bvalid                  ( afu_alite4_bvalid                 ) ,//(i)
        .afu_alite4_bready                  ( afu_alite4_bready                 ) ,//(o)
        .afu_alite4_bresp                   ( afu_alite4_bresp                  ) ,//(i)
        .afu_alite4_arvalid                 ( afu_alite4_arvalid                ) ,//(o)
        .afu_alite4_arready                 ( afu_alite4_arready                ) ,//(i)
        .afu_alite4_araddr                  ( afu_alite4_araddr                 ) ,//(o)
        .afu_alite4_rvalid                  ( afu_alite4_rvalid                 ) ,//(i)
        .afu_alite4_rready                  ( afu_alite4_rready                 ) ,//(o)
        .afu_alite4_rdata                   ( afu_alite4_rdata                  ) ,//(i)
        .afu_alite4_rresp                   ( afu_alite4_rresp                  ) ,//(i)
        .reg_work_mode                      ( reg_work_mode                     ) ,//(o)
        .reg_work_en                        ( reg_work_en                       ) ,//(o)
        .reg_work_stop                      ( reg_work_stop                     ) ,//(o)
        .reg_function_num                   ( reg_function_num                  ) ,//(o)
        .fifo_wr_cmd_valid                  ( fifo_wr_cmd_valid                 ) ,//(o)
        .fifo_wr_cycle                      ( fifo_wr_cycle                     ) ,//(o)
        .fifo_wr_addr                       ( fifo_wr_addr                      ) ,//(o)
        .fifo_wr_len                        ( fifo_wr_len                       ) ,//(o)
        .fifo_rd_cmd_valid                  ( fifo_rd_cmd_valid                 ) ,//(o)
        .fifo_rd_cycle                      ( fifo_rd_cycle                     ) ,//(o)
        .fifo_rd_addr                       ( fifo_rd_addr                      ) ,//(o)
        .fifo_rd_len                        ( fifo_rd_len                       ) ,//(o)
        .fifo_rd_ren                        ( fifo_rd_ren                       ) ,//(o)
        .fifo_rd_rdata                      ( fifo_rd_rdata                     ) ,//(i)
        .fifo_wr_cmd_num                    ( fifo_wr_cmd_num                   ) ,//(i)
        .fifo_rd_cmd_num                    ( fifo_rd_cmd_num                   ) ,//(i)
        .fifo_wr_send_cnt                   ( fifo_wr_send_cnt                  ) ,//(i)
        .fifo_rd_send_cnt                   ( fifo_rd_send_cnt                  ) ,//(i)
        .fifo_status                        ( fifo_status                       ) ,//(i)
        .fifo_wr_time_cost                  ( fifo_wr_time_cost                 ) ,//(i)
        .fifo_rd_time_cost                  ( fifo_rd_time_cost                 ) ,//(i)
        .fifo_rd_time_delay                 ( fifo_rd_time_delay                ) ,//(i)
        .fifo_rd_total_time                 ( fifo_rd_total_time                ) ,//(i)
        .fifo_rd_data_storage               ( fifo_rd_data_storage              ) ,//(o)
        .copy_cmd_valid                     ( copy_cmd_valid                    ) ,//(o)
        .copy_wr_addr                       ( copy_wr_addr                      ) ,//(o)
        .copy_rd_addr                       ( copy_rd_addr                      ) ,//(o)
        .copy_size                          ( copy_size                         ) ,//(o)
        .copy_mode                          ( copy_mode                         ) ,//(o)
        .copy_seed                          ( copy_seed                         ) ,//(o)
        .copy_status                        ( copy_status                       ) ,//(i)
        .copy_time_cost                     ( copy_time_cost                    ) ,//(i)
        .rd_random_fifo_stat                ( rd_random_fifo_stat               ) ,//(i)
        .wr_cmd_fifo_stat                   ( wr_cmd_fifo_stat                  ) ,//(i)
        .wr_data_fifo_stat                  ( wr_data_fifo_stat                 ) ,//(i)
        .rd_cmd_fifo_stat                   ( rd_cmd_fifo_stat                  ) ,//(i)
        .wr_strb_fifo_stat                  ( wr_strb_fifo_stat                 ) ,//(i)
        .copy_gen_rd_cmd_cnt                ( copy_gen_rd_cmd_cnt               ) ,//(i)
        .copy_wr_last_cnt                   ( copy_wr_last_cnt                  ) ,//(i)
        .axi_wr_cmd_cnt                     ( axi_wr_cmd_cnt                    ) ,//(i)
        .axi_rd_cmd_cnt                     ( axi_rd_cmd_cnt                    ) ,//(i)
        .axi_wr_burst_cnt                   ( axi_wr_burst_cnt                  ) ,//(i)
        .axi_rd_burst_cnt                   ( axi_rd_burst_cnt                  ) ,//(i)
        .stat                               ( stat                              )  //(i)
    );

    onboard_cmd_fifo      onboard_cmd_fifo     (
        .afu_pcie_core_clk                  ( afu_pcie_core_clk                 ) ,//(i)
        .afu_pcie_core_rst                  ( afu_pcie_core_rst                 ) ,//(i)
        .reg_work_mode                      ( reg_work_mode                     ) ,//(o)
        .reg_work_en                        ( reg_work_en                       ) ,//(o)
        .reg_work_stop                      ( reg_work_stop                     ) ,//(i)
        .reg_function_num                   ( reg_function_num                  ) ,//(i)
        .copy_seed                          ( copy_seed                         ) ,//(i)
        .fifo_wr_cmd_valid                  ( fifo_wr_cmd_valid                 ) ,//(i)
        .fifo_wr_cycle                      ( fifo_wr_cycle                     ) ,//(i)
        .fifo_wr_addr                       ( fifo_wr_addr                      ) ,//(i)
        .fifo_wr_len                        ( fifo_wr_len                       ) ,//(i)
        .fifo_rd_cmd_valid                  ( fifo_rd_cmd_valid                 ) ,//(i)
        .fifo_rd_cycle                      ( fifo_rd_cycle                     ) ,//(i)
        .fifo_rd_addr                       ( fifo_rd_addr                      ) ,//(i)
        .fifo_rd_len                        ( fifo_rd_len                       ) ,//(i)
        .fifo_rd_ren                        ( fifo_rd_ren                       ) ,//(i)
        .fifo_rd_rdata                      ( fifo_rd_rdata                     ) ,//(o)
        .fifo_wr_cmd_num                    ( fifo_wr_cmd_num                   ) ,//(o)
        .fifo_rd_cmd_num                    ( fifo_rd_cmd_num                   ) ,//(o)
        .fifo_status                        ( fifo_status                       ) ,//(o)
        .fifo_wr_time_cost                  ( fifo_wr_time_cost                 ) ,//(o)
        .fifo_rd_time_cost                  ( fifo_rd_time_cost                 ) ,//(o)
        .fifo_wr_send_cnt                   ( fifo_wr_send_cnt                  ) ,//(o)
        .fifo_rd_send_cnt                   ( fifo_rd_send_cnt                  ) ,//(o)
        .fifo_rd_time_delay                 ( fifo_rd_time_delay                ) ,//(o)
        .fifo_rd_total_time                 ( fifo_rd_total_time                ) ,//(o)
        .fifo_rd_data_storage               ( fifo_rd_data_storage              ) ,//(i)
        .wr_cmd_fifo_valid                  ( fmode_wr_cmd_fifo_valid           ) ,//(o)
        .wr_cmd_fifo_data                   ( fmode_wr_cmd_fifo_data            ) ,//(o)
        .wr_cmd_fifo_afull                  ( fmode_wr_cmd_fifo_afull           ) ,//(i)
        .wr_data_fifo_valid                 ( fmode_wr_data_fifo_valid          ) ,//(o)
        .wr_data_fifo_data                  ( fmode_wr_data_fifo_data           ) ,//(o)
        .wr_data_fifo_afull                 ( fmode_wr_data_fifo_afull          ) ,//(i)
        .rd_cmd_fifo_valid                  ( fmode_rd_cmd_fifo_valid           ) ,//(o)
        .rd_cmd_fifo_data                   ( fmode_rd_cmd_fifo_data            ) ,//(o)
        .rd_cmd_fifo_afull                  ( fmode_rd_cmd_fifo_afull           ) ,//(i)
        .axi_rd_data_valid                  ( axi_rd_data_valid                 ) ,//(i)
        .axi_rd_data                        ( axi_rd_data                       ) ,//(i)
        .stat                               ( stat[11:0]                        )  //(o)
    );
        
    onboard_cmd_copy      onboard_cmd_copy     (
        .afu_pcie_core_clk                  ( afu_pcie_core_clk                 ) ,//(i)
        .afu_pcie_core_rst                  ( afu_pcie_core_rst                 ) ,//(i)
        .reg_work_mode                      ( reg_work_mode                     ) ,//(i)
        .reg_work_en                        ( reg_work_en                       ) ,//(i)
        .reg_function_num                   ( reg_function_num                  ) ,//(i)
        .copy_cmd_valid                     ( copy_cmd_valid                    ) ,//(i)
        .copy_wr_addr                       ( copy_wr_addr                      ) ,//(i)
        .copy_rd_addr                       ( copy_rd_addr                      ) ,//(i)
        .copy_size                          ( copy_size                         ) ,//(i)
        .copy_mode                          ( copy_mode                         ) ,//(i)
        .copy_seed                          ( copy_seed                         ) ,//(i)
        .copy_status                        ( copy_status                       ) ,//(o)
        .copy_time_cost                     ( copy_time_cost                    ) ,//(o)
        .wr_cmd_fifo_valid                  ( cmode_wr_cmd_fifo_valid           ) ,//(o)
        .wr_cmd_fifo_data                   ( cmode_wr_cmd_fifo_data            ) ,//(o)
        .wr_cmd_fifo_afull                  ( cmode_wr_cmd_fifo_afull           ) ,//(i)
        .wr_data_fifo_valid                 ( cmode_wr_data_fifo_valid          ) ,//(o)
        .wr_data_fifo_data                  ( cmode_wr_data_fifo_data           ) ,//(o)
        .wr_data_fifo_afull                 ( cmode_wr_data_fifo_afull          ) ,//(i)
        .rd_cmd_fifo_valid                  ( cmode_rd_cmd_fifo_valid           ) ,//(o)
        .rd_cmd_fifo_data                   ( cmode_rd_cmd_fifo_data            ) ,//(o)
        .rd_cmd_fifo_afull                  ( cmode_rd_cmd_fifo_afull           ) ,//(i)
        .wr_data_fifo_ren                   ( wr_data_fifo_ren                  ) ,//(i)
        .axi_rd_data_valid                  ( axi_rd_data_valid                 ) ,//(i)
        .axi_rd_data                        ( axi_rd_data                       ) ,//(i)
        .rd_random_fifo_stat                ( rd_random_fifo_stat               ) ,//(o)
        .copy_gen_rd_cmd_cnt                ( copy_gen_rd_cmd_cnt               ) ,//(i)
        .copy_wr_last_cnt                   ( copy_wr_last_cnt                  ) ,//(i)
        .stat                               ( stat[19:12]                       )  //(o)
    );
    
    fifo_to_axi_interface      fifo_to_axi_interface     (
        .afu_pcie_core_clk                  ( afu_pcie_core_clk                 ) ,//(i)
        .afu_pcie_core_rst                  ( afu_pcie_core_rst                 ) ,//(i)
        .reg_work_mode                      ( reg_work_mode                     ) ,//(i)
        .fmode_wr_cmd_fifo_valid            ( fmode_wr_cmd_fifo_valid           ) ,//(i)
        .fmode_wr_cmd_fifo_data             ( fmode_wr_cmd_fifo_data            ) ,//(i)
        .fmode_wr_cmd_fifo_afull            ( fmode_wr_cmd_fifo_afull           ) ,//(o)
        .fmode_wr_data_fifo_valid           ( fmode_wr_data_fifo_valid          ) ,//(i)
        .fmode_wr_data_fifo_data            ( fmode_wr_data_fifo_data           ) ,//(i)
        .fmode_wr_data_fifo_afull           ( fmode_wr_data_fifo_afull          ) ,//(o)
        .fmode_rd_cmd_fifo_valid            ( fmode_rd_cmd_fifo_valid           ) ,//(i)
        .fmode_rd_cmd_fifo_data             ( fmode_rd_cmd_fifo_data            ) ,//(i)
        .fmode_rd_cmd_fifo_afull            ( fmode_rd_cmd_fifo_afull           ) ,//(o)
        .cmode_wr_cmd_fifo_valid            ( cmode_wr_cmd_fifo_valid           ) ,//(i)
        .cmode_wr_cmd_fifo_data             ( cmode_wr_cmd_fifo_data            ) ,//(i)
        .cmode_wr_cmd_fifo_afull            ( cmode_wr_cmd_fifo_afull           ) ,//(o)
        .cmode_wr_data_fifo_valid           ( cmode_wr_data_fifo_valid          ) ,//(i)
        .cmode_wr_data_fifo_data            ( cmode_wr_data_fifo_data           ) ,//(i)
        .cmode_wr_data_fifo_afull           ( cmode_wr_data_fifo_afull          ) ,//(o)
        .cmode_rd_cmd_fifo_valid            ( cmode_rd_cmd_fifo_valid           ) ,//(i)
        .cmode_rd_cmd_fifo_data             ( cmode_rd_cmd_fifo_data            ) ,//(i)
        .cmode_rd_cmd_fifo_afull            ( cmode_rd_cmd_fifo_afull           ) ,//(o)
        .wr_data_fifo_ren                   ( wr_data_fifo_ren                  ) ,//(o)
        .axi_rd_data_valid                  ( axi_rd_data_valid                 ) ,//(o)
        .axi_rd_data                        ( axi_rd_data                       ) ,//(o)
//Master side: write address channel
        .afu_axi4_awid                      ( afu_axi4_awid_shell               ) ,//(o)
        .afu_axi4_awaddr                    ( afu_axi4_awaddr_shell             ) ,//(o)
        .afu_axi4_awlen                     ( afu_axi4_awlen_shell              ) ,//(o)
        .afu_axi4_awsize                    ( afu_axi4_awsize_shell             ) ,//(o)
        .afu_axi4_awburst                   ( afu_axi4_awburst_shell            ) ,//(o)
        .afu_axi4_awuser                    ( afu_axi4_awuser_shell             ) ,//(o)
        .afu_axi4_awlock                    ( afu_axi4_awlock_shell             ) ,//(o)
        .afu_axi4_awcache                   ( afu_axi4_awcache_shell            ) ,//(o)
        .afu_axi4_awprot                    ( afu_axi4_awprot_shell             ) ,//(o)
        .afu_axi4_awqos                     ( afu_axi4_awqos_shell              ) ,//(o)
        .afu_axi4_awvalid                   ( afu_axi4_awvalid_shell            ) ,//(o)
        .afu_axi4_awready                   ( afu_axi4_awready_shell            ) ,//(i)
//Master side: write channel                                  
        .afu_axi4_wdata                     ( afu_axi4_wdata_shell              ) ,//(o)
        .afu_axi4_wuser                     ( afu_axi4_wuser_shell              ) ,//(o) WUSER Support only in AXI4
        .afu_axi4_wstrb                     ( afu_axi4_wstrb_shell              ) ,//(o)
        .afu_axi4_wlast                     ( afu_axi4_wlast_shell              ) ,//(o)
        .afu_axi4_wvalid                    ( afu_axi4_wvalid_shell             ) ,//(o)
        .afu_axi4_wready                    ( afu_axi4_wready_shell             ) ,//(i)
//Master side: write response channel                         
        .afu_axi4_bid                       ( afu_axi4_bid_shell                ) ,//(i)
        .afu_axi4_bresp                     ( afu_axi4_bresp_shell              ) ,//(i)
        .afu_axi4_bvalid                    ( afu_axi4_bvalid_shell             ) ,//(i)
        .afu_axi4_buser                     ( afu_axi4_buser_shell              ) ,//(i)BUSER Supported only in AXI4
        .afu_axi4_bready                    ( afu_axi4_bready_shell             ) ,//(o)
//Master side: read address channel                           
        .afu_axi4_arid                      ( afu_axi4_arid_shell               ) ,//(o)
        .afu_axi4_araddr                    ( afu_axi4_araddr_shell             ) ,//(o)
        .afu_axi4_arlen                     ( afu_axi4_arlen_shell              ) ,//(o)
        .afu_axi4_arsize                    ( afu_axi4_arsize_shell             ) ,//(o)
        .afu_axi4_arburst                   ( afu_axi4_arburst_shell            ) ,//(o)
        .afu_axi4_aruser                    () ,//(o)Supported only in AXI4
        .afu_axi4_arlock                    ( afu_axi4_arlock_shell             ) ,//(o)
        .afu_axi4_arcache                   ( afu_axi4_arcache_shell            ) ,//(o)
        .afu_axi4_arprot                    ( afu_axi4_arprot_shell             ) ,//(o)
        .afu_axi4_arqos                     ( afu_axi4_arqos_shell              ) ,//(o)Quality of service implemented in AXI4
        .afu_axi4_arvalid                   ( afu_axi4_arvalid_shell            ) ,//(o)
        .afu_axi4_arready                   ( afu_axi4_arready_shell            ) ,//(i)
//Master side: read channel                                   
        .afu_axi4_rid                       ( afu_axi4_rid_shell                ) ,//(i)
        .afu_axi4_rdata                     ( afu_axi4_rdata_shell              ) ,//(i)
        .afu_axi4_rresp                     ( afu_axi4_rresp_shell              ) ,//(i)
        .afu_axi4_ruser                     ( afu_axi4_ruser_shell              ) ,//(i) Supported only in AXI4
        .afu_axi4_rlast                     ( afu_axi4_rlast_shell              ) ,//(i)
        .afu_axi4_rvalid                    ( afu_axi4_rvalid_shell             ) ,//(i)
        .afu_axi4_rready                    ( afu_axi4_rready_shell             ) ,//(o)

        .wr_cmd_fifo_stat                   ( wr_cmd_fifo_stat                  ) ,//(o)
        .wr_data_fifo_stat                  ( wr_data_fifo_stat                 ) ,//(o)
        .rd_cmd_fifo_stat                   ( rd_cmd_fifo_stat                  ) ,//(o)
        .wr_strb_fifo_stat                  ( wr_strb_fifo_stat                 ) ,//(o)
        .axi_wr_cmd_cnt                     ( axi_wr_cmd_cnt                    ) ,//(i)
        .axi_rd_cmd_cnt                     ( axi_rd_cmd_cnt                    ) ,//(i)
        .axi_wr_burst_cnt                   ( axi_wr_burst_cnt                  ) ,//(i)
        .axi_rd_burst_cnt                   ( axi_rd_burst_cnt                  ) ,//(i)
        .stat                               ( stat[31:20]                       )  //(o)
    );

    ShellInfcAxi4MMSlice      ShellInfcMMAxi4MMSlice     (
        //Slave side: write address channel
        .input_aw_valid                 ( afu_axi4_awvalid_shell      ) ,//(i)
        .input_aw_ready                 ( afu_axi4_awready_shell      ) ,//(o)
        .input_aw_payload_addr          ( afu_axi4_awaddr_shell       ) ,//(i)
        .input_aw_payload_id            ( afu_axi4_awid_shell         ) ,//(i)
        .input_aw_payload_len           ( afu_axi4_awlen_shell        ) ,//(i)
        .input_aw_payload_size          ( afu_axi4_awsize_shell       ) ,//(i)
        .input_aw_payload_burst         ( afu_axi4_awburst_shell      ) ,//(i)
        .input_aw_payload_lock          ( afu_axi4_awlock_shell       ) ,//(i)
        .input_aw_payload_cache         ( afu_axi4_awcache_shell      ) ,//(i)
        .input_aw_payload_qos           ( afu_axi4_awqos_shell        ) ,//(i)
        .input_aw_payload_user          ( afu_axi4_awuser_shell       ) ,//(i)
        .input_aw_payload_prot          ( afu_axi4_awprot_shell       ) ,//(i)
        //Slave side: write channel                       
        .input_w_valid                  ( afu_axi4_wvalid_shell       ) ,//(i)
        .input_w_ready                  ( afu_axi4_wready_shell       ) ,//(o)
        .input_w_payload_data           ( afu_axi4_wdata_shell        ) ,//(i)
        .input_w_payload_strb           ( afu_axi4_wstrb_shell        ) ,//(i)
        .input_w_payload_user           ( afu_axi4_wuser_shell        ) ,//(i)
        .input_w_payload_last           ( afu_axi4_wlast_shell        ) ,//(i)
        //Slave side: write response channel
        .input_b_valid                  ( afu_axi4_bvalid_shell       ) ,//(o)
        .input_b_ready                  ( afu_axi4_bready_shell       ) ,//(i)
        .input_b_payload_id             ( afu_axi4_bid_shell          ) ,//(o)  
        .input_b_payload_resp           ( afu_axi4_bresp_shell        ) ,//(o)
        .input_b_payload_user           ( afu_axi4_buser_shell        ) ,//(o)  
        //Slave side: read address channel
        .input_ar_valid                 ( afu_axi4_arvalid_shell      ) ,//(i)
        .input_ar_ready                 ( afu_axi4_arready_shell      ) ,//(o)
        .input_ar_payload_addr          ( afu_axi4_araddr_shell       ) ,//(i)
        .input_ar_payload_id            ( afu_axi4_arid_shell         ) ,//(i)
        .input_ar_payload_len           ( afu_axi4_arlen_shell        ) ,//(i)
        .input_ar_payload_size          ( afu_axi4_arsize_shell       ) ,//(i)
        .input_ar_payload_burst         ( afu_axi4_arburst_shell      ) ,//(i)
        .input_ar_payload_lock          ( afu_axi4_arlock_shell       ) ,//(i)
        .input_ar_payload_cache         ( afu_axi4_arcache_shell      ) ,//(i)
        .input_ar_payload_qos           ( afu_axi4_arqos_shell        ) ,//(i)
        .input_ar_payload_user          ( afu_axi4_aruser_shell       ) ,//(i)
        .input_ar_payload_prot          ( afu_axi4_arprot_shell       ) ,//(i)
        //Slave side: read channel                        
        .input_r_valid                  ( afu_axi4_rvalid_shell       ) ,//(o)
        .input_r_ready                  ( afu_axi4_rready_shell       ) ,//(i)
        .input_r_payload_data           ( afu_axi4_rdata_shell        ) ,//(o) 
        .input_r_payload_id             ( afu_axi4_rid_shell          ) ,//(o) 
        .input_r_payload_resp           ( afu_axi4_rresp_shell        ) ,//(o)
        .input_r_payload_last           ( afu_axi4_rlast_shell        ) ,//(o) 
        .input_r_payload_user           ( afu_axi4_ruser_shell        ) ,//(o) 
        //Master side for output from user_logic
        //Master side: write address channel
        .output_aw_valid                ( afu_axi4_awvalid            ) ,//(o)
        .output_aw_ready                ( afu_axi4_awready            ) ,//(i)
        .output_aw_payload_addr         ( afu_axi4_awaddr             ) ,//(o)
        .output_aw_payload_id           ( afu_axi4_awid               ) ,//(o)
        .output_aw_payload_len          ( afu_axi4_awlen              ) ,//(o)
        .output_aw_payload_size         ( afu_axi4_awsize             ) ,//(o)
        .output_aw_payload_burst        ( afu_axi4_awburst            ) ,//(o)
        .output_aw_payload_lock         ( afu_axi4_awlock             ) ,//(o)
        .output_aw_payload_cache        ( afu_axi4_awcache            ) ,//(o)
        .output_aw_payload_qos          ( afu_axi4_awqos              ) ,//(o)
        .output_aw_payload_user         ( afu_axi4_awuser             ) ,//(o)
        .output_aw_payload_prot         ( afu_axi4_awprot             ) ,//(o)
        //Master side: write channel
        .output_w_valid                 ( afu_axi4_wvalid             ) ,//(o)
        .output_w_ready                 ( afu_axi4_wready             ) ,//(i)
        .output_w_payload_data          ( afu_axi4_wdata              ) ,//(o)
        .output_w_payload_strb          ( afu_axi4_wstrb              ) ,//(o)
        .output_w_payload_user          ( afu_axi4_wuser              ) ,//(o)
        .output_w_payload_last          ( afu_axi4_wlast              ) ,//(o)
        //Master side: write response channel
        .output_b_valid                 ( afu_axi4_bvalid             ) ,//(i)
        .output_b_ready                 ( afu_axi4_bready             ) ,//(o)
        .output_b_payload_id            ( afu_axi4_bid                ) ,//(i)
        .output_b_payload_resp          ( afu_axi4_bresp              ) ,//(i)
        .output_b_payload_user          ( afu_axi4_buser              ) ,//(i)
        //Master side: read address channel
        .output_ar_valid                ( afu_axi4_arvalid            ) ,//(o)
        .output_ar_ready                ( afu_axi4_arready            ) ,//(i)
        .output_ar_payload_addr         ( afu_axi4_araddr             ) ,//(o)
        .output_ar_payload_id           ( afu_axi4_arid               ) ,//(o)
        .output_ar_payload_len          ( afu_axi4_arlen              ) ,//(o)
        .output_ar_payload_size         ( afu_axi4_arsize             ) ,//(o)
        .output_ar_payload_burst        ( afu_axi4_arburst            ) ,//(o)
        .output_ar_payload_lock         ( afu_axi4_arlock             ) ,//(o)
        .output_ar_payload_cache        ( afu_axi4_arcache            ) ,//(o)
        .output_ar_payload_qos          ( afu_axi4_arqos              ) ,//(o)
        .output_ar_payload_user         ( afu_axi4_aruser             ) ,//(o)
        .output_ar_payload_prot         ( afu_axi4_arprot             ) ,//(o)
        //Master side: read channel
        .output_r_valid                 ( afu_axi4_rvalid             ) ,//(i)
        .output_r_ready                 ( afu_axi4_rready             ) ,//(o)
        .output_r_payload_data          ( afu_axi4_rdata              ) ,//(i)
        .output_r_payload_id            ( afu_axi4_rid                ) ,//(i)
        .output_r_payload_resp          ( afu_axi4_rresp              ) ,//(i)
        .output_r_payload_last          ( afu_axi4_rlast              ) ,//(i)
        .output_r_payload_user          ( afu_axi4_ruser              ) ,//(i)

        .clk                            ( afu_pcie_core_clk             ) ,//(i)
        .reset                          ( afu_pcie_core_rst             )  //(i)
    );


endmodule

