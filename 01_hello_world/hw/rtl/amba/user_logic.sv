// Generator : SpinalHDL v1.5.0    git head : 83a031922866b078c411ec5529e00f1b6e79f8e7
// Component : user_logic
// Git hash  : 8f35d589e85fa17aeadd0f5b7f4f5a5dba5c7fcb
// Date      : 25/11/2021, 15:24:40



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
  wire                afuAxi4CC_io_input_ar_ready;
  wire                afuAxi4CC_io_input_aw_ready;
  wire                afuAxi4CC_io_input_w_ready;
  wire                afuAxi4CC_io_input_r_valid;
  wire       [511:0]  afuAxi4CC_io_input_r_payload_data;
  wire       [3:0]    afuAxi4CC_io_input_r_payload_id;
  wire       [1:0]    afuAxi4CC_io_input_r_payload_resp;
  wire                afuAxi4CC_io_input_r_payload_last;
  wire       [63:0]   afuAxi4CC_io_input_r_payload_user;
  wire                afuAxi4CC_io_input_b_valid;
  wire       [3:0]    afuAxi4CC_io_input_b_payload_id;
  wire       [1:0]    afuAxi4CC_io_input_b_payload_resp;
  wire       [63:0]   afuAxi4CC_io_input_b_payload_user;
  wire                afuAxi4CC_io_output_ar_valid;
  wire       [63:0]   afuAxi4CC_io_output_ar_payload_addr;
  wire       [3:0]    afuAxi4CC_io_output_ar_payload_id;
  wire       [7:0]    afuAxi4CC_io_output_ar_payload_len;
  wire       [2:0]    afuAxi4CC_io_output_ar_payload_size;
  wire       [1:0]    afuAxi4CC_io_output_ar_payload_burst;
  wire       [0:0]    afuAxi4CC_io_output_ar_payload_lock;
  wire       [3:0]    afuAxi4CC_io_output_ar_payload_cache;
  wire       [3:0]    afuAxi4CC_io_output_ar_payload_qos;
  wire       [63:0]   afuAxi4CC_io_output_ar_payload_user;
  wire       [2:0]    afuAxi4CC_io_output_ar_payload_prot;
  wire                afuAxi4CC_io_output_aw_valid;
  wire       [63:0]   afuAxi4CC_io_output_aw_payload_addr;
  wire       [3:0]    afuAxi4CC_io_output_aw_payload_id;
  wire       [7:0]    afuAxi4CC_io_output_aw_payload_len;
  wire       [2:0]    afuAxi4CC_io_output_aw_payload_size;
  wire       [1:0]    afuAxi4CC_io_output_aw_payload_burst;
  wire       [0:0]    afuAxi4CC_io_output_aw_payload_lock;
  wire       [3:0]    afuAxi4CC_io_output_aw_payload_cache;
  wire       [3:0]    afuAxi4CC_io_output_aw_payload_qos;
  wire       [63:0]   afuAxi4CC_io_output_aw_payload_user;
  wire       [2:0]    afuAxi4CC_io_output_aw_payload_prot;
  wire                afuAxi4CC_io_output_w_valid;
  wire       [511:0]  afuAxi4CC_io_output_w_payload_data;
  wire       [63:0]   afuAxi4CC_io_output_w_payload_strb;
  wire       [3:0]    afuAxi4CC_io_output_w_payload_user;
  wire                afuAxi4CC_io_output_w_payload_last;
  wire                afuAxi4CC_io_output_r_ready;
  wire                afuAxi4CC_io_output_b_ready;
  wire                pcieCD_afuAliteSlice_input_awready;
  wire                pcieCD_afuAliteSlice_input_wready;
  wire                pcieCD_afuAliteSlice_input_bvalid;
  wire       [1:0]    pcieCD_afuAliteSlice_input_bresp;
  wire                pcieCD_afuAliteSlice_input_arready;
  wire                pcieCD_afuAliteSlice_input_rvalid;
  wire       [63:0]   pcieCD_afuAliteSlice_input_rdata;
  wire       [1:0]    pcieCD_afuAliteSlice_input_rresp;
  wire                pcieCD_afuAliteSlice_output_awvalid;
  wire       [31:0]   pcieCD_afuAliteSlice_output_awaddr;
  wire       [2:0]    pcieCD_afuAliteSlice_output_awprot;
  wire       [31:0]   pcieCD_afuAliteSlice_output_awuser;
  wire                pcieCD_afuAliteSlice_output_wvalid;
  wire       [63:0]   pcieCD_afuAliteSlice_output_wdata;
  wire       [7:0]    pcieCD_afuAliteSlice_output_wstrb;
  wire                pcieCD_afuAliteSlice_output_bready;
  wire                pcieCD_afuAliteSlice_output_arvalid;
  wire       [31:0]   pcieCD_afuAliteSlice_output_araddr;
  wire       [2:0]    pcieCD_afuAliteSlice_output_arprot;
  wire       [31:0]   pcieCD_afuAliteSlice_output_aruser;
  wire                pcieCD_afuAliteSlice_output_rready;
  wire                axi4Slice_1_input_arready;
  wire                axi4Slice_1_input_awready;
  wire                axi4Slice_1_input_wready;
  wire                axi4Slice_1_input_rvalid;
  wire       [511:0]  axi4Slice_1_input_rdata;
  wire       [3:0]    axi4Slice_1_input_rid;
  wire       [1:0]    axi4Slice_1_input_rresp;
  wire                axi4Slice_1_input_rlast;
  wire       [63:0]   axi4Slice_1_input_ruser;
  wire                axi4Slice_1_input_bvalid;
  wire       [3:0]    axi4Slice_1_input_bid;
  wire       [1:0]    axi4Slice_1_input_bresp;
  wire       [63:0]   axi4Slice_1_input_buser;
  wire                axi4Slice_1_output_arvalid;
  wire       [63:0]   axi4Slice_1_output_araddr;
  wire       [3:0]    axi4Slice_1_output_arid;
  wire       [7:0]    axi4Slice_1_output_arlen;
  wire       [2:0]    axi4Slice_1_output_arsize;
  wire       [1:0]    axi4Slice_1_output_arburst;
  wire       [0:0]    axi4Slice_1_output_arlock;
  wire       [3:0]    axi4Slice_1_output_arcache;
  wire       [3:0]    axi4Slice_1_output_arqos;
  wire       [63:0]   axi4Slice_1_output_aruser;
  wire       [2:0]    axi4Slice_1_output_arprot;
  wire                axi4Slice_1_output_awvalid;
  wire       [63:0]   axi4Slice_1_output_awaddr;
  wire       [3:0]    axi4Slice_1_output_awid;
  wire       [7:0]    axi4Slice_1_output_awlen;
  wire       [2:0]    axi4Slice_1_output_awsize;
  wire       [1:0]    axi4Slice_1_output_awburst;
  wire       [0:0]    axi4Slice_1_output_awlock;
  wire       [3:0]    axi4Slice_1_output_awcache;
  wire       [3:0]    axi4Slice_1_output_awqos;
  wire       [63:0]   axi4Slice_1_output_awuser;
  wire       [2:0]    axi4Slice_1_output_awprot;
  wire                axi4Slice_1_output_wvalid;
  wire       [511:0]  axi4Slice_1_output_wdata;
  wire       [63:0]   axi4Slice_1_output_wstrb;
  wire       [3:0]    axi4Slice_1_output_wuser;
  wire                axi4Slice_1_output_wlast;
  wire                axi4Slice_1_output_rready;
  wire                axi4Slice_1_output_bready;
  wire                afuAliteCC_input_awready;
  wire                afuAliteCC_input_wready;
  wire                afuAliteCC_input_bvalid;
  wire       [1:0]    afuAliteCC_input_bresp;
  wire                afuAliteCC_input_arready;
  wire                afuAliteCC_input_rvalid;
  wire       [63:0]   afuAliteCC_input_rdata;
  wire       [1:0]    afuAliteCC_input_rresp;
  wire                afuAliteCC_output_awvalid;
  wire       [31:0]   afuAliteCC_output_awaddr;
  wire       [2:0]    afuAliteCC_output_awprot;
  wire       [31:0]   afuAliteCC_output_awuser;
  wire                afuAliteCC_output_wvalid;
  wire       [63:0]   afuAliteCC_output_wdata;
  wire       [7:0]    afuAliteCC_output_wstrb;
  wire                afuAliteCC_output_bready;
  wire                afuAliteCC_output_arvalid;
  wire       [31:0]   afuAliteCC_output_araddr;
  wire       [2:0]    afuAliteCC_output_arprot;
  wire       [31:0]   afuAliteCC_output_aruser;
  wire                afuAliteCC_output_rready;
  wire                userCD_wCmdEvent_fork_io_input_ready;
  wire                userCD_wCmdEvent_fork_io_outputs_0_valid;
  wire                userCD_wCmdEvent_fork_io_outputs_1_valid;
  wire                userCD_wCmdEvent_fork_io_outputs_2_valid;
  wire       [63:0]   _zz_userCD_targetAddr;
  wire       [63:0]   _zz_userCD_targetAddr_1;
  wire       [63:0]   _zz_userCD_aliteFactory_readRsp_data_1;
  wire       [63:0]   _zz_userCD_aliteFactory_readRsp_data_2;
  wire                userCD_alite_awvalid;
  wire                userCD_alite_awready;
  wire       [31:0]   userCD_alite_awaddr;
  wire       [2:0]    userCD_alite_awprot;
  wire                userCD_alite_wvalid;
  wire                userCD_alite_wready;
  wire       [63:0]   userCD_alite_wdata;
  wire       [7:0]    userCD_alite_wstrb;
  wire                userCD_alite_bvalid;
  wire                userCD_alite_bready;
  wire       [1:0]    userCD_alite_bresp;
  wire                userCD_alite_arvalid;
  wire                userCD_alite_arready;
  wire       [31:0]   userCD_alite_araddr;
  wire       [2:0]    userCD_alite_arprot;
  wire                userCD_alite_rvalid;
  wire                userCD_alite_rready;
  wire       [63:0]   userCD_alite_rdata;
  wire       [1:0]    userCD_alite_rresp;
  wire                userCD_axiPort_aw_valid;
  wire                userCD_axiPort_aw_ready;
  wire       [63:0]   userCD_axiPort_aw_payload_addr;
  wire       [3:0]    userCD_axiPort_aw_payload_id;
  wire       [7:0]    userCD_axiPort_aw_payload_len;
  wire       [2:0]    userCD_axiPort_aw_payload_size;
  wire       [1:0]    userCD_axiPort_aw_payload_burst;
  wire       [0:0]    userCD_axiPort_aw_payload_lock;
  wire       [3:0]    userCD_axiPort_aw_payload_cache;
  wire       [3:0]    userCD_axiPort_aw_payload_qos;
  wire       [63:0]   userCD_axiPort_aw_payload_user;
  wire       [2:0]    userCD_axiPort_aw_payload_prot;
  wire                userCD_axiPort_w_valid;
  wire                userCD_axiPort_w_ready;
  wire       [511:0]  userCD_axiPort_w_payload_data;
  wire       [63:0]   userCD_axiPort_w_payload_strb;
  wire       [3:0]    userCD_axiPort_w_payload_user;
  wire                userCD_axiPort_w_payload_last;
  wire                userCD_axiPort_b_valid;
  wire                userCD_axiPort_b_ready;
  wire       [3:0]    userCD_axiPort_b_payload_id;
  wire       [1:0]    userCD_axiPort_b_payload_resp;
  wire       [63:0]   userCD_axiPort_b_payload_user;
  wire                userCD_axiPort_ar_valid;
  wire                userCD_axiPort_ar_ready;
  wire       [63:0]   userCD_axiPort_ar_payload_addr;
  wire       [3:0]    userCD_axiPort_ar_payload_id;
  wire       [7:0]    userCD_axiPort_ar_payload_len;
  wire       [2:0]    userCD_axiPort_ar_payload_size;
  wire       [1:0]    userCD_axiPort_ar_payload_burst;
  wire       [0:0]    userCD_axiPort_ar_payload_lock;
  wire       [3:0]    userCD_axiPort_ar_payload_cache;
  wire       [3:0]    userCD_axiPort_ar_payload_qos;
  wire       [63:0]   userCD_axiPort_ar_payload_user;
  wire       [2:0]    userCD_axiPort_ar_payload_prot;
  wire                userCD_axiPort_r_valid;
  wire                userCD_axiPort_r_ready;
  wire       [511:0]  userCD_axiPort_r_payload_data;
  wire       [3:0]    userCD_axiPort_r_payload_id;
  wire       [1:0]    userCD_axiPort_r_payload_resp;
  wire                userCD_axiPort_r_payload_last;
  wire       [63:0]   userCD_axiPort_r_payload_user;
  reg        [63:0]   userCD_DFH;
  wire       [127:0]  userCD_UUID;
  reg        [63:0]   userCD_targetAddr;
  reg                 userCD_start;
  reg                 userCD_done;
  wire                userCD_aliteFactory_readHaltRequest;
  wire                userCD_aliteFactory_writeHaltRequest;
  wire                userCD_aliteFactory_writeJoinEvent_valid;
  wire                userCD_aliteFactory_writeJoinEvent_ready;
  wire                _zz_userCD_alite_awready;
  wire       [1:0]    userCD_aliteFactory_writeRsp_resp;
  wire                userCD_aliteFactory_writeJoinEvent_translated_valid;
  wire                userCD_aliteFactory_writeJoinEvent_translated_ready;
  wire       [1:0]    userCD_aliteFactory_writeJoinEvent_translated_payload_resp;
  wire                _zz_userCD_alite_bvalid;
  wire                _zz_userCD_aliteFactory_writeJoinEvent_translated_ready;
  wire                _zz_userCD_alite_bvalid_1;
  reg                 _zz_userCD_alite_bvalid_2;
  reg        [1:0]    _zz_userCD_alite_bresp;
  wire                userCD_alite_ar_readDataStage_valid;
  wire                userCD_alite_ar_readDataStage_ready;
  wire       [31:0]   userCD_alite_ar_readDataStage_payload_addr;
  wire       [2:0]    userCD_alite_ar_readDataStage_payload_prot;
  reg                 userCD_alite_ar_rValid;
  reg        [31:0]   userCD_alite_ar_rData_addr;
  reg        [2:0]    userCD_alite_ar_rData_prot;
  reg        [63:0]   userCD_aliteFactory_readRsp_data;
  wire       [1:0]    userCD_aliteFactory_readRsp_resp;
  wire                _zz_userCD_alite_rvalid;
  wire                userCD_aliteFactory_writeOccur;
  wire                userCD_aliteFactory_readOccur;
  wire       [127:0]  _zz_userCD_aliteFactory_readRsp_data;
  wire                userCD_wCmdEvent_valid;
  wire                userCD_wCmdEvent_ready;
  reg                 userCD_start_regNext;
  wire                when_hello_world_l126;
  wire                when_hello_world_l129;
  wire                when_AxiLite4SlaveFactory_l47;
  wire                when_AxiLite4SlaveFactory_l62;
  wire                when_AxiLite4SlaveFactory_l62_1;
  wire                when_AxiLite4SlaveFactory_l62_2;
  wire                when_AxiLite4SlaveFactory_l62_3;
  function [63:0] zz_userCD_DFH(input dummy);
    begin
      zz_userCD_DFH = 64'h0;
      zz_userCD_DFH[60] = 1'b1;
      zz_userCD_DFH[40] = 1'b1;
    end
  endfunction
  wire [63:0] _zz_1;

  assign _zz_userCD_targetAddr_1 = userCD_alite_wdata[63 : 0];
  assign _zz_userCD_targetAddr = _zz_userCD_targetAddr_1;
  assign _zz_userCD_aliteFactory_readRsp_data_1 = userCD_DFH;
  assign _zz_userCD_aliteFactory_readRsp_data_2 = userCD_targetAddr;
  Axi4CC afuAxi4CC (
    .io_input_aw_valid             (userCD_axiPort_aw_valid               ), //i
    .io_input_aw_ready             (afuAxi4CC_io_input_aw_ready           ), //o
    .io_input_aw_payload_addr      (userCD_axiPort_aw_payload_addr        ), //i
    .io_input_aw_payload_id        (userCD_axiPort_aw_payload_id          ), //i
    .io_input_aw_payload_len       (userCD_axiPort_aw_payload_len         ), //i
    .io_input_aw_payload_size      (userCD_axiPort_aw_payload_size        ), //i
    .io_input_aw_payload_burst     (userCD_axiPort_aw_payload_burst       ), //i
    .io_input_aw_payload_lock      (userCD_axiPort_aw_payload_lock        ), //i
    .io_input_aw_payload_cache     (userCD_axiPort_aw_payload_cache       ), //i
    .io_input_aw_payload_qos       (userCD_axiPort_aw_payload_qos         ), //i
    .io_input_aw_payload_user      (userCD_axiPort_aw_payload_user        ), //i
    .io_input_aw_payload_prot      (userCD_axiPort_aw_payload_prot        ), //i
    .io_input_w_valid              (userCD_axiPort_w_valid                ), //i
    .io_input_w_ready              (afuAxi4CC_io_input_w_ready            ), //o
    .io_input_w_payload_data       (userCD_axiPort_w_payload_data         ), //i
    .io_input_w_payload_strb       (userCD_axiPort_w_payload_strb         ), //i
    .io_input_w_payload_user       (userCD_axiPort_w_payload_user         ), //i
    .io_input_w_payload_last       (userCD_axiPort_w_payload_last         ), //i
    .io_input_b_valid              (afuAxi4CC_io_input_b_valid            ), //o
    .io_input_b_ready              (userCD_axiPort_b_ready                ), //i
    .io_input_b_payload_id         (afuAxi4CC_io_input_b_payload_id       ), //o
    .io_input_b_payload_resp       (afuAxi4CC_io_input_b_payload_resp     ), //o
    .io_input_b_payload_user       (afuAxi4CC_io_input_b_payload_user     ), //o
    .io_input_ar_valid             (userCD_axiPort_ar_valid               ), //i
    .io_input_ar_ready             (afuAxi4CC_io_input_ar_ready           ), //o
    .io_input_ar_payload_addr      (userCD_axiPort_ar_payload_addr        ), //i
    .io_input_ar_payload_id        (userCD_axiPort_ar_payload_id          ), //i
    .io_input_ar_payload_len       (userCD_axiPort_ar_payload_len         ), //i
    .io_input_ar_payload_size      (userCD_axiPort_ar_payload_size        ), //i
    .io_input_ar_payload_burst     (userCD_axiPort_ar_payload_burst       ), //i
    .io_input_ar_payload_lock      (userCD_axiPort_ar_payload_lock        ), //i
    .io_input_ar_payload_cache     (userCD_axiPort_ar_payload_cache       ), //i
    .io_input_ar_payload_qos       (userCD_axiPort_ar_payload_qos         ), //i
    .io_input_ar_payload_user      (userCD_axiPort_ar_payload_user        ), //i
    .io_input_ar_payload_prot      (userCD_axiPort_ar_payload_prot        ), //i
    .io_input_r_valid              (afuAxi4CC_io_input_r_valid            ), //o
    .io_input_r_ready              (userCD_axiPort_r_ready                ), //i
    .io_input_r_payload_data       (afuAxi4CC_io_input_r_payload_data     ), //o
    .io_input_r_payload_id         (afuAxi4CC_io_input_r_payload_id       ), //o
    .io_input_r_payload_resp       (afuAxi4CC_io_input_r_payload_resp     ), //o
    .io_input_r_payload_last       (afuAxi4CC_io_input_r_payload_last     ), //o
    .io_input_r_payload_user       (afuAxi4CC_io_input_r_payload_user     ), //o
    .io_output_aw_valid            (afuAxi4CC_io_output_aw_valid          ), //o
    .io_output_aw_ready            (axi4Slice_1_input_awready             ), //i
    .io_output_aw_payload_addr     (afuAxi4CC_io_output_aw_payload_addr   ), //o
    .io_output_aw_payload_id       (afuAxi4CC_io_output_aw_payload_id     ), //o
    .io_output_aw_payload_len      (afuAxi4CC_io_output_aw_payload_len    ), //o
    .io_output_aw_payload_size     (afuAxi4CC_io_output_aw_payload_size   ), //o
    .io_output_aw_payload_burst    (afuAxi4CC_io_output_aw_payload_burst  ), //o
    .io_output_aw_payload_lock     (afuAxi4CC_io_output_aw_payload_lock   ), //o
    .io_output_aw_payload_cache    (afuAxi4CC_io_output_aw_payload_cache  ), //o
    .io_output_aw_payload_qos      (afuAxi4CC_io_output_aw_payload_qos    ), //o
    .io_output_aw_payload_user     (afuAxi4CC_io_output_aw_payload_user   ), //o
    .io_output_aw_payload_prot     (afuAxi4CC_io_output_aw_payload_prot   ), //o
    .io_output_w_valid             (afuAxi4CC_io_output_w_valid           ), //o
    .io_output_w_ready             (axi4Slice_1_input_wready              ), //i
    .io_output_w_payload_data      (afuAxi4CC_io_output_w_payload_data    ), //o
    .io_output_w_payload_strb      (afuAxi4CC_io_output_w_payload_strb    ), //o
    .io_output_w_payload_user      (afuAxi4CC_io_output_w_payload_user    ), //o
    .io_output_w_payload_last      (afuAxi4CC_io_output_w_payload_last    ), //o
    .io_output_b_valid             (axi4Slice_1_input_bvalid              ), //i
    .io_output_b_ready             (afuAxi4CC_io_output_b_ready           ), //o
    .io_output_b_payload_id        (axi4Slice_1_input_bid                 ), //i
    .io_output_b_payload_resp      (axi4Slice_1_input_bresp               ), //i
    .io_output_b_payload_user      (axi4Slice_1_input_buser               ), //i
    .io_output_ar_valid            (afuAxi4CC_io_output_ar_valid          ), //o
    .io_output_ar_ready            (axi4Slice_1_input_arready             ), //i
    .io_output_ar_payload_addr     (afuAxi4CC_io_output_ar_payload_addr   ), //o
    .io_output_ar_payload_id       (afuAxi4CC_io_output_ar_payload_id     ), //o
    .io_output_ar_payload_len      (afuAxi4CC_io_output_ar_payload_len    ), //o
    .io_output_ar_payload_size     (afuAxi4CC_io_output_ar_payload_size   ), //o
    .io_output_ar_payload_burst    (afuAxi4CC_io_output_ar_payload_burst  ), //o
    .io_output_ar_payload_lock     (afuAxi4CC_io_output_ar_payload_lock   ), //o
    .io_output_ar_payload_cache    (afuAxi4CC_io_output_ar_payload_cache  ), //o
    .io_output_ar_payload_qos      (afuAxi4CC_io_output_ar_payload_qos    ), //o
    .io_output_ar_payload_user     (afuAxi4CC_io_output_ar_payload_user   ), //o
    .io_output_ar_payload_prot     (afuAxi4CC_io_output_ar_payload_prot   ), //o
    .io_output_r_valid             (axi4Slice_1_input_rvalid              ), //i
    .io_output_r_ready             (afuAxi4CC_io_output_r_ready           ), //o
    .io_output_r_payload_data      (axi4Slice_1_input_rdata               ), //i
    .io_output_r_payload_id        (axi4Slice_1_input_rid                 ), //i
    .io_output_r_payload_resp      (axi4Slice_1_input_rresp               ), //i
    .io_output_r_payload_last      (axi4Slice_1_input_rlast               ), //i
    .io_output_r_payload_user      (axi4Slice_1_input_ruser               ), //i
    .afu_user_clk                  (afu_user_clk                          ), //i
    .afu_user_rst                  (afu_user_rst                          ), //i
    .afu_pcie_core_clk             (afu_pcie_core_clk                     ), //i
    .afu_pcie_core_rst             (afu_pcie_core_rst                     )  //i
  );
  ALite4Slice pcieCD_afuAliteSlice (
    .input_awvalid        (afu_alite4_awvalid                   ), //i
    .input_awready        (pcieCD_afuAliteSlice_input_awready   ), //o
    .input_awaddr         (afu_alite4_awaddr                    ), //i
    .input_awprot         (afu_alite4_awprot                    ), //i
    .input_awuser         (afu_alite4_awuser                    ), //i
    .input_wvalid         (afu_alite4_wvalid                    ), //i
    .input_wready         (pcieCD_afuAliteSlice_input_wready    ), //o
    .input_wdata          (afu_alite4_wdata                     ), //i
    .input_wstrb          (afu_alite4_wstrb                     ), //i
    .input_bvalid         (pcieCD_afuAliteSlice_input_bvalid    ), //o
    .input_bready         (afu_alite4_bready                    ), //i
    .input_bresp          (pcieCD_afuAliteSlice_input_bresp     ), //o
    .input_arvalid        (afu_alite4_arvalid                   ), //i
    .input_arready        (pcieCD_afuAliteSlice_input_arready   ), //o
    .input_araddr         (afu_alite4_araddr                    ), //i
    .input_arprot         (afu_alite4_arprot                    ), //i
    .input_aruser         (afu_alite4_aruser                    ), //i
    .input_rvalid         (pcieCD_afuAliteSlice_input_rvalid    ), //o
    .input_rready         (afu_alite4_rready                    ), //i
    .input_rdata          (pcieCD_afuAliteSlice_input_rdata     ), //o
    .input_rresp          (pcieCD_afuAliteSlice_input_rresp     ), //o
    .output_awvalid       (pcieCD_afuAliteSlice_output_awvalid  ), //o
    .output_awready       (afuAliteCC_input_awready             ), //i
    .output_awaddr        (pcieCD_afuAliteSlice_output_awaddr   ), //o
    .output_awprot        (pcieCD_afuAliteSlice_output_awprot   ), //o
    .output_awuser        (pcieCD_afuAliteSlice_output_awuser   ), //o
    .output_wvalid        (pcieCD_afuAliteSlice_output_wvalid   ), //o
    .output_wready        (afuAliteCC_input_wready              ), //i
    .output_wdata         (pcieCD_afuAliteSlice_output_wdata    ), //o
    .output_wstrb         (pcieCD_afuAliteSlice_output_wstrb    ), //o
    .output_bvalid        (afuAliteCC_input_bvalid              ), //i
    .output_bready        (pcieCD_afuAliteSlice_output_bready   ), //o
    .output_bresp         (afuAliteCC_input_bresp               ), //i
    .output_arvalid       (pcieCD_afuAliteSlice_output_arvalid  ), //o
    .output_arready       (afuAliteCC_input_arready             ), //i
    .output_araddr        (pcieCD_afuAliteSlice_output_araddr   ), //o
    .output_arprot        (pcieCD_afuAliteSlice_output_arprot   ), //o
    .output_aruser        (pcieCD_afuAliteSlice_output_aruser   ), //o
    .output_rvalid        (afuAliteCC_input_rvalid              ), //i
    .output_rready        (pcieCD_afuAliteSlice_output_rready   ), //o
    .output_rdata         (afuAliteCC_input_rdata               ), //i
    .output_rresp         (afuAliteCC_input_rresp               ), //i
    .afu_pcie_core_clk    (afu_pcie_core_clk                    ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                    )  //i
  );
  Axi4Slice axi4Slice_1 (
    .input_awvalid        (afuAxi4CC_io_output_aw_valid          ), //i
    .input_awready        (axi4Slice_1_input_awready             ), //o
    .input_awaddr         (afuAxi4CC_io_output_aw_payload_addr   ), //i
    .input_awid           (afuAxi4CC_io_output_aw_payload_id     ), //i
    .input_awlen          (afuAxi4CC_io_output_aw_payload_len    ), //i
    .input_awsize         (afuAxi4CC_io_output_aw_payload_size   ), //i
    .input_awburst        (afuAxi4CC_io_output_aw_payload_burst  ), //i
    .input_awlock         (afuAxi4CC_io_output_aw_payload_lock   ), //i
    .input_awcache        (afuAxi4CC_io_output_aw_payload_cache  ), //i
    .input_awqos          (afuAxi4CC_io_output_aw_payload_qos    ), //i
    .input_awuser         (afuAxi4CC_io_output_aw_payload_user   ), //i
    .input_awprot         (afuAxi4CC_io_output_aw_payload_prot   ), //i
    .input_wvalid         (afuAxi4CC_io_output_w_valid           ), //i
    .input_wready         (axi4Slice_1_input_wready              ), //o
    .input_wdata          (afuAxi4CC_io_output_w_payload_data    ), //i
    .input_wstrb          (afuAxi4CC_io_output_w_payload_strb    ), //i
    .input_wuser          (afuAxi4CC_io_output_w_payload_user    ), //i
    .input_wlast          (afuAxi4CC_io_output_w_payload_last    ), //i
    .input_bvalid         (axi4Slice_1_input_bvalid              ), //o
    .input_bready         (afuAxi4CC_io_output_b_ready           ), //i
    .input_bid            (axi4Slice_1_input_bid                 ), //o
    .input_bresp          (axi4Slice_1_input_bresp               ), //o
    .input_buser          (axi4Slice_1_input_buser               ), //o
    .input_arvalid        (afuAxi4CC_io_output_ar_valid          ), //i
    .input_arready        (axi4Slice_1_input_arready             ), //o
    .input_araddr         (afuAxi4CC_io_output_ar_payload_addr   ), //i
    .input_arid           (afuAxi4CC_io_output_ar_payload_id     ), //i
    .input_arlen          (afuAxi4CC_io_output_ar_payload_len    ), //i
    .input_arsize         (afuAxi4CC_io_output_ar_payload_size   ), //i
    .input_arburst        (afuAxi4CC_io_output_ar_payload_burst  ), //i
    .input_arlock         (afuAxi4CC_io_output_ar_payload_lock   ), //i
    .input_arcache        (afuAxi4CC_io_output_ar_payload_cache  ), //i
    .input_arqos          (afuAxi4CC_io_output_ar_payload_qos    ), //i
    .input_aruser         (afuAxi4CC_io_output_ar_payload_user   ), //i
    .input_arprot         (afuAxi4CC_io_output_ar_payload_prot   ), //i
    .input_rvalid         (axi4Slice_1_input_rvalid              ), //o
    .input_rready         (afuAxi4CC_io_output_r_ready           ), //i
    .input_rdata          (axi4Slice_1_input_rdata               ), //o
    .input_rid            (axi4Slice_1_input_rid                 ), //o
    .input_rresp          (axi4Slice_1_input_rresp               ), //o
    .input_rlast          (axi4Slice_1_input_rlast               ), //o
    .input_ruser          (axi4Slice_1_input_ruser               ), //o
    .output_awvalid       (axi4Slice_1_output_awvalid            ), //o
    .output_awready       (afu_axi4_awready                      ), //i
    .output_awaddr        (axi4Slice_1_output_awaddr             ), //o
    .output_awid          (axi4Slice_1_output_awid               ), //o
    .output_awlen         (axi4Slice_1_output_awlen              ), //o
    .output_awsize        (axi4Slice_1_output_awsize             ), //o
    .output_awburst       (axi4Slice_1_output_awburst            ), //o
    .output_awlock        (axi4Slice_1_output_awlock             ), //o
    .output_awcache       (axi4Slice_1_output_awcache            ), //o
    .output_awqos         (axi4Slice_1_output_awqos              ), //o
    .output_awuser        (axi4Slice_1_output_awuser             ), //o
    .output_awprot        (axi4Slice_1_output_awprot             ), //o
    .output_wvalid        (axi4Slice_1_output_wvalid             ), //o
    .output_wready        (afu_axi4_wready                       ), //i
    .output_wdata         (axi4Slice_1_output_wdata              ), //o
    .output_wstrb         (axi4Slice_1_output_wstrb              ), //o
    .output_wuser         (axi4Slice_1_output_wuser              ), //o
    .output_wlast         (axi4Slice_1_output_wlast              ), //o
    .output_bvalid        (afu_axi4_bvalid                       ), //i
    .output_bready        (axi4Slice_1_output_bready             ), //o
    .output_bid           (afu_axi4_bid                          ), //i
    .output_bresp         (afu_axi4_bresp                        ), //i
    .output_buser         (afu_axi4_buser                        ), //i
    .output_arvalid       (axi4Slice_1_output_arvalid            ), //o
    .output_arready       (afu_axi4_arready                      ), //i
    .output_araddr        (axi4Slice_1_output_araddr             ), //o
    .output_arid          (axi4Slice_1_output_arid               ), //o
    .output_arlen         (axi4Slice_1_output_arlen              ), //o
    .output_arsize        (axi4Slice_1_output_arsize             ), //o
    .output_arburst       (axi4Slice_1_output_arburst            ), //o
    .output_arlock        (axi4Slice_1_output_arlock             ), //o
    .output_arcache       (axi4Slice_1_output_arcache            ), //o
    .output_arqos         (axi4Slice_1_output_arqos              ), //o
    .output_aruser        (axi4Slice_1_output_aruser             ), //o
    .output_arprot        (axi4Slice_1_output_arprot             ), //o
    .output_rvalid        (afu_axi4_rvalid                       ), //i
    .output_rready        (axi4Slice_1_output_rready             ), //o
    .output_rdata         (afu_axi4_rdata                        ), //i
    .output_rid           (afu_axi4_rid                          ), //i
    .output_rresp         (afu_axi4_rresp                        ), //i
    .output_rlast         (afu_axi4_rlast                        ), //i
    .output_ruser         (afu_axi4_ruser                        ), //i
    .afu_pcie_core_clk    (afu_pcie_core_clk                     ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                     )  //i
  );
  ALite4CCHandShake afuAliteCC (
    .input_awvalid        (pcieCD_afuAliteSlice_output_awvalid  ), //i
    .input_awready        (afuAliteCC_input_awready             ), //o
    .input_awaddr         (pcieCD_afuAliteSlice_output_awaddr   ), //i
    .input_awprot         (pcieCD_afuAliteSlice_output_awprot   ), //i
    .input_awuser         (pcieCD_afuAliteSlice_output_awuser   ), //i
    .input_wvalid         (pcieCD_afuAliteSlice_output_wvalid   ), //i
    .input_wready         (afuAliteCC_input_wready              ), //o
    .input_wdata          (pcieCD_afuAliteSlice_output_wdata    ), //i
    .input_wstrb          (pcieCD_afuAliteSlice_output_wstrb    ), //i
    .input_bvalid         (afuAliteCC_input_bvalid              ), //o
    .input_bready         (pcieCD_afuAliteSlice_output_bready   ), //i
    .input_bresp          (afuAliteCC_input_bresp               ), //o
    .input_arvalid        (pcieCD_afuAliteSlice_output_arvalid  ), //i
    .input_arready        (afuAliteCC_input_arready             ), //o
    .input_araddr         (pcieCD_afuAliteSlice_output_araddr   ), //i
    .input_arprot         (pcieCD_afuAliteSlice_output_arprot   ), //i
    .input_aruser         (pcieCD_afuAliteSlice_output_aruser   ), //i
    .input_rvalid         (afuAliteCC_input_rvalid              ), //o
    .input_rready         (pcieCD_afuAliteSlice_output_rready   ), //i
    .input_rdata          (afuAliteCC_input_rdata               ), //o
    .input_rresp          (afuAliteCC_input_rresp               ), //o
    .output_awvalid       (afuAliteCC_output_awvalid            ), //o
    .output_awready       (userCD_alite_awready                 ), //i
    .output_awaddr        (afuAliteCC_output_awaddr             ), //o
    .output_awprot        (afuAliteCC_output_awprot             ), //o
    .output_awuser        (afuAliteCC_output_awuser             ), //o
    .output_wvalid        (afuAliteCC_output_wvalid             ), //o
    .output_wready        (userCD_alite_wready                  ), //i
    .output_wdata         (afuAliteCC_output_wdata              ), //o
    .output_wstrb         (afuAliteCC_output_wstrb              ), //o
    .output_bvalid        (userCD_alite_bvalid                  ), //i
    .output_bready        (afuAliteCC_output_bready             ), //o
    .output_bresp         (userCD_alite_bresp                   ), //i
    .output_arvalid       (afuAliteCC_output_arvalid            ), //o
    .output_arready       (userCD_alite_arready                 ), //i
    .output_araddr        (afuAliteCC_output_araddr             ), //o
    .output_arprot        (afuAliteCC_output_arprot             ), //o
    .output_aruser        (afuAliteCC_output_aruser             ), //o
    .output_rvalid        (userCD_alite_rvalid                  ), //i
    .output_rready        (afuAliteCC_output_rready             ), //o
    .output_rdata         (userCD_alite_rdata                   ), //i
    .output_rresp         (userCD_alite_rresp                   ), //i
    .afu_pcie_core_clk    (afu_pcie_core_clk                    ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                    ), //i
    .afu_user_clk         (afu_user_clk                         ), //i
    .afu_user_rst         (afu_user_rst                         )  //i
  );
  StreamFork userCD_wCmdEvent_fork (
    .io_input_valid        (userCD_wCmdEvent_valid                    ), //i
    .io_input_ready        (userCD_wCmdEvent_fork_io_input_ready      ), //o
    .io_outputs_0_valid    (userCD_wCmdEvent_fork_io_outputs_0_valid  ), //o
    .io_outputs_0_ready    (userCD_axiPort_aw_ready                   ), //i
    .io_outputs_1_valid    (userCD_wCmdEvent_fork_io_outputs_1_valid  ), //o
    .io_outputs_1_ready    (userCD_axiPort_w_ready                    ), //i
    .io_outputs_2_valid    (userCD_wCmdEvent_fork_io_outputs_2_valid  ), //o
    .io_outputs_2_ready    (userCD_axiPort_b_valid                    ), //i
    .afu_user_clk          (afu_user_clk                              ), //i
    .afu_user_rst          (afu_user_rst                              )  //i
  );
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
  assign user_msix_valid = 1'b0;
  assign user_msix_payload_func = 8'h0;
  assign user_msix_payload_vec = 5'h0;
  assign afu_alite4_awready = pcieCD_afuAliteSlice_input_awready;
  assign afu_alite4_wready = pcieCD_afuAliteSlice_input_wready;
  assign afu_alite4_bvalid = pcieCD_afuAliteSlice_input_bvalid;
  assign afu_alite4_bresp = pcieCD_afuAliteSlice_input_bresp;
  assign afu_alite4_arready = pcieCD_afuAliteSlice_input_arready;
  assign afu_alite4_rvalid = pcieCD_afuAliteSlice_input_rvalid;
  assign afu_alite4_rdata = pcieCD_afuAliteSlice_input_rdata;
  assign afu_alite4_rresp = pcieCD_afuAliteSlice_input_rresp;
  assign afu_axi4_awvalid = axi4Slice_1_output_awvalid;
  assign afu_axi4_awaddr = axi4Slice_1_output_awaddr;
  assign afu_axi4_awid = axi4Slice_1_output_awid;
  assign afu_axi4_awlen = axi4Slice_1_output_awlen;
  assign afu_axi4_awsize = axi4Slice_1_output_awsize;
  assign afu_axi4_awburst = axi4Slice_1_output_awburst;
  assign afu_axi4_awlock = axi4Slice_1_output_awlock;
  assign afu_axi4_awcache = axi4Slice_1_output_awcache;
  assign afu_axi4_awqos = axi4Slice_1_output_awqos;
  assign afu_axi4_awuser = axi4Slice_1_output_awuser;
  assign afu_axi4_awprot = axi4Slice_1_output_awprot;
  assign afu_axi4_wvalid = axi4Slice_1_output_wvalid;
  assign afu_axi4_wdata = axi4Slice_1_output_wdata;
  assign afu_axi4_wstrb = axi4Slice_1_output_wstrb;
  assign afu_axi4_wuser = axi4Slice_1_output_wuser;
  assign afu_axi4_wlast = axi4Slice_1_output_wlast;
  assign afu_axi4_bready = axi4Slice_1_output_bready;
  assign afu_axi4_arvalid = axi4Slice_1_output_arvalid;
  assign afu_axi4_araddr = axi4Slice_1_output_araddr;
  assign afu_axi4_arid = axi4Slice_1_output_arid;
  assign afu_axi4_arlen = axi4Slice_1_output_arlen;
  assign afu_axi4_arsize = axi4Slice_1_output_arsize;
  assign afu_axi4_arburst = axi4Slice_1_output_arburst;
  assign afu_axi4_arlock = axi4Slice_1_output_arlock;
  assign afu_axi4_arcache = axi4Slice_1_output_arcache;
  assign afu_axi4_arqos = axi4Slice_1_output_arqos;
  assign afu_axi4_aruser = axi4Slice_1_output_aruser;
  assign afu_axi4_arprot = axi4Slice_1_output_arprot;
  assign afu_axi4_rready = axi4Slice_1_output_rready;
  assign userCD_alite_awvalid = afuAliteCC_output_awvalid;
  assign userCD_alite_awaddr = afuAliteCC_output_awaddr;
  assign userCD_alite_awprot = afuAliteCC_output_awprot;
  assign userCD_alite_wvalid = afuAliteCC_output_wvalid;
  assign userCD_alite_wdata = afuAliteCC_output_wdata;
  assign userCD_alite_wstrb = afuAliteCC_output_wstrb;
  assign userCD_alite_bready = afuAliteCC_output_bready;
  assign userCD_alite_arvalid = afuAliteCC_output_arvalid;
  assign userCD_alite_araddr = afuAliteCC_output_araddr;
  assign userCD_alite_arprot = afuAliteCC_output_arprot;
  assign userCD_alite_rready = afuAliteCC_output_rready;
  assign userCD_axiPort_aw_ready = afuAxi4CC_io_input_aw_ready;
  assign userCD_axiPort_w_ready = afuAxi4CC_io_input_w_ready;
  assign userCD_axiPort_b_valid = afuAxi4CC_io_input_b_valid;
  assign userCD_axiPort_b_payload_id = afuAxi4CC_io_input_b_payload_id;
  assign userCD_axiPort_b_payload_resp = afuAxi4CC_io_input_b_payload_resp;
  assign userCD_axiPort_b_payload_user = afuAxi4CC_io_input_b_payload_user;
  assign userCD_axiPort_ar_ready = afuAxi4CC_io_input_ar_ready;
  assign userCD_axiPort_r_valid = afuAxi4CC_io_input_r_valid;
  assign userCD_axiPort_r_payload_data = afuAxi4CC_io_input_r_payload_data;
  assign userCD_axiPort_r_payload_id = afuAxi4CC_io_input_r_payload_id;
  assign userCD_axiPort_r_payload_resp = afuAxi4CC_io_input_r_payload_resp;
  assign userCD_axiPort_r_payload_last = afuAxi4CC_io_input_r_payload_last;
  assign userCD_axiPort_r_payload_user = afuAxi4CC_io_input_r_payload_user;
  assign _zz_1 = zz_userCD_DFH(1'b0);
  always @(*) userCD_DFH = _zz_1;
  assign userCD_UUID = 128'hc6aa954a9b914a37abc11d9f0709dcc3;
  assign userCD_aliteFactory_readHaltRequest = 1'b0;
  assign userCD_aliteFactory_writeHaltRequest = 1'b0;
  assign _zz_userCD_alite_awready = (userCD_aliteFactory_writeJoinEvent_valid && userCD_aliteFactory_writeJoinEvent_ready);
  assign userCD_aliteFactory_writeJoinEvent_valid = (userCD_alite_awvalid && userCD_alite_wvalid);
  assign userCD_alite_awready = _zz_userCD_alite_awready;
  assign userCD_alite_wready = _zz_userCD_alite_awready;
  assign userCD_aliteFactory_writeJoinEvent_translated_valid = userCD_aliteFactory_writeJoinEvent_valid;
  assign userCD_aliteFactory_writeJoinEvent_ready = userCD_aliteFactory_writeJoinEvent_translated_ready;
  assign userCD_aliteFactory_writeJoinEvent_translated_payload_resp = userCD_aliteFactory_writeRsp_resp;
  assign _zz_userCD_alite_bvalid = (! userCD_aliteFactory_writeHaltRequest);
  assign userCD_aliteFactory_writeJoinEvent_translated_ready = (_zz_userCD_aliteFactory_writeJoinEvent_translated_ready && _zz_userCD_alite_bvalid);
  assign _zz_userCD_aliteFactory_writeJoinEvent_translated_ready = ((1'b1 && (! _zz_userCD_alite_bvalid_1)) || userCD_alite_bready);
  assign _zz_userCD_alite_bvalid_1 = _zz_userCD_alite_bvalid_2;
  assign userCD_alite_bvalid = _zz_userCD_alite_bvalid_1;
  assign userCD_alite_bresp = _zz_userCD_alite_bresp;
  assign userCD_alite_arready = ((1'b1 && (! userCD_alite_ar_readDataStage_valid)) || userCD_alite_ar_readDataStage_ready);
  assign userCD_alite_ar_readDataStage_valid = userCD_alite_ar_rValid;
  assign userCD_alite_ar_readDataStage_payload_addr = userCD_alite_ar_rData_addr;
  assign userCD_alite_ar_readDataStage_payload_prot = userCD_alite_ar_rData_prot;
  assign _zz_userCD_alite_rvalid = (! userCD_aliteFactory_readHaltRequest);
  assign userCD_alite_ar_readDataStage_ready = (userCD_alite_rready && _zz_userCD_alite_rvalid);
  assign userCD_alite_rvalid = (userCD_alite_ar_readDataStage_valid && _zz_userCD_alite_rvalid);
  assign userCD_alite_rdata = userCD_aliteFactory_readRsp_data;
  assign userCD_alite_rresp = userCD_aliteFactory_readRsp_resp;
  assign userCD_aliteFactory_writeRsp_resp = 2'b00;
  assign userCD_aliteFactory_readRsp_resp = 2'b00;
  always @(*) begin
    userCD_aliteFactory_readRsp_data = 64'h0;
    case(userCD_alite_ar_readDataStage_payload_addr)
      32'h00000020 : begin
        userCD_aliteFactory_readRsp_data[0 : 0] = userCD_start;
      end
      32'h00000028 : begin
        userCD_aliteFactory_readRsp_data[0 : 0] = userCD_done;
      end
      default : begin
      end
    endcase
    if(when_AxiLite4SlaveFactory_l62) begin
      userCD_aliteFactory_readRsp_data[63 : 0] = _zz_userCD_aliteFactory_readRsp_data_1[63 : 0];
    end
    if(when_AxiLite4SlaveFactory_l62_1) begin
      userCD_aliteFactory_readRsp_data[63 : 0] = _zz_userCD_aliteFactory_readRsp_data[63 : 0];
    end
    if(when_AxiLite4SlaveFactory_l62_2) begin
      userCD_aliteFactory_readRsp_data[63 : 0] = _zz_userCD_aliteFactory_readRsp_data[127 : 64];
    end
    if(when_AxiLite4SlaveFactory_l62_3) begin
      userCD_aliteFactory_readRsp_data[63 : 0] = _zz_userCD_aliteFactory_readRsp_data_2[63 : 0];
    end
  end

  assign userCD_aliteFactory_writeOccur = (userCD_aliteFactory_writeJoinEvent_valid && userCD_aliteFactory_writeJoinEvent_ready);
  assign userCD_aliteFactory_readOccur = (userCD_alite_rvalid && userCD_alite_rready);
  assign _zz_userCD_aliteFactory_readRsp_data = userCD_UUID;
  assign userCD_wCmdEvent_valid = userCD_start;
  assign when_hello_world_l126 = (userCD_start && (! userCD_start_regNext));
  assign when_hello_world_l129 = (userCD_wCmdEvent_valid && userCD_wCmdEvent_ready);
  assign userCD_wCmdEvent_ready = userCD_wCmdEvent_fork_io_input_ready;
  assign userCD_axiPort_aw_valid = userCD_wCmdEvent_fork_io_outputs_0_valid;
  assign userCD_axiPort_w_valid = userCD_wCmdEvent_fork_io_outputs_1_valid;
  assign userCD_axiPort_b_ready = userCD_wCmdEvent_fork_io_outputs_2_valid;
  assign userCD_axiPort_ar_valid = 1'b0;
  assign userCD_axiPort_r_ready = 1'b1;
  assign userCD_axiPort_ar_payload_addr = 64'h0;
  assign userCD_axiPort_aw_payload_addr = userCD_targetAddr;
  assign userCD_axiPort_aw_payload_id = 4'b0000;
  assign userCD_axiPort_ar_payload_id = 4'b0000;
  assign userCD_axiPort_aw_payload_len = 8'h0;
  assign userCD_axiPort_ar_payload_len = 8'h0;
  assign userCD_axiPort_aw_payload_size = 3'b110;
  assign userCD_axiPort_ar_payload_size = 3'b110;
  assign userCD_axiPort_aw_payload_burst = 2'b01;
  assign userCD_axiPort_ar_payload_burst = 2'b01;
  assign userCD_axiPort_aw_payload_lock = 1'b0;
  assign userCD_axiPort_ar_payload_lock = 1'b0;
  assign userCD_axiPort_aw_payload_cache = 4'b0000;
  assign userCD_axiPort_ar_payload_cache = 4'b0000;
  assign userCD_axiPort_aw_payload_qos = 4'b0000;
  assign userCD_axiPort_ar_payload_qos = 4'b0000;
  assign userCD_axiPort_aw_payload_user = 64'h0;
  assign userCD_axiPort_ar_payload_user = 64'h0;
  assign userCD_axiPort_aw_payload_prot = 3'b000;
  assign userCD_axiPort_ar_payload_prot = 3'b000;
  assign userCD_axiPort_w_payload_user = 4'b0000;
  assign userCD_axiPort_w_payload_data = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000061626162696c41206d6f72462021646c726f77206f6c6c6548;
  assign userCD_axiPort_w_payload_last = 1'b1;
  assign userCD_axiPort_w_payload_strb = 64'h0000000001ffffff;
  assign when_AxiLite4SlaveFactory_l47 = ((userCD_alite_awaddr & (~ 32'h00000007)) == 32'h00000018);
  assign when_AxiLite4SlaveFactory_l62 = ((userCD_alite_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h0);
  assign when_AxiLite4SlaveFactory_l62_1 = ((userCD_alite_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h00000008);
  assign when_AxiLite4SlaveFactory_l62_2 = ((userCD_alite_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h00000010);
  assign when_AxiLite4SlaveFactory_l62_3 = ((userCD_alite_ar_readDataStage_payload_addr & (~ 32'h00000007)) == 32'h00000018);
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      userCD_start <= 1'b0;
      userCD_done <= 1'b0;
      _zz_userCD_alite_bvalid_2 <= 1'b0;
      userCD_alite_ar_rValid <= 1'b0;
      userCD_start_regNext <= 1'b0;
    end else begin
      if(_zz_userCD_aliteFactory_writeJoinEvent_translated_ready) begin
        _zz_userCD_alite_bvalid_2 <= (userCD_aliteFactory_writeJoinEvent_translated_valid && _zz_userCD_alite_bvalid);
      end
      if(userCD_alite_arready) begin
        userCD_alite_ar_rValid <= userCD_alite_arvalid;
      end
      userCD_start_regNext <= userCD_start;
      if(when_hello_world_l126) begin
        userCD_done <= 1'b0;
      end
      if(when_hello_world_l129) begin
        userCD_start <= 1'b0;
        userCD_done <= 1'b1;
      end
      case(userCD_alite_awaddr)
        32'h00000020 : begin
          if(userCD_aliteFactory_writeOccur) begin
            userCD_start <= userCD_alite_wdata[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge afu_user_clk) begin
    if(_zz_userCD_aliteFactory_writeJoinEvent_translated_ready) begin
      _zz_userCD_alite_bresp <= userCD_aliteFactory_writeJoinEvent_translated_payload_resp;
    end
    if(userCD_alite_arready) begin
      userCD_alite_ar_rData_addr <= userCD_alite_araddr;
      userCD_alite_ar_rData_prot <= userCD_alite_arprot;
    end
    if(when_AxiLite4SlaveFactory_l47) begin
      if(userCD_aliteFactory_writeOccur) begin
        userCD_targetAddr[63 : 0] <= _zz_userCD_targetAddr;
      end
    end
  end


endmodule

module StreamFork (
  input               io_input_valid,
  output reg          io_input_ready,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output              io_outputs_2_valid,
  input               io_outputs_2_ready,
  input               afu_user_clk,
  input               afu_user_rst
);
  reg                 _zz_io_outputs_0_valid;
  reg                 _zz_io_outputs_1_valid;
  reg                 _zz_io_outputs_2_valid;
  wire                when_Stream_l828;
  wire                when_Stream_l828_1;
  wire                when_Stream_l828_2;
  wire                when_Stream_l838;
  wire                when_Stream_l838_1;
  wire                when_Stream_l838_2;

  always @(*) begin
    io_input_ready = 1'b1;
    if(when_Stream_l828) begin
      io_input_ready = 1'b0;
    end
    if(when_Stream_l828_1) begin
      io_input_ready = 1'b0;
    end
    if(when_Stream_l828_2) begin
      io_input_ready = 1'b0;
    end
  end

  assign when_Stream_l828 = ((! io_outputs_0_ready) && _zz_io_outputs_0_valid);
  assign when_Stream_l828_1 = ((! io_outputs_1_ready) && _zz_io_outputs_1_valid);
  assign when_Stream_l828_2 = ((! io_outputs_2_ready) && _zz_io_outputs_2_valid);
  assign io_outputs_0_valid = (io_input_valid && _zz_io_outputs_0_valid);
  assign when_Stream_l838 = (io_outputs_0_valid && io_outputs_0_ready);
  assign io_outputs_1_valid = (io_input_valid && _zz_io_outputs_1_valid);
  assign when_Stream_l838_1 = (io_outputs_1_valid && io_outputs_1_ready);
  assign io_outputs_2_valid = (io_input_valid && _zz_io_outputs_2_valid);
  assign when_Stream_l838_2 = (io_outputs_2_valid && io_outputs_2_ready);
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      _zz_io_outputs_0_valid <= 1'b1;
      _zz_io_outputs_1_valid <= 1'b1;
      _zz_io_outputs_2_valid <= 1'b1;
    end else begin
      if(when_Stream_l838) begin
        _zz_io_outputs_0_valid <= 1'b0;
      end
      if(when_Stream_l838_1) begin
        _zz_io_outputs_1_valid <= 1'b0;
      end
      if(when_Stream_l838_2) begin
        _zz_io_outputs_2_valid <= 1'b0;
      end
      if(io_input_ready) begin
        _zz_io_outputs_0_valid <= 1'b1;
        _zz_io_outputs_1_valid <= 1'b1;
        _zz_io_outputs_2_valid <= 1'b1;
      end
    end
  end


endmodule

module ALite4CCHandShake (
  input               input_awvalid,
  output              input_awready,
  input      [31:0]   input_awaddr,
  input      [2:0]    input_awprot,
  input      [31:0]   input_awuser,
  input               input_wvalid,
  output              input_wready,
  input      [63:0]   input_wdata,
  input      [7:0]    input_wstrb,
  output              input_bvalid,
  input               input_bready,
  output     [1:0]    input_bresp,
  input               input_arvalid,
  output              input_arready,
  input      [31:0]   input_araddr,
  input      [2:0]    input_arprot,
  input      [31:0]   input_aruser,
  output              input_rvalid,
  input               input_rready,
  output     [63:0]   input_rdata,
  output     [1:0]    input_rresp,
  output              output_awvalid,
  input               output_awready,
  output     [31:0]   output_awaddr,
  output     [2:0]    output_awprot,
  output     [31:0]   output_awuser,
  output              output_wvalid,
  input               output_wready,
  output     [63:0]   output_wdata,
  output     [7:0]    output_wstrb,
  input               output_bvalid,
  output              output_bready,
  input      [1:0]    output_bresp,
  output              output_arvalid,
  input               output_arready,
  output     [31:0]   output_araddr,
  output     [2:0]    output_arprot,
  output     [31:0]   output_aruser,
  input               output_rvalid,
  output              output_rready,
  input      [63:0]   output_rdata,
  input      [1:0]    output_rresp,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_user_clk,
  input               afu_user_rst
);
  wire                streamCCHandShake_5_io_input_ready;
  wire                streamCCHandShake_5_io_output_valid;
  wire       [31:0]   streamCCHandShake_5_io_output_payload_addr;
  wire       [2:0]    streamCCHandShake_5_io_output_payload_prot;
  wire       [31:0]   streamCCHandShake_5_io_output_payload_user;
  wire                streamCCHandShake_6_io_input_ready;
  wire                streamCCHandShake_6_io_output_valid;
  wire       [63:0]   streamCCHandShake_6_io_output_payload_data;
  wire       [7:0]    streamCCHandShake_6_io_output_payload_strb;
  wire                streamCCHandShake_7_io_input_ready;
  wire                streamCCHandShake_7_io_output_valid;
  wire       [1:0]    streamCCHandShake_7_io_output_payload_resp;
  wire                streamCCHandShake_8_io_input_ready;
  wire                streamCCHandShake_8_io_output_valid;
  wire       [31:0]   streamCCHandShake_8_io_output_payload_addr;
  wire       [2:0]    streamCCHandShake_8_io_output_payload_prot;
  wire       [31:0]   streamCCHandShake_8_io_output_payload_user;
  wire                streamCCHandShake_9_io_input_ready;
  wire                streamCCHandShake_9_io_output_valid;
  wire       [63:0]   streamCCHandShake_9_io_output_payload_data;
  wire       [1:0]    streamCCHandShake_9_io_output_payload_resp;

  StreamCCHandShake streamCCHandShake_5 (
    .io_input_valid            (input_awvalid                               ), //i
    .io_input_ready            (streamCCHandShake_5_io_input_ready          ), //o
    .io_input_payload_addr     (input_awaddr                                ), //i
    .io_input_payload_prot     (input_awprot                                ), //i
    .io_input_payload_user     (input_awuser                                ), //i
    .io_output_valid           (streamCCHandShake_5_io_output_valid         ), //o
    .io_output_ready           (output_awready                              ), //i
    .io_output_payload_addr    (streamCCHandShake_5_io_output_payload_addr  ), //o
    .io_output_payload_prot    (streamCCHandShake_5_io_output_payload_prot  ), //o
    .io_output_payload_user    (streamCCHandShake_5_io_output_payload_user  ), //o
    .afu_pcie_core_clk         (afu_pcie_core_clk                           ), //i
    .afu_pcie_core_rst         (afu_pcie_core_rst                           ), //i
    .afu_user_clk              (afu_user_clk                                ), //i
    .afu_user_rst              (afu_user_rst                                )  //i
  );
  StreamCCHandShake_1 streamCCHandShake_6 (
    .io_input_valid            (input_wvalid                                ), //i
    .io_input_ready            (streamCCHandShake_6_io_input_ready          ), //o
    .io_input_payload_data     (input_wdata                                 ), //i
    .io_input_payload_strb     (input_wstrb                                 ), //i
    .io_output_valid           (streamCCHandShake_6_io_output_valid         ), //o
    .io_output_ready           (output_wready                               ), //i
    .io_output_payload_data    (streamCCHandShake_6_io_output_payload_data  ), //o
    .io_output_payload_strb    (streamCCHandShake_6_io_output_payload_strb  ), //o
    .afu_pcie_core_clk         (afu_pcie_core_clk                           ), //i
    .afu_pcie_core_rst         (afu_pcie_core_rst                           ), //i
    .afu_user_clk              (afu_user_clk                                ), //i
    .afu_user_rst              (afu_user_rst                                )  //i
  );
  StreamCCHandShake_2 streamCCHandShake_7 (
    .io_input_valid            (output_bvalid                               ), //i
    .io_input_ready            (streamCCHandShake_7_io_input_ready          ), //o
    .io_input_payload_resp     (output_bresp                                ), //i
    .io_output_valid           (streamCCHandShake_7_io_output_valid         ), //o
    .io_output_ready           (input_bready                                ), //i
    .io_output_payload_resp    (streamCCHandShake_7_io_output_payload_resp  ), //o
    .afu_user_clk              (afu_user_clk                                ), //i
    .afu_user_rst              (afu_user_rst                                ), //i
    .afu_pcie_core_clk         (afu_pcie_core_clk                           ), //i
    .afu_pcie_core_rst         (afu_pcie_core_rst                           )  //i
  );
  StreamCCHandShake streamCCHandShake_8 (
    .io_input_valid            (input_arvalid                               ), //i
    .io_input_ready            (streamCCHandShake_8_io_input_ready          ), //o
    .io_input_payload_addr     (input_araddr                                ), //i
    .io_input_payload_prot     (input_arprot                                ), //i
    .io_input_payload_user     (input_aruser                                ), //i
    .io_output_valid           (streamCCHandShake_8_io_output_valid         ), //o
    .io_output_ready           (output_arready                              ), //i
    .io_output_payload_addr    (streamCCHandShake_8_io_output_payload_addr  ), //o
    .io_output_payload_prot    (streamCCHandShake_8_io_output_payload_prot  ), //o
    .io_output_payload_user    (streamCCHandShake_8_io_output_payload_user  ), //o
    .afu_pcie_core_clk         (afu_pcie_core_clk                           ), //i
    .afu_pcie_core_rst         (afu_pcie_core_rst                           ), //i
    .afu_user_clk              (afu_user_clk                                ), //i
    .afu_user_rst              (afu_user_rst                                )  //i
  );
  StreamCCHandShake_4 streamCCHandShake_9 (
    .io_input_valid            (output_rvalid                               ), //i
    .io_input_ready            (streamCCHandShake_9_io_input_ready          ), //o
    .io_input_payload_data     (output_rdata                                ), //i
    .io_input_payload_resp     (output_rresp                                ), //i
    .io_output_valid           (streamCCHandShake_9_io_output_valid         ), //o
    .io_output_ready           (input_rready                                ), //i
    .io_output_payload_data    (streamCCHandShake_9_io_output_payload_data  ), //o
    .io_output_payload_resp    (streamCCHandShake_9_io_output_payload_resp  ), //o
    .afu_user_clk              (afu_user_clk                                ), //i
    .afu_user_rst              (afu_user_rst                                ), //i
    .afu_pcie_core_clk         (afu_pcie_core_clk                           ), //i
    .afu_pcie_core_rst         (afu_pcie_core_rst                           )  //i
  );
  assign input_awready = streamCCHandShake_5_io_input_ready;
  assign output_awvalid = streamCCHandShake_5_io_output_valid;
  assign output_awaddr = streamCCHandShake_5_io_output_payload_addr;
  assign output_awprot = streamCCHandShake_5_io_output_payload_prot;
  assign output_awuser = streamCCHandShake_5_io_output_payload_user;
  assign input_wready = streamCCHandShake_6_io_input_ready;
  assign output_wvalid = streamCCHandShake_6_io_output_valid;
  assign output_wdata = streamCCHandShake_6_io_output_payload_data;
  assign output_wstrb = streamCCHandShake_6_io_output_payload_strb;
  assign output_bready = streamCCHandShake_7_io_input_ready;
  assign input_bvalid = streamCCHandShake_7_io_output_valid;
  assign input_bresp = streamCCHandShake_7_io_output_payload_resp;
  assign input_arready = streamCCHandShake_8_io_input_ready;
  assign output_arvalid = streamCCHandShake_8_io_output_valid;
  assign output_araddr = streamCCHandShake_8_io_output_payload_addr;
  assign output_arprot = streamCCHandShake_8_io_output_payload_prot;
  assign output_aruser = streamCCHandShake_8_io_output_payload_user;
  assign output_rready = streamCCHandShake_9_io_input_ready;
  assign input_rvalid = streamCCHandShake_9_io_output_valid;
  assign input_rdata = streamCCHandShake_9_io_output_payload_data;
  assign input_rresp = streamCCHandShake_9_io_output_payload_resp;

endmodule

module Axi4Slice (
  input               input_awvalid,
  output              input_awready,
  input      [63:0]   input_awaddr,
  input      [3:0]    input_awid,
  input      [7:0]    input_awlen,
  input      [2:0]    input_awsize,
  input      [1:0]    input_awburst,
  input      [0:0]    input_awlock,
  input      [3:0]    input_awcache,
  input      [3:0]    input_awqos,
  input      [63:0]   input_awuser,
  input      [2:0]    input_awprot,
  input               input_wvalid,
  output              input_wready,
  input      [511:0]  input_wdata,
  input      [63:0]   input_wstrb,
  input      [3:0]    input_wuser,
  input               input_wlast,
  output              input_bvalid,
  input               input_bready,
  output     [3:0]    input_bid,
  output     [1:0]    input_bresp,
  output     [63:0]   input_buser,
  input               input_arvalid,
  output              input_arready,
  input      [63:0]   input_araddr,
  input      [3:0]    input_arid,
  input      [7:0]    input_arlen,
  input      [2:0]    input_arsize,
  input      [1:0]    input_arburst,
  input      [0:0]    input_arlock,
  input      [3:0]    input_arcache,
  input      [3:0]    input_arqos,
  input      [63:0]   input_aruser,
  input      [2:0]    input_arprot,
  output              input_rvalid,
  input               input_rready,
  output     [511:0]  input_rdata,
  output     [3:0]    input_rid,
  output     [1:0]    input_rresp,
  output              input_rlast,
  output     [63:0]   input_ruser,
  output              output_awvalid,
  input               output_awready,
  output     [63:0]   output_awaddr,
  output     [3:0]    output_awid,
  output     [7:0]    output_awlen,
  output     [2:0]    output_awsize,
  output     [1:0]    output_awburst,
  output     [0:0]    output_awlock,
  output     [3:0]    output_awcache,
  output     [3:0]    output_awqos,
  output     [63:0]   output_awuser,
  output     [2:0]    output_awprot,
  output              output_wvalid,
  input               output_wready,
  output     [511:0]  output_wdata,
  output     [63:0]   output_wstrb,
  output     [3:0]    output_wuser,
  output              output_wlast,
  input               output_bvalid,
  output              output_bready,
  input      [3:0]    output_bid,
  input      [1:0]    output_bresp,
  input      [63:0]   output_buser,
  output              output_arvalid,
  input               output_arready,
  output     [63:0]   output_araddr,
  output     [3:0]    output_arid,
  output     [7:0]    output_arlen,
  output     [2:0]    output_arsize,
  output     [1:0]    output_arburst,
  output     [0:0]    output_arlock,
  output     [3:0]    output_arcache,
  output     [3:0]    output_arqos,
  output     [63:0]   output_aruser,
  output     [2:0]    output_arprot,
  input               output_rvalid,
  output              output_rready,
  input      [511:0]  output_rdata,
  input      [3:0]    output_rid,
  input      [1:0]    output_rresp,
  input               output_rlast,
  input      [63:0]   output_ruser,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  wire                input_aw_s2mPipe_valid;
  wire                input_aw_s2mPipe_ready;
  wire       [63:0]   input_aw_s2mPipe_payload_addr;
  wire       [3:0]    input_aw_s2mPipe_payload_id;
  wire       [7:0]    input_aw_s2mPipe_payload_len;
  wire       [2:0]    input_aw_s2mPipe_payload_size;
  wire       [1:0]    input_aw_s2mPipe_payload_burst;
  wire       [0:0]    input_aw_s2mPipe_payload_lock;
  wire       [3:0]    input_aw_s2mPipe_payload_cache;
  wire       [3:0]    input_aw_s2mPipe_payload_qos;
  wire       [63:0]   input_aw_s2mPipe_payload_user;
  wire       [2:0]    input_aw_s2mPipe_payload_prot;
  reg                 input_aw_s2mPipe_rValid;
  reg        [63:0]   input_aw_s2mPipe_rData_addr;
  reg        [3:0]    input_aw_s2mPipe_rData_id;
  reg        [7:0]    input_aw_s2mPipe_rData_len;
  reg        [2:0]    input_aw_s2mPipe_rData_size;
  reg        [1:0]    input_aw_s2mPipe_rData_burst;
  reg        [0:0]    input_aw_s2mPipe_rData_lock;
  reg        [3:0]    input_aw_s2mPipe_rData_cache;
  reg        [3:0]    input_aw_s2mPipe_rData_qos;
  reg        [63:0]   input_aw_s2mPipe_rData_user;
  reg        [2:0]    input_aw_s2mPipe_rData_prot;
  wire                when_Stream_l365;
  wire                input_aw_s2mPipe_m2sPipe_valid;
  wire                input_aw_s2mPipe_m2sPipe_ready;
  wire       [63:0]   input_aw_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    input_aw_s2mPipe_m2sPipe_payload_id;
  wire       [7:0]    input_aw_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    input_aw_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    input_aw_s2mPipe_m2sPipe_payload_burst;
  wire       [0:0]    input_aw_s2mPipe_m2sPipe_payload_lock;
  wire       [3:0]    input_aw_s2mPipe_m2sPipe_payload_cache;
  wire       [3:0]    input_aw_s2mPipe_m2sPipe_payload_qos;
  wire       [63:0]   input_aw_s2mPipe_m2sPipe_payload_user;
  wire       [2:0]    input_aw_s2mPipe_m2sPipe_payload_prot;
  reg                 input_aw_s2mPipe_rValid_1;
  reg        [63:0]   input_aw_s2mPipe_rData_addr_1;
  reg        [3:0]    input_aw_s2mPipe_rData_id_1;
  reg        [7:0]    input_aw_s2mPipe_rData_len_1;
  reg        [2:0]    input_aw_s2mPipe_rData_size_1;
  reg        [1:0]    input_aw_s2mPipe_rData_burst_1;
  reg        [0:0]    input_aw_s2mPipe_rData_lock_1;
  reg        [3:0]    input_aw_s2mPipe_rData_cache_1;
  reg        [3:0]    input_aw_s2mPipe_rData_qos_1;
  reg        [63:0]   input_aw_s2mPipe_rData_user_1;
  reg        [2:0]    input_aw_s2mPipe_rData_prot_1;
  wire                input_w_s2mPipe_valid;
  wire                input_w_s2mPipe_ready;
  wire       [511:0]  input_w_s2mPipe_payload_data;
  wire       [63:0]   input_w_s2mPipe_payload_strb;
  wire       [3:0]    input_w_s2mPipe_payload_user;
  wire                input_w_s2mPipe_payload_last;
  reg                 input_w_s2mPipe_rValid;
  reg        [511:0]  input_w_s2mPipe_rData_data;
  reg        [63:0]   input_w_s2mPipe_rData_strb;
  reg        [3:0]    input_w_s2mPipe_rData_user;
  reg                 input_w_s2mPipe_rData_last;
  wire                when_Stream_l365_1;
  wire                input_w_s2mPipe_m2sPipe_valid;
  wire                input_w_s2mPipe_m2sPipe_ready;
  wire       [511:0]  input_w_s2mPipe_m2sPipe_payload_data;
  wire       [63:0]   input_w_s2mPipe_m2sPipe_payload_strb;
  wire       [3:0]    input_w_s2mPipe_m2sPipe_payload_user;
  wire                input_w_s2mPipe_m2sPipe_payload_last;
  reg                 input_w_s2mPipe_rValid_1;
  reg        [511:0]  input_w_s2mPipe_rData_data_1;
  reg        [63:0]   input_w_s2mPipe_rData_strb_1;
  reg        [3:0]    input_w_s2mPipe_rData_user_1;
  reg                 input_w_s2mPipe_rData_last_1;
  wire                output_b_s2mPipe_valid;
  wire                output_b_s2mPipe_ready;
  wire       [3:0]    output_b_s2mPipe_payload_id;
  wire       [1:0]    output_b_s2mPipe_payload_resp;
  wire       [63:0]   output_b_s2mPipe_payload_user;
  reg                 output_b_s2mPipe_rValid;
  reg        [3:0]    output_b_s2mPipe_rData_id;
  reg        [1:0]    output_b_s2mPipe_rData_resp;
  reg        [63:0]   output_b_s2mPipe_rData_user;
  wire                when_Stream_l365_2;
  wire                output_b_s2mPipe_m2sPipe_valid;
  wire                output_b_s2mPipe_m2sPipe_ready;
  wire       [3:0]    output_b_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    output_b_s2mPipe_m2sPipe_payload_resp;
  wire       [63:0]   output_b_s2mPipe_m2sPipe_payload_user;
  reg                 output_b_s2mPipe_rValid_1;
  reg        [3:0]    output_b_s2mPipe_rData_id_1;
  reg        [1:0]    output_b_s2mPipe_rData_resp_1;
  reg        [63:0]   output_b_s2mPipe_rData_user_1;
  wire                input_ar_s2mPipe_valid;
  wire                input_ar_s2mPipe_ready;
  wire       [63:0]   input_ar_s2mPipe_payload_addr;
  wire       [3:0]    input_ar_s2mPipe_payload_id;
  wire       [7:0]    input_ar_s2mPipe_payload_len;
  wire       [2:0]    input_ar_s2mPipe_payload_size;
  wire       [1:0]    input_ar_s2mPipe_payload_burst;
  wire       [0:0]    input_ar_s2mPipe_payload_lock;
  wire       [3:0]    input_ar_s2mPipe_payload_cache;
  wire       [3:0]    input_ar_s2mPipe_payload_qos;
  wire       [63:0]   input_ar_s2mPipe_payload_user;
  wire       [2:0]    input_ar_s2mPipe_payload_prot;
  reg                 input_ar_s2mPipe_rValid;
  reg        [63:0]   input_ar_s2mPipe_rData_addr;
  reg        [3:0]    input_ar_s2mPipe_rData_id;
  reg        [7:0]    input_ar_s2mPipe_rData_len;
  reg        [2:0]    input_ar_s2mPipe_rData_size;
  reg        [1:0]    input_ar_s2mPipe_rData_burst;
  reg        [0:0]    input_ar_s2mPipe_rData_lock;
  reg        [3:0]    input_ar_s2mPipe_rData_cache;
  reg        [3:0]    input_ar_s2mPipe_rData_qos;
  reg        [63:0]   input_ar_s2mPipe_rData_user;
  reg        [2:0]    input_ar_s2mPipe_rData_prot;
  wire                when_Stream_l365_3;
  wire                input_ar_s2mPipe_m2sPipe_valid;
  wire                input_ar_s2mPipe_m2sPipe_ready;
  wire       [63:0]   input_ar_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    input_ar_s2mPipe_m2sPipe_payload_id;
  wire       [7:0]    input_ar_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    input_ar_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    input_ar_s2mPipe_m2sPipe_payload_burst;
  wire       [0:0]    input_ar_s2mPipe_m2sPipe_payload_lock;
  wire       [3:0]    input_ar_s2mPipe_m2sPipe_payload_cache;
  wire       [3:0]    input_ar_s2mPipe_m2sPipe_payload_qos;
  wire       [63:0]   input_ar_s2mPipe_m2sPipe_payload_user;
  wire       [2:0]    input_ar_s2mPipe_m2sPipe_payload_prot;
  reg                 input_ar_s2mPipe_rValid_1;
  reg        [63:0]   input_ar_s2mPipe_rData_addr_1;
  reg        [3:0]    input_ar_s2mPipe_rData_id_1;
  reg        [7:0]    input_ar_s2mPipe_rData_len_1;
  reg        [2:0]    input_ar_s2mPipe_rData_size_1;
  reg        [1:0]    input_ar_s2mPipe_rData_burst_1;
  reg        [0:0]    input_ar_s2mPipe_rData_lock_1;
  reg        [3:0]    input_ar_s2mPipe_rData_cache_1;
  reg        [3:0]    input_ar_s2mPipe_rData_qos_1;
  reg        [63:0]   input_ar_s2mPipe_rData_user_1;
  reg        [2:0]    input_ar_s2mPipe_rData_prot_1;
  wire                output_r_s2mPipe_valid;
  wire                output_r_s2mPipe_ready;
  wire       [511:0]  output_r_s2mPipe_payload_data;
  wire       [3:0]    output_r_s2mPipe_payload_id;
  wire       [1:0]    output_r_s2mPipe_payload_resp;
  wire                output_r_s2mPipe_payload_last;
  wire       [63:0]   output_r_s2mPipe_payload_user;
  reg                 output_r_s2mPipe_rValid;
  reg        [511:0]  output_r_s2mPipe_rData_data;
  reg        [3:0]    output_r_s2mPipe_rData_id;
  reg        [1:0]    output_r_s2mPipe_rData_resp;
  reg                 output_r_s2mPipe_rData_last;
  reg        [63:0]   output_r_s2mPipe_rData_user;
  wire                when_Stream_l365_4;
  wire                output_r_s2mPipe_m2sPipe_valid;
  wire                output_r_s2mPipe_m2sPipe_ready;
  wire       [511:0]  output_r_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    output_r_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    output_r_s2mPipe_m2sPipe_payload_resp;
  wire                output_r_s2mPipe_m2sPipe_payload_last;
  wire       [63:0]   output_r_s2mPipe_m2sPipe_payload_user;
  reg                 output_r_s2mPipe_rValid_1;
  reg        [511:0]  output_r_s2mPipe_rData_data_1;
  reg        [3:0]    output_r_s2mPipe_rData_id_1;
  reg        [1:0]    output_r_s2mPipe_rData_resp_1;
  reg                 output_r_s2mPipe_rData_last_1;
  reg        [63:0]   output_r_s2mPipe_rData_user_1;

  assign input_aw_s2mPipe_valid = (input_awvalid || input_aw_s2mPipe_rValid);
  assign input_awready = (! input_aw_s2mPipe_rValid);
  assign input_aw_s2mPipe_payload_addr = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_addr : input_awaddr);
  assign input_aw_s2mPipe_payload_id = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_id : input_awid);
  assign input_aw_s2mPipe_payload_len = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_len : input_awlen);
  assign input_aw_s2mPipe_payload_size = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_size : input_awsize);
  assign input_aw_s2mPipe_payload_burst = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_burst : input_awburst);
  assign input_aw_s2mPipe_payload_lock = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_lock : input_awlock);
  assign input_aw_s2mPipe_payload_cache = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_cache : input_awcache);
  assign input_aw_s2mPipe_payload_qos = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_qos : input_awqos);
  assign input_aw_s2mPipe_payload_user = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_user : input_awuser);
  assign input_aw_s2mPipe_payload_prot = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_prot : input_awprot);
  assign when_Stream_l365 = (input_awready && (! input_aw_s2mPipe_ready));
  assign input_aw_s2mPipe_ready = ((1'b1 && (! input_aw_s2mPipe_m2sPipe_valid)) || input_aw_s2mPipe_m2sPipe_ready);
  assign input_aw_s2mPipe_m2sPipe_valid = input_aw_s2mPipe_rValid_1;
  assign input_aw_s2mPipe_m2sPipe_payload_addr = input_aw_s2mPipe_rData_addr_1;
  assign input_aw_s2mPipe_m2sPipe_payload_id = input_aw_s2mPipe_rData_id_1;
  assign input_aw_s2mPipe_m2sPipe_payload_len = input_aw_s2mPipe_rData_len_1;
  assign input_aw_s2mPipe_m2sPipe_payload_size = input_aw_s2mPipe_rData_size_1;
  assign input_aw_s2mPipe_m2sPipe_payload_burst = input_aw_s2mPipe_rData_burst_1;
  assign input_aw_s2mPipe_m2sPipe_payload_lock = input_aw_s2mPipe_rData_lock_1;
  assign input_aw_s2mPipe_m2sPipe_payload_cache = input_aw_s2mPipe_rData_cache_1;
  assign input_aw_s2mPipe_m2sPipe_payload_qos = input_aw_s2mPipe_rData_qos_1;
  assign input_aw_s2mPipe_m2sPipe_payload_user = input_aw_s2mPipe_rData_user_1;
  assign input_aw_s2mPipe_m2sPipe_payload_prot = input_aw_s2mPipe_rData_prot_1;
  assign output_awvalid = input_aw_s2mPipe_m2sPipe_valid;
  assign input_aw_s2mPipe_m2sPipe_ready = output_awready;
  assign output_awaddr = input_aw_s2mPipe_m2sPipe_payload_addr;
  assign output_awid = input_aw_s2mPipe_m2sPipe_payload_id;
  assign output_awlen = input_aw_s2mPipe_m2sPipe_payload_len;
  assign output_awsize = input_aw_s2mPipe_m2sPipe_payload_size;
  assign output_awburst = input_aw_s2mPipe_m2sPipe_payload_burst;
  assign output_awlock = input_aw_s2mPipe_m2sPipe_payload_lock;
  assign output_awcache = input_aw_s2mPipe_m2sPipe_payload_cache;
  assign output_awqos = input_aw_s2mPipe_m2sPipe_payload_qos;
  assign output_awuser = input_aw_s2mPipe_m2sPipe_payload_user;
  assign output_awprot = input_aw_s2mPipe_m2sPipe_payload_prot;
  assign input_w_s2mPipe_valid = (input_wvalid || input_w_s2mPipe_rValid);
  assign input_wready = (! input_w_s2mPipe_rValid);
  assign input_w_s2mPipe_payload_data = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_data : input_wdata);
  assign input_w_s2mPipe_payload_strb = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_strb : input_wstrb);
  assign input_w_s2mPipe_payload_user = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_user : input_wuser);
  assign input_w_s2mPipe_payload_last = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_last : input_wlast);
  assign when_Stream_l365_1 = (input_wready && (! input_w_s2mPipe_ready));
  assign input_w_s2mPipe_ready = ((1'b1 && (! input_w_s2mPipe_m2sPipe_valid)) || input_w_s2mPipe_m2sPipe_ready);
  assign input_w_s2mPipe_m2sPipe_valid = input_w_s2mPipe_rValid_1;
  assign input_w_s2mPipe_m2sPipe_payload_data = input_w_s2mPipe_rData_data_1;
  assign input_w_s2mPipe_m2sPipe_payload_strb = input_w_s2mPipe_rData_strb_1;
  assign input_w_s2mPipe_m2sPipe_payload_user = input_w_s2mPipe_rData_user_1;
  assign input_w_s2mPipe_m2sPipe_payload_last = input_w_s2mPipe_rData_last_1;
  assign output_wvalid = input_w_s2mPipe_m2sPipe_valid;
  assign input_w_s2mPipe_m2sPipe_ready = output_wready;
  assign output_wdata = input_w_s2mPipe_m2sPipe_payload_data;
  assign output_wstrb = input_w_s2mPipe_m2sPipe_payload_strb;
  assign output_wuser = input_w_s2mPipe_m2sPipe_payload_user;
  assign output_wlast = input_w_s2mPipe_m2sPipe_payload_last;
  assign output_b_s2mPipe_valid = (output_bvalid || output_b_s2mPipe_rValid);
  assign output_bready = (! output_b_s2mPipe_rValid);
  assign output_b_s2mPipe_payload_id = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_id : output_bid);
  assign output_b_s2mPipe_payload_resp = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_resp : output_bresp);
  assign output_b_s2mPipe_payload_user = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_user : output_buser);
  assign when_Stream_l365_2 = (output_bready && (! output_b_s2mPipe_ready));
  assign output_b_s2mPipe_ready = ((1'b1 && (! output_b_s2mPipe_m2sPipe_valid)) || output_b_s2mPipe_m2sPipe_ready);
  assign output_b_s2mPipe_m2sPipe_valid = output_b_s2mPipe_rValid_1;
  assign output_b_s2mPipe_m2sPipe_payload_id = output_b_s2mPipe_rData_id_1;
  assign output_b_s2mPipe_m2sPipe_payload_resp = output_b_s2mPipe_rData_resp_1;
  assign output_b_s2mPipe_m2sPipe_payload_user = output_b_s2mPipe_rData_user_1;
  assign input_bvalid = output_b_s2mPipe_m2sPipe_valid;
  assign output_b_s2mPipe_m2sPipe_ready = input_bready;
  assign input_bid = output_b_s2mPipe_m2sPipe_payload_id;
  assign input_bresp = output_b_s2mPipe_m2sPipe_payload_resp;
  assign input_buser = output_b_s2mPipe_m2sPipe_payload_user;
  assign input_ar_s2mPipe_valid = (input_arvalid || input_ar_s2mPipe_rValid);
  assign input_arready = (! input_ar_s2mPipe_rValid);
  assign input_ar_s2mPipe_payload_addr = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_addr : input_araddr);
  assign input_ar_s2mPipe_payload_id = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_id : input_arid);
  assign input_ar_s2mPipe_payload_len = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_len : input_arlen);
  assign input_ar_s2mPipe_payload_size = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_size : input_arsize);
  assign input_ar_s2mPipe_payload_burst = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_burst : input_arburst);
  assign input_ar_s2mPipe_payload_lock = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_lock : input_arlock);
  assign input_ar_s2mPipe_payload_cache = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_cache : input_arcache);
  assign input_ar_s2mPipe_payload_qos = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_qos : input_arqos);
  assign input_ar_s2mPipe_payload_user = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_user : input_aruser);
  assign input_ar_s2mPipe_payload_prot = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_prot : input_arprot);
  assign when_Stream_l365_3 = (input_arready && (! input_ar_s2mPipe_ready));
  assign input_ar_s2mPipe_ready = ((1'b1 && (! input_ar_s2mPipe_m2sPipe_valid)) || input_ar_s2mPipe_m2sPipe_ready);
  assign input_ar_s2mPipe_m2sPipe_valid = input_ar_s2mPipe_rValid_1;
  assign input_ar_s2mPipe_m2sPipe_payload_addr = input_ar_s2mPipe_rData_addr_1;
  assign input_ar_s2mPipe_m2sPipe_payload_id = input_ar_s2mPipe_rData_id_1;
  assign input_ar_s2mPipe_m2sPipe_payload_len = input_ar_s2mPipe_rData_len_1;
  assign input_ar_s2mPipe_m2sPipe_payload_size = input_ar_s2mPipe_rData_size_1;
  assign input_ar_s2mPipe_m2sPipe_payload_burst = input_ar_s2mPipe_rData_burst_1;
  assign input_ar_s2mPipe_m2sPipe_payload_lock = input_ar_s2mPipe_rData_lock_1;
  assign input_ar_s2mPipe_m2sPipe_payload_cache = input_ar_s2mPipe_rData_cache_1;
  assign input_ar_s2mPipe_m2sPipe_payload_qos = input_ar_s2mPipe_rData_qos_1;
  assign input_ar_s2mPipe_m2sPipe_payload_user = input_ar_s2mPipe_rData_user_1;
  assign input_ar_s2mPipe_m2sPipe_payload_prot = input_ar_s2mPipe_rData_prot_1;
  assign output_arvalid = input_ar_s2mPipe_m2sPipe_valid;
  assign input_ar_s2mPipe_m2sPipe_ready = output_arready;
  assign output_araddr = input_ar_s2mPipe_m2sPipe_payload_addr;
  assign output_arid = input_ar_s2mPipe_m2sPipe_payload_id;
  assign output_arlen = input_ar_s2mPipe_m2sPipe_payload_len;
  assign output_arsize = input_ar_s2mPipe_m2sPipe_payload_size;
  assign output_arburst = input_ar_s2mPipe_m2sPipe_payload_burst;
  assign output_arlock = input_ar_s2mPipe_m2sPipe_payload_lock;
  assign output_arcache = input_ar_s2mPipe_m2sPipe_payload_cache;
  assign output_arqos = input_ar_s2mPipe_m2sPipe_payload_qos;
  assign output_aruser = input_ar_s2mPipe_m2sPipe_payload_user;
  assign output_arprot = input_ar_s2mPipe_m2sPipe_payload_prot;
  assign output_r_s2mPipe_valid = (output_rvalid || output_r_s2mPipe_rValid);
  assign output_rready = (! output_r_s2mPipe_rValid);
  assign output_r_s2mPipe_payload_data = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_data : output_rdata);
  assign output_r_s2mPipe_payload_id = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_id : output_rid);
  assign output_r_s2mPipe_payload_resp = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_resp : output_rresp);
  assign output_r_s2mPipe_payload_last = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_last : output_rlast);
  assign output_r_s2mPipe_payload_user = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_user : output_ruser);
  assign when_Stream_l365_4 = (output_rready && (! output_r_s2mPipe_ready));
  assign output_r_s2mPipe_ready = ((1'b1 && (! output_r_s2mPipe_m2sPipe_valid)) || output_r_s2mPipe_m2sPipe_ready);
  assign output_r_s2mPipe_m2sPipe_valid = output_r_s2mPipe_rValid_1;
  assign output_r_s2mPipe_m2sPipe_payload_data = output_r_s2mPipe_rData_data_1;
  assign output_r_s2mPipe_m2sPipe_payload_id = output_r_s2mPipe_rData_id_1;
  assign output_r_s2mPipe_m2sPipe_payload_resp = output_r_s2mPipe_rData_resp_1;
  assign output_r_s2mPipe_m2sPipe_payload_last = output_r_s2mPipe_rData_last_1;
  assign output_r_s2mPipe_m2sPipe_payload_user = output_r_s2mPipe_rData_user_1;
  assign input_rvalid = output_r_s2mPipe_m2sPipe_valid;
  assign output_r_s2mPipe_m2sPipe_ready = input_rready;
  assign input_rdata = output_r_s2mPipe_m2sPipe_payload_data;
  assign input_rid = output_r_s2mPipe_m2sPipe_payload_id;
  assign input_rresp = output_r_s2mPipe_m2sPipe_payload_resp;
  assign input_rlast = output_r_s2mPipe_m2sPipe_payload_last;
  assign input_ruser = output_r_s2mPipe_m2sPipe_payload_user;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      input_aw_s2mPipe_rValid <= 1'b0;
      input_aw_s2mPipe_rValid_1 <= 1'b0;
      input_w_s2mPipe_rValid <= 1'b0;
      input_w_s2mPipe_rValid_1 <= 1'b0;
      output_b_s2mPipe_rValid <= 1'b0;
      output_b_s2mPipe_rValid_1 <= 1'b0;
      input_ar_s2mPipe_rValid <= 1'b0;
      input_ar_s2mPipe_rValid_1 <= 1'b0;
      output_r_s2mPipe_rValid <= 1'b0;
      output_r_s2mPipe_rValid_1 <= 1'b0;
    end else begin
      if(input_aw_s2mPipe_ready) begin
        input_aw_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365) begin
        input_aw_s2mPipe_rValid <= input_awvalid;
      end
      if(input_aw_s2mPipe_ready) begin
        input_aw_s2mPipe_rValid_1 <= input_aw_s2mPipe_valid;
      end
      if(input_w_s2mPipe_ready) begin
        input_w_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_1) begin
        input_w_s2mPipe_rValid <= input_wvalid;
      end
      if(input_w_s2mPipe_ready) begin
        input_w_s2mPipe_rValid_1 <= input_w_s2mPipe_valid;
      end
      if(output_b_s2mPipe_ready) begin
        output_b_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_2) begin
        output_b_s2mPipe_rValid <= output_bvalid;
      end
      if(output_b_s2mPipe_ready) begin
        output_b_s2mPipe_rValid_1 <= output_b_s2mPipe_valid;
      end
      if(input_ar_s2mPipe_ready) begin
        input_ar_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_3) begin
        input_ar_s2mPipe_rValid <= input_arvalid;
      end
      if(input_ar_s2mPipe_ready) begin
        input_ar_s2mPipe_rValid_1 <= input_ar_s2mPipe_valid;
      end
      if(output_r_s2mPipe_ready) begin
        output_r_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_4) begin
        output_r_s2mPipe_rValid <= output_rvalid;
      end
      if(output_r_s2mPipe_ready) begin
        output_r_s2mPipe_rValid_1 <= output_r_s2mPipe_valid;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(when_Stream_l365) begin
      input_aw_s2mPipe_rData_addr <= input_awaddr;
      input_aw_s2mPipe_rData_id <= input_awid;
      input_aw_s2mPipe_rData_len <= input_awlen;
      input_aw_s2mPipe_rData_size <= input_awsize;
      input_aw_s2mPipe_rData_burst <= input_awburst;
      input_aw_s2mPipe_rData_lock <= input_awlock;
      input_aw_s2mPipe_rData_cache <= input_awcache;
      input_aw_s2mPipe_rData_qos <= input_awqos;
      input_aw_s2mPipe_rData_user <= input_awuser;
      input_aw_s2mPipe_rData_prot <= input_awprot;
    end
    if(input_aw_s2mPipe_ready) begin
      input_aw_s2mPipe_rData_addr_1 <= input_aw_s2mPipe_payload_addr;
      input_aw_s2mPipe_rData_id_1 <= input_aw_s2mPipe_payload_id;
      input_aw_s2mPipe_rData_len_1 <= input_aw_s2mPipe_payload_len;
      input_aw_s2mPipe_rData_size_1 <= input_aw_s2mPipe_payload_size;
      input_aw_s2mPipe_rData_burst_1 <= input_aw_s2mPipe_payload_burst;
      input_aw_s2mPipe_rData_lock_1 <= input_aw_s2mPipe_payload_lock;
      input_aw_s2mPipe_rData_cache_1 <= input_aw_s2mPipe_payload_cache;
      input_aw_s2mPipe_rData_qos_1 <= input_aw_s2mPipe_payload_qos;
      input_aw_s2mPipe_rData_user_1 <= input_aw_s2mPipe_payload_user;
      input_aw_s2mPipe_rData_prot_1 <= input_aw_s2mPipe_payload_prot;
    end
    if(when_Stream_l365_1) begin
      input_w_s2mPipe_rData_data <= input_wdata;
      input_w_s2mPipe_rData_strb <= input_wstrb;
      input_w_s2mPipe_rData_user <= input_wuser;
      input_w_s2mPipe_rData_last <= input_wlast;
    end
    if(input_w_s2mPipe_ready) begin
      input_w_s2mPipe_rData_data_1 <= input_w_s2mPipe_payload_data;
      input_w_s2mPipe_rData_strb_1 <= input_w_s2mPipe_payload_strb;
      input_w_s2mPipe_rData_user_1 <= input_w_s2mPipe_payload_user;
      input_w_s2mPipe_rData_last_1 <= input_w_s2mPipe_payload_last;
    end
    if(when_Stream_l365_2) begin
      output_b_s2mPipe_rData_id <= output_bid;
      output_b_s2mPipe_rData_resp <= output_bresp;
      output_b_s2mPipe_rData_user <= output_buser;
    end
    if(output_b_s2mPipe_ready) begin
      output_b_s2mPipe_rData_id_1 <= output_b_s2mPipe_payload_id;
      output_b_s2mPipe_rData_resp_1 <= output_b_s2mPipe_payload_resp;
      output_b_s2mPipe_rData_user_1 <= output_b_s2mPipe_payload_user;
    end
    if(when_Stream_l365_3) begin
      input_ar_s2mPipe_rData_addr <= input_araddr;
      input_ar_s2mPipe_rData_id <= input_arid;
      input_ar_s2mPipe_rData_len <= input_arlen;
      input_ar_s2mPipe_rData_size <= input_arsize;
      input_ar_s2mPipe_rData_burst <= input_arburst;
      input_ar_s2mPipe_rData_lock <= input_arlock;
      input_ar_s2mPipe_rData_cache <= input_arcache;
      input_ar_s2mPipe_rData_qos <= input_arqos;
      input_ar_s2mPipe_rData_user <= input_aruser;
      input_ar_s2mPipe_rData_prot <= input_arprot;
    end
    if(input_ar_s2mPipe_ready) begin
      input_ar_s2mPipe_rData_addr_1 <= input_ar_s2mPipe_payload_addr;
      input_ar_s2mPipe_rData_id_1 <= input_ar_s2mPipe_payload_id;
      input_ar_s2mPipe_rData_len_1 <= input_ar_s2mPipe_payload_len;
      input_ar_s2mPipe_rData_size_1 <= input_ar_s2mPipe_payload_size;
      input_ar_s2mPipe_rData_burst_1 <= input_ar_s2mPipe_payload_burst;
      input_ar_s2mPipe_rData_lock_1 <= input_ar_s2mPipe_payload_lock;
      input_ar_s2mPipe_rData_cache_1 <= input_ar_s2mPipe_payload_cache;
      input_ar_s2mPipe_rData_qos_1 <= input_ar_s2mPipe_payload_qos;
      input_ar_s2mPipe_rData_user_1 <= input_ar_s2mPipe_payload_user;
      input_ar_s2mPipe_rData_prot_1 <= input_ar_s2mPipe_payload_prot;
    end
    if(when_Stream_l365_4) begin
      output_r_s2mPipe_rData_data <= output_rdata;
      output_r_s2mPipe_rData_id <= output_rid;
      output_r_s2mPipe_rData_resp <= output_rresp;
      output_r_s2mPipe_rData_last <= output_rlast;
      output_r_s2mPipe_rData_user <= output_ruser;
    end
    if(output_r_s2mPipe_ready) begin
      output_r_s2mPipe_rData_data_1 <= output_r_s2mPipe_payload_data;
      output_r_s2mPipe_rData_id_1 <= output_r_s2mPipe_payload_id;
      output_r_s2mPipe_rData_resp_1 <= output_r_s2mPipe_payload_resp;
      output_r_s2mPipe_rData_last_1 <= output_r_s2mPipe_payload_last;
      output_r_s2mPipe_rData_user_1 <= output_r_s2mPipe_payload_user;
    end
  end


endmodule

module ALite4Slice (
  input               input_awvalid,
  output              input_awready,
  input      [31:0]   input_awaddr,
  input      [2:0]    input_awprot,
  input      [31:0]   input_awuser,
  input               input_wvalid,
  output              input_wready,
  input      [63:0]   input_wdata,
  input      [7:0]    input_wstrb,
  output              input_bvalid,
  input               input_bready,
  output     [1:0]    input_bresp,
  input               input_arvalid,
  output              input_arready,
  input      [31:0]   input_araddr,
  input      [2:0]    input_arprot,
  input      [31:0]   input_aruser,
  output              input_rvalid,
  input               input_rready,
  output     [63:0]   input_rdata,
  output     [1:0]    input_rresp,
  output              output_awvalid,
  input               output_awready,
  output     [31:0]   output_awaddr,
  output     [2:0]    output_awprot,
  output     [31:0]   output_awuser,
  output              output_wvalid,
  input               output_wready,
  output     [63:0]   output_wdata,
  output     [7:0]    output_wstrb,
  input               output_bvalid,
  output              output_bready,
  input      [1:0]    output_bresp,
  output              output_arvalid,
  input               output_arready,
  output     [31:0]   output_araddr,
  output     [2:0]    output_arprot,
  output     [31:0]   output_aruser,
  input               output_rvalid,
  output              output_rready,
  input      [63:0]   output_rdata,
  input      [1:0]    output_rresp,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  wire                input_aw_s2mPipe_valid;
  wire                input_aw_s2mPipe_ready;
  wire       [31:0]   input_aw_s2mPipe_payload_addr;
  wire       [2:0]    input_aw_s2mPipe_payload_prot;
  wire       [31:0]   input_aw_s2mPipe_payload_user;
  reg                 input_aw_s2mPipe_rValid;
  reg        [31:0]   input_aw_s2mPipe_rData_addr;
  reg        [2:0]    input_aw_s2mPipe_rData_prot;
  reg        [31:0]   input_aw_s2mPipe_rData_user;
  wire                when_Stream_l365;
  wire                input_aw_s2mPipe_m2sPipe_valid;
  wire                input_aw_s2mPipe_m2sPipe_ready;
  wire       [31:0]   input_aw_s2mPipe_m2sPipe_payload_addr;
  wire       [2:0]    input_aw_s2mPipe_m2sPipe_payload_prot;
  wire       [31:0]   input_aw_s2mPipe_m2sPipe_payload_user;
  reg                 input_aw_s2mPipe_rValid_1;
  reg        [31:0]   input_aw_s2mPipe_rData_addr_1;
  reg        [2:0]    input_aw_s2mPipe_rData_prot_1;
  reg        [31:0]   input_aw_s2mPipe_rData_user_1;
  wire                input_w_s2mPipe_valid;
  wire                input_w_s2mPipe_ready;
  wire       [63:0]   input_w_s2mPipe_payload_data;
  wire       [7:0]    input_w_s2mPipe_payload_strb;
  reg                 input_w_s2mPipe_rValid;
  reg        [63:0]   input_w_s2mPipe_rData_data;
  reg        [7:0]    input_w_s2mPipe_rData_strb;
  wire                when_Stream_l365_1;
  wire                input_w_s2mPipe_m2sPipe_valid;
  wire                input_w_s2mPipe_m2sPipe_ready;
  wire       [63:0]   input_w_s2mPipe_m2sPipe_payload_data;
  wire       [7:0]    input_w_s2mPipe_m2sPipe_payload_strb;
  reg                 input_w_s2mPipe_rValid_1;
  reg        [63:0]   input_w_s2mPipe_rData_data_1;
  reg        [7:0]    input_w_s2mPipe_rData_strb_1;
  wire                output_b_s2mPipe_valid;
  wire                output_b_s2mPipe_ready;
  wire       [1:0]    output_b_s2mPipe_payload_resp;
  reg                 output_b_s2mPipe_rValid;
  reg        [1:0]    output_b_s2mPipe_rData_resp;
  wire                when_Stream_l365_2;
  wire                output_b_s2mPipe_m2sPipe_valid;
  wire                output_b_s2mPipe_m2sPipe_ready;
  wire       [1:0]    output_b_s2mPipe_m2sPipe_payload_resp;
  reg                 output_b_s2mPipe_rValid_1;
  reg        [1:0]    output_b_s2mPipe_rData_resp_1;
  wire                input_ar_s2mPipe_valid;
  wire                input_ar_s2mPipe_ready;
  wire       [31:0]   input_ar_s2mPipe_payload_addr;
  wire       [2:0]    input_ar_s2mPipe_payload_prot;
  wire       [31:0]   input_ar_s2mPipe_payload_user;
  reg                 input_ar_s2mPipe_rValid;
  reg        [31:0]   input_ar_s2mPipe_rData_addr;
  reg        [2:0]    input_ar_s2mPipe_rData_prot;
  reg        [31:0]   input_ar_s2mPipe_rData_user;
  wire                when_Stream_l365_3;
  wire                input_ar_s2mPipe_m2sPipe_valid;
  wire                input_ar_s2mPipe_m2sPipe_ready;
  wire       [31:0]   input_ar_s2mPipe_m2sPipe_payload_addr;
  wire       [2:0]    input_ar_s2mPipe_m2sPipe_payload_prot;
  wire       [31:0]   input_ar_s2mPipe_m2sPipe_payload_user;
  reg                 input_ar_s2mPipe_rValid_1;
  reg        [31:0]   input_ar_s2mPipe_rData_addr_1;
  reg        [2:0]    input_ar_s2mPipe_rData_prot_1;
  reg        [31:0]   input_ar_s2mPipe_rData_user_1;
  wire                output_r_s2mPipe_valid;
  wire                output_r_s2mPipe_ready;
  wire       [63:0]   output_r_s2mPipe_payload_data;
  wire       [1:0]    output_r_s2mPipe_payload_resp;
  reg                 output_r_s2mPipe_rValid;
  reg        [63:0]   output_r_s2mPipe_rData_data;
  reg        [1:0]    output_r_s2mPipe_rData_resp;
  wire                when_Stream_l365_4;
  wire                output_r_s2mPipe_m2sPipe_valid;
  wire                output_r_s2mPipe_m2sPipe_ready;
  wire       [63:0]   output_r_s2mPipe_m2sPipe_payload_data;
  wire       [1:0]    output_r_s2mPipe_m2sPipe_payload_resp;
  reg                 output_r_s2mPipe_rValid_1;
  reg        [63:0]   output_r_s2mPipe_rData_data_1;
  reg        [1:0]    output_r_s2mPipe_rData_resp_1;

  assign input_aw_s2mPipe_valid = (input_awvalid || input_aw_s2mPipe_rValid);
  assign input_awready = (! input_aw_s2mPipe_rValid);
  assign input_aw_s2mPipe_payload_addr = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_addr : input_awaddr);
  assign input_aw_s2mPipe_payload_prot = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_prot : input_awprot);
  assign input_aw_s2mPipe_payload_user = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_user : input_awuser);
  assign when_Stream_l365 = (input_awready && (! input_aw_s2mPipe_ready));
  assign input_aw_s2mPipe_ready = ((1'b1 && (! input_aw_s2mPipe_m2sPipe_valid)) || input_aw_s2mPipe_m2sPipe_ready);
  assign input_aw_s2mPipe_m2sPipe_valid = input_aw_s2mPipe_rValid_1;
  assign input_aw_s2mPipe_m2sPipe_payload_addr = input_aw_s2mPipe_rData_addr_1;
  assign input_aw_s2mPipe_m2sPipe_payload_prot = input_aw_s2mPipe_rData_prot_1;
  assign input_aw_s2mPipe_m2sPipe_payload_user = input_aw_s2mPipe_rData_user_1;
  assign output_awvalid = input_aw_s2mPipe_m2sPipe_valid;
  assign input_aw_s2mPipe_m2sPipe_ready = output_awready;
  assign output_awaddr = input_aw_s2mPipe_m2sPipe_payload_addr;
  assign output_awprot = input_aw_s2mPipe_m2sPipe_payload_prot;
  assign output_awuser = input_aw_s2mPipe_m2sPipe_payload_user;
  assign input_w_s2mPipe_valid = (input_wvalid || input_w_s2mPipe_rValid);
  assign input_wready = (! input_w_s2mPipe_rValid);
  assign input_w_s2mPipe_payload_data = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_data : input_wdata);
  assign input_w_s2mPipe_payload_strb = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_strb : input_wstrb);
  assign when_Stream_l365_1 = (input_wready && (! input_w_s2mPipe_ready));
  assign input_w_s2mPipe_ready = ((1'b1 && (! input_w_s2mPipe_m2sPipe_valid)) || input_w_s2mPipe_m2sPipe_ready);
  assign input_w_s2mPipe_m2sPipe_valid = input_w_s2mPipe_rValid_1;
  assign input_w_s2mPipe_m2sPipe_payload_data = input_w_s2mPipe_rData_data_1;
  assign input_w_s2mPipe_m2sPipe_payload_strb = input_w_s2mPipe_rData_strb_1;
  assign output_wvalid = input_w_s2mPipe_m2sPipe_valid;
  assign input_w_s2mPipe_m2sPipe_ready = output_wready;
  assign output_wdata = input_w_s2mPipe_m2sPipe_payload_data;
  assign output_wstrb = input_w_s2mPipe_m2sPipe_payload_strb;
  assign output_b_s2mPipe_valid = (output_bvalid || output_b_s2mPipe_rValid);
  assign output_bready = (! output_b_s2mPipe_rValid);
  assign output_b_s2mPipe_payload_resp = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_resp : output_bresp);
  assign when_Stream_l365_2 = (output_bready && (! output_b_s2mPipe_ready));
  assign output_b_s2mPipe_ready = ((1'b1 && (! output_b_s2mPipe_m2sPipe_valid)) || output_b_s2mPipe_m2sPipe_ready);
  assign output_b_s2mPipe_m2sPipe_valid = output_b_s2mPipe_rValid_1;
  assign output_b_s2mPipe_m2sPipe_payload_resp = output_b_s2mPipe_rData_resp_1;
  assign input_bvalid = output_b_s2mPipe_m2sPipe_valid;
  assign output_b_s2mPipe_m2sPipe_ready = input_bready;
  assign input_bresp = output_b_s2mPipe_m2sPipe_payload_resp;
  assign input_ar_s2mPipe_valid = (input_arvalid || input_ar_s2mPipe_rValid);
  assign input_arready = (! input_ar_s2mPipe_rValid);
  assign input_ar_s2mPipe_payload_addr = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_addr : input_araddr);
  assign input_ar_s2mPipe_payload_prot = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_prot : input_arprot);
  assign input_ar_s2mPipe_payload_user = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_user : input_aruser);
  assign when_Stream_l365_3 = (input_arready && (! input_ar_s2mPipe_ready));
  assign input_ar_s2mPipe_ready = ((1'b1 && (! input_ar_s2mPipe_m2sPipe_valid)) || input_ar_s2mPipe_m2sPipe_ready);
  assign input_ar_s2mPipe_m2sPipe_valid = input_ar_s2mPipe_rValid_1;
  assign input_ar_s2mPipe_m2sPipe_payload_addr = input_ar_s2mPipe_rData_addr_1;
  assign input_ar_s2mPipe_m2sPipe_payload_prot = input_ar_s2mPipe_rData_prot_1;
  assign input_ar_s2mPipe_m2sPipe_payload_user = input_ar_s2mPipe_rData_user_1;
  assign output_arvalid = input_ar_s2mPipe_m2sPipe_valid;
  assign input_ar_s2mPipe_m2sPipe_ready = output_arready;
  assign output_araddr = input_ar_s2mPipe_m2sPipe_payload_addr;
  assign output_arprot = input_ar_s2mPipe_m2sPipe_payload_prot;
  assign output_aruser = input_ar_s2mPipe_m2sPipe_payload_user;
  assign output_r_s2mPipe_valid = (output_rvalid || output_r_s2mPipe_rValid);
  assign output_rready = (! output_r_s2mPipe_rValid);
  assign output_r_s2mPipe_payload_data = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_data : output_rdata);
  assign output_r_s2mPipe_payload_resp = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_resp : output_rresp);
  assign when_Stream_l365_4 = (output_rready && (! output_r_s2mPipe_ready));
  assign output_r_s2mPipe_ready = ((1'b1 && (! output_r_s2mPipe_m2sPipe_valid)) || output_r_s2mPipe_m2sPipe_ready);
  assign output_r_s2mPipe_m2sPipe_valid = output_r_s2mPipe_rValid_1;
  assign output_r_s2mPipe_m2sPipe_payload_data = output_r_s2mPipe_rData_data_1;
  assign output_r_s2mPipe_m2sPipe_payload_resp = output_r_s2mPipe_rData_resp_1;
  assign input_rvalid = output_r_s2mPipe_m2sPipe_valid;
  assign output_r_s2mPipe_m2sPipe_ready = input_rready;
  assign input_rdata = output_r_s2mPipe_m2sPipe_payload_data;
  assign input_rresp = output_r_s2mPipe_m2sPipe_payload_resp;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      input_aw_s2mPipe_rValid <= 1'b0;
      input_aw_s2mPipe_rValid_1 <= 1'b0;
      input_w_s2mPipe_rValid <= 1'b0;
      input_w_s2mPipe_rValid_1 <= 1'b0;
      output_b_s2mPipe_rValid <= 1'b0;
      output_b_s2mPipe_rValid_1 <= 1'b0;
      input_ar_s2mPipe_rValid <= 1'b0;
      input_ar_s2mPipe_rValid_1 <= 1'b0;
      output_r_s2mPipe_rValid <= 1'b0;
      output_r_s2mPipe_rValid_1 <= 1'b0;
    end else begin
      if(input_aw_s2mPipe_ready) begin
        input_aw_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365) begin
        input_aw_s2mPipe_rValid <= input_awvalid;
      end
      if(input_aw_s2mPipe_ready) begin
        input_aw_s2mPipe_rValid_1 <= input_aw_s2mPipe_valid;
      end
      if(input_w_s2mPipe_ready) begin
        input_w_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_1) begin
        input_w_s2mPipe_rValid <= input_wvalid;
      end
      if(input_w_s2mPipe_ready) begin
        input_w_s2mPipe_rValid_1 <= input_w_s2mPipe_valid;
      end
      if(output_b_s2mPipe_ready) begin
        output_b_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_2) begin
        output_b_s2mPipe_rValid <= output_bvalid;
      end
      if(output_b_s2mPipe_ready) begin
        output_b_s2mPipe_rValid_1 <= output_b_s2mPipe_valid;
      end
      if(input_ar_s2mPipe_ready) begin
        input_ar_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_3) begin
        input_ar_s2mPipe_rValid <= input_arvalid;
      end
      if(input_ar_s2mPipe_ready) begin
        input_ar_s2mPipe_rValid_1 <= input_ar_s2mPipe_valid;
      end
      if(output_r_s2mPipe_ready) begin
        output_r_s2mPipe_rValid <= 1'b0;
      end
      if(when_Stream_l365_4) begin
        output_r_s2mPipe_rValid <= output_rvalid;
      end
      if(output_r_s2mPipe_ready) begin
        output_r_s2mPipe_rValid_1 <= output_r_s2mPipe_valid;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(when_Stream_l365) begin
      input_aw_s2mPipe_rData_addr <= input_awaddr;
      input_aw_s2mPipe_rData_prot <= input_awprot;
      input_aw_s2mPipe_rData_user <= input_awuser;
    end
    if(input_aw_s2mPipe_ready) begin
      input_aw_s2mPipe_rData_addr_1 <= input_aw_s2mPipe_payload_addr;
      input_aw_s2mPipe_rData_prot_1 <= input_aw_s2mPipe_payload_prot;
      input_aw_s2mPipe_rData_user_1 <= input_aw_s2mPipe_payload_user;
    end
    if(when_Stream_l365_1) begin
      input_w_s2mPipe_rData_data <= input_wdata;
      input_w_s2mPipe_rData_strb <= input_wstrb;
    end
    if(input_w_s2mPipe_ready) begin
      input_w_s2mPipe_rData_data_1 <= input_w_s2mPipe_payload_data;
      input_w_s2mPipe_rData_strb_1 <= input_w_s2mPipe_payload_strb;
    end
    if(when_Stream_l365_2) begin
      output_b_s2mPipe_rData_resp <= output_bresp;
    end
    if(output_b_s2mPipe_ready) begin
      output_b_s2mPipe_rData_resp_1 <= output_b_s2mPipe_payload_resp;
    end
    if(when_Stream_l365_3) begin
      input_ar_s2mPipe_rData_addr <= input_araddr;
      input_ar_s2mPipe_rData_prot <= input_arprot;
      input_ar_s2mPipe_rData_user <= input_aruser;
    end
    if(input_ar_s2mPipe_ready) begin
      input_ar_s2mPipe_rData_addr_1 <= input_ar_s2mPipe_payload_addr;
      input_ar_s2mPipe_rData_prot_1 <= input_ar_s2mPipe_payload_prot;
      input_ar_s2mPipe_rData_user_1 <= input_ar_s2mPipe_payload_user;
    end
    if(when_Stream_l365_4) begin
      output_r_s2mPipe_rData_data <= output_rdata;
      output_r_s2mPipe_rData_resp <= output_rresp;
    end
    if(output_r_s2mPipe_ready) begin
      output_r_s2mPipe_rData_data_1 <= output_r_s2mPipe_payload_data;
      output_r_s2mPipe_rData_resp_1 <= output_r_s2mPipe_payload_resp;
    end
  end


endmodule

module Axi4CC (
  input               io_input_aw_valid,
  output              io_input_aw_ready,
  input      [63:0]   io_input_aw_payload_addr,
  input      [3:0]    io_input_aw_payload_id,
  input      [7:0]    io_input_aw_payload_len,
  input      [2:0]    io_input_aw_payload_size,
  input      [1:0]    io_input_aw_payload_burst,
  input      [0:0]    io_input_aw_payload_lock,
  input      [3:0]    io_input_aw_payload_cache,
  input      [3:0]    io_input_aw_payload_qos,
  input      [63:0]   io_input_aw_payload_user,
  input      [2:0]    io_input_aw_payload_prot,
  input               io_input_w_valid,
  output              io_input_w_ready,
  input      [511:0]  io_input_w_payload_data,
  input      [63:0]   io_input_w_payload_strb,
  input      [3:0]    io_input_w_payload_user,
  input               io_input_w_payload_last,
  output              io_input_b_valid,
  input               io_input_b_ready,
  output     [3:0]    io_input_b_payload_id,
  output     [1:0]    io_input_b_payload_resp,
  output     [63:0]   io_input_b_payload_user,
  input               io_input_ar_valid,
  output              io_input_ar_ready,
  input      [63:0]   io_input_ar_payload_addr,
  input      [3:0]    io_input_ar_payload_id,
  input      [7:0]    io_input_ar_payload_len,
  input      [2:0]    io_input_ar_payload_size,
  input      [1:0]    io_input_ar_payload_burst,
  input      [0:0]    io_input_ar_payload_lock,
  input      [3:0]    io_input_ar_payload_cache,
  input      [3:0]    io_input_ar_payload_qos,
  input      [63:0]   io_input_ar_payload_user,
  input      [2:0]    io_input_ar_payload_prot,
  output              io_input_r_valid,
  input               io_input_r_ready,
  output     [511:0]  io_input_r_payload_data,
  output     [3:0]    io_input_r_payload_id,
  output     [1:0]    io_input_r_payload_resp,
  output              io_input_r_payload_last,
  output     [63:0]   io_input_r_payload_user,
  output              io_output_aw_valid,
  input               io_output_aw_ready,
  output     [63:0]   io_output_aw_payload_addr,
  output     [3:0]    io_output_aw_payload_id,
  output     [7:0]    io_output_aw_payload_len,
  output     [2:0]    io_output_aw_payload_size,
  output     [1:0]    io_output_aw_payload_burst,
  output     [0:0]    io_output_aw_payload_lock,
  output     [3:0]    io_output_aw_payload_cache,
  output     [3:0]    io_output_aw_payload_qos,
  output     [63:0]   io_output_aw_payload_user,
  output     [2:0]    io_output_aw_payload_prot,
  output              io_output_w_valid,
  input               io_output_w_ready,
  output     [511:0]  io_output_w_payload_data,
  output     [63:0]   io_output_w_payload_strb,
  output     [3:0]    io_output_w_payload_user,
  output              io_output_w_payload_last,
  input               io_output_b_valid,
  output              io_output_b_ready,
  input      [3:0]    io_output_b_payload_id,
  input      [1:0]    io_output_b_payload_resp,
  input      [63:0]   io_output_b_payload_user,
  output              io_output_ar_valid,
  input               io_output_ar_ready,
  output     [63:0]   io_output_ar_payload_addr,
  output     [3:0]    io_output_ar_payload_id,
  output     [7:0]    io_output_ar_payload_len,
  output     [2:0]    io_output_ar_payload_size,
  output     [1:0]    io_output_ar_payload_burst,
  output     [0:0]    io_output_ar_payload_lock,
  output     [3:0]    io_output_ar_payload_cache,
  output     [3:0]    io_output_ar_payload_qos,
  output     [63:0]   io_output_ar_payload_user,
  output     [2:0]    io_output_ar_payload_prot,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [511:0]  io_output_r_payload_data,
  input      [3:0]    io_output_r_payload_id,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  input      [63:0]   io_output_r_payload_user,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  wire                io_input_ar_queue_io_push_ready;
  wire                io_input_ar_queue_io_pop_valid;
  wire       [63:0]   io_input_ar_queue_io_pop_payload_addr;
  wire       [3:0]    io_input_ar_queue_io_pop_payload_id;
  wire       [7:0]    io_input_ar_queue_io_pop_payload_len;
  wire       [2:0]    io_input_ar_queue_io_pop_payload_size;
  wire       [1:0]    io_input_ar_queue_io_pop_payload_burst;
  wire       [0:0]    io_input_ar_queue_io_pop_payload_lock;
  wire       [3:0]    io_input_ar_queue_io_pop_payload_cache;
  wire       [3:0]    io_input_ar_queue_io_pop_payload_qos;
  wire       [63:0]   io_input_ar_queue_io_pop_payload_user;
  wire       [2:0]    io_input_ar_queue_io_pop_payload_prot;
  wire       [3:0]    io_input_ar_queue_io_pushOccupancy;
  wire       [3:0]    io_input_ar_queue_io_popOccupancy;
  wire                io_output_r_queue_io_push_ready;
  wire                io_output_r_queue_io_pop_valid;
  wire       [511:0]  io_output_r_queue_io_pop_payload_data;
  wire       [3:0]    io_output_r_queue_io_pop_payload_id;
  wire       [1:0]    io_output_r_queue_io_pop_payload_resp;
  wire                io_output_r_queue_io_pop_payload_last;
  wire       [63:0]   io_output_r_queue_io_pop_payload_user;
  wire       [9:0]    io_output_r_queue_io_pushOccupancy;
  wire       [9:0]    io_output_r_queue_io_popOccupancy;
  wire                io_input_aw_queue_io_push_ready;
  wire                io_input_aw_queue_io_pop_valid;
  wire       [63:0]   io_input_aw_queue_io_pop_payload_addr;
  wire       [3:0]    io_input_aw_queue_io_pop_payload_id;
  wire       [7:0]    io_input_aw_queue_io_pop_payload_len;
  wire       [2:0]    io_input_aw_queue_io_pop_payload_size;
  wire       [1:0]    io_input_aw_queue_io_pop_payload_burst;
  wire       [0:0]    io_input_aw_queue_io_pop_payload_lock;
  wire       [3:0]    io_input_aw_queue_io_pop_payload_cache;
  wire       [3:0]    io_input_aw_queue_io_pop_payload_qos;
  wire       [63:0]   io_input_aw_queue_io_pop_payload_user;
  wire       [2:0]    io_input_aw_queue_io_pop_payload_prot;
  wire       [3:0]    io_input_aw_queue_io_pushOccupancy;
  wire       [3:0]    io_input_aw_queue_io_popOccupancy;
  wire                io_input_w_queue_io_push_ready;
  wire                io_input_w_queue_io_pop_valid;
  wire       [511:0]  io_input_w_queue_io_pop_payload_data;
  wire       [63:0]   io_input_w_queue_io_pop_payload_strb;
  wire       [3:0]    io_input_w_queue_io_pop_payload_user;
  wire                io_input_w_queue_io_pop_payload_last;
  wire       [9:0]    io_input_w_queue_io_pushOccupancy;
  wire       [9:0]    io_input_w_queue_io_popOccupancy;
  wire                io_output_b_queue_io_push_ready;
  wire                io_output_b_queue_io_pop_valid;
  wire       [3:0]    io_output_b_queue_io_pop_payload_id;
  wire       [1:0]    io_output_b_queue_io_pop_payload_resp;
  wire       [63:0]   io_output_b_queue_io_pop_payload_user;
  wire       [3:0]    io_output_b_queue_io_pushOccupancy;
  wire       [3:0]    io_output_b_queue_io_popOccupancy;

  StreamFifoCC io_input_ar_queue (
    .io_push_valid            (io_input_ar_valid                       ), //i
    .io_push_ready            (io_input_ar_queue_io_push_ready         ), //o
    .io_push_payload_addr     (io_input_ar_payload_addr                ), //i
    .io_push_payload_id       (io_input_ar_payload_id                  ), //i
    .io_push_payload_len      (io_input_ar_payload_len                 ), //i
    .io_push_payload_size     (io_input_ar_payload_size                ), //i
    .io_push_payload_burst    (io_input_ar_payload_burst               ), //i
    .io_push_payload_lock     (io_input_ar_payload_lock                ), //i
    .io_push_payload_cache    (io_input_ar_payload_cache               ), //i
    .io_push_payload_qos      (io_input_ar_payload_qos                 ), //i
    .io_push_payload_user     (io_input_ar_payload_user                ), //i
    .io_push_payload_prot     (io_input_ar_payload_prot                ), //i
    .io_pop_valid             (io_input_ar_queue_io_pop_valid          ), //o
    .io_pop_ready             (io_output_ar_ready                      ), //i
    .io_pop_payload_addr      (io_input_ar_queue_io_pop_payload_addr   ), //o
    .io_pop_payload_id        (io_input_ar_queue_io_pop_payload_id     ), //o
    .io_pop_payload_len       (io_input_ar_queue_io_pop_payload_len    ), //o
    .io_pop_payload_size      (io_input_ar_queue_io_pop_payload_size   ), //o
    .io_pop_payload_burst     (io_input_ar_queue_io_pop_payload_burst  ), //o
    .io_pop_payload_lock      (io_input_ar_queue_io_pop_payload_lock   ), //o
    .io_pop_payload_cache     (io_input_ar_queue_io_pop_payload_cache  ), //o
    .io_pop_payload_qos       (io_input_ar_queue_io_pop_payload_qos    ), //o
    .io_pop_payload_user      (io_input_ar_queue_io_pop_payload_user   ), //o
    .io_pop_payload_prot      (io_input_ar_queue_io_pop_payload_prot   ), //o
    .io_pushOccupancy         (io_input_ar_queue_io_pushOccupancy      ), //o
    .io_popOccupancy          (io_input_ar_queue_io_popOccupancy       ), //o
    .afu_user_clk             (afu_user_clk                            ), //i
    .afu_user_rst             (afu_user_rst                            ), //i
    .afu_pcie_core_clk        (afu_pcie_core_clk                       ), //i
    .afu_pcie_core_rst        (afu_pcie_core_rst                       )  //i
  );
  StreamFifoCC_1 io_output_r_queue (
    .io_push_valid           (io_output_r_valid                      ), //i
    .io_push_ready           (io_output_r_queue_io_push_ready        ), //o
    .io_push_payload_data    (io_output_r_payload_data               ), //i
    .io_push_payload_id      (io_output_r_payload_id                 ), //i
    .io_push_payload_resp    (io_output_r_payload_resp               ), //i
    .io_push_payload_last    (io_output_r_payload_last               ), //i
    .io_push_payload_user    (io_output_r_payload_user               ), //i
    .io_pop_valid            (io_output_r_queue_io_pop_valid         ), //o
    .io_pop_ready            (io_input_r_ready                       ), //i
    .io_pop_payload_data     (io_output_r_queue_io_pop_payload_data  ), //o
    .io_pop_payload_id       (io_output_r_queue_io_pop_payload_id    ), //o
    .io_pop_payload_resp     (io_output_r_queue_io_pop_payload_resp  ), //o
    .io_pop_payload_last     (io_output_r_queue_io_pop_payload_last  ), //o
    .io_pop_payload_user     (io_output_r_queue_io_pop_payload_user  ), //o
    .io_pushOccupancy        (io_output_r_queue_io_pushOccupancy     ), //o
    .io_popOccupancy         (io_output_r_queue_io_popOccupancy      ), //o
    .afu_pcie_core_clk       (afu_pcie_core_clk                      ), //i
    .afu_pcie_core_rst       (afu_pcie_core_rst                      ), //i
    .afu_user_clk            (afu_user_clk                           ), //i
    .afu_user_rst            (afu_user_rst                           )  //i
  );
  StreamFifoCC io_input_aw_queue (
    .io_push_valid            (io_input_aw_valid                       ), //i
    .io_push_ready            (io_input_aw_queue_io_push_ready         ), //o
    .io_push_payload_addr     (io_input_aw_payload_addr                ), //i
    .io_push_payload_id       (io_input_aw_payload_id                  ), //i
    .io_push_payload_len      (io_input_aw_payload_len                 ), //i
    .io_push_payload_size     (io_input_aw_payload_size                ), //i
    .io_push_payload_burst    (io_input_aw_payload_burst               ), //i
    .io_push_payload_lock     (io_input_aw_payload_lock                ), //i
    .io_push_payload_cache    (io_input_aw_payload_cache               ), //i
    .io_push_payload_qos      (io_input_aw_payload_qos                 ), //i
    .io_push_payload_user     (io_input_aw_payload_user                ), //i
    .io_push_payload_prot     (io_input_aw_payload_prot                ), //i
    .io_pop_valid             (io_input_aw_queue_io_pop_valid          ), //o
    .io_pop_ready             (io_output_aw_ready                      ), //i
    .io_pop_payload_addr      (io_input_aw_queue_io_pop_payload_addr   ), //o
    .io_pop_payload_id        (io_input_aw_queue_io_pop_payload_id     ), //o
    .io_pop_payload_len       (io_input_aw_queue_io_pop_payload_len    ), //o
    .io_pop_payload_size      (io_input_aw_queue_io_pop_payload_size   ), //o
    .io_pop_payload_burst     (io_input_aw_queue_io_pop_payload_burst  ), //o
    .io_pop_payload_lock      (io_input_aw_queue_io_pop_payload_lock   ), //o
    .io_pop_payload_cache     (io_input_aw_queue_io_pop_payload_cache  ), //o
    .io_pop_payload_qos       (io_input_aw_queue_io_pop_payload_qos    ), //o
    .io_pop_payload_user      (io_input_aw_queue_io_pop_payload_user   ), //o
    .io_pop_payload_prot      (io_input_aw_queue_io_pop_payload_prot   ), //o
    .io_pushOccupancy         (io_input_aw_queue_io_pushOccupancy      ), //o
    .io_popOccupancy          (io_input_aw_queue_io_popOccupancy       ), //o
    .afu_user_clk             (afu_user_clk                            ), //i
    .afu_user_rst             (afu_user_rst                            ), //i
    .afu_pcie_core_clk        (afu_pcie_core_clk                       ), //i
    .afu_pcie_core_rst        (afu_pcie_core_rst                       )  //i
  );
  StreamFifoCC_3 io_input_w_queue (
    .io_push_valid           (io_input_w_valid                      ), //i
    .io_push_ready           (io_input_w_queue_io_push_ready        ), //o
    .io_push_payload_data    (io_input_w_payload_data               ), //i
    .io_push_payload_strb    (io_input_w_payload_strb               ), //i
    .io_push_payload_user    (io_input_w_payload_user               ), //i
    .io_push_payload_last    (io_input_w_payload_last               ), //i
    .io_pop_valid            (io_input_w_queue_io_pop_valid         ), //o
    .io_pop_ready            (io_output_w_ready                     ), //i
    .io_pop_payload_data     (io_input_w_queue_io_pop_payload_data  ), //o
    .io_pop_payload_strb     (io_input_w_queue_io_pop_payload_strb  ), //o
    .io_pop_payload_user     (io_input_w_queue_io_pop_payload_user  ), //o
    .io_pop_payload_last     (io_input_w_queue_io_pop_payload_last  ), //o
    .io_pushOccupancy        (io_input_w_queue_io_pushOccupancy     ), //o
    .io_popOccupancy         (io_input_w_queue_io_popOccupancy      ), //o
    .afu_user_clk            (afu_user_clk                          ), //i
    .afu_user_rst            (afu_user_rst                          ), //i
    .afu_pcie_core_clk       (afu_pcie_core_clk                     ), //i
    .afu_pcie_core_rst       (afu_pcie_core_rst                     )  //i
  );
  StreamFifoCC_4 io_output_b_queue (
    .io_push_valid           (io_output_b_valid                      ), //i
    .io_push_ready           (io_output_b_queue_io_push_ready        ), //o
    .io_push_payload_id      (io_output_b_payload_id                 ), //i
    .io_push_payload_resp    (io_output_b_payload_resp               ), //i
    .io_push_payload_user    (io_output_b_payload_user               ), //i
    .io_pop_valid            (io_output_b_queue_io_pop_valid         ), //o
    .io_pop_ready            (io_input_b_ready                       ), //i
    .io_pop_payload_id       (io_output_b_queue_io_pop_payload_id    ), //o
    .io_pop_payload_resp     (io_output_b_queue_io_pop_payload_resp  ), //o
    .io_pop_payload_user     (io_output_b_queue_io_pop_payload_user  ), //o
    .io_pushOccupancy        (io_output_b_queue_io_pushOccupancy     ), //o
    .io_popOccupancy         (io_output_b_queue_io_popOccupancy      ), //o
    .afu_pcie_core_clk       (afu_pcie_core_clk                      ), //i
    .afu_pcie_core_rst       (afu_pcie_core_rst                      ), //i
    .afu_user_clk            (afu_user_clk                           ), //i
    .afu_user_rst            (afu_user_rst                           )  //i
  );
  assign io_input_ar_ready = io_input_ar_queue_io_push_ready;
  assign io_output_ar_valid = io_input_ar_queue_io_pop_valid;
  assign io_output_ar_payload_addr = io_input_ar_queue_io_pop_payload_addr;
  assign io_output_ar_payload_id = io_input_ar_queue_io_pop_payload_id;
  assign io_output_ar_payload_len = io_input_ar_queue_io_pop_payload_len;
  assign io_output_ar_payload_size = io_input_ar_queue_io_pop_payload_size;
  assign io_output_ar_payload_burst = io_input_ar_queue_io_pop_payload_burst;
  assign io_output_ar_payload_lock = io_input_ar_queue_io_pop_payload_lock;
  assign io_output_ar_payload_cache = io_input_ar_queue_io_pop_payload_cache;
  assign io_output_ar_payload_qos = io_input_ar_queue_io_pop_payload_qos;
  assign io_output_ar_payload_user = io_input_ar_queue_io_pop_payload_user;
  assign io_output_ar_payload_prot = io_input_ar_queue_io_pop_payload_prot;
  assign io_output_r_ready = io_output_r_queue_io_push_ready;
  assign io_input_r_valid = io_output_r_queue_io_pop_valid;
  assign io_input_r_payload_data = io_output_r_queue_io_pop_payload_data;
  assign io_input_r_payload_id = io_output_r_queue_io_pop_payload_id;
  assign io_input_r_payload_resp = io_output_r_queue_io_pop_payload_resp;
  assign io_input_r_payload_last = io_output_r_queue_io_pop_payload_last;
  assign io_input_r_payload_user = io_output_r_queue_io_pop_payload_user;
  assign io_input_aw_ready = io_input_aw_queue_io_push_ready;
  assign io_output_aw_valid = io_input_aw_queue_io_pop_valid;
  assign io_output_aw_payload_addr = io_input_aw_queue_io_pop_payload_addr;
  assign io_output_aw_payload_id = io_input_aw_queue_io_pop_payload_id;
  assign io_output_aw_payload_len = io_input_aw_queue_io_pop_payload_len;
  assign io_output_aw_payload_size = io_input_aw_queue_io_pop_payload_size;
  assign io_output_aw_payload_burst = io_input_aw_queue_io_pop_payload_burst;
  assign io_output_aw_payload_lock = io_input_aw_queue_io_pop_payload_lock;
  assign io_output_aw_payload_cache = io_input_aw_queue_io_pop_payload_cache;
  assign io_output_aw_payload_qos = io_input_aw_queue_io_pop_payload_qos;
  assign io_output_aw_payload_user = io_input_aw_queue_io_pop_payload_user;
  assign io_output_aw_payload_prot = io_input_aw_queue_io_pop_payload_prot;
  assign io_input_w_ready = io_input_w_queue_io_push_ready;
  assign io_output_w_valid = io_input_w_queue_io_pop_valid;
  assign io_output_w_payload_data = io_input_w_queue_io_pop_payload_data;
  assign io_output_w_payload_strb = io_input_w_queue_io_pop_payload_strb;
  assign io_output_w_payload_user = io_input_w_queue_io_pop_payload_user;
  assign io_output_w_payload_last = io_input_w_queue_io_pop_payload_last;
  assign io_output_b_ready = io_output_b_queue_io_push_ready;
  assign io_input_b_valid = io_output_b_queue_io_pop_valid;
  assign io_input_b_payload_id = io_output_b_queue_io_pop_payload_id;
  assign io_input_b_payload_resp = io_output_b_queue_io_pop_payload_resp;
  assign io_input_b_payload_user = io_output_b_queue_io_pop_payload_user;

endmodule

module StreamCCHandShake_4 (
  input               io_input_valid,
  output              io_input_ready,
  input      [63:0]   io_input_payload_data,
  input      [1:0]    io_input_payload_resp,
  output              io_output_valid,
  input               io_output_ready,
  output     [63:0]   io_output_payload_data,
  output     [1:0]    io_output_payload_resp,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  wire                popAck_buffercc_io_dataOut;
  wire                pushArea_taskPending_buffercc_io_dataOut;
  wire                popAck;
  wire                pushArea_ack;
  reg                 pushArea_taskPending;
  wire                when_StreamCCHandShake_l17;
  reg                 pushArea_ack_regNext;
  wire                when_StreamCCHandShake_l17_1;
  wire                when_StreamCCHandShake_l20;
  (* async_reg = "true" *) reg        [63:0]   pushArea_data_data;
  (* async_reg = "true" *) reg        [1:0]    pushArea_data_resp;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [63:0]   popArea_stream_payload_data;
  wire       [1:0]    popArea_stream_payload_resp;
  wire                popArea_req;
  reg                 popArea_ack;
  wire                when_StreamCCHandShake_l25;
  wire                when_StreamCCHandShake_l25_1;
  reg                 popArea_rValid;
  reg                 popArea_req_regNext;
  wire                when_StreamCCHandShake_l27;
  wire                when_StreamCCHandShake_l28;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [63:0]   popArea_stream_m2sPipe_payload_data;
  wire       [1:0]    popArea_stream_m2sPipe_payload_resp;
  reg                 popArea_stream_rValid;
  reg        [63:0]   popArea_stream_rData_data;
  reg        [1:0]    popArea_stream_rData_resp;

  BufferCC_11 popAck_buffercc (
    .io_dataIn       (popAck                      ), //i
    .io_dataOut      (popAck_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                ), //i
    .afu_user_rst    (afu_user_rst                )  //i
  );
  BufferCC_10 pushArea_taskPending_buffercc (
    .io_dataIn            (pushArea_taskPending                      ), //i
    .io_dataOut           (pushArea_taskPending_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk                         ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                         )  //i
  );
  assign pushArea_ack = popAck_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l17 = (io_input_valid && io_input_ready);
  assign when_StreamCCHandShake_l17_1 = (pushArea_ack && (! pushArea_ack_regNext));
  assign io_input_ready = ((! pushArea_taskPending) && (! pushArea_ack));
  assign when_StreamCCHandShake_l20 = (io_input_valid && io_input_ready);
  assign popArea_req = pushArea_taskPending_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l25 = (popArea_stream_valid && popArea_stream_ready);
  assign when_StreamCCHandShake_l25_1 = (! popArea_req);
  assign popAck = popArea_ack;
  assign when_StreamCCHandShake_l27 = (popArea_req && (! popArea_req_regNext));
  assign when_StreamCCHandShake_l28 = (popArea_stream_valid && popArea_stream_ready);
  assign popArea_stream_payload_data = pushArea_data_data;
  assign popArea_stream_payload_resp = pushArea_data_resp;
  assign popArea_stream_valid = popArea_rValid;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_rValid;
  assign popArea_stream_m2sPipe_payload_data = popArea_stream_rData_data;
  assign popArea_stream_m2sPipe_payload_resp = popArea_stream_rData_resp;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_data = popArea_stream_m2sPipe_payload_data;
  assign io_output_payload_resp = popArea_stream_m2sPipe_payload_resp;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      pushArea_taskPending <= 1'b0;
      pushArea_ack_regNext <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l17) begin
        pushArea_taskPending <= 1'b1;
      end
      pushArea_ack_regNext <= pushArea_ack;
      if(when_StreamCCHandShake_l17_1) begin
        pushArea_taskPending <= 1'b0;
      end
    end
  end

  always @(posedge afu_user_clk) begin
    if(when_StreamCCHandShake_l20) begin
      pushArea_data_data <= io_input_payload_data;
      pushArea_data_resp <= io_input_payload_resp;
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      popArea_ack <= 1'b0;
      popArea_rValid <= 1'b0;
      popArea_req_regNext <= 1'b0;
      popArea_stream_rValid <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l25) begin
        popArea_ack <= 1'b1;
      end
      if(when_StreamCCHandShake_l25_1) begin
        popArea_ack <= 1'b0;
      end
      popArea_req_regNext <= popArea_req;
      if(when_StreamCCHandShake_l27) begin
        popArea_rValid <= 1'b1;
      end
      if(when_StreamCCHandShake_l28) begin
        popArea_rValid <= 1'b0;
      end
      if(popArea_stream_ready) begin
        popArea_stream_rValid <= popArea_stream_valid;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(popArea_stream_ready) begin
      popArea_stream_rData_data <= popArea_stream_payload_data;
      popArea_stream_rData_resp <= popArea_stream_payload_resp;
    end
  end


endmodule

//StreamCCHandShake replaced by StreamCCHandShake

module StreamCCHandShake_2 (
  input               io_input_valid,
  output              io_input_ready,
  input      [1:0]    io_input_payload_resp,
  output              io_output_valid,
  input               io_output_ready,
  output     [1:0]    io_output_payload_resp,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  wire                popAck_buffercc_io_dataOut;
  wire                pushArea_taskPending_buffercc_io_dataOut;
  wire                popAck;
  wire                pushArea_ack;
  reg                 pushArea_taskPending;
  wire                when_StreamCCHandShake_l17;
  reg                 pushArea_ack_regNext;
  wire                when_StreamCCHandShake_l17_1;
  wire                when_StreamCCHandShake_l20;
  (* async_reg = "true" *) reg        [1:0]    pushArea_data_resp;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [1:0]    popArea_stream_payload_resp;
  wire                popArea_req;
  reg                 popArea_ack;
  wire                when_StreamCCHandShake_l25;
  wire                when_StreamCCHandShake_l25_1;
  reg                 popArea_rValid;
  reg                 popArea_req_regNext;
  wire                when_StreamCCHandShake_l27;
  wire                when_StreamCCHandShake_l28;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [1:0]    popArea_stream_m2sPipe_payload_resp;
  reg                 popArea_stream_rValid;
  reg        [1:0]    popArea_stream_rData_resp;

  BufferCC_11 popAck_buffercc (
    .io_dataIn       (popAck                      ), //i
    .io_dataOut      (popAck_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                ), //i
    .afu_user_rst    (afu_user_rst                )  //i
  );
  BufferCC_10 pushArea_taskPending_buffercc (
    .io_dataIn            (pushArea_taskPending                      ), //i
    .io_dataOut           (pushArea_taskPending_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk                         ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                         )  //i
  );
  assign pushArea_ack = popAck_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l17 = (io_input_valid && io_input_ready);
  assign when_StreamCCHandShake_l17_1 = (pushArea_ack && (! pushArea_ack_regNext));
  assign io_input_ready = ((! pushArea_taskPending) && (! pushArea_ack));
  assign when_StreamCCHandShake_l20 = (io_input_valid && io_input_ready);
  assign popArea_req = pushArea_taskPending_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l25 = (popArea_stream_valid && popArea_stream_ready);
  assign when_StreamCCHandShake_l25_1 = (! popArea_req);
  assign popAck = popArea_ack;
  assign when_StreamCCHandShake_l27 = (popArea_req && (! popArea_req_regNext));
  assign when_StreamCCHandShake_l28 = (popArea_stream_valid && popArea_stream_ready);
  assign popArea_stream_payload_resp = pushArea_data_resp;
  assign popArea_stream_valid = popArea_rValid;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_rValid;
  assign popArea_stream_m2sPipe_payload_resp = popArea_stream_rData_resp;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_resp = popArea_stream_m2sPipe_payload_resp;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      pushArea_taskPending <= 1'b0;
      pushArea_ack_regNext <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l17) begin
        pushArea_taskPending <= 1'b1;
      end
      pushArea_ack_regNext <= pushArea_ack;
      if(when_StreamCCHandShake_l17_1) begin
        pushArea_taskPending <= 1'b0;
      end
    end
  end

  always @(posedge afu_user_clk) begin
    if(when_StreamCCHandShake_l20) begin
      pushArea_data_resp <= io_input_payload_resp;
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      popArea_ack <= 1'b0;
      popArea_rValid <= 1'b0;
      popArea_req_regNext <= 1'b0;
      popArea_stream_rValid <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l25) begin
        popArea_ack <= 1'b1;
      end
      if(when_StreamCCHandShake_l25_1) begin
        popArea_ack <= 1'b0;
      end
      popArea_req_regNext <= popArea_req;
      if(when_StreamCCHandShake_l27) begin
        popArea_rValid <= 1'b1;
      end
      if(when_StreamCCHandShake_l28) begin
        popArea_rValid <= 1'b0;
      end
      if(popArea_stream_ready) begin
        popArea_stream_rValid <= popArea_stream_valid;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(popArea_stream_ready) begin
      popArea_stream_rData_resp <= popArea_stream_payload_resp;
    end
  end


endmodule

module StreamCCHandShake_1 (
  input               io_input_valid,
  output              io_input_ready,
  input      [63:0]   io_input_payload_data,
  input      [7:0]    io_input_payload_strb,
  output              io_output_valid,
  input               io_output_ready,
  output     [63:0]   io_output_payload_data,
  output     [7:0]    io_output_payload_strb,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_user_clk,
  input               afu_user_rst
);
  wire                popAck_buffercc_io_dataOut;
  wire                pushArea_taskPending_buffercc_io_dataOut;
  wire                popAck;
  wire                pushArea_ack;
  reg                 pushArea_taskPending;
  wire                when_StreamCCHandShake_l17;
  reg                 pushArea_ack_regNext;
  wire                when_StreamCCHandShake_l17_1;
  wire                when_StreamCCHandShake_l20;
  (* async_reg = "true" *) reg        [63:0]   pushArea_data_data;
  (* async_reg = "true" *) reg        [7:0]    pushArea_data_strb;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [63:0]   popArea_stream_payload_data;
  wire       [7:0]    popArea_stream_payload_strb;
  wire                popArea_req;
  reg                 popArea_ack;
  wire                when_StreamCCHandShake_l25;
  wire                when_StreamCCHandShake_l25_1;
  reg                 popArea_rValid;
  reg                 popArea_req_regNext;
  wire                when_StreamCCHandShake_l27;
  wire                when_StreamCCHandShake_l28;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [63:0]   popArea_stream_m2sPipe_payload_data;
  wire       [7:0]    popArea_stream_m2sPipe_payload_strb;
  reg                 popArea_stream_rValid;
  reg        [63:0]   popArea_stream_rData_data;
  reg        [7:0]    popArea_stream_rData_strb;

  BufferCC_10 popAck_buffercc (
    .io_dataIn            (popAck                      ), //i
    .io_dataOut           (popAck_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk           ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst           )  //i
  );
  BufferCC_11 pushArea_taskPending_buffercc (
    .io_dataIn       (pushArea_taskPending                      ), //i
    .io_dataOut      (pushArea_taskPending_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                              ), //i
    .afu_user_rst    (afu_user_rst                              )  //i
  );
  assign pushArea_ack = popAck_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l17 = (io_input_valid && io_input_ready);
  assign when_StreamCCHandShake_l17_1 = (pushArea_ack && (! pushArea_ack_regNext));
  assign io_input_ready = ((! pushArea_taskPending) && (! pushArea_ack));
  assign when_StreamCCHandShake_l20 = (io_input_valid && io_input_ready);
  assign popArea_req = pushArea_taskPending_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l25 = (popArea_stream_valid && popArea_stream_ready);
  assign when_StreamCCHandShake_l25_1 = (! popArea_req);
  assign popAck = popArea_ack;
  assign when_StreamCCHandShake_l27 = (popArea_req && (! popArea_req_regNext));
  assign when_StreamCCHandShake_l28 = (popArea_stream_valid && popArea_stream_ready);
  assign popArea_stream_payload_data = pushArea_data_data;
  assign popArea_stream_payload_strb = pushArea_data_strb;
  assign popArea_stream_valid = popArea_rValid;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_rValid;
  assign popArea_stream_m2sPipe_payload_data = popArea_stream_rData_data;
  assign popArea_stream_m2sPipe_payload_strb = popArea_stream_rData_strb;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_data = popArea_stream_m2sPipe_payload_data;
  assign io_output_payload_strb = popArea_stream_m2sPipe_payload_strb;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      pushArea_taskPending <= 1'b0;
      pushArea_ack_regNext <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l17) begin
        pushArea_taskPending <= 1'b1;
      end
      pushArea_ack_regNext <= pushArea_ack;
      if(when_StreamCCHandShake_l17_1) begin
        pushArea_taskPending <= 1'b0;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(when_StreamCCHandShake_l20) begin
      pushArea_data_data <= io_input_payload_data;
      pushArea_data_strb <= io_input_payload_strb;
    end
  end

  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      popArea_ack <= 1'b0;
      popArea_rValid <= 1'b0;
      popArea_req_regNext <= 1'b0;
      popArea_stream_rValid <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l25) begin
        popArea_ack <= 1'b1;
      end
      if(when_StreamCCHandShake_l25_1) begin
        popArea_ack <= 1'b0;
      end
      popArea_req_regNext <= popArea_req;
      if(when_StreamCCHandShake_l27) begin
        popArea_rValid <= 1'b1;
      end
      if(when_StreamCCHandShake_l28) begin
        popArea_rValid <= 1'b0;
      end
      if(popArea_stream_ready) begin
        popArea_stream_rValid <= popArea_stream_valid;
      end
    end
  end

  always @(posedge afu_user_clk) begin
    if(popArea_stream_ready) begin
      popArea_stream_rData_data <= popArea_stream_payload_data;
      popArea_stream_rData_strb <= popArea_stream_payload_strb;
    end
  end


endmodule

module StreamCCHandShake (
  input               io_input_valid,
  output              io_input_ready,
  input      [31:0]   io_input_payload_addr,
  input      [2:0]    io_input_payload_prot,
  input      [31:0]   io_input_payload_user,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload_addr,
  output     [2:0]    io_output_payload_prot,
  output     [31:0]   io_output_payload_user,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_user_clk,
  input               afu_user_rst
);
  wire                popAck_buffercc_io_dataOut;
  wire                pushArea_taskPending_buffercc_io_dataOut;
  wire                popAck;
  wire                pushArea_ack;
  reg                 pushArea_taskPending;
  wire                when_StreamCCHandShake_l17;
  reg                 pushArea_ack_regNext;
  wire                when_StreamCCHandShake_l17_1;
  wire                when_StreamCCHandShake_l20;
  (* async_reg = "true" *) reg        [31:0]   pushArea_data_addr;
  (* async_reg = "true" *) reg        [2:0]    pushArea_data_prot;
  (* async_reg = "true" *) reg        [31:0]   pushArea_data_user;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [31:0]   popArea_stream_payload_addr;
  wire       [2:0]    popArea_stream_payload_prot;
  wire       [31:0]   popArea_stream_payload_user;
  wire                popArea_req;
  reg                 popArea_ack;
  wire                when_StreamCCHandShake_l25;
  wire                when_StreamCCHandShake_l25_1;
  reg                 popArea_rValid;
  reg                 popArea_req_regNext;
  wire                when_StreamCCHandShake_l27;
  wire                when_StreamCCHandShake_l28;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [31:0]   popArea_stream_m2sPipe_payload_addr;
  wire       [2:0]    popArea_stream_m2sPipe_payload_prot;
  wire       [31:0]   popArea_stream_m2sPipe_payload_user;
  reg                 popArea_stream_rValid;
  reg        [31:0]   popArea_stream_rData_addr;
  reg        [2:0]    popArea_stream_rData_prot;
  reg        [31:0]   popArea_stream_rData_user;

  BufferCC_10 popAck_buffercc (
    .io_dataIn            (popAck                      ), //i
    .io_dataOut           (popAck_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk           ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst           )  //i
  );
  BufferCC_11 pushArea_taskPending_buffercc (
    .io_dataIn       (pushArea_taskPending                      ), //i
    .io_dataOut      (pushArea_taskPending_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                              ), //i
    .afu_user_rst    (afu_user_rst                              )  //i
  );
  assign pushArea_ack = popAck_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l17 = (io_input_valid && io_input_ready);
  assign when_StreamCCHandShake_l17_1 = (pushArea_ack && (! pushArea_ack_regNext));
  assign io_input_ready = ((! pushArea_taskPending) && (! pushArea_ack));
  assign when_StreamCCHandShake_l20 = (io_input_valid && io_input_ready);
  assign popArea_req = pushArea_taskPending_buffercc_io_dataOut;
  assign when_StreamCCHandShake_l25 = (popArea_stream_valid && popArea_stream_ready);
  assign when_StreamCCHandShake_l25_1 = (! popArea_req);
  assign popAck = popArea_ack;
  assign when_StreamCCHandShake_l27 = (popArea_req && (! popArea_req_regNext));
  assign when_StreamCCHandShake_l28 = (popArea_stream_valid && popArea_stream_ready);
  assign popArea_stream_payload_addr = pushArea_data_addr;
  assign popArea_stream_payload_prot = pushArea_data_prot;
  assign popArea_stream_payload_user = pushArea_data_user;
  assign popArea_stream_valid = popArea_rValid;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_rValid;
  assign popArea_stream_m2sPipe_payload_addr = popArea_stream_rData_addr;
  assign popArea_stream_m2sPipe_payload_prot = popArea_stream_rData_prot;
  assign popArea_stream_m2sPipe_payload_user = popArea_stream_rData_user;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_addr = popArea_stream_m2sPipe_payload_addr;
  assign io_output_payload_prot = popArea_stream_m2sPipe_payload_prot;
  assign io_output_payload_user = popArea_stream_m2sPipe_payload_user;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      pushArea_taskPending <= 1'b0;
      pushArea_ack_regNext <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l17) begin
        pushArea_taskPending <= 1'b1;
      end
      pushArea_ack_regNext <= pushArea_ack;
      if(when_StreamCCHandShake_l17_1) begin
        pushArea_taskPending <= 1'b0;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(when_StreamCCHandShake_l20) begin
      pushArea_data_addr <= io_input_payload_addr;
      pushArea_data_prot <= io_input_payload_prot;
      pushArea_data_user <= io_input_payload_user;
    end
  end

  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      popArea_ack <= 1'b0;
      popArea_rValid <= 1'b0;
      popArea_req_regNext <= 1'b0;
      popArea_stream_rValid <= 1'b0;
    end else begin
      if(when_StreamCCHandShake_l25) begin
        popArea_ack <= 1'b1;
      end
      if(when_StreamCCHandShake_l25_1) begin
        popArea_ack <= 1'b0;
      end
      popArea_req_regNext <= popArea_req;
      if(when_StreamCCHandShake_l27) begin
        popArea_rValid <= 1'b1;
      end
      if(when_StreamCCHandShake_l28) begin
        popArea_rValid <= 1'b0;
      end
      if(popArea_stream_ready) begin
        popArea_stream_rValid <= popArea_stream_valid;
      end
    end
  end

  always @(posedge afu_user_clk) begin
    if(popArea_stream_ready) begin
      popArea_stream_rData_addr <= popArea_stream_payload_addr;
      popArea_stream_rData_prot <= popArea_stream_payload_prot;
      popArea_stream_rData_user <= popArea_stream_payload_user;
    end
  end


endmodule

module StreamFifoCC_4 (
  input               io_push_valid,
  output              io_push_ready,
  input      [3:0]    io_push_payload_id,
  input      [1:0]    io_push_payload_resp,
  input      [63:0]   io_push_payload_user,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [3:0]    io_pop_payload_id,
  output     [1:0]    io_pop_payload_resp,
  output     [63:0]   io_pop_payload_user,
  output     [3:0]    io_pushOccupancy,
  output     [3:0]    io_popOccupancy,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_user_clk,
  input               afu_user_rst
);
  reg        [69:0]   _zz_ram_port1;
  wire       [3:0]    popToPushGray_buffercc_io_dataOut;
  wire       [3:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [3:0]    _zz_pushCC_pushPtrGray;
  wire       [2:0]    _zz_ram_port;
  wire       [69:0]   _zz_ram_port_1;
  wire       [3:0]    _zz_popCC_popPtrGray;
  wire       [2:0]    _zz_ram_port_2;
  wire                _zz_ram_port_3;
  wire       [2:0]    _zz__zz_io_pop_payload_id_1;
  wire                _zz__zz_io_pop_payload_id_1_1;
  reg                 _zz_1;
  wire       [3:0]    popToPushGray;
  wire       [3:0]    pushToPopGray;
  reg        [3:0]    pushCC_pushPtr;
  wire       [3:0]    pushCC_pushPtrPlus;
  wire                when_Stream_l1144;
  reg        [3:0]    pushCC_pushPtrGray;
  wire       [3:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                when_Stream_l1150;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                _zz_io_pushOccupancy_2;
  reg        [3:0]    popCC_popPtr;
  wire       [3:0]    popCC_popPtrPlus;
  wire                when_Stream_l1161;
  reg        [3:0]    popCC_popPtrGray;
  wire       [3:0]    popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [3:0]    _zz_io_pop_payload_id;
  wire       [69:0]   _zz_io_pop_payload_id_1;
  wire                when_Stream_l1168;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  wire                _zz_io_popOccupancy_2;
  reg [69:0] ram [0:7];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[2:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtrPlus >>> 1'b1);
  assign _zz__zz_io_pop_payload_id_1 = _zz_io_pop_payload_id[2:0];
  assign _zz_ram_port_1 = {io_push_payload_user,{io_push_payload_resp,io_push_payload_id}};
  assign _zz__zz_io_pop_payload_id_1_1 = 1'b1;
  always @(posedge afu_pcie_core_clk) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= _zz_ram_port_1;
    end
  end

  always @(posedge afu_user_clk) begin
    if(_zz__zz_io_pop_payload_id_1_1) begin
      _zz_ram_port1 <= ram[_zz__zz_io_pop_payload_id_1];
    end
  end

  BufferCC_1 popToPushGray_buffercc (
    .io_dataIn            (popToPushGray                      ), //i
    .io_dataOut           (popToPushGray_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk                  ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                  )  //i
  );
  BufferCC pushToPopGray_buffercc (
    .io_dataIn       (pushToPopGray                      ), //i
    .io_dataOut      (pushToPopGray_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                       ), //i
    .afu_user_rst    (afu_user_rst                       )  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(when_Stream_l1150) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 4'b0001);
  assign when_Stream_l1144 = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[3 : 2] == (~ pushCC_popPtrGray[3 : 2])) && (pushCC_pushPtrGray[1 : 0] == pushCC_popPtrGray[1 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign when_Stream_l1150 = (io_push_valid && io_push_ready);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ _zz_io_pushOccupancy_2);
  assign _zz_io_pushOccupancy_2 = pushCC_popPtrGray[3];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_2,{_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,(pushCC_popPtrGray[0] ^ _zz_io_pushOccupancy)}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 4'b0001);
  assign when_Stream_l1161 = (io_pop_valid && io_pop_ready);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_io_pop_payload_id = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_io_pop_payload_id_1 = _zz_ram_port1;
  assign io_pop_payload_id = _zz_io_pop_payload_id_1[3 : 0];
  assign io_pop_payload_resp = _zz_io_pop_payload_id_1[5 : 4];
  assign io_pop_payload_user = _zz_io_pop_payload_id_1[69 : 6];
  assign when_Stream_l1168 = (io_pop_valid && io_pop_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ _zz_io_popOccupancy_2);
  assign _zz_io_popOccupancy_2 = popCC_pushPtrGray[3];
  assign io_popOccupancy = ({_zz_io_popOccupancy_2,{_zz_io_popOccupancy_1,{_zz_io_popOccupancy,(popCC_pushPtrGray[0] ^ _zz_io_popOccupancy)}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      pushCC_pushPtr <= 4'b0000;
      pushCC_pushPtrGray <= 4'b0000;
    end else begin
      if(when_Stream_l1144) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(when_Stream_l1150) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      popCC_popPtr <= 4'b0000;
      popCC_popPtrGray <= 4'b0000;
    end else begin
      if(when_Stream_l1161) begin
        popCC_popPtrGray <= (_zz_popCC_popPtrGray ^ popCC_popPtrPlus);
      end
      if(when_Stream_l1168) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule

module StreamFifoCC_3 (
  input               io_push_valid,
  output              io_push_ready,
  input      [511:0]  io_push_payload_data,
  input      [63:0]   io_push_payload_strb,
  input      [3:0]    io_push_payload_user,
  input               io_push_payload_last,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [511:0]  io_pop_payload_data,
  output     [63:0]   io_pop_payload_strb,
  output     [3:0]    io_pop_payload_user,
  output              io_pop_payload_last,
  output     [9:0]    io_pushOccupancy,
  output     [9:0]    io_popOccupancy,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  reg        [580:0]  _zz_ram_port1;
  wire       [9:0]    popToPushGray_buffercc_io_dataOut;
  wire       [9:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [9:0]    _zz_pushCC_pushPtrGray;
  wire       [8:0]    _zz_ram_port;
  wire       [580:0]  _zz_ram_port_1;
  wire                _zz_io_pushOccupancy_9;
  wire       [9:0]    _zz_popCC_popPtrGray;
  wire       [8:0]    _zz_ram_port_2;
  wire                _zz_ram_port_3;
  wire       [8:0]    _zz__zz_io_pop_payload_data_1;
  wire                _zz__zz_io_pop_payload_data_1_1;
  wire                _zz_io_popOccupancy_9;
  reg                 _zz_1;
  wire       [9:0]    popToPushGray;
  wire       [9:0]    pushToPopGray;
  reg        [9:0]    pushCC_pushPtr;
  wire       [9:0]    pushCC_pushPtrPlus;
  wire                when_Stream_l1144;
  reg        [9:0]    pushCC_pushPtrGray;
  wire       [9:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                when_Stream_l1150;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                _zz_io_pushOccupancy_2;
  wire                _zz_io_pushOccupancy_3;
  wire                _zz_io_pushOccupancy_4;
  wire                _zz_io_pushOccupancy_5;
  wire                _zz_io_pushOccupancy_6;
  wire                _zz_io_pushOccupancy_7;
  wire                _zz_io_pushOccupancy_8;
  reg        [9:0]    popCC_popPtr;
  wire       [9:0]    popCC_popPtrPlus;
  wire                when_Stream_l1161;
  reg        [9:0]    popCC_popPtrGray;
  wire       [9:0]    popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [9:0]    _zz_io_pop_payload_data;
  wire       [580:0]  _zz_io_pop_payload_data_1;
  wire                when_Stream_l1168;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  wire                _zz_io_popOccupancy_2;
  wire                _zz_io_popOccupancy_3;
  wire                _zz_io_popOccupancy_4;
  wire                _zz_io_popOccupancy_5;
  wire                _zz_io_popOccupancy_6;
  wire                _zz_io_popOccupancy_7;
  wire                _zz_io_popOccupancy_8;
  reg [580:0] ram [0:511];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[8:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtrPlus >>> 1'b1);
  assign _zz__zz_io_pop_payload_data_1 = _zz_io_pop_payload_data[8:0];
  assign _zz_ram_port_1 = {io_push_payload_last,{io_push_payload_user,{io_push_payload_strb,io_push_payload_data}}};
  assign _zz__zz_io_pop_payload_data_1_1 = 1'b1;
  assign _zz_io_pushOccupancy_9 = pushCC_popPtrGray[0];
  assign _zz_io_popOccupancy_9 = (popCC_pushPtrGray[0] ^ _zz_io_popOccupancy);
  always @(posedge afu_user_clk) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= _zz_ram_port_1;
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(_zz__zz_io_pop_payload_data_1_1) begin
      _zz_ram_port1 <= ram[_zz__zz_io_pop_payload_data_1];
    end
  end

  BufferCC_3 popToPushGray_buffercc (
    .io_dataIn       (popToPushGray                      ), //i
    .io_dataOut      (popToPushGray_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                       ), //i
    .afu_user_rst    (afu_user_rst                       )  //i
  );
  BufferCC_2 pushToPopGray_buffercc (
    .io_dataIn            (pushToPopGray                      ), //i
    .io_dataOut           (pushToPopGray_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk                  ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                  )  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(when_Stream_l1150) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 10'h001);
  assign when_Stream_l1144 = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[9 : 8] == (~ pushCC_popPtrGray[9 : 8])) && (pushCC_pushPtrGray[7 : 0] == pushCC_popPtrGray[7 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign when_Stream_l1150 = (io_push_valid && io_push_ready);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ _zz_io_pushOccupancy_2);
  assign _zz_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ _zz_io_pushOccupancy_3);
  assign _zz_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ _zz_io_pushOccupancy_4);
  assign _zz_io_pushOccupancy_4 = (pushCC_popPtrGray[5] ^ _zz_io_pushOccupancy_5);
  assign _zz_io_pushOccupancy_5 = (pushCC_popPtrGray[6] ^ _zz_io_pushOccupancy_6);
  assign _zz_io_pushOccupancy_6 = (pushCC_popPtrGray[7] ^ _zz_io_pushOccupancy_7);
  assign _zz_io_pushOccupancy_7 = (pushCC_popPtrGray[8] ^ _zz_io_pushOccupancy_8);
  assign _zz_io_pushOccupancy_8 = pushCC_popPtrGray[9];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_8,{_zz_io_pushOccupancy_7,{_zz_io_pushOccupancy_6,{_zz_io_pushOccupancy_5,{_zz_io_pushOccupancy_4,{_zz_io_pushOccupancy_3,{_zz_io_pushOccupancy_2,{_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,(_zz_io_pushOccupancy_9 ^ _zz_io_pushOccupancy)}}}}}}}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 10'h001);
  assign when_Stream_l1161 = (io_pop_valid && io_pop_ready);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_io_pop_payload_data = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_io_pop_payload_data_1 = _zz_ram_port1;
  assign io_pop_payload_data = _zz_io_pop_payload_data_1[511 : 0];
  assign io_pop_payload_strb = _zz_io_pop_payload_data_1[575 : 512];
  assign io_pop_payload_user = _zz_io_pop_payload_data_1[579 : 576];
  assign io_pop_payload_last = _zz_io_pop_payload_data_1[580];
  assign when_Stream_l1168 = (io_pop_valid && io_pop_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ _zz_io_popOccupancy_2);
  assign _zz_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ _zz_io_popOccupancy_3);
  assign _zz_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ _zz_io_popOccupancy_4);
  assign _zz_io_popOccupancy_4 = (popCC_pushPtrGray[5] ^ _zz_io_popOccupancy_5);
  assign _zz_io_popOccupancy_5 = (popCC_pushPtrGray[6] ^ _zz_io_popOccupancy_6);
  assign _zz_io_popOccupancy_6 = (popCC_pushPtrGray[7] ^ _zz_io_popOccupancy_7);
  assign _zz_io_popOccupancy_7 = (popCC_pushPtrGray[8] ^ _zz_io_popOccupancy_8);
  assign _zz_io_popOccupancy_8 = popCC_pushPtrGray[9];
  assign io_popOccupancy = ({_zz_io_popOccupancy_8,{_zz_io_popOccupancy_7,{_zz_io_popOccupancy_6,{_zz_io_popOccupancy_5,{_zz_io_popOccupancy_4,{_zz_io_popOccupancy_3,{_zz_io_popOccupancy_2,{_zz_io_popOccupancy_1,{_zz_io_popOccupancy,_zz_io_popOccupancy_9}}}}}}}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      pushCC_pushPtr <= 10'h0;
      pushCC_pushPtrGray <= 10'h0;
    end else begin
      if(when_Stream_l1144) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(when_Stream_l1150) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      popCC_popPtr <= 10'h0;
      popCC_popPtrGray <= 10'h0;
    end else begin
      if(when_Stream_l1161) begin
        popCC_popPtrGray <= (_zz_popCC_popPtrGray ^ popCC_popPtrPlus);
      end
      if(when_Stream_l1168) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule

//StreamFifoCC replaced by StreamFifoCC

module StreamFifoCC_1 (
  input               io_push_valid,
  output              io_push_ready,
  input      [511:0]  io_push_payload_data,
  input      [3:0]    io_push_payload_id,
  input      [1:0]    io_push_payload_resp,
  input               io_push_payload_last,
  input      [63:0]   io_push_payload_user,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [511:0]  io_pop_payload_data,
  output     [3:0]    io_pop_payload_id,
  output     [1:0]    io_pop_payload_resp,
  output              io_pop_payload_last,
  output     [63:0]   io_pop_payload_user,
  output     [9:0]    io_pushOccupancy,
  output     [9:0]    io_popOccupancy,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_user_clk,
  input               afu_user_rst
);
  reg        [582:0]  _zz_ram_port1;
  wire       [9:0]    popToPushGray_buffercc_io_dataOut;
  wire       [9:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [9:0]    _zz_pushCC_pushPtrGray;
  wire       [8:0]    _zz_ram_port;
  wire       [582:0]  _zz_ram_port_1;
  wire                _zz_io_pushOccupancy_9;
  wire       [9:0]    _zz_popCC_popPtrGray;
  wire       [8:0]    _zz_ram_port_2;
  wire                _zz_ram_port_3;
  wire       [8:0]    _zz__zz_io_pop_payload_data_1;
  wire                _zz__zz_io_pop_payload_data_1_1;
  wire                _zz_io_popOccupancy_9;
  reg                 _zz_1;
  wire       [9:0]    popToPushGray;
  wire       [9:0]    pushToPopGray;
  reg        [9:0]    pushCC_pushPtr;
  wire       [9:0]    pushCC_pushPtrPlus;
  wire                when_Stream_l1144;
  reg        [9:0]    pushCC_pushPtrGray;
  wire       [9:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                when_Stream_l1150;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                _zz_io_pushOccupancy_2;
  wire                _zz_io_pushOccupancy_3;
  wire                _zz_io_pushOccupancy_4;
  wire                _zz_io_pushOccupancy_5;
  wire                _zz_io_pushOccupancy_6;
  wire                _zz_io_pushOccupancy_7;
  wire                _zz_io_pushOccupancy_8;
  reg        [9:0]    popCC_popPtr;
  wire       [9:0]    popCC_popPtrPlus;
  wire                when_Stream_l1161;
  reg        [9:0]    popCC_popPtrGray;
  wire       [9:0]    popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [9:0]    _zz_io_pop_payload_data;
  wire       [582:0]  _zz_io_pop_payload_data_1;
  wire                when_Stream_l1168;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  wire                _zz_io_popOccupancy_2;
  wire                _zz_io_popOccupancy_3;
  wire                _zz_io_popOccupancy_4;
  wire                _zz_io_popOccupancy_5;
  wire                _zz_io_popOccupancy_6;
  wire                _zz_io_popOccupancy_7;
  wire                _zz_io_popOccupancy_8;
  reg [582:0] ram [0:511];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[8:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtrPlus >>> 1'b1);
  assign _zz__zz_io_pop_payload_data_1 = _zz_io_pop_payload_data[8:0];
  assign _zz_ram_port_1 = {io_push_payload_user,{io_push_payload_last,{io_push_payload_resp,{io_push_payload_id,io_push_payload_data}}}};
  assign _zz__zz_io_pop_payload_data_1_1 = 1'b1;
  assign _zz_io_pushOccupancy_9 = pushCC_popPtrGray[0];
  assign _zz_io_popOccupancy_9 = (popCC_pushPtrGray[0] ^ _zz_io_popOccupancy);
  always @(posedge afu_pcie_core_clk) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= _zz_ram_port_1;
    end
  end

  always @(posedge afu_user_clk) begin
    if(_zz__zz_io_pop_payload_data_1_1) begin
      _zz_ram_port1 <= ram[_zz__zz_io_pop_payload_data_1];
    end
  end

  BufferCC_2 popToPushGray_buffercc (
    .io_dataIn            (popToPushGray                      ), //i
    .io_dataOut           (popToPushGray_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk                  ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                  )  //i
  );
  BufferCC_3 pushToPopGray_buffercc (
    .io_dataIn       (pushToPopGray                      ), //i
    .io_dataOut      (pushToPopGray_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                       ), //i
    .afu_user_rst    (afu_user_rst                       )  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(when_Stream_l1150) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 10'h001);
  assign when_Stream_l1144 = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[9 : 8] == (~ pushCC_popPtrGray[9 : 8])) && (pushCC_pushPtrGray[7 : 0] == pushCC_popPtrGray[7 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign when_Stream_l1150 = (io_push_valid && io_push_ready);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ _zz_io_pushOccupancy_2);
  assign _zz_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ _zz_io_pushOccupancy_3);
  assign _zz_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ _zz_io_pushOccupancy_4);
  assign _zz_io_pushOccupancy_4 = (pushCC_popPtrGray[5] ^ _zz_io_pushOccupancy_5);
  assign _zz_io_pushOccupancy_5 = (pushCC_popPtrGray[6] ^ _zz_io_pushOccupancy_6);
  assign _zz_io_pushOccupancy_6 = (pushCC_popPtrGray[7] ^ _zz_io_pushOccupancy_7);
  assign _zz_io_pushOccupancy_7 = (pushCC_popPtrGray[8] ^ _zz_io_pushOccupancy_8);
  assign _zz_io_pushOccupancy_8 = pushCC_popPtrGray[9];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_8,{_zz_io_pushOccupancy_7,{_zz_io_pushOccupancy_6,{_zz_io_pushOccupancy_5,{_zz_io_pushOccupancy_4,{_zz_io_pushOccupancy_3,{_zz_io_pushOccupancy_2,{_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,(_zz_io_pushOccupancy_9 ^ _zz_io_pushOccupancy)}}}}}}}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 10'h001);
  assign when_Stream_l1161 = (io_pop_valid && io_pop_ready);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_io_pop_payload_data = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_io_pop_payload_data_1 = _zz_ram_port1;
  assign io_pop_payload_data = _zz_io_pop_payload_data_1[511 : 0];
  assign io_pop_payload_id = _zz_io_pop_payload_data_1[515 : 512];
  assign io_pop_payload_resp = _zz_io_pop_payload_data_1[517 : 516];
  assign io_pop_payload_last = _zz_io_pop_payload_data_1[518];
  assign io_pop_payload_user = _zz_io_pop_payload_data_1[582 : 519];
  assign when_Stream_l1168 = (io_pop_valid && io_pop_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ _zz_io_popOccupancy_2);
  assign _zz_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ _zz_io_popOccupancy_3);
  assign _zz_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ _zz_io_popOccupancy_4);
  assign _zz_io_popOccupancy_4 = (popCC_pushPtrGray[5] ^ _zz_io_popOccupancy_5);
  assign _zz_io_popOccupancy_5 = (popCC_pushPtrGray[6] ^ _zz_io_popOccupancy_6);
  assign _zz_io_popOccupancy_6 = (popCC_pushPtrGray[7] ^ _zz_io_popOccupancy_7);
  assign _zz_io_popOccupancy_7 = (popCC_pushPtrGray[8] ^ _zz_io_popOccupancy_8);
  assign _zz_io_popOccupancy_8 = popCC_pushPtrGray[9];
  assign io_popOccupancy = ({_zz_io_popOccupancy_8,{_zz_io_popOccupancy_7,{_zz_io_popOccupancy_6,{_zz_io_popOccupancy_5,{_zz_io_popOccupancy_4,{_zz_io_popOccupancy_3,{_zz_io_popOccupancy_2,{_zz_io_popOccupancy_1,{_zz_io_popOccupancy,_zz_io_popOccupancy_9}}}}}}}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      pushCC_pushPtr <= 10'h0;
      pushCC_pushPtrGray <= 10'h0;
    end else begin
      if(when_Stream_l1144) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(when_Stream_l1150) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      popCC_popPtr <= 10'h0;
      popCC_popPtrGray <= 10'h0;
    end else begin
      if(when_Stream_l1161) begin
        popCC_popPtrGray <= (_zz_popCC_popPtrGray ^ popCC_popPtrPlus);
      end
      if(when_Stream_l1168) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule

module StreamFifoCC (
  input               io_push_valid,
  output              io_push_ready,
  input      [63:0]   io_push_payload_addr,
  input      [3:0]    io_push_payload_id,
  input      [7:0]    io_push_payload_len,
  input      [2:0]    io_push_payload_size,
  input      [1:0]    io_push_payload_burst,
  input      [0:0]    io_push_payload_lock,
  input      [3:0]    io_push_payload_cache,
  input      [3:0]    io_push_payload_qos,
  input      [63:0]   io_push_payload_user,
  input      [2:0]    io_push_payload_prot,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [63:0]   io_pop_payload_addr,
  output     [3:0]    io_pop_payload_id,
  output     [7:0]    io_pop_payload_len,
  output     [2:0]    io_pop_payload_size,
  output     [1:0]    io_pop_payload_burst,
  output     [0:0]    io_pop_payload_lock,
  output     [3:0]    io_pop_payload_cache,
  output     [3:0]    io_pop_payload_qos,
  output     [63:0]   io_pop_payload_user,
  output     [2:0]    io_pop_payload_prot,
  output     [3:0]    io_pushOccupancy,
  output     [3:0]    io_popOccupancy,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  reg        [156:0]  _zz_ram_port1;
  wire       [3:0]    popToPushGray_buffercc_io_dataOut;
  wire       [3:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [3:0]    _zz_pushCC_pushPtrGray;
  wire       [2:0]    _zz_ram_port;
  wire       [156:0]  _zz_ram_port_1;
  wire       [3:0]    _zz_popCC_popPtrGray;
  wire       [2:0]    _zz_ram_port_2;
  wire                _zz_ram_port_3;
  wire       [2:0]    _zz__zz_io_pop_payload_addr_1;
  wire                _zz__zz_io_pop_payload_addr_1_1;
  reg                 _zz_1;
  wire       [3:0]    popToPushGray;
  wire       [3:0]    pushToPopGray;
  reg        [3:0]    pushCC_pushPtr;
  wire       [3:0]    pushCC_pushPtrPlus;
  wire                when_Stream_l1144;
  reg        [3:0]    pushCC_pushPtrGray;
  wire       [3:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                when_Stream_l1150;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                _zz_io_pushOccupancy_2;
  reg        [3:0]    popCC_popPtr;
  wire       [3:0]    popCC_popPtrPlus;
  wire                when_Stream_l1161;
  reg        [3:0]    popCC_popPtrGray;
  wire       [3:0]    popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [3:0]    _zz_io_pop_payload_addr;
  wire       [156:0]  _zz_io_pop_payload_addr_1;
  wire                when_Stream_l1168;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  wire                _zz_io_popOccupancy_2;
  reg [156:0] ram [0:7];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[2:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtrPlus >>> 1'b1);
  assign _zz__zz_io_pop_payload_addr_1 = _zz_io_pop_payload_addr[2:0];
  assign _zz_ram_port_1 = {io_push_payload_prot,{io_push_payload_user,{io_push_payload_qos,{io_push_payload_cache,{io_push_payload_lock,{io_push_payload_burst,{io_push_payload_size,{io_push_payload_len,{io_push_payload_id,io_push_payload_addr}}}}}}}}};
  assign _zz__zz_io_pop_payload_addr_1_1 = 1'b1;
  always @(posedge afu_user_clk) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= _zz_ram_port_1;
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(_zz__zz_io_pop_payload_addr_1_1) begin
      _zz_ram_port1 <= ram[_zz__zz_io_pop_payload_addr_1];
    end
  end

  BufferCC popToPushGray_buffercc (
    .io_dataIn       (popToPushGray                      ), //i
    .io_dataOut      (popToPushGray_buffercc_io_dataOut  ), //o
    .afu_user_clk    (afu_user_clk                       ), //i
    .afu_user_rst    (afu_user_rst                       )  //i
  );
  BufferCC_1 pushToPopGray_buffercc (
    .io_dataIn            (pushToPopGray                      ), //i
    .io_dataOut           (pushToPopGray_buffercc_io_dataOut  ), //o
    .afu_pcie_core_clk    (afu_pcie_core_clk                  ), //i
    .afu_pcie_core_rst    (afu_pcie_core_rst                  )  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(when_Stream_l1150) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 4'b0001);
  assign when_Stream_l1144 = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[3 : 2] == (~ pushCC_popPtrGray[3 : 2])) && (pushCC_pushPtrGray[1 : 0] == pushCC_popPtrGray[1 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign when_Stream_l1150 = (io_push_valid && io_push_ready);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ _zz_io_pushOccupancy_2);
  assign _zz_io_pushOccupancy_2 = pushCC_popPtrGray[3];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_2,{_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,(pushCC_popPtrGray[0] ^ _zz_io_pushOccupancy)}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 4'b0001);
  assign when_Stream_l1161 = (io_pop_valid && io_pop_ready);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_io_pop_payload_addr = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_io_pop_payload_addr_1 = _zz_ram_port1;
  assign io_pop_payload_addr = _zz_io_pop_payload_addr_1[63 : 0];
  assign io_pop_payload_id = _zz_io_pop_payload_addr_1[67 : 64];
  assign io_pop_payload_len = _zz_io_pop_payload_addr_1[75 : 68];
  assign io_pop_payload_size = _zz_io_pop_payload_addr_1[78 : 76];
  assign io_pop_payload_burst = _zz_io_pop_payload_addr_1[80 : 79];
  assign io_pop_payload_lock = _zz_io_pop_payload_addr_1[81 : 81];
  assign io_pop_payload_cache = _zz_io_pop_payload_addr_1[85 : 82];
  assign io_pop_payload_qos = _zz_io_pop_payload_addr_1[89 : 86];
  assign io_pop_payload_user = _zz_io_pop_payload_addr_1[153 : 90];
  assign io_pop_payload_prot = _zz_io_pop_payload_addr_1[156 : 154];
  assign when_Stream_l1168 = (io_pop_valid && io_pop_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ _zz_io_popOccupancy_2);
  assign _zz_io_popOccupancy_2 = popCC_pushPtrGray[3];
  assign io_popOccupancy = ({_zz_io_popOccupancy_2,{_zz_io_popOccupancy_1,{_zz_io_popOccupancy,(popCC_pushPtrGray[0] ^ _zz_io_popOccupancy)}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      pushCC_pushPtr <= 4'b0000;
      pushCC_pushPtrGray <= 4'b0000;
    end else begin
      if(when_Stream_l1144) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(when_Stream_l1150) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      popCC_popPtr <= 4'b0000;
      popCC_popPtrGray <= 4'b0000;
    end else begin
      if(when_Stream_l1161) begin
        popCC_popPtrGray <= (_zz_popCC_popPtrGray ^ popCC_popPtrPlus);
      end
      if(when_Stream_l1168) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule

//BufferCC_10 replaced by BufferCC_10

//BufferCC_11 replaced by BufferCC_11

//BufferCC_11 replaced by BufferCC_11

//BufferCC_10 replaced by BufferCC_10

//BufferCC_10 replaced by BufferCC_10

//BufferCC_11 replaced by BufferCC_11

//BufferCC_11 replaced by BufferCC_11

//BufferCC_10 replaced by BufferCC_10

module BufferCC_11 (
  input               io_dataIn,
  output              io_dataOut,
  input               afu_user_clk,
  input               afu_user_rst
);
  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;
  (* async_reg = "true" *) reg                 buffers_2;
  (* async_reg = "true" *) reg                 buffers_3;

  assign io_dataOut = buffers_3;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
      buffers_2 <= 1'b0;
      buffers_3 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
      buffers_2 <= buffers_1;
      buffers_3 <= buffers_2;
    end
  end


endmodule

module BufferCC_10 (
  input               io_dataIn,
  output              io_dataOut,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;
  (* async_reg = "true" *) reg                 buffers_2;
  (* async_reg = "true" *) reg                 buffers_3;

  assign io_dataOut = buffers_3;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
      buffers_2 <= 1'b0;
      buffers_3 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
      buffers_2 <= buffers_1;
      buffers_3 <= buffers_2;
    end
  end


endmodule

//BufferCC replaced by BufferCC

//BufferCC_1 replaced by BufferCC_1

//BufferCC_2 replaced by BufferCC_2

//BufferCC_3 replaced by BufferCC_3

//BufferCC_1 replaced by BufferCC_1

//BufferCC replaced by BufferCC

module BufferCC_3 (
  input      [9:0]    io_dataIn,
  output     [9:0]    io_dataOut,
  input               afu_user_clk,
  input               afu_user_rst
);
  (* async_reg = "true" *) reg        [9:0]    buffers_0;
  (* async_reg = "true" *) reg        [9:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      buffers_0 <= 10'h0;
      buffers_1 <= 10'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_2 (
  input      [9:0]    io_dataIn,
  output     [9:0]    io_dataOut,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  (* async_reg = "true" *) reg        [9:0]    buffers_0;
  (* async_reg = "true" *) reg        [9:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      buffers_0 <= 10'h0;
      buffers_1 <= 10'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_1 (
  input      [3:0]    io_dataIn,
  output     [3:0]    io_dataOut,
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst
);
  (* async_reg = "true" *) reg        [3:0]    buffers_0;
  (* async_reg = "true" *) reg        [3:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      buffers_0 <= 4'b0000;
      buffers_1 <= 4'b0000;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC (
  input      [3:0]    io_dataIn,
  output     [3:0]    io_dataOut,
  input               afu_user_clk,
  input               afu_user_rst
);
  (* async_reg = "true" *) reg        [3:0]    buffers_0;
  (* async_reg = "true" *) reg        [3:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge afu_user_clk) begin
    if(afu_user_rst) begin
      buffers_0 <= 4'b0000;
      buffers_1 <= 4'b0000;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
