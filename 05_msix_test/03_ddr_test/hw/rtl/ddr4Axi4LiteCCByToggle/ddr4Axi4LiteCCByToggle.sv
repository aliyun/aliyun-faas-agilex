// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4Axi4LiteCCByToggle


module ddr4Axi4LiteCCByToggle (
  input               input_awvalid,
  output              input_awready,
  input      [31:0]   input_awaddr,
  input      [2:0]    input_awprot,
  input               input_wvalid,
  output              input_wready,
  input      [63:0]   input_wdata,
  input      [3:0]    input_wstrb,
  output              input_bvalid,
  input               input_bready,
  output     [1:0]    input_bresp,
  input               input_arvalid,
  output              input_arready,
  input      [31:0]   input_araddr,
  input      [2:0]    input_arprot,
  output              input_rvalid,
  input               input_rready,
  output     [63:0]   input_rdata,
  output     [1:0]    input_rresp,
  output              output_awvalid,
  input               output_awready,
  output     [31:0]   output_awaddr,
  output     [2:0]    output_awprot,
  output              output_wvalid,
  input               output_wready,
  output     [63:0]   output_wdata,
  output     [3:0]    output_wstrb,
  input               output_bvalid,
  output              output_bready,
  input      [1:0]    output_bresp,
  output              output_arvalid,
  input               output_arready,
  output     [31:0]   output_araddr,
  output     [2:0]    output_arprot,
  input               output_rvalid,
  output              output_rready,
  input      [63:0]   output_rdata,
  input      [1:0]    output_rresp,
  input               clkA_clk,
  input               clkA_reset,
  input               clkB_clk,
  input               clkB_reset
);
  wire                streamCCByToggle_io_input_ready;
  wire                streamCCByToggle_io_output_valid;
  wire       [31:0]   streamCCByToggle_io_output_payload_addr;
  wire       [2:0]    streamCCByToggle_io_output_payload_prot;
  wire                streamCCByToggle_1_io_input_ready;
  wire                streamCCByToggle_1_io_output_valid;
  wire       [63:0]   streamCCByToggle_1_io_output_payload_data;
  wire       [3:0]    streamCCByToggle_1_io_output_payload_strb;
  wire                streamCCByToggle_2_io_input_ready;
  wire                streamCCByToggle_2_io_output_valid;
  wire       [1:0]    streamCCByToggle_2_io_output_payload_resp;
  wire                streamCCByToggle_3_io_input_ready;
  wire                streamCCByToggle_3_io_output_valid;
  wire       [31:0]   streamCCByToggle_3_io_output_payload_addr;
  wire       [2:0]    streamCCByToggle_3_io_output_payload_prot;
  wire                streamCCByToggle_4_io_input_ready;
  wire                streamCCByToggle_4_io_output_valid;
  wire       [63:0]   streamCCByToggle_4_io_output_payload_data;
  wire       [1:0]    streamCCByToggle_4_io_output_payload_resp;

  ddr4StreamCCByToggle streamCCByToggle (
    .io_input_valid            (input_awvalid                                  ), //i
    .io_input_ready            (streamCCByToggle_io_input_ready                ), //o
    .io_input_payload_addr     (input_awaddr[31:0]                             ), //i
    .io_input_payload_prot     (input_awprot[2:0]                              ), //i
    .io_output_valid           (streamCCByToggle_io_output_valid               ), //o
    .io_output_ready           (output_awready                                 ), //i
    .io_output_payload_addr    (streamCCByToggle_io_output_payload_addr[31:0]  ), //o
    .io_output_payload_prot    (streamCCByToggle_io_output_payload_prot[2:0]   ), //o
    .clkA_clk                  (clkA_clk                                       ), //i
    .clkA_reset                (clkA_reset                                     ), //i
    .clkB_clk                  (clkB_clk                                       ), //i
    .clkB_reset                (clkB_reset                                     )  //i
  );
  ddr4StreamCCByToggle_1 streamCCByToggle_1 (
    .io_input_valid            (input_wvalid                                     ), //i
    .io_input_ready            (streamCCByToggle_1_io_input_ready                ), //o
    .io_input_payload_data     (input_wdata[63:0]                                ), //i
    .io_input_payload_strb     (input_wstrb[3:0]                                 ), //i
    .io_output_valid           (streamCCByToggle_1_io_output_valid               ), //o
    .io_output_ready           (output_wready                                    ), //i
    .io_output_payload_data    (streamCCByToggle_1_io_output_payload_data[63:0]  ), //o
    .io_output_payload_strb    (streamCCByToggle_1_io_output_payload_strb[3:0]   ), //o
    .clkA_clk                  (clkA_clk                                         ), //i
    .clkA_reset                (clkA_reset                                       ), //i
    .clkB_clk                  (clkB_clk                                         ), //i
    .clkB_reset                (clkB_reset                                       )  //i
  );
  ddr4StreamCCByToggle_2 streamCCByToggle_2 (
    .io_input_valid            (output_bvalid                                   ), //i
    .io_input_ready            (streamCCByToggle_2_io_input_ready               ), //o
    .io_input_payload_resp     (output_bresp[1:0]                               ), //i
    .io_output_valid           (streamCCByToggle_2_io_output_valid              ), //o
    .io_output_ready           (input_bready                                    ), //i
    .io_output_payload_resp    (streamCCByToggle_2_io_output_payload_resp[1:0]  ), //o
    .clkB_clk                  (clkB_clk                                        ), //i
    .clkB_reset                (clkB_reset                                      ), //i
    .clkA_clk                  (clkA_clk                                        ), //i
    .clkA_reset                (clkA_reset                                      )  //i
  );
  ddr4StreamCCByToggle streamCCByToggle_3 (
    .io_input_valid            (input_arvalid                                    ), //i
    .io_input_ready            (streamCCByToggle_3_io_input_ready                ), //o
    .io_input_payload_addr     (input_araddr[31:0]                               ), //i
    .io_input_payload_prot     (input_arprot[2:0]                                ), //i
    .io_output_valid           (streamCCByToggle_3_io_output_valid               ), //o
    .io_output_ready           (output_arready                                   ), //i
    .io_output_payload_addr    (streamCCByToggle_3_io_output_payload_addr[31:0]  ), //o
    .io_output_payload_prot    (streamCCByToggle_3_io_output_payload_prot[2:0]   ), //o
    .clkA_clk                  (clkA_clk                                         ), //i
    .clkA_reset                (clkA_reset                                       ), //i
    .clkB_clk                  (clkB_clk                                         ), //i
    .clkB_reset                (clkB_reset                                       )  //i
  );
  ddr4StreamCCByToggle_4 streamCCByToggle_4 (
    .io_input_valid            (output_rvalid                                    ), //i
    .io_input_ready            (streamCCByToggle_4_io_input_ready                ), //o
    .io_input_payload_data     (output_rdata[63:0]                               ), //i
    .io_input_payload_resp     (output_rresp[1:0]                                ), //i
    .io_output_valid           (streamCCByToggle_4_io_output_valid               ), //o
    .io_output_ready           (input_rready                                     ), //i
    .io_output_payload_data    (streamCCByToggle_4_io_output_payload_data[63:0]  ), //o
    .io_output_payload_resp    (streamCCByToggle_4_io_output_payload_resp[1:0]   ), //o
    .clkB_clk                  (clkB_clk                                         ), //i
    .clkB_reset                (clkB_reset                                       ), //i
    .clkA_clk                  (clkA_clk                                         ), //i
    .clkA_reset                (clkA_reset                                       )  //i
  );
  assign input_awready = streamCCByToggle_io_input_ready;
  assign output_awvalid = streamCCByToggle_io_output_valid;
  assign output_awaddr = streamCCByToggle_io_output_payload_addr;
  assign output_awprot = streamCCByToggle_io_output_payload_prot;
  assign input_wready = streamCCByToggle_1_io_input_ready;
  assign output_wvalid = streamCCByToggle_1_io_output_valid;
  assign output_wdata = streamCCByToggle_1_io_output_payload_data;
  assign output_wstrb = streamCCByToggle_1_io_output_payload_strb;
  assign output_bready = streamCCByToggle_2_io_input_ready;
  assign input_bvalid = streamCCByToggle_2_io_output_valid;
  assign input_bresp = streamCCByToggle_2_io_output_payload_resp;
  assign input_arready = streamCCByToggle_3_io_input_ready;
  assign output_arvalid = streamCCByToggle_3_io_output_valid;
  assign output_araddr = streamCCByToggle_3_io_output_payload_addr;
  assign output_arprot = streamCCByToggle_3_io_output_payload_prot;
  assign output_rready = streamCCByToggle_4_io_input_ready;
  assign input_rvalid = streamCCByToggle_4_io_output_valid;
  assign input_rdata = streamCCByToggle_4_io_output_payload_data;
  assign input_rresp = streamCCByToggle_4_io_output_payload_resp;

endmodule
