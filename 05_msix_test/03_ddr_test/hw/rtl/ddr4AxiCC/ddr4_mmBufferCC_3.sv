// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4_mmBufferCC_3


module ddr4_mmBufferCC_3 (
  input      [9:0]    io_dataIn,
  output     [9:0]    io_dataOut,
  input               clkA_clk,
  input               clkA_reset
);
  reg        [9:0]    buffers_0;
  reg        [9:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge clkA_clk) begin
    if(clkA_reset) begin
      buffers_0 <= 10'h0;
      buffers_1 <= 10'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
