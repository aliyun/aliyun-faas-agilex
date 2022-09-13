// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4_mmStreamFifoCC_4


module ddr4_mmStreamFifoCC_4 (
  input               io_push_valid,
  output              io_push_ready,
  input      [3:0]    io_push_payload_id,
  input      [1:0]    io_push_payload_resp,
  input      [15:0]   io_push_payload_user,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [3:0]    io_pop_payload_id,
  output     [1:0]    io_pop_payload_resp,
  output     [15:0]   io_pop_payload_user,
  output     [3:0]    io_pushOccupancy,
  output     [3:0]    io_popOccupancy,
  input               clkB_clk,
  input               clkB_reset,
  input               clkA_clk,
  input               clkA_reset
);
  reg        [21:0]   _zz_10;
  wire       [3:0]    popToPushGray_buffercc_io_dataOut;
  wire       [3:0]    pushToPopGray_buffercc_io_dataOut;
  wire                _zz_11;
  wire       [3:0]    _zz_12;
  wire       [2:0]    _zz_13;
  wire       [3:0]    _zz_14;
  wire       [2:0]    _zz_15;
  wire       [21:0]   _zz_16;
  wire                _zz_17;
  reg                 _zz_1;
  wire       [3:0]    popToPushGray;
  wire       [3:0]    pushToPopGray;
  reg        [3:0]    pushCC_pushPtr;
  wire       [3:0]    pushCC_pushPtrPlus;
  reg        [3:0]    pushCC_pushPtrGray;
  wire       [3:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  reg        [3:0]    popCC_popPtr;
  wire       [3:0]    popCC_popPtrPlus;
  reg        [3:0]    popCC_popPtrGray;
  wire       [3:0]    popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [3:0]    _zz_5;
  wire       [21:0]   _zz_6;
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  reg [21:0] ram [0:7];

  assign _zz_11 = (io_push_valid && io_push_ready);
  assign _zz_12 = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_13 = pushCC_pushPtr[2:0];
  assign _zz_14 = (popCC_popPtrPlus >>> 1'b1);
  assign _zz_15 = _zz_5[2:0];
  assign _zz_16 = {io_push_payload_user,{io_push_payload_resp,io_push_payload_id}};
  assign _zz_17 = 1'b1;
  always @ (posedge clkB_clk) begin
    if(_zz_1) begin
      ram[_zz_13] <= _zz_16;
    end
  end

  always @ (posedge clkA_clk) begin
    if(_zz_17) begin
      _zz_10 <= ram[_zz_15];
    end
  end

  ddr4_mmBufferCC_1 popToPushGray_buffercc (
    .io_dataIn     (popToPushGray[3:0]                      ), //i
    .io_dataOut    (popToPushGray_buffercc_io_dataOut[3:0]  ), //o
    .clkB_clk      (clkB_clk                                ), //i
    .clkB_reset    (clkB_reset                              )  //i
  );
  ddr4_mmBufferCC pushToPopGray_buffercc (
    .io_dataIn     (pushToPopGray[3:0]                      ), //i
    .io_dataOut    (pushToPopGray_buffercc_io_dataOut[3:0]  ), //o
    .clkA_clk      (clkA_clk                                ), //i
    .clkA_reset    (clkA_reset                              )  //i
  );
  always @ (*) begin
    _zz_1 = 1'b0;
    if(_zz_11)begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 4'b0001);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[3 : 2] == (~ pushCC_popPtrGray[3 : 2])) && (pushCC_pushPtrGray[1 : 0] == pushCC_popPtrGray[1 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign _zz_2 = (pushCC_popPtrGray[1] ^ _zz_3);
  assign _zz_3 = (pushCC_popPtrGray[2] ^ _zz_4);
  assign _zz_4 = pushCC_popPtrGray[3];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_4,{_zz_3,{_zz_2,(pushCC_popPtrGray[0] ^ _zz_2)}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 4'b0001);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_5 = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_6 = _zz_10;
  assign io_pop_payload_id = _zz_6[3 : 0];
  assign io_pop_payload_resp = _zz_6[5 : 4];
  assign io_pop_payload_user = _zz_6[21 : 6];
  assign _zz_7 = (popCC_pushPtrGray[1] ^ _zz_8);
  assign _zz_8 = (popCC_pushPtrGray[2] ^ _zz_9);
  assign _zz_9 = popCC_pushPtrGray[3];
  assign io_popOccupancy = ({_zz_9,{_zz_8,{_zz_7,(popCC_pushPtrGray[0] ^ _zz_7)}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @ (posedge clkB_clk) begin
    if(clkB_reset) begin
      pushCC_pushPtr <= 4'b0000;
      pushCC_pushPtrGray <= 4'b0000;
    end else begin
      if((io_push_valid && io_push_ready))begin
        pushCC_pushPtrGray <= (_zz_12 ^ pushCC_pushPtrPlus);
      end
      if(_zz_11)begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @ (posedge clkA_clk) begin
    if(clkA_reset) begin
      popCC_popPtr <= 4'b0000;
      popCC_popPtrGray <= 4'b0000;
    end else begin
      if((io_pop_valid && io_pop_ready))begin
        popCC_popPtrGray <= (_zz_14 ^ popCC_popPtrPlus);
      end
      if((io_pop_valid && io_pop_ready))begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule
