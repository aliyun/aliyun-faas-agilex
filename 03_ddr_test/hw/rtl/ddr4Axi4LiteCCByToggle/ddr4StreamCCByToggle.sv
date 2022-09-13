// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4StreamCCByToggle


module ddr4StreamCCByToggle (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [31:0]   io_input_payload_addr,
  input      [2:0]    io_input_payload_prot,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload_addr,
  output     [2:0]    io_output_payload_prot,
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
  reg        [31:0]   pushArea_data_addr;
  reg        [2:0]    pushArea_data_prot;
  wire                popArea_target;
  reg                 popArea_hit;
  wire                popArea_stream_valid;
  wire                popArea_stream_ready;
  wire       [31:0]   popArea_stream_payload_addr;
  wire       [2:0]    popArea_stream_payload_prot;
  wire                popArea_stream_m2sPipe_valid;
  wire                popArea_stream_m2sPipe_ready;
  wire       [31:0]   popArea_stream_m2sPipe_payload_addr;
  wire       [2:0]    popArea_stream_m2sPipe_payload_prot;
  reg                 popArea_stream_m2sPipe_rValid;
  reg        [31:0]   popArea_stream_m2sPipe_rData_addr;
  reg        [2:0]    popArea_stream_m2sPipe_rData_prot;

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
  assign popArea_stream_payload_addr = pushArea_data_addr;
  assign popArea_stream_payload_prot = pushArea_data_prot;
  assign popArea_stream_ready = ((1'b1 && (! popArea_stream_m2sPipe_valid)) || popArea_stream_m2sPipe_ready);
  assign popArea_stream_m2sPipe_valid = popArea_stream_m2sPipe_rValid;
  assign popArea_stream_m2sPipe_payload_addr = popArea_stream_m2sPipe_rData_addr;
  assign popArea_stream_m2sPipe_payload_prot = popArea_stream_m2sPipe_rData_prot;
  assign io_output_valid = popArea_stream_m2sPipe_valid;
  assign popArea_stream_m2sPipe_ready = io_output_ready;
  assign io_output_payload_addr = popArea_stream_m2sPipe_payload_addr;
  assign io_output_payload_prot = popArea_stream_m2sPipe_payload_prot;
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
      pushArea_data_addr <= io_input_payload_addr;
      pushArea_data_prot <= io_input_payload_prot;
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
      popArea_stream_m2sPipe_rData_addr <= popArea_stream_payload_addr;
      popArea_stream_m2sPipe_rData_prot <= popArea_stream_payload_prot;
    end
  end


endmodule
