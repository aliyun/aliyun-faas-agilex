// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4mmStreamSfifo_2


module ddr4mmStreamSfifo_2 (
  input               push_valid,
  output              push_ready,
  input      [511:0]  push_payload,
  output              pop_valid,
  input               pop_ready,
  output     [511:0]  pop_payload,
  output              stats_empty,
  output              stats_afull,
  output              stats_aempty,
  output              stats_full,
  output              stats_overflow,
  output              stats_underflow,
  output     [1:0]    stats_eccState,
  output     [9:0]    occupancy,
  output     [9:0]    availability,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                streamFifo_io_push_ready;
  wire                streamFifo_io_pop_valid;
  wire       [511:0]  streamFifo_io_pop_payload;
  wire       [9:0]    streamFifo_io_occupancy;
  wire       [9:0]    streamFifo_io_availability;
  wire                streamFifo__zz_3;
  wire                streamFifo__zz_4;

  ddr4mmStreamFifo_2 streamFifo (
    .io_push_valid      (push_valid                        ), //i
    .io_push_ready      (streamFifo_io_push_ready          ), //o
    .io_push_payload    (push_payload[511:0]               ), //i
    .io_pop_valid       (streamFifo_io_pop_valid           ), //o
    .io_pop_ready       (pop_ready                         ), //i
    .io_pop_payload     (streamFifo_io_pop_payload[511:0]  ), //o
    .io_flush           (_zz_1                             ), //i
    .io_occupancy       (streamFifo_io_occupancy[9:0]      ), //o
    .io_availability    (streamFifo_io_availability[9:0]   ), //o
    ._zz_3              (streamFifo__zz_3                  ), //o
    ._zz_4              (streamFifo__zz_4                  ), //o
    .clk                (clk                               ), //i
    .reset              (reset                             )  //i
  );
  assign push_ready = streamFifo_io_push_ready;
  assign pop_valid = streamFifo_io_pop_valid;
  assign pop_payload = streamFifo_io_pop_payload;
  assign stats_full = streamFifo__zz_3;
  assign stats_empty = streamFifo__zz_4;
  assign stats_afull = (10'h1e0 < streamFifo_io_occupancy);
  assign stats_aempty = (streamFifo_io_availability < 10'h00a);
  assign stats_eccState = 2'b00;
  assign stats_overflow = 1'b0;
  assign stats_underflow = 1'b0;
  assign occupancy = streamFifo_io_occupancy;
  assign availability = streamFifo_io_availability;
  assign _zz_1 = 1'b0;

endmodule
