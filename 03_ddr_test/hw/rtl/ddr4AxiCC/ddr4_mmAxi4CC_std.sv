// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4_mmAxi4CC_std


module ddr4_mmAxi4CC_std (
  input               input_awvalid,
  output              input_awready,
  input      [63:0]   input_awaddr,
  input      [3:0]    input_awid,
  input      [7:0]    input_awlen,
  input      [2:0]    input_awsize,
  input      [1:0]    input_awburst,
  input      [15:0]   input_awuser,
  input               input_wvalid,
  output              input_wready,
  input      [511:0]  input_wdata,
  input      [63:0]   input_wstrb,
  input      [15:0]   input_wuser,
  input               input_wlast,
  output              input_bvalid,
  input               input_bready,
  output     [3:0]    input_bid,
  output     [1:0]    input_bresp,
  output     [15:0]   input_buser,
  input               input_arvalid,
  output              input_arready,
  input      [63:0]   input_araddr,
  input      [3:0]    input_arid,
  input      [7:0]    input_arlen,
  input      [2:0]    input_arsize,
  input      [1:0]    input_arburst,
  input      [15:0]   input_aruser,
  output              input_rvalid,
  input               input_rready,
  output     [511:0]  input_rdata,
  output     [3:0]    input_rid,
  output     [1:0]    input_rresp,
  output              input_rlast,
  output     [15:0]   input_ruser,
  output              output_awvalid,
  input               output_awready,
  output     [63:0]   output_awaddr,
  output     [3:0]    output_awid,
  output     [7:0]    output_awlen,
  output     [2:0]    output_awsize,
  output     [1:0]    output_awburst,
  output     [15:0]   output_awuser,
  output              output_wvalid,
  input               output_wready,
  output     [511:0]  output_wdata,
  output     [63:0]   output_wstrb,
  output     [15:0]   output_wuser,
  output              output_wlast,
  input               output_bvalid,
  output              output_bready,
  input      [3:0]    output_bid,
  input      [1:0]    output_bresp,
  input      [15:0]   output_buser,
  output              output_arvalid,
  input               output_arready,
  output     [63:0]   output_araddr,
  output     [3:0]    output_arid,
  output     [7:0]    output_arlen,
  output     [2:0]    output_arsize,
  output     [1:0]    output_arburst,
  output     [15:0]   output_aruser,
  input               output_rvalid,
  output              output_rready,
  input      [511:0]  output_rdata,
  input      [3:0]    output_rid,
  input      [1:0]    output_rresp,
  input               output_rlast,
  input      [15:0]   output_ruser,
  input               clkA_clk,
  input               clkA_reset,
  input               clkB_clk,
  input               clkB_reset
);
  wire                input_ar_queue_io_push_ready;
  wire                input_ar_queue_io_pop_valid;
  wire       [63:0]   input_ar_queue_io_pop_payload_addr;
  wire       [3:0]    input_ar_queue_io_pop_payload_id;
  wire       [7:0]    input_ar_queue_io_pop_payload_len;
  wire       [2:0]    input_ar_queue_io_pop_payload_size;
  wire       [1:0]    input_ar_queue_io_pop_payload_burst;
  wire       [15:0]   input_ar_queue_io_pop_payload_user;
  wire       [3:0]    input_ar_queue_io_pushOccupancy;
  wire       [3:0]    input_ar_queue_io_popOccupancy;
  wire                output_r_queue_io_push_ready;
  wire                output_r_queue_io_pop_valid;
  wire       [511:0]  output_r_queue_io_pop_payload_data;
  wire       [3:0]    output_r_queue_io_pop_payload_id;
  wire       [1:0]    output_r_queue_io_pop_payload_resp;
  wire                output_r_queue_io_pop_payload_last;
  wire       [15:0]   output_r_queue_io_pop_payload_user;
  wire       [9:0]    output_r_queue_io_pushOccupancy;
  wire       [9:0]    output_r_queue_io_popOccupancy;
  wire                input_aw_queue_io_push_ready;
  wire                input_aw_queue_io_pop_valid;
  wire       [63:0]   input_aw_queue_io_pop_payload_addr;
  wire       [3:0]    input_aw_queue_io_pop_payload_id;
  wire       [7:0]    input_aw_queue_io_pop_payload_len;
  wire       [2:0]    input_aw_queue_io_pop_payload_size;
  wire       [1:0]    input_aw_queue_io_pop_payload_burst;
  wire       [15:0]   input_aw_queue_io_pop_payload_user;
  wire       [3:0]    input_aw_queue_io_pushOccupancy;
  wire       [3:0]    input_aw_queue_io_popOccupancy;
  wire                input_w_queue_io_push_ready;
  wire                input_w_queue_io_pop_valid;
  wire       [511:0]  input_w_queue_io_pop_payload_data;
  wire       [63:0]   input_w_queue_io_pop_payload_strb;
  wire       [15:0]   input_w_queue_io_pop_payload_user;
  wire                input_w_queue_io_pop_payload_last;
  wire       [9:0]    input_w_queue_io_pushOccupancy;
  wire       [9:0]    input_w_queue_io_popOccupancy;
  wire                output_b_queue_io_push_ready;
  wire                output_b_queue_io_pop_valid;
  wire       [3:0]    output_b_queue_io_pop_payload_id;
  wire       [1:0]    output_b_queue_io_pop_payload_resp;
  wire       [15:0]   output_b_queue_io_pop_payload_user;
  wire       [3:0]    output_b_queue_io_pushOccupancy;
  wire       [3:0]    output_b_queue_io_popOccupancy;

  ddr4_mmStreamFifoCC input_ar_queue (
    .io_push_valid            (input_arvalid                             ), //i
    .io_push_ready            (input_ar_queue_io_push_ready              ), //o
    .io_push_payload_addr     (input_araddr[63:0]                        ), //i
    .io_push_payload_id       (input_arid[3:0]                           ), //i
    .io_push_payload_len      (input_arlen[7:0]                          ), //i
    .io_push_payload_size     (input_arsize[2:0]                         ), //i
    .io_push_payload_burst    (input_arburst[1:0]                        ), //i
    .io_push_payload_user     (input_aruser[15:0]                        ), //i
    .io_pop_valid             (input_ar_queue_io_pop_valid               ), //o
    .io_pop_ready             (output_arready                            ), //i
    .io_pop_payload_addr      (input_ar_queue_io_pop_payload_addr[63:0]  ), //o
    .io_pop_payload_id        (input_ar_queue_io_pop_payload_id[3:0]     ), //o
    .io_pop_payload_len       (input_ar_queue_io_pop_payload_len[7:0]    ), //o
    .io_pop_payload_size      (input_ar_queue_io_pop_payload_size[2:0]   ), //o
    .io_pop_payload_burst     (input_ar_queue_io_pop_payload_burst[1:0]  ), //o
    .io_pop_payload_user      (input_ar_queue_io_pop_payload_user[15:0]  ), //o
    .io_pushOccupancy         (input_ar_queue_io_pushOccupancy[3:0]      ), //o
    .io_popOccupancy          (input_ar_queue_io_popOccupancy[3:0]       ), //o
    .clkA_clk                 (clkA_clk                                  ), //i
    .clkA_reset               (clkA_reset                                ), //i
    .clkB_clk                 (clkB_clk                                  ), //i
    .clkB_reset               (clkB_reset                                )  //i
  );
  ddr4_mmStreamFifoCC_1 output_r_queue (
    .io_push_valid           (output_rvalid                              ), //i
    .io_push_ready           (output_r_queue_io_push_ready               ), //o
    .io_push_payload_data    (output_rdata[511:0]                        ), //i
    .io_push_payload_id      (output_rid[3:0]                            ), //i
    .io_push_payload_resp    (output_rresp[1:0]                          ), //i
    .io_push_payload_last    (output_rlast                               ), //i
    .io_push_payload_user    (output_ruser[15:0]                         ), //i
    .io_pop_valid            (output_r_queue_io_pop_valid                ), //o
    .io_pop_ready            (input_rready                               ), //i
    .io_pop_payload_data     (output_r_queue_io_pop_payload_data[511:0]  ), //o
    .io_pop_payload_id       (output_r_queue_io_pop_payload_id[3:0]      ), //o
    .io_pop_payload_resp     (output_r_queue_io_pop_payload_resp[1:0]    ), //o
    .io_pop_payload_last     (output_r_queue_io_pop_payload_last         ), //o
    .io_pop_payload_user     (output_r_queue_io_pop_payload_user[15:0]   ), //o
    .io_pushOccupancy        (output_r_queue_io_pushOccupancy[9:0]       ), //o
    .io_popOccupancy         (output_r_queue_io_popOccupancy[9:0]        ), //o
    .clkB_clk                (clkB_clk                                   ), //i
    .clkB_reset              (clkB_reset                                 ), //i
    .clkA_clk                (clkA_clk                                   ), //i
    .clkA_reset              (clkA_reset                                 )  //i
  );
  ddr4_mmStreamFifoCC input_aw_queue (
    .io_push_valid            (input_awvalid                             ), //i
    .io_push_ready            (input_aw_queue_io_push_ready              ), //o
    .io_push_payload_addr     (input_awaddr[63:0]                        ), //i
    .io_push_payload_id       (input_awid[3:0]                           ), //i
    .io_push_payload_len      (input_awlen[7:0]                          ), //i
    .io_push_payload_size     (input_awsize[2:0]                         ), //i
    .io_push_payload_burst    (input_awburst[1:0]                        ), //i
    .io_push_payload_user     (input_awuser[15:0]                        ), //i
    .io_pop_valid             (input_aw_queue_io_pop_valid               ), //o
    .io_pop_ready             (output_awready                            ), //i
    .io_pop_payload_addr      (input_aw_queue_io_pop_payload_addr[63:0]  ), //o
    .io_pop_payload_id        (input_aw_queue_io_pop_payload_id[3:0]     ), //o
    .io_pop_payload_len       (input_aw_queue_io_pop_payload_len[7:0]    ), //o
    .io_pop_payload_size      (input_aw_queue_io_pop_payload_size[2:0]   ), //o
    .io_pop_payload_burst     (input_aw_queue_io_pop_payload_burst[1:0]  ), //o
    .io_pop_payload_user      (input_aw_queue_io_pop_payload_user[15:0]  ), //o
    .io_pushOccupancy         (input_aw_queue_io_pushOccupancy[3:0]      ), //o
    .io_popOccupancy          (input_aw_queue_io_popOccupancy[3:0]       ), //o
    .clkA_clk                 (clkA_clk                                  ), //i
    .clkA_reset               (clkA_reset                                ), //i
    .clkB_clk                 (clkB_clk                                  ), //i
    .clkB_reset               (clkB_reset                                )  //i
  );
  ddr4_mmStreamFifoCC_3 input_w_queue (
    .io_push_valid           (input_wvalid                              ), //i
    .io_push_ready           (input_w_queue_io_push_ready               ), //o
    .io_push_payload_data    (input_wdata[511:0]                        ), //i
    .io_push_payload_strb    (input_wstrb[63:0]                         ), //i
    .io_push_payload_user    (input_wuser[15:0]                         ), //i
    .io_push_payload_last    (input_wlast                               ), //i
    .io_pop_valid            (input_w_queue_io_pop_valid                ), //o
    .io_pop_ready            (output_wready                             ), //i
    .io_pop_payload_data     (input_w_queue_io_pop_payload_data[511:0]  ), //o
    .io_pop_payload_strb     (input_w_queue_io_pop_payload_strb[63:0]   ), //o
    .io_pop_payload_user     (input_w_queue_io_pop_payload_user[15:0]   ), //o
    .io_pop_payload_last     (input_w_queue_io_pop_payload_last         ), //o
    .io_pushOccupancy        (input_w_queue_io_pushOccupancy[9:0]       ), //o
    .io_popOccupancy         (input_w_queue_io_popOccupancy[9:0]        ), //o
    .clkA_clk                (clkA_clk                                  ), //i
    .clkA_reset              (clkA_reset                                ), //i
    .clkB_clk                (clkB_clk                                  ), //i
    .clkB_reset              (clkB_reset                                )  //i
  );
  ddr4_mmStreamFifoCC_4 output_b_queue (
    .io_push_valid           (output_bvalid                             ), //i
    .io_push_ready           (output_b_queue_io_push_ready              ), //o
    .io_push_payload_id      (output_bid[3:0]                           ), //i
    .io_push_payload_resp    (output_bresp[1:0]                         ), //i
    .io_push_payload_user    (output_buser[15:0]                        ), //i
    .io_pop_valid            (output_b_queue_io_pop_valid               ), //o
    .io_pop_ready            (input_bready                              ), //i
    .io_pop_payload_id       (output_b_queue_io_pop_payload_id[3:0]     ), //o
    .io_pop_payload_resp     (output_b_queue_io_pop_payload_resp[1:0]   ), //o
    .io_pop_payload_user     (output_b_queue_io_pop_payload_user[15:0]  ), //o
    .io_pushOccupancy        (output_b_queue_io_pushOccupancy[3:0]      ), //o
    .io_popOccupancy         (output_b_queue_io_popOccupancy[3:0]       ), //o
    .clkB_clk                (clkB_clk                                  ), //i
    .clkB_reset              (clkB_reset                                ), //i
    .clkA_clk                (clkA_clk                                  ), //i
    .clkA_reset              (clkA_reset                                )  //i
  );
  assign input_arready = input_ar_queue_io_push_ready;
  assign output_arvalid = input_ar_queue_io_pop_valid;
  assign output_araddr = input_ar_queue_io_pop_payload_addr;
  assign output_arid = input_ar_queue_io_pop_payload_id;
  assign output_arlen = input_ar_queue_io_pop_payload_len;
  assign output_arsize = input_ar_queue_io_pop_payload_size;
  assign output_arburst = input_ar_queue_io_pop_payload_burst;
  assign output_aruser = input_ar_queue_io_pop_payload_user;
  assign output_rready = output_r_queue_io_push_ready;
  assign input_rvalid = output_r_queue_io_pop_valid;
  assign input_rdata = output_r_queue_io_pop_payload_data;
  assign input_rid = output_r_queue_io_pop_payload_id;
  assign input_rresp = output_r_queue_io_pop_payload_resp;
  assign input_rlast = output_r_queue_io_pop_payload_last;
  assign input_ruser = output_r_queue_io_pop_payload_user;
  assign input_awready = input_aw_queue_io_push_ready;
  assign output_awvalid = input_aw_queue_io_pop_valid;
  assign output_awaddr = input_aw_queue_io_pop_payload_addr;
  assign output_awid = input_aw_queue_io_pop_payload_id;
  assign output_awlen = input_aw_queue_io_pop_payload_len;
  assign output_awsize = input_aw_queue_io_pop_payload_size;
  assign output_awburst = input_aw_queue_io_pop_payload_burst;
  assign output_awuser = input_aw_queue_io_pop_payload_user;
  assign input_wready = input_w_queue_io_push_ready;
  assign output_wvalid = input_w_queue_io_pop_valid;
  assign output_wdata = input_w_queue_io_pop_payload_data;
  assign output_wstrb = input_w_queue_io_pop_payload_strb;
  assign output_wuser = input_w_queue_io_pop_payload_user;
  assign output_wlast = input_w_queue_io_pop_payload_last;
  assign output_bready = output_b_queue_io_push_ready;
  assign input_bvalid = output_b_queue_io_pop_valid;
  assign input_bid = output_b_queue_io_pop_payload_id;
  assign input_bresp = output_b_queue_io_pop_payload_resp;
  assign input_buser = output_b_queue_io_pop_payload_user;

endmodule
