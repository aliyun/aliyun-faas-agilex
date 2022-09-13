module user_logic (
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_sys_100m_clk,
  input               afu_sys_100m_rst,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_user_div2_clk,
  input               afu_user_div2_rst,
  input               afu_c0_emif_clk,
  input               afu_c0_emif_user_rst,
  input               afu_c0_emif_init_done,
  input               afu_c1_emif_clk,
  input               afu_c1_emif_user_rst,
  input               afu_c1_emif_init_done,
  input               afu_c2_emif_clk,
  input               afu_c2_emif_user_rst,
  input               afu_c2_emif_init_done,
  input               afu_c3_emif_clk,
  input               afu_c3_emif_user_rst,
  input               afu_c3_emif_init_done,
  output              afu_c0_emif_axi_awvalid,
  input               afu_c0_emif_axi_awready,
  output     [63:0]   afu_c0_emif_axi_awaddr,
  output     [7:0]    afu_c0_emif_axi_awid,
  output     [7:0]    afu_c0_emif_axi_awlen,
  output     [2:0]    afu_c0_emif_axi_awsize,
  output     [1:0]    afu_c0_emif_axi_awburst,
  output     [0:0]    afu_c0_emif_axi_awlock,
  output     [3:0]    afu_c0_emif_axi_awcache,
  output     [3:0]    afu_c0_emif_axi_awqos,
  output     [63:0]   afu_c0_emif_axi_awuser,
  output     [2:0]    afu_c0_emif_axi_awprot,
  output              afu_c0_emif_axi_wvalid,
  input               afu_c0_emif_axi_wready,
  output     [511:0]  afu_c0_emif_axi_wdata,
  output     [63:0]   afu_c0_emif_axi_wstrb,
  output     [3:0]    afu_c0_emif_axi_wuser,
  output              afu_c0_emif_axi_wlast,
  input               afu_c0_emif_axi_bvalid,
  output              afu_c0_emif_axi_bready,
  input      [7:0]    afu_c0_emif_axi_bid,
  input      [1:0]    afu_c0_emif_axi_bresp,
  input      [63:0]   afu_c0_emif_axi_buser,
  output              afu_c0_emif_axi_arvalid,
  input               afu_c0_emif_axi_arready,
  output     [63:0]   afu_c0_emif_axi_araddr,
  output     [7:0]    afu_c0_emif_axi_arid,
  output     [7:0]    afu_c0_emif_axi_arlen,
  output     [2:0]    afu_c0_emif_axi_arsize,
  output     [1:0]    afu_c0_emif_axi_arburst,
  output     [0:0]    afu_c0_emif_axi_arlock,
  output     [3:0]    afu_c0_emif_axi_arcache,
  output     [3:0]    afu_c0_emif_axi_arqos,
  output     [63:0]   afu_c0_emif_axi_aruser,
  output     [2:0]    afu_c0_emif_axi_arprot,
  input               afu_c0_emif_axi_rvalid,
  output              afu_c0_emif_axi_rready,
  input      [511:0]  afu_c0_emif_axi_rdata,
  input      [7:0]    afu_c0_emif_axi_rid,
  input      [1:0]    afu_c0_emif_axi_rresp,
  input               afu_c0_emif_axi_rlast,
  input      [63:0]   afu_c0_emif_axi_ruser,
  output              afu_c1_emif_axi_awvalid,
  input               afu_c1_emif_axi_awready,
  output     [63:0]   afu_c1_emif_axi_awaddr,
  output     [7:0]    afu_c1_emif_axi_awid,
  output     [7:0]    afu_c1_emif_axi_awlen,
  output     [2:0]    afu_c1_emif_axi_awsize,
  output     [1:0]    afu_c1_emif_axi_awburst,
  output     [0:0]    afu_c1_emif_axi_awlock,
  output     [3:0]    afu_c1_emif_axi_awcache,
  output     [3:0]    afu_c1_emif_axi_awqos,
  output     [63:0]   afu_c1_emif_axi_awuser,
  output     [2:0]    afu_c1_emif_axi_awprot,
  output              afu_c1_emif_axi_wvalid,
  input               afu_c1_emif_axi_wready,
  output     [511:0]  afu_c1_emif_axi_wdata,
  output     [63:0]   afu_c1_emif_axi_wstrb,
  output     [3:0]    afu_c1_emif_axi_wuser,
  output              afu_c1_emif_axi_wlast,
  input               afu_c1_emif_axi_bvalid,
  output              afu_c1_emif_axi_bready,
  input      [7:0]    afu_c1_emif_axi_bid,
  input      [1:0]    afu_c1_emif_axi_bresp,
  input      [63:0]   afu_c1_emif_axi_buser,
  output              afu_c1_emif_axi_arvalid,
  input               afu_c1_emif_axi_arready,
  output     [63:0]   afu_c1_emif_axi_araddr,
  output     [7:0]    afu_c1_emif_axi_arid,
  output     [7:0]    afu_c1_emif_axi_arlen,
  output     [2:0]    afu_c1_emif_axi_arsize,
  output     [1:0]    afu_c1_emif_axi_arburst,
  output     [0:0]    afu_c1_emif_axi_arlock,
  output     [3:0]    afu_c1_emif_axi_arcache,
  output     [3:0]    afu_c1_emif_axi_arqos,
  output     [63:0]   afu_c1_emif_axi_aruser,
  output     [2:0]    afu_c1_emif_axi_arprot,
  input               afu_c1_emif_axi_rvalid,
  output              afu_c1_emif_axi_rready,
  input      [511:0]  afu_c1_emif_axi_rdata,
  input      [7:0]    afu_c1_emif_axi_rid,
  input      [1:0]    afu_c1_emif_axi_rresp,
  input               afu_c1_emif_axi_rlast,
  input      [63:0]   afu_c1_emif_axi_ruser,
  output              afu_c2_emif_axi_awvalid,
  input               afu_c2_emif_axi_awready,
  output     [63:0]   afu_c2_emif_axi_awaddr,
  output     [7:0]    afu_c2_emif_axi_awid,
  output     [7:0]    afu_c2_emif_axi_awlen,
  output     [2:0]    afu_c2_emif_axi_awsize,
  output     [1:0]    afu_c2_emif_axi_awburst,
  output     [0:0]    afu_c2_emif_axi_awlock,
  output     [3:0]    afu_c2_emif_axi_awcache,
  output     [3:0]    afu_c2_emif_axi_awqos,
  output     [63:0]   afu_c2_emif_axi_awuser,
  output     [2:0]    afu_c2_emif_axi_awprot,
  output              afu_c2_emif_axi_wvalid,
  input               afu_c2_emif_axi_wready,
  output     [511:0]  afu_c2_emif_axi_wdata,
  output     [63:0]   afu_c2_emif_axi_wstrb,
  output     [3:0]    afu_c2_emif_axi_wuser,
  output              afu_c2_emif_axi_wlast,
  input               afu_c2_emif_axi_bvalid,
  output              afu_c2_emif_axi_bready,
  input      [7:0]    afu_c2_emif_axi_bid,
  input      [1:0]    afu_c2_emif_axi_bresp,
  input      [63:0]   afu_c2_emif_axi_buser,
  output              afu_c2_emif_axi_arvalid,
  input               afu_c2_emif_axi_arready,
  output     [63:0]   afu_c2_emif_axi_araddr,
  output     [7:0]    afu_c2_emif_axi_arid,
  output     [7:0]    afu_c2_emif_axi_arlen,
  output     [2:0]    afu_c2_emif_axi_arsize,
  output     [1:0]    afu_c2_emif_axi_arburst,
  output     [0:0]    afu_c2_emif_axi_arlock,
  output     [3:0]    afu_c2_emif_axi_arcache,
  output     [3:0]    afu_c2_emif_axi_arqos,
  output     [63:0]   afu_c2_emif_axi_aruser,
  output     [2:0]    afu_c2_emif_axi_arprot,
  input               afu_c2_emif_axi_rvalid,
  output              afu_c2_emif_axi_rready,
  input      [511:0]  afu_c2_emif_axi_rdata,
  input      [7:0]    afu_c2_emif_axi_rid,
  input      [1:0]    afu_c2_emif_axi_rresp,
  input               afu_c2_emif_axi_rlast,
  input      [63:0]   afu_c2_emif_axi_ruser,
  output              afu_c3_emif_axi_awvalid,
  input               afu_c3_emif_axi_awready,
  output     [63:0]   afu_c3_emif_axi_awaddr,
  output     [7:0]    afu_c3_emif_axi_awid,
  output     [7:0]    afu_c3_emif_axi_awlen,
  output     [2:0]    afu_c3_emif_axi_awsize,
  output     [1:0]    afu_c3_emif_axi_awburst,
  output     [0:0]    afu_c3_emif_axi_awlock,
  output     [3:0]    afu_c3_emif_axi_awcache,
  output     [3:0]    afu_c3_emif_axi_awqos,
  output     [63:0]   afu_c3_emif_axi_awuser,
  output     [2:0]    afu_c3_emif_axi_awprot,
  output              afu_c3_emif_axi_wvalid,
  input               afu_c3_emif_axi_wready,
  output     [511:0]  afu_c3_emif_axi_wdata,
  output     [63:0]   afu_c3_emif_axi_wstrb,
  output     [3:0]    afu_c3_emif_axi_wuser,
  output              afu_c3_emif_axi_wlast,
  input               afu_c3_emif_axi_bvalid,
  output              afu_c3_emif_axi_bready,
  input      [7:0]    afu_c3_emif_axi_bid,
  input      [1:0]    afu_c3_emif_axi_bresp,
  input      [63:0]   afu_c3_emif_axi_buser,
  output              afu_c3_emif_axi_arvalid,
  input               afu_c3_emif_axi_arready,
  output     [63:0]   afu_c3_emif_axi_araddr,
  output     [7:0]    afu_c3_emif_axi_arid,
  output     [7:0]    afu_c3_emif_axi_arlen,
  output     [2:0]    afu_c3_emif_axi_arsize,
  output     [1:0]    afu_c3_emif_axi_arburst,
  output     [0:0]    afu_c3_emif_axi_arlock,
  output     [3:0]    afu_c3_emif_axi_arcache,
  output     [3:0]    afu_c3_emif_axi_arqos,
  output     [63:0]   afu_c3_emif_axi_aruser,
  output     [2:0]    afu_c3_emif_axi_arprot,
  input               afu_c3_emif_axi_rvalid,
  output              afu_c3_emif_axi_rready,
  input      [511:0]  afu_c3_emif_axi_rdata,
  input      [7:0]    afu_c3_emif_axi_rid,
  input      [1:0]    afu_c3_emif_axi_rresp,
  input               afu_c3_emif_axi_rlast,
  input      [63:0]   afu_c3_emif_axi_ruser,
  output              afu_axi4_awvalid,
  input               afu_axi4_awready,
  output     [63:0]   afu_axi4_awaddr,
  output     [3:0]    afu_axi4_awid,
  output     [7:0]    afu_axi4_awlen,
  output     [2:0]    afu_axi4_awsize,
  output     [1:0]    afu_axi4_awburst,
  output     [0:0]    afu_axi4_awlock,
  output     [3:0]    afu_axi4_awcache,
  output     [3:0]    afu_axi4_awqos,
  output     [63:0]   afu_axi4_awuser,
  output     [2:0]    afu_axi4_awprot,
  output              afu_axi4_wvalid,
  input               afu_axi4_wready,
  output     [511:0]  afu_axi4_wdata,
  output     [63:0]   afu_axi4_wstrb,
  output     [3:0]    afu_axi4_wuser,
  output              afu_axi4_wlast,
  input               afu_axi4_bvalid,
  output              afu_axi4_bready,
  input      [3:0]    afu_axi4_bid,
  input      [1:0]    afu_axi4_bresp,
  input      [63:0]   afu_axi4_buser,
  output              afu_axi4_arvalid,
  input               afu_axi4_arready,
  output     [63:0]   afu_axi4_araddr,
  output     [3:0]    afu_axi4_arid,
  output     [7:0]    afu_axi4_arlen,
  output     [2:0]    afu_axi4_arsize,
  output     [1:0]    afu_axi4_arburst,
  output     [0:0]    afu_axi4_arlock,
  output     [3:0]    afu_axi4_arcache,
  output     [3:0]    afu_axi4_arqos,
  output     [63:0]   afu_axi4_aruser,
  output     [2:0]    afu_axi4_arprot,
  input               afu_axi4_rvalid,
  output              afu_axi4_rready,
  input      [511:0]  afu_axi4_rdata,
  input      [3:0]    afu_axi4_rid,
  input      [1:0]    afu_axi4_rresp,
  input               afu_axi4_rlast,
  input      [63:0]   afu_axi4_ruser,
  input               afu_alite4_awvalid,
  output              afu_alite4_awready,
  input      [31:0]   afu_alite4_awaddr,
  input      [2:0]    afu_alite4_awprot,
  input      [31:0]   afu_alite4_awuser,
  input               afu_alite4_wvalid,
  output              afu_alite4_wready,
  input      [63:0]   afu_alite4_wdata,
  input      [7:0]    afu_alite4_wstrb,
  output              afu_alite4_bvalid,
  input               afu_alite4_bready,
  output     [1:0]    afu_alite4_bresp,
  input               afu_alite4_arvalid,
  output              afu_alite4_arready,
  input      [31:0]   afu_alite4_araddr,
  input      [2:0]    afu_alite4_arprot,
  input      [31:0]   afu_alite4_aruser,
  output              afu_alite4_rvalid,
  input               afu_alite4_rready,
  output     [63:0]   afu_alite4_rdata,
  output     [1:0]    afu_alite4_rresp,
  output              user_msix_valid,
  input               user_msix_ready,
  output     [4:0]    user_msix_payload_vec,
  output     [7:0]    user_msix_payload_func
);
  reg        [63:0]   PCIeCD_DFH;
  wire       [127:0]  PCIeCD_UUID;

  wire               output_awvalid ;
  wire               output_awready ;
  wire       [31:0]   output_awaddr ;
  wire       [2:0]    output_awprot ;
  wire                output_wvalid ;
  wire                output_wready ;
  wire       [63:0]    output_wdata ;
  wire        [3:0]    output_wstrb ;
  wire                output_bvalid ;
  wire                output_bready ;
  wire        [1:0]    output_bresp ;
  wire               output_arvalid ;
  wire               output_arready ;
  wire       [31:0]   output_araddr ;
  wire       [2:0]    output_arprot ;
  wire                output_rvalid ;
  wire                output_rready ;
  wire        [63:0]   output_rdata ;
  wire        [1:0]    output_rresp ;

  function [63:0] zz_PCIeCD_DFH(input dummy);
    begin
      zz_PCIeCD_DFH = 64'h0;
      zz_PCIeCD_DFH[60] = 1'b1;
      zz_PCIeCD_DFH[40] = 1'b1;
    end
  endfunction
  wire [63:0] _zz_1;
  assign _zz_1 = zz_PCIeCD_DFH(1'b0);
  always @(*) PCIeCD_DFH = _zz_1;
  assign PCIeCD_UUID = 128'ha78438f11d0e4c3eabe02ca59ba8814a;

  assign afu_c0_emif_axi_awuser  =  0;
  assign afu_c0_emif_axi_wuser   =  0;
  assign afu_c0_emif_axi_aruser  =  0;
  assign afu_c0_emif_axi_aruser  =  0;

  assign afu_c1_emif_axi_awvalid =  0;
  assign afu_c1_emif_axi_awaddr  =  0;
  assign afu_c1_emif_axi_awid    =  0;
  assign afu_c1_emif_axi_awlen   =  0;
  assign afu_c1_emif_axi_awsize  =  0;
  assign afu_c1_emif_axi_awburst =  0;
  assign afu_c1_emif_axi_awlock  =  0;
  assign afu_c1_emif_axi_awcache =  0;
  assign afu_c1_emif_axi_awqos   =  0;
  assign afu_c1_emif_axi_awuser  =  0;
  assign afu_c1_emif_axi_awprot  =  0;
  assign afu_c1_emif_axi_wvalid  =  0;
  assign afu_c1_emif_axi_wdata   =  0;
  assign afu_c1_emif_axi_wstrb   =  0;
  assign afu_c1_emif_axi_wuser   =  0;
  assign afu_c1_emif_axi_wlast   =  0;
  assign afu_c1_emif_axi_bready  =  0;
  assign afu_c1_emif_axi_arvalid =  0;
  assign afu_c1_emif_axi_araddr  =  0;
  assign afu_c1_emif_axi_arid    =  0;
  assign afu_c1_emif_axi_arlen   =  0;
  assign afu_c1_emif_axi_arsize  =  0;
  assign afu_c1_emif_axi_arburst =  0;
  assign afu_c1_emif_axi_arlock  =  0;
  assign afu_c1_emif_axi_arcache =  0;
  assign afu_c1_emif_axi_arqos   =  0;
  assign afu_c1_emif_axi_aruser  =  0;
  assign afu_c1_emif_axi_arprot  =  0;
  assign afu_c1_emif_axi_rready  =  0;

  assign afu_c2_emif_axi_awvalid =  0;
  assign afu_c2_emif_axi_awaddr  =  0;
  assign afu_c2_emif_axi_awid    =  0;
  assign afu_c2_emif_axi_awlen   =  0;
  assign afu_c2_emif_axi_awsize  =  0;
  assign afu_c2_emif_axi_awburst =  0;
  assign afu_c2_emif_axi_awlock  =  0;
  assign afu_c2_emif_axi_awcache =  0;
  assign afu_c2_emif_axi_awqos   =  0;
  assign afu_c2_emif_axi_awuser  =  0;
  assign afu_c2_emif_axi_awprot  =  0;
  assign afu_c2_emif_axi_wvalid  =  0;
  assign afu_c2_emif_axi_wdata   =  0;
  assign afu_c2_emif_axi_wstrb   =  0;
  assign afu_c2_emif_axi_wuser   =  0;
  assign afu_c2_emif_axi_wlast   =  0;
  assign afu_c2_emif_axi_bready  =  0;
  assign afu_c2_emif_axi_arvalid =  0;
  assign afu_c2_emif_axi_araddr  =  0;
  assign afu_c2_emif_axi_arid    =  0;
  assign afu_c2_emif_axi_arlen   =  0;
  assign afu_c2_emif_axi_arsize  =  0;
  assign afu_c2_emif_axi_arburst =  0;
  assign afu_c2_emif_axi_arlock  =  0;
  assign afu_c2_emif_axi_arcache =  0;
  assign afu_c2_emif_axi_arqos   =  0;
  assign afu_c2_emif_axi_aruser  =  0;
  assign afu_c2_emif_axi_arprot  =  0;
  assign afu_c2_emif_axi_rready  =  0;
 
  assign afu_c3_emif_axi_awvalid =  0;
  assign afu_c3_emif_axi_awaddr  =  0;
  assign afu_c3_emif_axi_awid    =  0;
  assign afu_c3_emif_axi_awlen   =  0;
  assign afu_c3_emif_axi_awsize  =  0;
  assign afu_c3_emif_axi_awburst =  0;
  assign afu_c3_emif_axi_awlock  =  0;
  assign afu_c3_emif_axi_awcache =  0;
  assign afu_c3_emif_axi_awqos   =  0;
  assign afu_c3_emif_axi_awuser  =  0;
  assign afu_c3_emif_axi_awprot  =  0;
  assign afu_c3_emif_axi_wvalid  =  0;
  assign afu_c3_emif_axi_wdata   =  0;
  assign afu_c3_emif_axi_wstrb   =  0;
  assign afu_c3_emif_axi_wuser   =  0;
  assign afu_c3_emif_axi_wlast   =  0;
  assign afu_c3_emif_axi_bready  =  0;
  assign afu_c3_emif_axi_arvalid =  0;
  assign afu_c3_emif_axi_araddr  =  0;
  assign afu_c3_emif_axi_arid    =  0;
  assign afu_c3_emif_axi_arlen   =  0;
  assign afu_c3_emif_axi_arsize  =  0;
  assign afu_c3_emif_axi_arburst =  0;
  assign afu_c3_emif_axi_arlock  =  0;
  assign afu_c3_emif_axi_arcache =  0;
  assign afu_c3_emif_axi_arqos   =  0;
  assign afu_c3_emif_axi_aruser  =  0;
  assign afu_c3_emif_axi_arprot  =  0;
  assign afu_c3_emif_axi_rready  =  0;

  assign afu_axi4_awvalid    =  0;
  assign afu_axi4_awaddr     =  0;
  assign afu_axi4_awid       =  0;
  assign afu_axi4_awlen      =  0;
  assign afu_axi4_awsize     =  0;
  assign afu_axi4_awburst    =  0;
  assign afu_axi4_awlock     =  0;
  assign afu_axi4_awcache    =  0;
  assign afu_axi4_awqos      =  0;
  assign afu_axi4_awuser     =  0;
  assign afu_axi4_awprot     =  0;
  assign afu_axi4_wvalid     =  0;
  assign afu_axi4_wdata      =  0;
  assign afu_axi4_wstrb      =  0;
  assign afu_axi4_wuser      =  0;
  assign afu_axi4_wlast      =  0;
  assign afu_axi4_bready     =  0;
  assign afu_axi4_arvalid    =  0;
  assign afu_axi4_araddr     =  0;
  assign afu_axi4_arid       =  0;
  assign afu_axi4_arlen      =  0;
  assign afu_axi4_arsize     =  0;
  assign afu_axi4_arburst    =  0;
  assign afu_axi4_arlock     =  0;
  assign afu_axi4_arcache    =  0;
  assign afu_axi4_arqos      =  0;
  assign afu_axi4_aruser     =  0;
  assign afu_axi4_arprot     =  0;
  assign afu_axi4_rready     =  0;

  assign user_msix_valid         =  0;
  assign user_msix_payload_vec   =  0;
  assign user_msix_payload_func  =  0;

//litecc
ddr4Axi4LiteCCByToggle litecc(
  .input_awvalid      (afu_alite4_awvalid),
  .input_awready      (afu_alite4_awready),
  .input_awaddr       (afu_alite4_awaddr ),
  .input_awprot       (afu_alite4_awprot ),
  .input_wvalid       (afu_alite4_wvalid ),
  .input_wready       (afu_alite4_wready ),
  .input_wdata        (afu_alite4_wdata  ),
  .input_wstrb        (afu_alite4_wstrb  ),
  .input_bvalid       (afu_alite4_bvalid ),
  .input_bready       (afu_alite4_bready ),
  .input_bresp        (afu_alite4_bresp  ),
  .input_arvalid      (afu_alite4_arvalid),
  .input_arready      (afu_alite4_arready),
  .input_araddr       (afu_alite4_araddr ),
  .input_arprot       (afu_alite4_arprot ),
  .input_rvalid       (afu_alite4_rvalid ),
  .input_rready       (afu_alite4_rready ),
  .input_rdata        (afu_alite4_rdata  ),
  .input_rresp        (afu_alite4_rresp  ),

  .output_awvalid     (output_awvalid),
  .output_awready     (output_awready),
  .output_awaddr      (output_awaddr ),
  .output_awprot      (output_awprot ),
  .output_wvalid      (output_wvalid ),
  .output_wready      (output_wready ),
  .output_wdata       (output_wdata  ),
  .output_wstrb       (output_wstrb  ),
  .output_bvalid      (output_bvalid ),
  .output_bready      (output_bready ),
  .output_bresp       (output_bresp  ),
  .output_arvalid     (output_arvalid),
  .output_arready     (output_arready),
  .output_araddr      (output_araddr ),
  .output_arprot      (output_arprot ),
  .output_rvalid      (output_rvalid ),
  .output_rready      (output_rready ),
  .output_rdata       (output_rdata  ),
  .output_rresp       (output_rresp  ),
  .clkA_clk           (afu_pcie_core_clk      ), //lite 350M
  .clkA_reset         (afu_pcie_core_rst      ),
  .clkB_clk           (afu_c0_emif_clk        ), //ddr 333M
  .clkB_reset         (afu_c0_emif_user_rst   )
);
//ddr_test
  usr_ddr_access
#(
   .AXI_DATA_WIDTH          (512             )      
)
ddr_test(   
    .kernel_clk_300m        (afu_c0_emif_clk     )       ,   //300Mhz  mmcm output, reconfig clock
    .kernel_clk_rstn        (~afu_c0_emif_user_rst)       ,   //reset -active low 
    .ddr_usr_clk            (afu_c0_emif_clk     )       ,
    .ddr_usr_clk_rstn       (~afu_c0_emif_user_rst)       , 
    
    .ddr_alite_awvalid      (output_awvalid  )       ,  //the clock domain sys_alite_aclk
    .ddr_alite_awready      (output_awready  )       ,   
    .ddr_alite_awaddr       (output_awaddr   )       , 
    .ddr_alite_awprot       (output_awprot   )       ,
    .ddr_alite_wvalid       (output_wvalid   )       ,   
    .ddr_alite_wready       (output_wready   )       ,   
    .ddr_alite_wdata        (output_wdata    )       ,  
    .ddr_alite_wstrb        (output_wstrb    )       , 
    .ddr_alite_bvalid       (output_bvalid   )       ,   
    .ddr_alite_bready       (output_bready   )       ,   
    .ddr_alite_bresp        (output_bresp    )       ,   
    .ddr_alite_arvalid      (output_arvalid  )       ,   
    .ddr_alite_arready      (output_arready  )       ,   
    .ddr_alite_araddr       (output_araddr   )       , 
    .ddr_alite_arprot       (output_arprot   )       ,
    .ddr_alite_rvalid       (output_rvalid   )       ,   
    .ddr_alite_rready       (output_rready   )       ,   
    .ddr_alite_rdata        (output_rdata    )       ,   
    .ddr_alite_rresp        (output_rresp    )       , 

    //
    .c0_sys_axi_araddr      (afu_c0_emif_axi_araddr    )      ,
    .c0_sys_axi_arburst     (afu_c0_emif_axi_arburst   )      ,
    .c0_sys_axi_arcache     (afu_c0_emif_axi_arcache   )      ,
    .c0_sys_axi_arid        (afu_c0_emif_axi_arid      )      ,
    .c0_sys_axi_arlen       (afu_c0_emif_axi_arlen     )      ,
    .c0_sys_axi_arlock      (afu_c0_emif_axi_arlock    )      ,
    .c0_sys_axi_arprot      (afu_c0_emif_axi_arprot    )      ,
    .c0_sys_axi_arqos       (afu_c0_emif_axi_arqos     )      ,
    .c0_sys_axi_arready     (afu_c0_emif_axi_arready   )      ,
    .c0_sys_axi_arregion    (      ),
    .c0_sys_axi_arsize      (afu_c0_emif_axi_arsize    )      ,
    .c0_sys_axi_arvalid     (afu_c0_emif_axi_arvalid   )      ,
    .c0_sys_axi_awaddr      (afu_c0_emif_axi_awaddr    )      ,
    .c0_sys_axi_awburst     (afu_c0_emif_axi_awburst   )      ,
    .c0_sys_axi_awcache     (afu_c0_emif_axi_awcache   )      ,
    .c0_sys_axi_awid        (afu_c0_emif_axi_awid      )      ,
    .c0_sys_axi_awlen       (afu_c0_emif_axi_awlen     )      ,
    .c0_sys_axi_awlock      (afu_c0_emif_axi_awlock    )      ,
    .c0_sys_axi_awprot      (afu_c0_emif_axi_awprot    )      ,
    .c0_sys_axi_awqos       (afu_c0_emif_axi_awqos     )      ,
    .c0_sys_axi_awready     (afu_c0_emif_axi_awready   )      ,
    .c0_sys_axi_awsize      (afu_c0_emif_axi_awsize    )      ,
    .c0_sys_axi_awvalid     (afu_c0_emif_axi_awvalid   )      ,
    .c0_sys_axi_bid         (afu_c0_emif_axi_bid       )      ,
    .c0_sys_axi_bready      (afu_c0_emif_axi_bready    )      ,
    .c0_sys_axi_bresp       (afu_c0_emif_axi_bresp     )      ,
    .c0_sys_axi_bvalid      (afu_c0_emif_axi_bvalid    )      ,
    .c0_sys_axi_rdata       (afu_c0_emif_axi_rdata     )      ,
    .c0_sys_axi_rid         (afu_c0_emif_axi_rid       )      ,
    .c0_sys_axi_rlast       (afu_c0_emif_axi_rlast     )      ,
    .c0_sys_axi_rready      (afu_c0_emif_axi_rready    )      ,
    .c0_sys_axi_rresp       (afu_c0_emif_axi_rresp     )      ,
    .c0_sys_axi_rvalid      (afu_c0_emif_axi_rvalid    )      ,
    .c0_sys_axi_wdata       (afu_c0_emif_axi_wdata     )      ,
    .c0_sys_axi_wlast       (afu_c0_emif_axi_wlast     )      ,
    .c0_sys_axi_wready      (afu_c0_emif_axi_wready    )      ,
    .c0_sys_axi_wstrb       (afu_c0_emif_axi_wstrb     )      ,
    .c0_sys_axi_wvalid      (afu_c0_emif_axi_wvalid    )      ,     
    
    .ddr_cal_done           (afu_c0_emif_init_done     )      ,
//	 .ddr_cal_done 			 (c0_emif_init_done_6dly    )      ,
    .usr_int_en             (0       ),   //the clock domain kernel_clk_300m
    .usr_int_req            (        ),
    .usr_int_ack            (0       )     
);

endmodule
