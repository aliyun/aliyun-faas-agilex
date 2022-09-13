// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4_mmBufferCC


module ddr4_mmBufferCC (
  input      [3:0]    io_dataIn,
  output     [3:0]    io_dataOut,
  input               clkA_clk,
  input               clkA_reset
);
  reg        [3:0]    buffers_0;
  reg        [3:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge clkA_clk) begin
    if(clkA_reset) begin
      buffers_0 <= 4'b0000;
      buffers_1 <= 4'b0000;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
