// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4StreamCCByToggle_1


module ddr4StreamCCByToggle_1 (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [63:0]   io_input_payload_data,
  input      [3:0]    io_input_payload_strb,
  output              io_output_valid,
  input               io_output_ready,
  output     [63:0]   io_output_payload_data,
  output     [3:0]    io_output_payload_strb,
  input               clkA_clk,
  input               clkA_reset,
  input               clkB_clk,
  input               clkB_reset
);
  wire                outHitSignal_buffercc_io_dataOut;
  wire                pushArea_target_buffercc_io_dataOut;
  wire                _zz_1;
  wire                outHitSignal;
  wire                pushArea_hit;
  reg                 pushArea_target;
  reg        [63:0]   pushArea_data_data;
  reg        [3:0]    pushArea_data_strb;
  wire                popArea_target;
  reg                 popArea_hit;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [63:0]   popArea_stream_payload_data;
  wire       [3:0]    popArea_stream_payload_strb;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [63:0]   popArea_stream_m2sPipe_payload_data;
  wire       [3:0]    popArea_stream_m2sPipe_payload_strb;
  reg                 popArea_stream_m2sPipe_rValid;
  reg        [63:0]   popArea_stream_m2sPipe_rData_data;
  reg        [3:0]    popArea_stream_m2sPipe_rData_strb;

  assign _zz_1 = (io_input_valid && (pushArea_hit == pushArea_target));
  ddr4BufferCC outHitSignal_buffercc (
    .io_dataIn     (outHitSignal                      ), //i
    .io_dataOut    (outHitSignal_buffercc_io_dataOut  ), //o
    .clkA_clk      (clkA_clk                          ), //i
    .clkA_reset    (clkA_reset                        )  //i
  );
  ddr4BufferCC_1 pushArea_target_buffercc (
    .io_dataIn     (pushArea_target                      ), //i
    .io_dataOut    (pushArea_target_buffercc_io_dataOut  ), //o
    .clkB_clk      (clkB_clk                             ), //i
    .clkB_reset    (clkB_reset                           )  //i
  );
  assign pushArea_hit = outHitSignal_buffercc_io_dataOut;
  always @ (*) begin
    io_input_ready = 1'b0;
    if(_zz_1)begin
      io_input_ready = 1'b1;
    end
  end

  assign popArea_target = pushArea_target_buffercc_io_dataOut;
  assign outHitSignal = popArea_hit;
  assign popArea_stream_valid = (popArea_target != popArea_hit);
  assign popArea_stream_payload_data = pushArea_data_data;
  assign popArea_stream_payload_strb = pushArea_data_strb;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_m2sPipe_rValid;
  assign popArea_stream_m2sPipe_payload_data = popArea_stream_m2sPipe_rData_data;
  assign popArea_stream_m2sPipe_payload_strb = popArea_stream_m2sPipe_rData_strb;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_data = popArea_stream_m2sPipe_payload_data;
  assign io_output_payload_strb = popArea_stream_m2sPipe_payload_strb;
  always @ (posedge clkA_clk) begin
    if(clkA_reset) begin
      pushArea_target <= 1'b0;
    end else begin
      if(_zz_1)begin
        pushArea_target <= (! pushArea_target);
      end
    end
  end

  always @ (posedge clkA_clk) begin
    if(_zz_1)begin
      pushArea_data_data <= io_input_payload_data;
      pushArea_data_strb <= io_input_payload_strb;
    end
  end

  always @ (posedge clkB_clk) begin
    if(clkB_reset) begin
      popArea_hit <= 1'b0;
      popArea_stream_m2sPipe_rValid <= 1'b0;
    end else begin
      if((popArea_stream_valid && popArea_stream_ready))begin
        popArea_hit <= (! popArea_hit);
      end
      if(popArea_stream_ready)begin
        popArea_stream_m2sPipe_rValid <= popArea_stream_valid;
      end
    end
  end

  always @ (posedge clkB_clk) begin
    if(popArea_stream_ready)begin
      popArea_stream_m2sPipe_rData_data <= popArea_stream_payload_data;
      popArea_stream_m2sPipe_rData_strb <= popArea_stream_payload_strb;
    end
  end


endmodule
