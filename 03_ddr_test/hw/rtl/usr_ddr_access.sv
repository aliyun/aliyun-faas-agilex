// ***************************************************************************************
//
// Filename        :    usr_ddr_access.v
//
// ***************************************************************************************
module  usr_ddr_access
#(
  parameter AXI_DATA_WIDTH   = 512      
)
(
    input                   kernel_clk_300m             ,   //300Mhz  mmcm output, reconfig clock
    input                   kernel_clk_rstn             ,   //reset -active low 
    input                   ddr_usr_clk                 ,   
    input                   ddr_usr_clk_rstn            ,   
   
    input                   ddr_alite_awvalid           ,  //the clock domain sys_alite_aclk
    output                  ddr_alite_awready           ,   
    input  [31:0]           ddr_alite_awaddr            , 
    input  [2:0]            ddr_alite_awprot            ,
    input                   ddr_alite_wvalid            ,   
    output                  ddr_alite_wready            ,   
    input  [63 : 0]         ddr_alite_wdata             ,  
    input  [3:0]            ddr_alite_wstrb             , 
    output                  ddr_alite_bvalid            ,   
    input                   ddr_alite_bready            ,   
    output [1:0]            ddr_alite_bresp             ,   
    input                   ddr_alite_arvalid           ,   
    output                  ddr_alite_arready           ,   
    input  [31:0]           ddr_alite_araddr            , 
    input   [2:0]           ddr_alite_arprot            ,
    output                  ddr_alite_rvalid            ,   
    input                   ddr_alite_rready            ,   
    output [63:0]           ddr_alite_rdata             ,   
    output [1:0]            ddr_alite_rresp             , 

    //
    output [63:0]           c0_sys_axi_araddr          ,
    output [1:0]            c0_sys_axi_arburst         ,
    output [3:0]            c0_sys_axi_arcache         ,
    output [4:0]            c0_sys_axi_arid            ,
    output [7:0]            c0_sys_axi_arlen           ,
    output [0:0]            c0_sys_axi_arlock          ,
    output [2:0]            c0_sys_axi_arprot          ,
    output [3:0]            c0_sys_axi_arqos           ,
    input                   c0_sys_axi_arready         ,
    output [3:0]            c0_sys_axi_arregion        ,
    output [2:0]            c0_sys_axi_arsize          ,
    output                  c0_sys_axi_arvalid         ,
    output [63:0]           c0_sys_axi_awaddr          ,
    output [1:0]            c0_sys_axi_awburst         ,
    output [3:0]            c0_sys_axi_awcache         ,
    output [4:0]            c0_sys_axi_awid            ,
    output [7:0]            c0_sys_axi_awlen           ,
    output [0:0]            c0_sys_axi_awlock          ,
    output [2:0]            c0_sys_axi_awprot          ,
    output [3:0]            c0_sys_axi_awqos           ,
    input                   c0_sys_axi_awready         ,
    output [3:0]            c0_sys_axi_awregion        ,
    output [2:0]            c0_sys_axi_awsize          ,
    output                  c0_sys_axi_awvalid         ,
    input [4:0]             c0_sys_axi_bid             ,
    output                  c0_sys_axi_bready          ,
    input [1:0]             c0_sys_axi_bresp           ,
    input                   c0_sys_axi_bvalid          ,
    input [AXI_DATA_WIDTH-1:0]c0_sys_axi_rdata           ,
    input [4:0]             c0_sys_axi_rid             ,
    input                   c0_sys_axi_rlast           ,
    output                  c0_sys_axi_rready          ,
    input [1:0]             c0_sys_axi_rresp           ,
    input                   c0_sys_axi_rvalid          ,
    output [AXI_DATA_WIDTH-1:0]c0_sys_axi_wdata           ,
    output                  c0_sys_axi_wlast           ,
    input                   c0_sys_axi_wready          ,
    output [63:0]           c0_sys_axi_wstrb           ,
    output                  c0_sys_axi_wvalid          ,     
    
    input                   ddr_cal_done               ,
    input                   usr_int_en                 ,   //the clock domain kernel_clk_300m
    output  [15:0]          usr_int_req                ,
    input   [15:0]          usr_int_ack     
    
);

// ---------------------------------------------------------------------------------------
//  parameter
// ---------------------------------------------------------------------------------------
parameter ADDR_OFFSET  = 16*(AXI_DATA_WIDTH/8);

//parameter AXI_END_ADDR = ADDR_OFFSET*(24'h3FFFFF);   
parameter AXI_END_ADDR = (AXI_DATA_WIDTH==576) ? 16*(24'h3FFFFF) : (ADDR_OFFSET*(24'h3FFFFF));   

// ---------------------------------------------------------------------------------------
//  signales
// ---------------------------------------------------------------------------------------
wire    [32:0]  c0_sys_axi_araddr_tmp   ;
wire    [32:0]  c0_sys_axi_awaddr_tmp   ;

wire   [3:0]    prbs_mode_start          ;
wire   [3:0]    prbs_mode_sel            ;

wire    [32:0]  c0_err                   ;
wire    [3:0]   c0_curr_state_r          ;

wire    [3:0]   bist_running            ;
wire    [3:0]   bist_cplt               ;
wire    [31:0]  c0_wr_cycle_cnt         ;
wire    [31:0]  c0_rd_cycle_cnt         ;
wire    [31:0]  c0_syn                   ;

wire    [3:0]   prbs_mode_cplt           ;
//dfx
reg     [63:0]  c0_txcmd_cnt  =0         ;
reg     [63:0]  c0_rxcmd_cnt  =0         ;
wire    [63:0]  c0_round_time            ;
reg     [31:0]  REQ_LEN                  ;

wire    [31:0]  c0_wr_burst_cnt           ;
wire    [31:0]  c0_rd_req_cnt             ;
wire    [31:0]  c0_wr_prbs_burst_cnt      ;
wire    [31:0]  c0_rd_prbs_req_cnt        ;
wire    [31:0]  c0_rd_back_cnt            ;
wire    [3 :0]  c0_ddr_bist_done          ;

wire    [9 :0]  c0_vld_rdy                ;
wire    [31:0]  c0_wr_data_cnt            ;
wire    [31:0]  c0_rd_data_cnt            ;
wire    [71:0]  c0_rdata_00               ;
wire    [71:0]  c0_rdata_ff               ;
wire    [4:0]   c0_slice_error            ;
wire    [31:0]  c0_rd_pkg_cnt             ;
wire    [31:0]  test_mode                 ;

assign  c0_vld_rdy ={c0_sys_axi_bvalid,c0_sys_axi_bready,c0_sys_axi_rvalid,c0_sys_axi_arvalid,c0_sys_axi_rready,c0_sys_axi_arready,c0_sys_axi_wvalid,c0_sys_axi_awvalid,c0_sys_axi_wready,c0_sys_axi_awready};
// ---------------------------------------------------------------------------------------
//  logic
// ---------------------------------------------------------------------------------------
//assign  c0_sys_axi_araddr   = {30'h0,c0_sys_axi_araddr_tmp};
//assign  c0_sys_axi_awaddr   = {30'h0,c0_sys_axi_awaddr_tmp};
//assign  c1_sys_axi_araddr   = {30'h1,c1_sys_axi_araddr_tmp};
//assign  c1_sys_axi_awaddr   = {30'h1,c1_sys_axi_awaddr_tmp};
//assign  c2_sys_axi_araddr   = {30'h2,c2_sys_axi_araddr_tmp};
//assign  c2_sys_axi_awaddr   = {30'h2,c2_sys_axi_awaddr_tmp};
//assign  c3_sys_axi_araddr   = {30'h3,c3_sys_axi_araddr_tmp};
//assign  c3_sys_axi_awaddr   = {30'h3,c3_sys_axi_awaddr_tmp};
assign  c0_sys_axi_araddr   = {30'h0,c0_sys_axi_araddr_tmp};
assign  c0_sys_axi_awaddr   = {30'h0,c0_sys_axi_awaddr_tmp};

assign  c0_sys_axi_arqos      = 0;
assign  c0_sys_axi_arregion   = 0;
assign  c0_sys_axi_awqos      = 0;
assign  c0_sys_axi_awregion   = 0;


// ---------------------------------------------------------------------------------------
//  dfx
// ---------------------------------------------------------------------------------------
always @(posedge kernel_clk_300m) 
begin
    if(c0_sys_axi_awvalid == 1'b1 && c0_sys_axi_awready == 1'b1) c0_txcmd_cnt <= c0_txcmd_cnt + 1'b1; else;
    if(c0_sys_axi_arvalid == 1'b1 && c0_sys_axi_arready == 1'b1) c0_rxcmd_cnt <= c0_rxcmd_cnt + 1'b1; else;     
end

reg                ddr_cal_done_1dly        ;
reg                ddr_cal_done_2dly        ;
reg                ddr_cal_done_3dly        ;
reg                ddr_cal_done_4dly        ;
reg                ddr_cal_done_5dly        ;
reg                ddr_cal_done_6dly        ;

always @(posedge ddr_usr_clk) 
begin
    ddr_cal_done_1dly <= ddr_cal_done;
    ddr_cal_done_2dly <= ddr_cal_done_1dly;
    ddr_cal_done_3dly <= ddr_cal_done_2dly;
    ddr_cal_done_4dly <= ddr_cal_done_3dly;
	 ddr_cal_done_5dly <= ddr_cal_done_4dly;
	 ddr_cal_done_6dly <= ddr_cal_done_5dly;  	 
end

// ---------------------------------------------------------------------------------------
//  instance
// ---------------------------------------------------------------------------------------
defparam u0_ddr4_bist.AXI_ID_WIDTH     = 4          ;
defparam u0_ddr4_bist.AXI_ADDR_WIDTH   = 33         ; 
defparam u0_ddr4_bist.AXI_DATA_WIDTH   = AXI_DATA_WIDTH;
defparam u0_ddr4_bist.AXI_END_ADDR     = AXI_END_ADDR;   
ddr4_bist   u0_ddr4_bist(
    .s_axi_aclk             (kernel_clk_300m    ),
    .s_axi_aresetn          (kernel_clk_rstn    ),
    .prbs_mode_sel          (prbs_mode_sel[0]   ),//1-prbs 4K burst; 0-prbs all ddr burst
    .prbs_mode_start        (prbs_mode_start[0] ),
    .test_mode              (test_mode          ),
    .REQ_LEN                (REQ_LEN            ),
    .round_time             (c0_round_time      ),
    .ddr_cal_done           (ddr_cal_done_6dly       ),//ddr calibration done
    .axi_awready            (c0_sys_axi_awready ),// Indicates slave is ready to accept a     
    .axi_awid               (c0_sys_axi_awid    ),// Write ID                                 
    .axi_awaddr             (c0_sys_axi_awaddr_tmp  ),// Write address                            
    .axi_awlen              (c0_sys_axi_awlen   ),// Write Burst Length                       
    .axi_awsize             (c0_sys_axi_awsize  ),// Write Burst size                         
    .axi_awburst            (c0_sys_axi_awburst ),// Write Burst type                         
    .axi_awlock             (c0_sys_axi_awlock  ),// Write lock type                          
    .axi_awcache            (c0_sys_axi_awcache ),// Write Cache type                         
    .axi_awprot             (c0_sys_axi_awprot  ),// Write Protection type                    
    .axi_awvalid            (c0_sys_axi_awvalid ),// Write address valid                    
    .axi_wready             (c0_sys_axi_wready  ),// Write data ready                         
    .axi_wdata              (c0_sys_axi_wdata   ),// Write data                               
    .axi_wstrb              (c0_sys_axi_wstrb   ),// Write strobes                            
    .axi_wlast              (c0_sys_axi_wlast   ),// Last write transaction                   
    .axi_wvalid             (c0_sys_axi_wvalid  ),// Write valid                              
    .axi_bid                (c0_sys_axi_bid     ),// Response ID                              
    .axi_bresp              (c0_sys_axi_bresp   ),// Write response                           
    .axi_bvalid             (c0_sys_axi_bvalid  ),// Write reponse valid                      
    .axi_bready             (c0_sys_axi_bready  ),// Response ready                           
    .axi_arready            (c0_sys_axi_arready ),// Read address ready                       
    .axi_arid               (c0_sys_axi_arid    ),// Read ID                                  
    .axi_araddr             (c0_sys_axi_araddr_tmp  ),// Read address
    .axi_arlen              (c0_sys_axi_arlen   ),// Read Burst Length
    .axi_arsize             (c0_sys_axi_arsize  ),// Read Burst size
    .axi_arburst            (c0_sys_axi_arburst ),// Read Burst type                          
    .axi_arlock             (c0_sys_axi_arlock  ),// Read lock type                           
    .axi_arcache            (c0_sys_axi_arcache ),// Read Cache type                          
    .axi_arprot             (c0_sys_axi_arprot  ),// Read Protection type                     
    .axi_arvalid            (c0_sys_axi_arvalid ),// Read address valid                       
    .axi_rid                (c0_sys_axi_rid     ),// Response ID                              
    .axi_rresp              (c0_sys_axi_rresp   ),// Read response                            
    .axi_rvalid             (c0_sys_axi_rvalid  ),// Read reponse valid                       
    .axi_rdata              (c0_sys_axi_rdata   ),// Read data                                
    .axi_rlast              (c0_sys_axi_rlast   ),// Read last                                
    .axi_rready             (c0_sys_axi_rready  ),// Read Response ready
    .bist_running           (bist_running[0]    ),
    .bist_cplt              (bist_cplt[0]       ),
    .wr_cycle_cnt           (c0_wr_cycle_cnt    ),
    .rd_cycle_cnt           (c0_rd_cycle_cnt    ),
    .curr_state_r           (c0_curr_state_r    ),// state 
    .prbs_syn               (c0_syn             ),  // prbs synchronous flag               
    .bist_err_flag          (c0_err             ),  // prbs error flag                     
    .wr_burst_cnt           (c0_wr_burst_cnt      ),
    .rd_req_cnt             (c0_rd_req_cnt        ),
    .wr_prbs_burst_cnt      (c0_wr_prbs_burst_cnt ),
    .rd_prbs_req_cnt        (c0_rd_prbs_req_cnt   ),
    .rd_back_cnt            (c0_rd_back_cnt       ),
    .ddr_bist_done          (c0_ddr_bist_done     ),
    .wr_data_cnt            (c0_wr_data_cnt       ),
    .rd_data_cnt            (c0_rd_data_cnt       ),
    .rd_data_00             (c0_rdata_00          ),        
    .rd_data_ff             (c0_rdata_ff          ),        
    .slice_error            (c0_slice_error       ),  
    .rd_pkg_cnt             (c0_rd_pkg_cnt        ),
    .prbs_rx_dcnt           (),                   // prbs receive data counter           
    .prbs_rx_ecnt           ()                    // prbs receive data error counter     
);

ddr_test_hpi 
#(
    .AXI_ADDR_WIDTH      (33                )   
)
u_ddr_test_hpi(
    .s_axi_aclk          (ddr_usr_clk         ),   
    .s_axi_aresetn       (ddr_usr_clk_rstn    ),    
    .s_axi_awvalid       (ddr_alite_awvalid   ),     
    .s_axi_awaddr        (ddr_alite_awaddr    ),     
    .s_axi_awprot        (     ),
    .s_axi_awready       (ddr_alite_awready   ),     
    .s_axi_wdata         (ddr_alite_wdata     ),     
    .s_axi_wstrb         (     ),
    .s_axi_wvalid        (ddr_alite_wvalid    ),     
    .s_axi_wready        (ddr_alite_wready    ),     
    .s_axi_bresp         (ddr_alite_bresp     ),     
    .s_axi_bvalid        (ddr_alite_bvalid    ),     
    .s_axi_bready        (ddr_alite_bready    ),     
    .s_axi_araddr        (ddr_alite_araddr    ),     
    .s_axi_arprot        (    ),                    
    .s_axi_arvalid       (ddr_alite_arvalid   ),     
    .s_axi_arready       (ddr_alite_arready   ),
    .s_axi_rdata         (ddr_alite_rdata     ),
    .s_axi_rresp         (ddr_alite_rresp     ),
    .s_axi_rvalid        (ddr_alite_rvalid    ),
    .s_axi_rready        (ddr_alite_rready    ),
    .prbs_mode_start     (prbs_mode_start     ),
    .prbs_mode_sel       (prbs_mode_sel       ), 
    .test_mode           (test_mode           ),
    .REQ_LEN             (REQ_LEN             ),
    .c0_round_time       (c0_round_time       ),
    .c0_err              (c0_err              ),
    .c0_syn              (c0_syn              ),
    .c0_curr_state_r     (c0_curr_state_r     ),
    
    .c0_txcmd_cnt        (c0_txcmd_cnt        ),
    .c0_rxcmd_cnt        (c0_rxcmd_cnt        ),
    .bist_running        (bist_running        ),
    .bist_cplt           (bist_cplt           ),    
    .c0_wr_cycle_cnt     (c0_wr_cycle_cnt     ),
    .c0_rd_cycle_cnt     (c0_rd_cycle_cnt     ),     
  
    .c0_vld_rdy          (c0_vld_rdy          ),
    .c0_wr_burst_cnt     (c0_wr_burst_cnt      ),
    .c0_rd_req_cnt       (c0_rd_req_cnt        ),
    .c0_wr_prbs_burst_cnt(c0_wr_prbs_burst_cnt ),
    .c0_rd_prbs_req_cnt  (c0_rd_prbs_req_cnt   ),
    .c0_rd_back_cnt      (c0_rd_back_cnt       ),
    .c0_ddr_bist_done    (c0_ddr_bist_done     ),
    .c0_wr_data_cnt      (c0_wr_data_cnt       ),
    .c0_rd_data_cnt      (c0_rd_data_cnt       ),
    .c0_rdata_00         (c0_rdata_00          ),             
    .c0_rdata_ff         (c0_rdata_ff          ),           
    .c0_slice_error      (c0_slice_error       ),  

    .c0_rd_pkg_cnt       (c0_rd_pkg_cnt     ),

    .ddr_err_info        (burnin_state       ),
    .ddr_err_location    (burnin_err         ),

    .ddr_cal_done        (ddr_cal_done_6dly      ),
    .usr_int_en          (usr_int_en        ),
    .usr_int_req         (usr_int_req       ),
    .usr_int_ack         (usr_int_ack       )
);   

endmodule
