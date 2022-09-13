// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4mmAxi4Mm2Avmm


`define Response_defaultEncoding_type [1:0]
`define Response_defaultEncoding_OKAY 2'b00
`define Response_defaultEncoding_RESERVED 2'b01
`define Response_defaultEncoding_SLAVEERROR 2'b10
`define Response_defaultEncoding_DECODEERROR 2'b11

module ddr4mmAxi4Mm2Avmm (
  input               axi4_awvalid,
  output              axi4_awready,
  input      [63:0]   axi4_awaddr,
  input      [3:0]    axi4_awid,
  input      [7:0]    axi4_awlen,
  input      [2:0]    axi4_awsize,
  input      [1:0]    axi4_awburst,
  input      [15:0]   axi4_awuser,
  input               axi4_wvalid,
  output              axi4_wready,
  input      [511:0]  axi4_wdata,
  input      [63:0]   axi4_wstrb,
  input      [15:0]   axi4_wuser,
  input               axi4_wlast,
  output              axi4_bvalid,
  input               axi4_bready,
  output     [3:0]    axi4_bid,
  output     [1:0]    axi4_bresp,
  output     [15:0]   axi4_buser,
  input               axi4_arvalid,
  output              axi4_arready,
  input      [63:0]   axi4_araddr,
  input      [3:0]    axi4_arid,
  input      [7:0]    axi4_arlen,
  input      [2:0]    axi4_arsize,
  input      [1:0]    axi4_arburst,
  input      [15:0]   axi4_aruser,
  output              axi4_rvalid,
  input               axi4_rready,
  output     [511:0]  axi4_rdata,
  output     [3:0]    axi4_rid,
  output     [1:0]    axi4_rresp,
  output              axi4_rlast,
  output     [15:0]   axi4_ruser,
  output              avmm_read,
  output              avmm_write,
  input               avmm_waitRequest,
  output     [63:0]   avmm_address,
  output              avmm_beginbursttransfer,
  output     [7:0]    avmm_burstCount,
  output     [63:0]   avmm_byteEnable,
  output     [511:0]  avmm_writeData,
  input      `Response_defaultEncoding_type avmm_response,
  input               avmm_readDataValid,
  input      [511:0]  avmm_readData,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire       [19:0]   _zz_2;
  wire                _zz_3;
  wire       [27:0]   _zz_4;
  wire                _zz_5;
  wire                streamArbiter_io_inputs_0_ready;
  wire                streamArbiter_io_inputs_1_ready;
  wire                streamArbiter_io_output_valid;
  wire       [63:0]   streamArbiter_io_output_payload_addr;
  wire       [3:0]    streamArbiter_io_output_payload_id;
  wire       [7:0]    streamArbiter_io_output_payload_len;
  wire       [2:0]    streamArbiter_io_output_payload_size;
  wire       [1:0]    streamArbiter_io_output_payload_burst;
  wire       [15:0]   streamArbiter_io_output_payload_user;
  wire       [0:0]    streamArbiter_io_chosen;
  wire       [1:0]    streamArbiter_io_chosenOH;
  wire                cmdGen_bRespFifo_push_ready;
  wire                cmdGen_bRespFifo_pop_valid;
  wire       [19:0]   cmdGen_bRespFifo_pop_payload;
  wire                cmdGen_bRespFifo_stats_empty;
  wire                cmdGen_bRespFifo_stats_afull;
  wire                cmdGen_bRespFifo_stats_aempty;
  wire                cmdGen_bRespFifo_stats_full;
  wire                cmdGen_bRespFifo_stats_overflow;
  wire                cmdGen_bRespFifo_stats_underflow;
  wire       [1:0]    cmdGen_bRespFifo_stats_eccState;
  wire       [3:0]    cmdGen_bRespFifo_occupancy;
  wire       [3:0]    cmdGen_bRespFifo_availability;
  wire                cmdGen_rRespFifo_push_ready;
  wire                cmdGen_rRespFifo_pop_valid;
  wire       [27:0]   cmdGen_rRespFifo_pop_payload;
  wire                cmdGen_rRespFifo_stats_empty;
  wire                cmdGen_rRespFifo_stats_afull;
  wire                cmdGen_rRespFifo_stats_aempty;
  wire                cmdGen_rRespFifo_stats_full;
  wire                cmdGen_rRespFifo_stats_overflow;
  wire                cmdGen_rRespFifo_stats_underflow;
  wire       [1:0]    cmdGen_rRespFifo_stats_eccState;
  wire       [3:0]    cmdGen_rRespFifo_occupancy;
  wire       [3:0]    cmdGen_rRespFifo_availability;
  wire                cmdGen_rDataFifo_push_ready;
  wire                cmdGen_rDataFifo_pop_valid;
  wire       [511:0]  cmdGen_rDataFifo_pop_payload;
  wire                cmdGen_rDataFifo_stats_empty;
  wire                cmdGen_rDataFifo_stats_afull;
  wire                cmdGen_rDataFifo_stats_aempty;
  wire                cmdGen_rDataFifo_stats_full;
  wire                cmdGen_rDataFifo_stats_overflow;
  wire                cmdGen_rDataFifo_stats_underflow;
  wire       [1:0]    cmdGen_rDataFifo_stats_eccState;
  wire       [9:0]    cmdGen_rDataFifo_occupancy;
  wire       [9:0]    cmdGen_rDataFifo_availability;
  wire                _zz_6;
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire       [57:0]   _zz_10;
  wire       [8:0]    _zz_11;
  wire       [1:0]    _zz_12;
  wire       [8:0]    _zz_13;
  wire       [0:0]    _zz_14;
  wire       [7:0]    _zz_15;
  wire                cmdGen_axi4Shared_arw_valid;
  wire                cmdGen_axi4Shared_arw_ready;
  wire       [63:0]   cmdGen_axi4Shared_arw_payload_addr;
  wire       [3:0]    cmdGen_axi4Shared_arw_payload_id;
  wire       [7:0]    cmdGen_axi4Shared_arw_payload_len;
  wire       [2:0]    cmdGen_axi4Shared_arw_payload_size;
  wire       [1:0]    cmdGen_axi4Shared_arw_payload_burst;
  wire       [15:0]   cmdGen_axi4Shared_arw_payload_user;
  wire                cmdGen_axi4Shared_arw_payload_write;
  wire                cmdGen_axi4Shared_w_valid;
  wire                cmdGen_axi4Shared_w_ready;
  wire       [511:0]  cmdGen_axi4Shared_w_payload_data;
  wire       [63:0]   cmdGen_axi4Shared_w_payload_strb;
  wire       [15:0]   cmdGen_axi4Shared_w_payload_user;
  wire                cmdGen_axi4Shared_w_payload_last;
  wire                cmdGen_axi4Shared_b_valid;
  wire                cmdGen_axi4Shared_b_ready;
  wire       [3:0]    cmdGen_axi4Shared_b_payload_id;
  wire       [1:0]    cmdGen_axi4Shared_b_payload_resp;
  wire       [15:0]   cmdGen_axi4Shared_b_payload_user;
  wire                cmdGen_axi4Shared_r_valid;
  wire                cmdGen_axi4Shared_r_ready;
  wire       [511:0]  cmdGen_axi4Shared_r_payload_data;
  wire       [3:0]    cmdGen_axi4Shared_r_payload_id;
  wire       [1:0]    cmdGen_axi4Shared_r_payload_resp;
  wire                cmdGen_axi4Shared_r_payload_last;
  wire       [15:0]   cmdGen_axi4Shared_r_payload_user;
  wire                cmdGen_axi4SharedPipe_arw_valid;
  wire                cmdGen_axi4SharedPipe_arw_ready;
  wire       [63:0]   cmdGen_axi4SharedPipe_arw_payload_addr;
  wire       [3:0]    cmdGen_axi4SharedPipe_arw_payload_id;
  wire       [7:0]    cmdGen_axi4SharedPipe_arw_payload_len;
  wire       [2:0]    cmdGen_axi4SharedPipe_arw_payload_size;
  wire       [1:0]    cmdGen_axi4SharedPipe_arw_payload_burst;
  wire       [15:0]   cmdGen_axi4SharedPipe_arw_payload_user;
  wire                cmdGen_axi4SharedPipe_arw_payload_write;
  wire                cmdGen_axi4SharedPipe_w_valid;
  wire                cmdGen_axi4SharedPipe_w_ready;
  wire       [511:0]  cmdGen_axi4SharedPipe_w_payload_data;
  wire       [63:0]   cmdGen_axi4SharedPipe_w_payload_strb;
  wire       [15:0]   cmdGen_axi4SharedPipe_w_payload_user;
  wire                cmdGen_axi4SharedPipe_w_payload_last;
  wire                cmdGen_axi4SharedPipe_b_valid;
  wire                cmdGen_axi4SharedPipe_b_ready;
  wire       [3:0]    cmdGen_axi4SharedPipe_b_payload_id;
  wire       [1:0]    cmdGen_axi4SharedPipe_b_payload_resp;
  wire       [15:0]   cmdGen_axi4SharedPipe_b_payload_user;
  wire                cmdGen_axi4SharedPipe_r_valid;
  wire                cmdGen_axi4SharedPipe_r_ready;
  wire       [511:0]  cmdGen_axi4SharedPipe_r_payload_data;
  wire       [3:0]    cmdGen_axi4SharedPipe_r_payload_id;
  wire       [1:0]    cmdGen_axi4SharedPipe_r_payload_resp;
  wire                cmdGen_axi4SharedPipe_r_payload_last;
  wire       [15:0]   cmdGen_axi4SharedPipe_r_payload_user;
  wire                cmdGen_axi4Shared_arw_s2mPipe_valid;
  wire                cmdGen_axi4Shared_arw_s2mPipe_ready;
  wire       [63:0]   cmdGen_axi4Shared_arw_s2mPipe_payload_addr;
  wire       [3:0]    cmdGen_axi4Shared_arw_s2mPipe_payload_id;
  wire       [7:0]    cmdGen_axi4Shared_arw_s2mPipe_payload_len;
  wire       [2:0]    cmdGen_axi4Shared_arw_s2mPipe_payload_size;
  wire       [1:0]    cmdGen_axi4Shared_arw_s2mPipe_payload_burst;
  wire       [15:0]   cmdGen_axi4Shared_arw_s2mPipe_payload_user;
  wire                cmdGen_axi4Shared_arw_s2mPipe_payload_write;
  reg                 cmdGen_axi4Shared_arw_s2mPipe_rValid;
  reg        [63:0]   cmdGen_axi4Shared_arw_s2mPipe_rData_addr;
  reg        [3:0]    cmdGen_axi4Shared_arw_s2mPipe_rData_id;
  reg        [7:0]    cmdGen_axi4Shared_arw_s2mPipe_rData_len;
  reg        [2:0]    cmdGen_axi4Shared_arw_s2mPipe_rData_size;
  reg        [1:0]    cmdGen_axi4Shared_arw_s2mPipe_rData_burst;
  reg        [15:0]   cmdGen_axi4Shared_arw_s2mPipe_rData_user;
  reg                 cmdGen_axi4Shared_arw_s2mPipe_rData_write;
  wire                cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_valid;
  wire                cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_ready;
  wire       [63:0]   cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_id;
  wire       [7:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_burst;
  wire       [15:0]   cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_user;
  wire                cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_write;
  reg                 cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rValid;
  reg        [63:0]   cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_addr;
  reg        [3:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_id;
  reg        [7:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_len;
  reg        [2:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_size;
  reg        [1:0]    cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_burst;
  reg        [15:0]   cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_user;
  reg                 cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_write;
  wire                cmdGen_axi4Shared_w_s2mPipe_valid;
  wire                cmdGen_axi4Shared_w_s2mPipe_ready;
  wire       [511:0]  cmdGen_axi4Shared_w_s2mPipe_payload_data;
  wire       [63:0]   cmdGen_axi4Shared_w_s2mPipe_payload_strb;
  wire       [15:0]   cmdGen_axi4Shared_w_s2mPipe_payload_user;
  wire                cmdGen_axi4Shared_w_s2mPipe_payload_last;
  reg                 cmdGen_axi4Shared_w_s2mPipe_rValid;
  reg        [511:0]  cmdGen_axi4Shared_w_s2mPipe_rData_data;
  reg        [63:0]   cmdGen_axi4Shared_w_s2mPipe_rData_strb;
  reg        [15:0]   cmdGen_axi4Shared_w_s2mPipe_rData_user;
  reg                 cmdGen_axi4Shared_w_s2mPipe_rData_last;
  wire                cmdGen_axi4Shared_w_s2mPipe_m2sPipe_valid;
  wire                cmdGen_axi4Shared_w_s2mPipe_m2sPipe_ready;
  wire       [511:0]  cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_data;
  wire       [63:0]   cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_strb;
  wire       [15:0]   cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_user;
  wire                cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_last;
  reg                 cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rValid;
  reg        [511:0]  cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_data;
  reg        [63:0]   cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_strb;
  reg        [15:0]   cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_user;
  reg                 cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_last;
  wire                cmdGen_axi4SharedPipe_b_s2mPipe_valid;
  wire                cmdGen_axi4SharedPipe_b_s2mPipe_ready;
  wire       [3:0]    cmdGen_axi4SharedPipe_b_s2mPipe_payload_id;
  wire       [1:0]    cmdGen_axi4SharedPipe_b_s2mPipe_payload_resp;
  wire       [15:0]   cmdGen_axi4SharedPipe_b_s2mPipe_payload_user;
  reg                 cmdGen_axi4SharedPipe_b_s2mPipe_rValid;
  reg        [3:0]    cmdGen_axi4SharedPipe_b_s2mPipe_rData_id;
  reg        [1:0]    cmdGen_axi4SharedPipe_b_s2mPipe_rData_resp;
  reg        [15:0]   cmdGen_axi4SharedPipe_b_s2mPipe_rData_user;
  wire                cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_valid;
  wire                cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_ready;
  wire       [3:0]    cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_resp;
  wire       [15:0]   cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_user;
  reg                 cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rValid;
  reg        [3:0]    cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_id;
  reg        [1:0]    cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_resp;
  reg        [15:0]   cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_user;
  wire                cmdGen_axi4SharedPipe_r_s2mPipe_valid;
  wire                cmdGen_axi4SharedPipe_r_s2mPipe_ready;
  wire       [511:0]  cmdGen_axi4SharedPipe_r_s2mPipe_payload_data;
  wire       [3:0]    cmdGen_axi4SharedPipe_r_s2mPipe_payload_id;
  wire       [1:0]    cmdGen_axi4SharedPipe_r_s2mPipe_payload_resp;
  wire                cmdGen_axi4SharedPipe_r_s2mPipe_payload_last;
  wire       [15:0]   cmdGen_axi4SharedPipe_r_s2mPipe_payload_user;
  reg                 cmdGen_axi4SharedPipe_r_s2mPipe_rValid;
  reg        [511:0]  cmdGen_axi4SharedPipe_r_s2mPipe_rData_data;
  reg        [3:0]    cmdGen_axi4SharedPipe_r_s2mPipe_rData_id;
  reg        [1:0]    cmdGen_axi4SharedPipe_r_s2mPipe_rData_resp;
  reg                 cmdGen_axi4SharedPipe_r_s2mPipe_rData_last;
  reg        [15:0]   cmdGen_axi4SharedPipe_r_s2mPipe_rData_user;
  wire                cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_valid;
  wire                cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_ready;
  wire       [511:0]  cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_resp;
  wire                cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_last;
  wire       [15:0]   cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_user;
  reg                 cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rValid;
  reg        [511:0]  cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_data;
  reg        [3:0]    cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_id;
  reg        [1:0]    cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_resp;
  reg                 cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_last;
  reg        [15:0]   cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_user;
  reg                 cmdGen_writeFirst;
  reg                 respProc_readCycleCnt_willIncrement;
  wire                respProc_readCycleCnt_willClear;
  reg        [7:0]    respProc_readCycleCnt_valueNext;
  reg        [7:0]    respProc_readCycleCnt_value;
  wire                respProc_readCycleCnt_willOverflowIfInc;
  wire                respProc_readCycleCnt_willOverflow;
  wire       [7:0]    respProc_pkgLenRef;
  `ifndef SYNTHESIS
  reg [87:0] avmm_response_string;
  `endif


  assign _zz_6 = (cmdGen_axi4Shared_arw_ready && (! cmdGen_axi4Shared_arw_s2mPipe_ready));
  assign _zz_7 = (cmdGen_axi4Shared_w_ready && (! cmdGen_axi4Shared_w_s2mPipe_ready));
  assign _zz_8 = (cmdGen_axi4SharedPipe_b_ready && (! cmdGen_axi4SharedPipe_b_s2mPipe_ready));
  assign _zz_9 = (cmdGen_axi4SharedPipe_r_ready && (! cmdGen_axi4SharedPipe_r_s2mPipe_ready));
  assign _zz_10 = (cmdGen_axi4SharedPipe_arw_payload_addr >>> 6);
  assign _zz_11 = ({1'b0,cmdGen_axi4SharedPipe_arw_payload_len} + _zz_13);
  assign _zz_12 = {1'b0,1'b1};
  assign _zz_13 = {7'd0, _zz_12};
  assign _zz_14 = respProc_readCycleCnt_willIncrement;
  assign _zz_15 = {7'd0, _zz_14};
  ddr4mmStreamArbiter streamArbiter (
    .io_inputs_0_valid            (axi4_arvalid                                ), //i
    .io_inputs_0_ready            (streamArbiter_io_inputs_0_ready             ), //o
    .io_inputs_0_payload_addr     (axi4_araddr[63:0]                           ), //i
    .io_inputs_0_payload_id       (axi4_arid[3:0]                              ), //i
    .io_inputs_0_payload_len      (axi4_arlen[7:0]                             ), //i
    .io_inputs_0_payload_size     (axi4_arsize[2:0]                            ), //i
    .io_inputs_0_payload_burst    (axi4_arburst[1:0]                           ), //i
    .io_inputs_0_payload_user     (axi4_aruser[15:0]                           ), //i
    .io_inputs_1_valid            (axi4_awvalid                                ), //i
    .io_inputs_1_ready            (streamArbiter_io_inputs_1_ready             ), //o
    .io_inputs_1_payload_addr     (axi4_awaddr[63:0]                           ), //i
    .io_inputs_1_payload_id       (axi4_awid[3:0]                              ), //i
    .io_inputs_1_payload_len      (axi4_awlen[7:0]                             ), //i
    .io_inputs_1_payload_size     (axi4_awsize[2:0]                            ), //i
    .io_inputs_1_payload_burst    (axi4_awburst[1:0]                           ), //i
    .io_inputs_1_payload_user     (axi4_awuser[15:0]                           ), //i
    .io_output_valid              (streamArbiter_io_output_valid               ), //o
    .io_output_ready              (cmdGen_axi4Shared_arw_ready                 ), //i
    .io_output_payload_addr       (streamArbiter_io_output_payload_addr[63:0]  ), //o
    .io_output_payload_id         (streamArbiter_io_output_payload_id[3:0]     ), //o
    .io_output_payload_len        (streamArbiter_io_output_payload_len[7:0]    ), //o
    .io_output_payload_size       (streamArbiter_io_output_payload_size[2:0]   ), //o
    .io_output_payload_burst      (streamArbiter_io_output_payload_burst[1:0]  ), //o
    .io_output_payload_user       (streamArbiter_io_output_payload_user[15:0]  ), //o
    .io_chosen                    (streamArbiter_io_chosen                     ), //o
    .io_chosenOH                  (streamArbiter_io_chosenOH[1:0]              ), //o
    .clk                          (clk                                         ), //i
    .reset                        (reset                                       )  //i
  );
  ddr4mmStreamSfifo cmdGen_bRespFifo (
    .push_valid         (_zz_1                                 ), //i
    .push_ready         (cmdGen_bRespFifo_push_ready           ), //o
    .push_payload       (_zz_2[19:0]                           ), //i
    .pop_valid          (cmdGen_bRespFifo_pop_valid            ), //o
    .pop_ready          (cmdGen_axi4SharedPipe_b_ready         ), //i
    .pop_payload        (cmdGen_bRespFifo_pop_payload[19:0]    ), //o
    .stats_empty        (cmdGen_bRespFifo_stats_empty          ), //o
    .stats_afull        (cmdGen_bRespFifo_stats_afull          ), //o
    .stats_aempty       (cmdGen_bRespFifo_stats_aempty         ), //o
    .stats_full         (cmdGen_bRespFifo_stats_full           ), //o
    .stats_overflow     (cmdGen_bRespFifo_stats_overflow       ), //o
    .stats_underflow    (cmdGen_bRespFifo_stats_underflow      ), //o
    .stats_eccState     (cmdGen_bRespFifo_stats_eccState[1:0]  ), //o
    .occupancy          (cmdGen_bRespFifo_occupancy[3:0]       ), //o
    .availability       (cmdGen_bRespFifo_availability[3:0]    ), //o
    .clk                (clk                                   ), //i
    .reset              (reset                                 )  //i
  );
  ddr4mmStreamSfifo_1 cmdGen_rRespFifo (
    .push_valid         (_zz_3                                 ), //i
    .push_ready         (cmdGen_rRespFifo_push_ready           ), //o
    .push_payload       (_zz_4[27:0]                           ), //i
    .pop_valid          (cmdGen_rRespFifo_pop_valid            ), //o
    .pop_ready          (_zz_5                                 ), //i
    .pop_payload        (cmdGen_rRespFifo_pop_payload[27:0]    ), //o
    .stats_empty        (cmdGen_rRespFifo_stats_empty          ), //o
    .stats_afull        (cmdGen_rRespFifo_stats_afull          ), //o
    .stats_aempty       (cmdGen_rRespFifo_stats_aempty         ), //o
    .stats_full         (cmdGen_rRespFifo_stats_full           ), //o
    .stats_overflow     (cmdGen_rRespFifo_stats_overflow       ), //o
    .stats_underflow    (cmdGen_rRespFifo_stats_underflow      ), //o
    .stats_eccState     (cmdGen_rRespFifo_stats_eccState[1:0]  ), //o
    .occupancy          (cmdGen_rRespFifo_occupancy[3:0]       ), //o
    .availability       (cmdGen_rRespFifo_availability[3:0]    ), //o
    .clk                (clk                                   ), //i
    .reset              (reset                                 )  //i
  );
  ddr4mmStreamSfifo_2 cmdGen_rDataFifo (
    .push_valid         (avmm_readDataValid                    ), //i
    .push_ready         (cmdGen_rDataFifo_push_ready           ), //o
    .push_payload       (avmm_readData[511:0]                  ), //i
    .pop_valid          (cmdGen_rDataFifo_pop_valid            ), //o
    .pop_ready          (cmdGen_axi4SharedPipe_r_ready         ), //i
    .pop_payload        (cmdGen_rDataFifo_pop_payload[511:0]   ), //o
    .stats_empty        (cmdGen_rDataFifo_stats_empty          ), //o
    .stats_afull        (cmdGen_rDataFifo_stats_afull          ), //o
    .stats_aempty       (cmdGen_rDataFifo_stats_aempty         ), //o
    .stats_full         (cmdGen_rDataFifo_stats_full           ), //o
    .stats_overflow     (cmdGen_rDataFifo_stats_overflow       ), //o
    .stats_underflow    (cmdGen_rDataFifo_stats_underflow      ), //o
    .stats_eccState     (cmdGen_rDataFifo_stats_eccState[1:0]  ), //o
    .occupancy          (cmdGen_rDataFifo_occupancy[9:0]       ), //o
    .availability       (cmdGen_rDataFifo_availability[9:0]    ), //o
    .clk                (clk                                   ), //i
    .reset              (reset                                 )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(avmm_response)
      `Response_defaultEncoding_OKAY : avmm_response_string = "OKAY       ";
      `Response_defaultEncoding_RESERVED : avmm_response_string = "RESERVED   ";
      `Response_defaultEncoding_SLAVEERROR : avmm_response_string = "SLAVEERROR ";
      `Response_defaultEncoding_DECODEERROR : avmm_response_string = "DECODEERROR";
      default : avmm_response_string = "???????????";
    endcase
  end
  `endif

  assign axi4_arready = streamArbiter_io_inputs_0_ready;
  assign axi4_awready = streamArbiter_io_inputs_1_ready;
  assign cmdGen_axi4Shared_arw_valid = streamArbiter_io_output_valid;
  assign cmdGen_axi4Shared_arw_payload_addr = streamArbiter_io_output_payload_addr;
  assign cmdGen_axi4Shared_arw_payload_id = streamArbiter_io_output_payload_id;
  assign cmdGen_axi4Shared_arw_payload_len = streamArbiter_io_output_payload_len;
  assign cmdGen_axi4Shared_arw_payload_size = streamArbiter_io_output_payload_size;
  assign cmdGen_axi4Shared_arw_payload_burst = streamArbiter_io_output_payload_burst;
  assign cmdGen_axi4Shared_arw_payload_user = streamArbiter_io_output_payload_user;
  assign cmdGen_axi4Shared_arw_payload_write = streamArbiter_io_chosenOH[1];
  assign cmdGen_axi4Shared_w_valid = axi4_wvalid;
  assign axi4_wready = cmdGen_axi4Shared_w_ready;
  assign cmdGen_axi4Shared_w_payload_data = axi4_wdata;
  assign cmdGen_axi4Shared_w_payload_strb = axi4_wstrb;
  assign cmdGen_axi4Shared_w_payload_user = axi4_wuser;
  assign cmdGen_axi4Shared_w_payload_last = axi4_wlast;
  assign axi4_bvalid = cmdGen_axi4Shared_b_valid;
  assign cmdGen_axi4Shared_b_ready = axi4_bready;
  assign axi4_bid = cmdGen_axi4Shared_b_payload_id;
  assign axi4_bresp = cmdGen_axi4Shared_b_payload_resp;
  assign axi4_buser = cmdGen_axi4Shared_b_payload_user;
  assign axi4_rvalid = cmdGen_axi4Shared_r_valid;
  assign cmdGen_axi4Shared_r_ready = axi4_rready;
  assign axi4_rdata = cmdGen_axi4Shared_r_payload_data;
  assign axi4_rid = cmdGen_axi4Shared_r_payload_id;
  assign axi4_rresp = cmdGen_axi4Shared_r_payload_resp;
  assign axi4_rlast = cmdGen_axi4Shared_r_payload_last;
  assign axi4_ruser = cmdGen_axi4Shared_r_payload_user;
  assign cmdGen_axi4Shared_arw_s2mPipe_valid = (cmdGen_axi4Shared_arw_valid || cmdGen_axi4Shared_arw_s2mPipe_rValid);
  assign cmdGen_axi4Shared_arw_ready = (! cmdGen_axi4Shared_arw_s2mPipe_rValid);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_addr = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_addr : cmdGen_axi4Shared_arw_payload_addr);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_id = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_id : cmdGen_axi4Shared_arw_payload_id);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_len = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_len : cmdGen_axi4Shared_arw_payload_len);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_size = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_size : cmdGen_axi4Shared_arw_payload_size);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_burst = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_burst : cmdGen_axi4Shared_arw_payload_burst);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_user = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_user : cmdGen_axi4Shared_arw_payload_user);
  assign cmdGen_axi4Shared_arw_s2mPipe_payload_write = (cmdGen_axi4Shared_arw_s2mPipe_rValid ? cmdGen_axi4Shared_arw_s2mPipe_rData_write : cmdGen_axi4Shared_arw_payload_write);
  assign cmdGen_axi4Shared_arw_s2mPipe_ready = ((1'b1 && (! cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_valid)) || cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_ready);
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_valid = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rValid;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_addr = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_addr;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_id = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_id;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_len = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_len;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_size = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_size;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_burst = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_burst;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_user = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_user;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_write = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_write;
  assign cmdGen_axi4SharedPipe_arw_valid = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_valid;
  assign cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_ready = cmdGen_axi4SharedPipe_arw_ready;
  assign cmdGen_axi4SharedPipe_arw_payload_addr = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_addr;
  assign cmdGen_axi4SharedPipe_arw_payload_id = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_id;
  assign cmdGen_axi4SharedPipe_arw_payload_len = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_len;
  assign cmdGen_axi4SharedPipe_arw_payload_size = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_size;
  assign cmdGen_axi4SharedPipe_arw_payload_burst = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_burst;
  assign cmdGen_axi4SharedPipe_arw_payload_user = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_user;
  assign cmdGen_axi4SharedPipe_arw_payload_write = cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_payload_write;
  assign cmdGen_axi4Shared_w_s2mPipe_valid = (cmdGen_axi4Shared_w_valid || cmdGen_axi4Shared_w_s2mPipe_rValid);
  assign cmdGen_axi4Shared_w_ready = (! cmdGen_axi4Shared_w_s2mPipe_rValid);
  assign cmdGen_axi4Shared_w_s2mPipe_payload_data = (cmdGen_axi4Shared_w_s2mPipe_rValid ? cmdGen_axi4Shared_w_s2mPipe_rData_data : cmdGen_axi4Shared_w_payload_data);
  assign cmdGen_axi4Shared_w_s2mPipe_payload_strb = (cmdGen_axi4Shared_w_s2mPipe_rValid ? cmdGen_axi4Shared_w_s2mPipe_rData_strb : cmdGen_axi4Shared_w_payload_strb);
  assign cmdGen_axi4Shared_w_s2mPipe_payload_user = (cmdGen_axi4Shared_w_s2mPipe_rValid ? cmdGen_axi4Shared_w_s2mPipe_rData_user : cmdGen_axi4Shared_w_payload_user);
  assign cmdGen_axi4Shared_w_s2mPipe_payload_last = (cmdGen_axi4Shared_w_s2mPipe_rValid ? cmdGen_axi4Shared_w_s2mPipe_rData_last : cmdGen_axi4Shared_w_payload_last);
  assign cmdGen_axi4Shared_w_s2mPipe_ready = ((1'b1 && (! cmdGen_axi4Shared_w_s2mPipe_m2sPipe_valid)) || cmdGen_axi4Shared_w_s2mPipe_m2sPipe_ready);
  assign cmdGen_axi4Shared_w_s2mPipe_m2sPipe_valid = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rValid;
  assign cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_data = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_data;
  assign cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_strb = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_strb;
  assign cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_user = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_user;
  assign cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_last = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_last;
  assign cmdGen_axi4SharedPipe_w_valid = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_valid;
  assign cmdGen_axi4Shared_w_s2mPipe_m2sPipe_ready = cmdGen_axi4SharedPipe_w_ready;
  assign cmdGen_axi4SharedPipe_w_payload_data = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_data;
  assign cmdGen_axi4SharedPipe_w_payload_strb = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_strb;
  assign cmdGen_axi4SharedPipe_w_payload_user = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_user;
  assign cmdGen_axi4SharedPipe_w_payload_last = cmdGen_axi4Shared_w_s2mPipe_m2sPipe_payload_last;
  assign cmdGen_axi4SharedPipe_b_s2mPipe_valid = (cmdGen_axi4SharedPipe_b_valid || cmdGen_axi4SharedPipe_b_s2mPipe_rValid);
  assign cmdGen_axi4SharedPipe_b_ready = (! cmdGen_axi4SharedPipe_b_s2mPipe_rValid);
  assign cmdGen_axi4SharedPipe_b_s2mPipe_payload_id = (cmdGen_axi4SharedPipe_b_s2mPipe_rValid ? cmdGen_axi4SharedPipe_b_s2mPipe_rData_id : cmdGen_axi4SharedPipe_b_payload_id);
  assign cmdGen_axi4SharedPipe_b_s2mPipe_payload_resp = (cmdGen_axi4SharedPipe_b_s2mPipe_rValid ? cmdGen_axi4SharedPipe_b_s2mPipe_rData_resp : cmdGen_axi4SharedPipe_b_payload_resp);
  assign cmdGen_axi4SharedPipe_b_s2mPipe_payload_user = (cmdGen_axi4SharedPipe_b_s2mPipe_rValid ? cmdGen_axi4SharedPipe_b_s2mPipe_rData_user : cmdGen_axi4SharedPipe_b_payload_user);
  assign cmdGen_axi4SharedPipe_b_s2mPipe_ready = ((1'b1 && (! cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_valid)) || cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_ready);
  assign cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_valid = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rValid;
  assign cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_id = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_id;
  assign cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_resp = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_resp;
  assign cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_user = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_user;
  assign cmdGen_axi4Shared_b_valid = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_valid;
  assign cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_ready = cmdGen_axi4Shared_b_ready;
  assign cmdGen_axi4Shared_b_payload_id = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_id;
  assign cmdGen_axi4Shared_b_payload_resp = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_resp;
  assign cmdGen_axi4Shared_b_payload_user = cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_payload_user;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_valid = (cmdGen_axi4SharedPipe_r_valid || cmdGen_axi4SharedPipe_r_s2mPipe_rValid);
  assign cmdGen_axi4SharedPipe_r_ready = (! cmdGen_axi4SharedPipe_r_s2mPipe_rValid);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_payload_data = (cmdGen_axi4SharedPipe_r_s2mPipe_rValid ? cmdGen_axi4SharedPipe_r_s2mPipe_rData_data : cmdGen_axi4SharedPipe_r_payload_data);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_payload_id = (cmdGen_axi4SharedPipe_r_s2mPipe_rValid ? cmdGen_axi4SharedPipe_r_s2mPipe_rData_id : cmdGen_axi4SharedPipe_r_payload_id);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_payload_resp = (cmdGen_axi4SharedPipe_r_s2mPipe_rValid ? cmdGen_axi4SharedPipe_r_s2mPipe_rData_resp : cmdGen_axi4SharedPipe_r_payload_resp);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_payload_last = (cmdGen_axi4SharedPipe_r_s2mPipe_rValid ? cmdGen_axi4SharedPipe_r_s2mPipe_rData_last : cmdGen_axi4SharedPipe_r_payload_last);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_payload_user = (cmdGen_axi4SharedPipe_r_s2mPipe_rValid ? cmdGen_axi4SharedPipe_r_s2mPipe_rData_user : cmdGen_axi4SharedPipe_r_payload_user);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_ready = ((1'b1 && (! cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_valid)) || cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_ready);
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_valid = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rValid;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_data = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_data;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_id = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_id;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_resp = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_resp;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_last = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_last;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_user = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_user;
  assign cmdGen_axi4Shared_r_valid = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_valid;
  assign cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_ready = cmdGen_axi4Shared_r_ready;
  assign cmdGen_axi4Shared_r_payload_data = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_data;
  assign cmdGen_axi4Shared_r_payload_id = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_id;
  assign cmdGen_axi4Shared_r_payload_resp = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_resp;
  assign cmdGen_axi4Shared_r_payload_last = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_last;
  assign cmdGen_axi4Shared_r_payload_user = cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_payload_user;
  assign _zz_2 = {cmdGen_axi4SharedPipe_arw_payload_id,cmdGen_axi4SharedPipe_arw_payload_user};
  assign _zz_4 = {{cmdGen_axi4SharedPipe_arw_payload_len,cmdGen_axi4SharedPipe_arw_payload_id},cmdGen_axi4SharedPipe_arw_payload_user};
  assign _zz_3 = ((cmdGen_axi4SharedPipe_arw_valid && cmdGen_axi4SharedPipe_arw_ready) && (! cmdGen_axi4SharedPipe_arw_payload_write));
  assign _zz_1 = ((cmdGen_axi4SharedPipe_w_payload_last && (cmdGen_axi4SharedPipe_w_valid && cmdGen_axi4SharedPipe_w_ready)) && cmdGen_axi4SharedPipe_arw_payload_write);
  assign avmm_read = ((cmdGen_axi4SharedPipe_arw_valid && (! cmdGen_axi4SharedPipe_arw_payload_write)) && cmdGen_rRespFifo_push_ready);
  assign avmm_write = (((cmdGen_axi4SharedPipe_arw_valid && cmdGen_axi4SharedPipe_arw_payload_write) && cmdGen_bRespFifo_push_ready) && cmdGen_axi4SharedPipe_w_valid);
  assign avmm_address = ({6'd0,_zz_10} <<< 6);
  assign avmm_beginbursttransfer = (cmdGen_axi4SharedPipe_arw_payload_write ? cmdGen_writeFirst : 1'b1);
  assign avmm_burstCount = _zz_11[7:0];
  assign avmm_byteEnable = cmdGen_axi4SharedPipe_w_payload_strb;
  assign avmm_writeData = cmdGen_axi4SharedPipe_w_payload_data;
  assign cmdGen_axi4SharedPipe_arw_ready = (cmdGen_axi4SharedPipe_arw_payload_write ? ((cmdGen_axi4SharedPipe_w_valid && cmdGen_axi4SharedPipe_w_ready) && cmdGen_axi4SharedPipe_w_payload_last) : ((! avmm_waitRequest) && cmdGen_rRespFifo_push_ready));
  assign cmdGen_axi4SharedPipe_w_ready = (((! avmm_waitRequest) && cmdGen_bRespFifo_push_ready) && avmm_write);
  always @ (*) begin
    respProc_readCycleCnt_willIncrement = 1'b0;
    if((cmdGen_axi4SharedPipe_r_valid && cmdGen_axi4SharedPipe_r_ready))begin
      respProc_readCycleCnt_willIncrement = 1'b1;
    end
  end

  assign respProc_readCycleCnt_willClear = 1'b0;
  assign respProc_readCycleCnt_willOverflowIfInc = (respProc_readCycleCnt_value == 8'hff);
  assign respProc_readCycleCnt_willOverflow = (respProc_readCycleCnt_willOverflowIfInc && respProc_readCycleCnt_willIncrement);
  always @ (*) begin
    respProc_readCycleCnt_valueNext = (respProc_readCycleCnt_value + _zz_15);
    if(respProc_readCycleCnt_willClear)begin
      respProc_readCycleCnt_valueNext = 8'h0;
    end
  end

  assign cmdGen_axi4SharedPipe_b_payload_resp = 2'b00;
  assign cmdGen_axi4SharedPipe_r_payload_resp = 2'b00;
  assign cmdGen_axi4SharedPipe_b_valid = cmdGen_bRespFifo_pop_valid;
  assign cmdGen_axi4SharedPipe_b_payload_id = cmdGen_bRespFifo_pop_payload[19 : 16];
  assign cmdGen_axi4SharedPipe_b_payload_user = cmdGen_bRespFifo_pop_payload[15 : 0];
  assign cmdGen_axi4SharedPipe_r_payload_id = cmdGen_rRespFifo_pop_payload[19 : 16];
  assign cmdGen_axi4SharedPipe_r_payload_user = cmdGen_rRespFifo_pop_payload[15 : 0];
  assign respProc_pkgLenRef = cmdGen_rRespFifo_pop_payload[27 : 20];
  assign cmdGen_axi4SharedPipe_r_valid = (cmdGen_rRespFifo_pop_valid && cmdGen_rDataFifo_pop_valid);
  assign cmdGen_axi4SharedPipe_r_payload_data = cmdGen_rDataFifo_pop_payload;
  assign cmdGen_axi4SharedPipe_r_payload_last = (respProc_readCycleCnt_value == respProc_pkgLenRef);
  assign _zz_5 = ((cmdGen_axi4SharedPipe_r_valid && cmdGen_axi4SharedPipe_r_ready) && cmdGen_axi4SharedPipe_r_payload_last);
  always @ (posedge clk) begin
    if(reset) begin
      cmdGen_axi4Shared_arw_s2mPipe_rValid <= 1'b0;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rValid <= 1'b0;
      cmdGen_axi4Shared_w_s2mPipe_rValid <= 1'b0;
      cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rValid <= 1'b0;
      cmdGen_axi4SharedPipe_b_s2mPipe_rValid <= 1'b0;
      cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rValid <= 1'b0;
      cmdGen_axi4SharedPipe_r_s2mPipe_rValid <= 1'b0;
      cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rValid <= 1'b0;
      cmdGen_writeFirst <= 1'b1;
      respProc_readCycleCnt_value <= 8'h0;
    end else begin
      if(cmdGen_axi4Shared_arw_s2mPipe_ready)begin
        cmdGen_axi4Shared_arw_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_6)begin
        cmdGen_axi4Shared_arw_s2mPipe_rValid <= cmdGen_axi4Shared_arw_valid;
      end
      if(cmdGen_axi4Shared_arw_s2mPipe_ready)begin
        cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rValid <= cmdGen_axi4Shared_arw_s2mPipe_valid;
      end
      if(cmdGen_axi4Shared_w_s2mPipe_ready)begin
        cmdGen_axi4Shared_w_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_7)begin
        cmdGen_axi4Shared_w_s2mPipe_rValid <= cmdGen_axi4Shared_w_valid;
      end
      if(cmdGen_axi4Shared_w_s2mPipe_ready)begin
        cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rValid <= cmdGen_axi4Shared_w_s2mPipe_valid;
      end
      if(cmdGen_axi4SharedPipe_b_s2mPipe_ready)begin
        cmdGen_axi4SharedPipe_b_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_8)begin
        cmdGen_axi4SharedPipe_b_s2mPipe_rValid <= cmdGen_axi4SharedPipe_b_valid;
      end
      if(cmdGen_axi4SharedPipe_b_s2mPipe_ready)begin
        cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rValid <= cmdGen_axi4SharedPipe_b_s2mPipe_valid;
      end
      if(cmdGen_axi4SharedPipe_r_s2mPipe_ready)begin
        cmdGen_axi4SharedPipe_r_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_9)begin
        cmdGen_axi4SharedPipe_r_s2mPipe_rValid <= cmdGen_axi4SharedPipe_r_valid;
      end
      if(cmdGen_axi4SharedPipe_r_s2mPipe_ready)begin
        cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rValid <= cmdGen_axi4SharedPipe_r_s2mPipe_valid;
      end
      if((cmdGen_axi4SharedPipe_w_valid && cmdGen_axi4SharedPipe_w_ready))begin
        cmdGen_writeFirst <= cmdGen_axi4SharedPipe_w_payload_last;
      end
      respProc_readCycleCnt_value <= respProc_readCycleCnt_valueNext;
      if(_zz_5)begin
        respProc_readCycleCnt_value <= 8'h0;
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_6)begin
      cmdGen_axi4Shared_arw_s2mPipe_rData_addr <= cmdGen_axi4Shared_arw_payload_addr;
      cmdGen_axi4Shared_arw_s2mPipe_rData_id <= cmdGen_axi4Shared_arw_payload_id;
      cmdGen_axi4Shared_arw_s2mPipe_rData_len <= cmdGen_axi4Shared_arw_payload_len;
      cmdGen_axi4Shared_arw_s2mPipe_rData_size <= cmdGen_axi4Shared_arw_payload_size;
      cmdGen_axi4Shared_arw_s2mPipe_rData_burst <= cmdGen_axi4Shared_arw_payload_burst;
      cmdGen_axi4Shared_arw_s2mPipe_rData_user <= cmdGen_axi4Shared_arw_payload_user;
      cmdGen_axi4Shared_arw_s2mPipe_rData_write <= cmdGen_axi4Shared_arw_payload_write;
    end
    if(cmdGen_axi4Shared_arw_s2mPipe_ready)begin
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_addr <= cmdGen_axi4Shared_arw_s2mPipe_payload_addr;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_id <= cmdGen_axi4Shared_arw_s2mPipe_payload_id;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_len <= cmdGen_axi4Shared_arw_s2mPipe_payload_len;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_size <= cmdGen_axi4Shared_arw_s2mPipe_payload_size;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_burst <= cmdGen_axi4Shared_arw_s2mPipe_payload_burst;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_user <= cmdGen_axi4Shared_arw_s2mPipe_payload_user;
      cmdGen_axi4Shared_arw_s2mPipe_m2sPipe_rData_write <= cmdGen_axi4Shared_arw_s2mPipe_payload_write;
    end
    if(_zz_7)begin
      cmdGen_axi4Shared_w_s2mPipe_rData_data <= cmdGen_axi4Shared_w_payload_data;
      cmdGen_axi4Shared_w_s2mPipe_rData_strb <= cmdGen_axi4Shared_w_payload_strb;
      cmdGen_axi4Shared_w_s2mPipe_rData_user <= cmdGen_axi4Shared_w_payload_user;
      cmdGen_axi4Shared_w_s2mPipe_rData_last <= cmdGen_axi4Shared_w_payload_last;
    end
    if(cmdGen_axi4Shared_w_s2mPipe_ready)begin
      cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_data <= cmdGen_axi4Shared_w_s2mPipe_payload_data;
      cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_strb <= cmdGen_axi4Shared_w_s2mPipe_payload_strb;
      cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_user <= cmdGen_axi4Shared_w_s2mPipe_payload_user;
      cmdGen_axi4Shared_w_s2mPipe_m2sPipe_rData_last <= cmdGen_axi4Shared_w_s2mPipe_payload_last;
    end
    if(_zz_8)begin
      cmdGen_axi4SharedPipe_b_s2mPipe_rData_id <= cmdGen_axi4SharedPipe_b_payload_id;
      cmdGen_axi4SharedPipe_b_s2mPipe_rData_resp <= cmdGen_axi4SharedPipe_b_payload_resp;
      cmdGen_axi4SharedPipe_b_s2mPipe_rData_user <= cmdGen_axi4SharedPipe_b_payload_user;
    end
    if(cmdGen_axi4SharedPipe_b_s2mPipe_ready)begin
      cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_id <= cmdGen_axi4SharedPipe_b_s2mPipe_payload_id;
      cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_resp <= cmdGen_axi4SharedPipe_b_s2mPipe_payload_resp;
      cmdGen_axi4SharedPipe_b_s2mPipe_m2sPipe_rData_user <= cmdGen_axi4SharedPipe_b_s2mPipe_payload_user;
    end
    if(_zz_9)begin
      cmdGen_axi4SharedPipe_r_s2mPipe_rData_data <= cmdGen_axi4SharedPipe_r_payload_data;
      cmdGen_axi4SharedPipe_r_s2mPipe_rData_id <= cmdGen_axi4SharedPipe_r_payload_id;
      cmdGen_axi4SharedPipe_r_s2mPipe_rData_resp <= cmdGen_axi4SharedPipe_r_payload_resp;
      cmdGen_axi4SharedPipe_r_s2mPipe_rData_last <= cmdGen_axi4SharedPipe_r_payload_last;
      cmdGen_axi4SharedPipe_r_s2mPipe_rData_user <= cmdGen_axi4SharedPipe_r_payload_user;
    end
    if(cmdGen_axi4SharedPipe_r_s2mPipe_ready)begin
      cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_data <= cmdGen_axi4SharedPipe_r_s2mPipe_payload_data;
      cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_id <= cmdGen_axi4SharedPipe_r_s2mPipe_payload_id;
      cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_resp <= cmdGen_axi4SharedPipe_r_s2mPipe_payload_resp;
      cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_last <= cmdGen_axi4SharedPipe_r_s2mPipe_payload_last;
      cmdGen_axi4SharedPipe_r_s2mPipe_m2sPipe_rData_user <= cmdGen_axi4SharedPipe_r_s2mPipe_payload_user;
    end
  end


endmodule
