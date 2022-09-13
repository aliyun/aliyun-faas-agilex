// Generator : SpinalHDL v1.5.0    git head : 83a031922866b078c411ec5529e00f1b6e79f8e7
// Component : user_logic
// Git hash  : 559c7ab7c778968a5a66d0fcd8b0342431581361
// Date      : 09/12/2021, 16:29:09



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
  wire       [31:0]   _zz_msixPorc_msixCount_valueNext;
  wire       [0:0]    _zz_msixPorc_msixCount_valueNext_1;
  wire       [63:0]   _zz_msixPorc_aliteFactory_readRsp_data_1;
  wire       [127:0]  msixPorc_UUID;
  reg        [63:0]   msixPorc_DFH;
  wire                msixPorc_mmio_ctrl_awvalid;
  wire                msixPorc_mmio_ctrl_awready;
  wire       [31:0]   msixPorc_mmio_ctrl_awaddr;
  wire       [2:0]    msixPorc_mmio_ctrl_awprot;
  wire                msixPorc_mmio_ctrl_wvalid;
  wire                msixPorc_mmio_ctrl_wready;
  wire       [63:0]   msixPorc_mmio_ctrl_wdata;
  wire       [7:0]    msixPorc_mmio_ctrl_wstrb;
  wire                msixPorc_mmio_ctrl_bvalid;
  wire                msixPorc_mmio_ctrl_bready;
  wire       [1:0]    msixPorc_mmio_ctrl_bresp;
  wire                msixPorc_mmio_ctrl_arvalid;
  wire                msixPorc_mmio_ctrl_arready;
  wire       [31:0]   msixPorc_mmio_ctrl_araddr;
  wire       [2:0]    msixPorc_mmio_ctrl_arprot;
  wire                msixPorc_mmio_ctrl_rvalid;
  wire                msixPorc_mmio_ctrl_rready;
  wire       [63:0]   msixPorc_mmio_ctrl_rdata;
  wire       [1:0]    msixPorc_mmio_ctrl_rresp;
  reg        [4:0]    msixPorc_interruptId;
  reg                 msixPorc_interruptTrigger;
  wire                when_Utils_l357;
  reg                 msixPorc_msixCount_willIncrement;
  wire                msixPorc_msixCount_willClear;
  reg        [31:0]   msixPorc_msixCount_valueNext;
  reg        [31:0]   msixPorc_msixCount_value;
  wire                msixPorc_msixCount_willOverflowIfInc;
  wire                msixPorc_msixCount_willOverflow;
  reg                 msixPorc_msixCountClear;
  wire                when_afu_interrupt_l82;
  wire                msixPorc_aliteFactory_readHaltRequest;
  wire                msixPorc_aliteFactory_writeHaltRequest;
  wire                msixPorc_aliteFactory_writeJoinEvent_valid;
  wire                msixPorc_aliteFactory_writeJoinEvent_ready;
  wire                _zz_msixPorc_mmio_ctrl_awready;
  wire       [1:0]    msixPorc_aliteFactory_writeRsp_resp;
  wire                msixPorc_aliteFactory_writeJoinEvent_translated_valid;
  wire                msixPorc_aliteFactory_writeJoinEvent_translated_ready;
  wire       [1:0]    msixPorc_aliteFactory_writeJoinEvent_translated_payload_resp;
  wire                _zz_msixPorc_mmio_ctrl_bvalid;
  wire                _zz_msixPorc_aliteFactory_writeJoinEvent_translated_ready;
  wire                _zz_msixPorc_mmio_ctrl_bvalid_1;
  reg                 _zz_msixPorc_mmio_ctrl_bvalid_2;
  reg        [1:0]    _zz_msixPorc_mmio_ctrl_bresp;
  wire                msixPorc_mmio_ctrl_ar_readDataStage_valid;
  wire                msixPorc_mmio_ctrl_ar_readDataStage_ready;
  wire       [31:0]   msixPorc_mmio_ctrl_ar_readDataStage_payload_addr;
  wire       [2:0]    msixPorc_mmio_ctrl_ar_readDataStage_payload_prot;
  reg                 msixPorc_mmio_ctrl_ar_rValid;
  reg        [31:0]   msixPorc_mmio_ctrl_ar_rData_addr;
  reg        [2:0]    msixPorc_mmio_ctrl_ar_rData_prot;
  reg        [63:0]   msixPorc_aliteFactory_readRsp_data;
  wire       [1:0]    msixPorc_aliteFactory_readRsp_resp;
  wire                _zz_msixPorc_mmio_ctrl_rvalid;
  wire                msixPorc_aliteFactory_writeOccur;
  wire                msixPorc_aliteFactory_readOccur;
  wire       [127:0]  _zz_msixPorc_aliteFactory_readRsp_data;
  wire                when_AxiLite4SlaveFactory_l62;
  wire                when_AxiLite4SlaveFactory_l62_1;
  wire                when_AxiLite4SlaveFactory_l62_2;
  function [63:0] zz_msixPorc_DFH(input dummy);
    begin
      zz_msixPorc_DFH = 64'h0;
      zz_msixPorc_DFH[60] = 1'b1;
      zz_msixPorc_DFH[40] = 1'b1;
    end
  endfunction
  wire [63:0] _zz_1;

  assign _zz_msixPorc_msixCount_valueNext_1 = msixPorc_msixCount_willIncrement;
  assign _zz_msixPorc_msixCount_valueNext = {31'd0, _zz_msixPorc_msixCount_valueNext_1};
  assign _zz_msixPorc_aliteFactory_readRsp_data_1 = msixPorc_DFH;
  assign afu_c0_emif_axi_awvalid = 1'b0;
  assign afu_c0_emif_axi_wvalid = 1'b0;
  assign afu_c0_emif_axi_bready = 1'b1;
  assign afu_c0_emif_axi_arvalid = 1'b0;
  assign afu_c0_emif_axi_rready = 1'b1;
  assign afu_c0_emif_axi_awaddr = 64'h0;
  assign afu_c0_emif_axi_araddr = 64'h0;
  assign afu_c0_emif_axi_awid = 8'h0;
  assign afu_c0_emif_axi_arid = 8'h0;
  assign afu_c0_emif_axi_awlen = 8'h0;
  assign afu_c0_emif_axi_arlen = 8'h0;
  assign afu_c0_emif_axi_awsize = 3'b000;
  assign afu_c0_emif_axi_arsize = 3'b000;
  assign afu_c0_emif_axi_awburst = 2'b00;
  assign afu_c0_emif_axi_arburst = 2'b00;
  assign afu_c0_emif_axi_awlock = 1'b0;
  assign afu_c0_emif_axi_arlock = 1'b0;
  assign afu_c0_emif_axi_awcache = 4'b0000;
  assign afu_c0_emif_axi_arcache = 4'b0000;
  assign afu_c0_emif_axi_awqos = 4'b0000;
  assign afu_c0_emif_axi_arqos = 4'b0000;
  assign afu_c0_emif_axi_awuser = 64'h0;
  assign afu_c0_emif_axi_aruser = 64'h0;
  assign afu_c0_emif_axi_awprot = 3'b000;
  assign afu_c0_emif_axi_arprot = 3'b000;
  assign afu_c0_emif_axi_wdata = 512'h0;
  assign afu_c0_emif_axi_wstrb = 64'h0;
  assign afu_c0_emif_axi_wuser = 4'b0000;
  assign afu_c0_emif_axi_wlast = 1'b0;
  assign afu_c1_emif_axi_awvalid = 1'b0;
  assign afu_c1_emif_axi_wvalid = 1'b0;
  assign afu_c1_emif_axi_bready = 1'b1;
  assign afu_c1_emif_axi_arvalid = 1'b0;
  assign afu_c1_emif_axi_rready = 1'b1;
  assign afu_c1_emif_axi_awaddr = 64'h0;
  assign afu_c1_emif_axi_araddr = 64'h0;
  assign afu_c1_emif_axi_awid = 8'h0;
  assign afu_c1_emif_axi_arid = 8'h0;
  assign afu_c1_emif_axi_awlen = 8'h0;
  assign afu_c1_emif_axi_arlen = 8'h0;
  assign afu_c1_emif_axi_awsize = 3'b000;
  assign afu_c1_emif_axi_arsize = 3'b000;
  assign afu_c1_emif_axi_awburst = 2'b00;
  assign afu_c1_emif_axi_arburst = 2'b00;
  assign afu_c1_emif_axi_awlock = 1'b0;
  assign afu_c1_emif_axi_arlock = 1'b0;
  assign afu_c1_emif_axi_awcache = 4'b0000;
  assign afu_c1_emif_axi_arcache = 4'b0000;
  assign afu_c1_emif_axi_awqos = 4'b0000;
  assign afu_c1_emif_axi_arqos = 4'b0000;
  assign afu_c1_emif_axi_awuser = 64'h0;
  assign afu_c1_emif_axi_aruser = 64'h0;
  assign afu_c1_emif_axi_awprot = 3'b000;
  assign afu_c1_emif_axi_arprot = 3'b000;
  assign afu_c1_emif_axi_wdata = 512'h0;
  assign afu_c1_emif_axi_wstrb = 64'h0;
  assign afu_c1_emif_axi_wuser = 4'b0000;
  assign afu_c1_emif_axi_wlast = 1'b0;
  assign afu_c2_emif_axi_awvalid = 1'b0;
  assign afu_c2_emif_axi_wvalid = 1'b0;
  assign afu_c2_emif_axi_bready = 1'b1;
  assign afu_c2_emif_axi_arvalid = 1'b0;
  assign afu_c2_emif_axi_rready = 1'b1;
  assign afu_c2_emif_axi_awaddr = 64'h0;
  assign afu_c2_emif_axi_araddr = 64'h0;
  assign afu_c2_emif_axi_awid = 8'h0;
  assign afu_c2_emif_axi_arid = 8'h0;
  assign afu_c2_emif_axi_awlen = 8'h0;
  assign afu_c2_emif_axi_arlen = 8'h0;
  assign afu_c2_emif_axi_awsize = 3'b000;
  assign afu_c2_emif_axi_arsize = 3'b000;
  assign afu_c2_emif_axi_awburst = 2'b00;
  assign afu_c2_emif_axi_arburst = 2'b00;
  assign afu_c2_emif_axi_awlock = 1'b0;
  assign afu_c2_emif_axi_arlock = 1'b0;
  assign afu_c2_emif_axi_awcache = 4'b0000;
  assign afu_c2_emif_axi_arcache = 4'b0000;
  assign afu_c2_emif_axi_awqos = 4'b0000;
  assign afu_c2_emif_axi_arqos = 4'b0000;
  assign afu_c2_emif_axi_awuser = 64'h0;
  assign afu_c2_emif_axi_aruser = 64'h0;
  assign afu_c2_emif_axi_awprot = 3'b000;
  assign afu_c2_emif_axi_arprot = 3'b000;
  assign afu_c2_emif_axi_wdata = 512'h0;
  assign afu_c2_emif_axi_wstrb = 64'h0;
  assign afu_c2_emif_axi_wuser = 4'b0000;
  assign afu_c2_emif_axi_wlast = 1'b0;
  assign afu_c3_emif_axi_awvalid = 1'b0;
  assign afu_c3_emif_axi_wvalid = 1'b0;
  assign afu_c3_emif_axi_bready = 1'b1;
  assign afu_c3_emif_axi_arvalid = 1'b0;
  assign afu_c3_emif_axi_rready = 1'b1;
  assign afu_c3_emif_axi_awaddr = 64'h0;
  assign afu_c3_emif_axi_araddr = 64'h0;
  assign afu_c3_emif_axi_awid = 8'h0;
  assign afu_c3_emif_axi_arid = 8'h0;
  assign afu_c3_emif_axi_awlen = 8'h0;
  assign afu_c3_emif_axi_arlen = 8'h0;
  assign afu_c3_emif_axi_awsize = 3'b000;
  assign afu_c3_emif_axi_arsize = 3'b000;
  assign afu_c3_emif_axi_awburst = 2'b00;
  assign afu_c3_emif_axi_arburst = 2'b00;
  assign afu_c3_emif_axi_awlock = 1'b0;
  assign afu_c3_emif_axi_arlock = 1'b0;
  assign afu_c3_emif_axi_awcache = 4'b0000;
  assign afu_c3_emif_axi_arcache = 4'b0000;
  assign afu_c3_emif_axi_awqos = 4'b0000;
  assign afu_c3_emif_axi_arqos = 4'b0000;
  assign afu_c3_emif_axi_awuser = 64'h0;
  assign afu_c3_emif_axi_aruser = 64'h0;
  assign afu_c3_emif_axi_awprot = 3'b000;
  assign afu_c3_emif_axi_arprot = 3'b000;
  assign afu_c3_emif_axi_wdata = 512'h0;
  assign afu_c3_emif_axi_wstrb = 64'h0;
  assign afu_c3_emif_axi_wuser = 4'b0000;
  assign afu_c3_emif_axi_wlast = 1'b0;
  assign afu_axi4_awvalid = 1'b0;
  assign afu_axi4_wvalid = 1'b0;
  assign afu_axi4_bready = 1'b1;
  assign afu_axi4_arvalid = 1'b0;
  assign afu_axi4_rready = 1'b1;
  assign afu_axi4_awaddr = 64'h0;
  assign afu_axi4_araddr = 64'h0;
  assign afu_axi4_awid = 4'b0000;
  assign afu_axi4_arid = 4'b0000;
  assign afu_axi4_awlen = 8'h0;
  assign afu_axi4_arlen = 8'h0;
  assign afu_axi4_awsize = 3'b000;
  assign afu_axi4_arsize = 3'b000;
  assign afu_axi4_awburst = 2'b00;
  assign afu_axi4_arburst = 2'b00;
  assign afu_axi4_awlock = 1'b0;
  assign afu_axi4_arlock = 1'b0;
  assign afu_axi4_awcache = 4'b0000;
  assign afu_axi4_arcache = 4'b0000;
  assign afu_axi4_awqos = 4'b0000;
  assign afu_axi4_arqos = 4'b0000;
  assign afu_axi4_awuser = 64'h0;
  assign afu_axi4_aruser = 64'h0;
  assign afu_axi4_awprot = 3'b000;
  assign afu_axi4_arprot = 3'b000;
  assign afu_axi4_wdata = 512'h0;
  assign afu_axi4_wstrb = 64'h0;
  assign afu_axi4_wuser = 4'b0000;
  assign afu_axi4_wlast = 1'b0;
  assign _zz_1 = zz_msixPorc_DFH(1'b0);
  always @(*) msixPorc_DFH = _zz_1;
  assign msixPorc_UUID = 128'hc6aa954a9b914a37abc11d9f0709dcc4;
  assign msixPorc_mmio_ctrl_awvalid = afu_alite4_awvalid;
  assign afu_alite4_awready = msixPorc_mmio_ctrl_awready;
  assign msixPorc_mmio_ctrl_awaddr = afu_alite4_awaddr;
  assign msixPorc_mmio_ctrl_awprot = afu_alite4_awprot;
  assign msixPorc_mmio_ctrl_wvalid = afu_alite4_wvalid;
  assign msixPorc_mmio_ctrl_wdata = afu_alite4_wdata;
  assign msixPorc_mmio_ctrl_wstrb = afu_alite4_wstrb;
  assign afu_alite4_wready = msixPorc_mmio_ctrl_wready;
  assign afu_alite4_bvalid = msixPorc_mmio_ctrl_bvalid;
  assign msixPorc_mmio_ctrl_bready = afu_alite4_bready;
  assign afu_alite4_bresp = msixPorc_mmio_ctrl_bresp;
  assign msixPorc_mmio_ctrl_arvalid = afu_alite4_arvalid;
  assign afu_alite4_arready = msixPorc_mmio_ctrl_arready;
  assign msixPorc_mmio_ctrl_araddr = afu_alite4_araddr;
  assign msixPorc_mmio_ctrl_arprot = afu_alite4_arprot;
  assign afu_alite4_rvalid = msixPorc_mmio_ctrl_rvalid;
  assign afu_alite4_rdata = msixPorc_mmio_ctrl_rdata;
  assign afu_alite4_rresp = msixPorc_mmio_ctrl_rresp;
  assign msixPorc_mmio_ctrl_rready = afu_alite4_rready;
  assign when_Utils_l357 = (user_msix_valid && user_msix_ready);
  always @(*) begin
    msixPorc_msixCount_willIncrement = 1'b0;
    if(when_Utils_l357) begin
      msixPorc_msixCount_willIncrement = 1'b1;
    end
  end

  assign msixPorc_msixCount_willClear = 1'b0;
  assign msixPorc_msixCount_willOverflowIfInc = (msixPorc_msixCount_value == 32'hffffffff);
  assign msixPorc_msixCount_willOverflow = (msixPorc_msixCount_willOverflowIfInc && msixPorc_msixCount_willIncrement);
  always @(*) begin
    msixPorc_msixCount_valueNext = (msixPorc_msixCount_value + _zz_msixPorc_msixCount_valueNext);
    if(msixPorc_msixCount_willClear) begin
      msixPorc_msixCount_valueNext = 32'h0;
    end
  end

  assign user_msix_valid = msixPorc_interruptTrigger;
  assign user_msix_payload_vec = msixPorc_interruptId;
  assign user_msix_payload_func = 8'h0;
  assign when_afu_interrupt_l82 = (user_msix_valid && user_msix_ready);
  assign msixPorc_aliteFactory_readHaltRequest = 1'b0;
  assign msixPorc_aliteFactory_writeHaltRequest = 1'b0;
  assign _zz_msixPorc_mmio_ctrl_awready = (msixPorc_aliteFactory_writeJoinEvent_valid && msixPorc_aliteFactory_writeJoinEvent_ready);
  assign msixPorc_aliteFactory_writeJoinEvent_valid = (msixPorc_mmio_ctrl_awvalid && msixPorc_mmio_ctrl_wvalid);
  assign msixPorc_mmio_ctrl_awready = _zz_msixPorc_mmio_ctrl_awready;
  assign msixPorc_mmio_ctrl_wready = _zz_msixPorc_mmio_ctrl_awready;
  assign msixPorc_aliteFactory_writeJoinEvent_translated_valid = msixPorc_aliteFactory_writeJoinEvent_valid;
  assign msixPorc_aliteFactory_writeJoinEvent_ready = msixPorc_aliteFactory_writeJoinEvent_translated_ready;
  assign msixPorc_aliteFactory_writeJoinEvent_translated_payload_resp = msixPorc_aliteFactory_writeRsp_resp;
  assign _zz_msixPorc_mmio_ctrl_bvalid = (! msixPorc_aliteFactory_writeHaltRequest);
  assign msixPorc_aliteFactory_writeJoinEvent_translated_ready = (_zz_msixPorc_aliteFactory_writeJoinEvent_translated_ready && _zz_msixPorc_mmio_ctrl_bvalid);
  assign _zz_msixPorc_aliteFactory_writeJoinEvent_translated_ready = ((1'b1 && (! _zz_msixPorc_mmio_ctrl_bvalid_1)) || msixPorc_mmio_ctrl_bready);
  assign _zz_msixPorc_mmio_ctrl_bvalid_1 = _zz_msixPorc_mmio_ctrl_bvalid_2;
  assign msixPorc_mmio_ctrl_bvalid = _zz_msixPorc_mmio_ctrl_bvalid_1;
  assign msixPorc_mmio_ctrl_bresp = _zz_msixPorc_mmio_ctrl_bresp;
  assign msixPorc_mmio_ctrl_arready = ((1'b1 && (! msixPorc_mmio_ctrl_ar_readDataStage_valid)) || msixPorc_mmio_ctrl_ar_readDataStage_ready);
  assign msixPorc_mmio_ctrl_ar_readDataStage_valid = msixPorc_mmio_ctrl_ar_rValid;
  assign msixPorc_mmio_ctrl_ar_readDataStage_payload_addr = msixPorc_mmio_ctrl_ar_rData_addr;
  assign msixPorc_mmio_ctrl_ar_readDataStage_payload_prot = msixPorc_mmio_ctrl_ar_rData_prot;
  assign _zz_msixPorc_mmio_ctrl_rvalid = (! msixPorc_aliteFactory_readHaltRequest);
  assign msixPorc_mmio_ctrl_ar_readDataStage_ready = (msixPorc_mmio_ctrl_rready && _zz_msixPorc_mmio_ctrl_rvalid);
  assign msixPorc_mmio_ctrl_rvalid = (msixPorc_mmio_ctrl_ar_readDataStage_valid && _zz_msixPorc_mmio_ctrl_rvalid);
  assign msixPorc_mmio_ctrl_rdata = msixPorc_aliteFactory_readRsp_data;
  assign msixPorc_mmio_ctrl_rresp = msixPorc_aliteFactory_readRsp_resp;
  assign msixPorc_aliteFactory_writeRsp_resp = 2'b00;
  assign msixPorc_aliteFactory_readRsp_resp = 2'b00;
  always @(*) begin
    msixPorc_aliteFactory_readRsp_data = 64'h0;
    case(msixPorc_mmio_ctrl_ar_readDataStage_payload_addr)
      32'h00000030 : begin
        msixPorc_aliteFactory_readRsp_data[4 : 0] = msixPorc_interruptId;
      end
      32'h00000038 : begin
        msixPorc_aliteFactory_readRsp_data[0 : 0] = msixPorc_interruptTrigger;
      end
      32'h00000040 : begin
        msixPorc_aliteFactory_readRsp_data[31 : 0] = msixPorc_msixCount_value;
      end
      32'h00000048 : begin
        msixPorc_aliteFactory_readRsp_data[0 : 0] = msixPorc_msixCountClear;
      end
      default : begin
      end
    endcase
    if(when_AxiLite4SlaveFactory_l62) begin
      msixPorc_aliteFactory_readRsp_data[63 : 0] = _zz_msixPorc_aliteFactory_readRsp_data_1[63 : 0];
    end
    if(when_AxiLite4SlaveFactory_l62_1) begin
      msixPorc_aliteFactory_readRsp_data[63 : 0] = _zz_msixPorc_aliteFactory_readRsp_data[63 : 0];
    end
    if(when_AxiLite4SlaveFactory_l62_2) begin
      msixPorc_aliteFactory_readRsp_data[63 : 0] = _zz_msixPorc_aliteFactory_readRsp_data[127 : 64];
    end
  end

  assign msixPorc_aliteFactory_writeOccur = (msixPorc_aliteFactory_writeJoinEvent_valid && msixPorc_aliteFactory_writeJoinEvent_ready);
  assign msixPorc_aliteFactory_readOccur = (msixPorc_mmio_ctrl_rvalid && msixPorc_mmio_ctrl_rready);
  assign _zz_msixPorc_aliteFactory_readRsp_data = msixPorc_UUID;
  assign when_AxiLite4SlaveFactory_l62 = ((msixPorc_mmio_ctrl_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h0);
  assign when_AxiLite4SlaveFactory_l62_1 = ((msixPorc_mmio_ctrl_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h00000008);
  assign when_AxiLite4SlaveFactory_l62_2 = ((msixPorc_mmio_ctrl_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h00000010);
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      msixPorc_interruptTrigger <= 1'b0;
      msixPorc_msixCount_value <= 32'h0;
      msixPorc_msixCountClear <= 1'b0;
      _zz_msixPorc_mmio_ctrl_bvalid_2 <= 1'b0;
      msixPorc_mmio_ctrl_ar_rValid <= 1'b0;
    end else begin
      msixPorc_msixCount_value <= msixPorc_msixCount_valueNext;
      if(when_afu_interrupt_l82) begin
        msixPorc_interruptTrigger <= 1'b0;
      end
      if(msixPorc_msixCountClear) begin
        msixPorc_msixCount_value <= 32'h0;
      end
      if(_zz_msixPorc_aliteFactory_writeJoinEvent_translated_ready) begin
        _zz_msixPorc_mmio_ctrl_bvalid_2 <= (msixPorc_aliteFactory_writeJoinEvent_translated_valid && _zz_msixPorc_mmio_ctrl_bvalid);
      end
      if(msixPorc_mmio_ctrl_arready) begin
        msixPorc_mmio_ctrl_ar_rValid <= msixPorc_mmio_ctrl_arvalid;
      end
      case(msixPorc_mmio_ctrl_awaddr)
        32'h00000038 : begin
          if(msixPorc_aliteFactory_writeOccur) begin
            msixPorc_interruptTrigger <= msixPorc_mmio_ctrl_wdata[0];
          end
        end
        32'h00000048 : begin
          if(msixPorc_aliteFactory_writeOccur) begin
            msixPorc_msixCountClear <= msixPorc_mmio_ctrl_wdata[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(_zz_msixPorc_aliteFactory_writeJoinEvent_translated_ready) begin
      _zz_msixPorc_mmio_ctrl_bresp <= msixPorc_aliteFactory_writeJoinEvent_translated_payload_resp;
    end
    if(msixPorc_mmio_ctrl_arready) begin
      msixPorc_mmio_ctrl_ar_rData_addr <= msixPorc_mmio_ctrl_araddr;
      msixPorc_mmio_ctrl_ar_rData_prot <= msixPorc_mmio_ctrl_arprot;
    end
    case(msixPorc_mmio_ctrl_awaddr)
      32'h00000030 : begin
        if(msixPorc_aliteFactory_writeOccur) begin
          msixPorc_interruptId <= msixPorc_mmio_ctrl_wdata[4 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule
