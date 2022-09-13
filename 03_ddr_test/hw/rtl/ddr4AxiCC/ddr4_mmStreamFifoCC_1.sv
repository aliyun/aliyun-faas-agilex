// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ddr4_mmStreamFifoCC_1


module ddr4_mmStreamFifoCC_1 (
  input               io_push_valid,
  output              io_push_ready,
  input      [511:0]  io_push_payload_data,
  input      [3:0]    io_push_payload_id,
  input      [1:0]    io_push_payload_resp,
  input               io_push_payload_last,
  input      [15:0]   io_push_payload_user,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [511:0]  io_pop_payload_data,
  output     [3:0]    io_pop_payload_id,
  output     [1:0]    io_pop_payload_resp,
  output              io_pop_payload_last,
  output     [15:0]   io_pop_payload_user,
  output     [9:0]    io_pushOccupancy,
  output     [9:0]    io_popOccupancy,
  input               clkB_clk,
  input               clkB_reset,
  input               clkA_clk,
  input               clkA_reset
);
  reg        [534:0]  _zz_22;
  wire       [9:0]    popToPushGray_buffercc_io_dataOut;
  wire       [9:0]    pushToPopGray_buffercc_io_dataOut;
  wire                _zz_23;
  wire       [9:0]    _zz_24;
  wire       [8:0]    _zz_25;
  wire       [9:0]    _zz_26;
  wire       [8:0]    _zz_27;
  wire       [0:0]    _zz_28;
  wire       [534:0]  _zz_29;
  wire                _zz_30;
  wire                _zz_31;
  wire                _zz_32;
  reg                 _zz_1;
  wire       [9:0]    popToPushGray;
  wire       [9:0]    pushToPopGray;
  reg        [9:0]    pushCC_pushPtr;
  wire       [9:0]    pushCC_pushPtrPlus;
  reg        [9:0]    pushCC_pushPtrGray;
  wire       [9:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire                _zz_10;
  reg        [9:0]    popCC_popPtr;
  wire       [9:0]    popCC_popPtrPlus;
  reg        [9:0]    popCC_popPtrGray;
  wire       [9:0]    popCC_pushPtrGray;
  wire                popCC_empty;
  wire       [9:0]    _zz_11;
  wire       [534:0]  _zz_12;
  wire                _zz_13;
  wire                _zz_14;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire                _zz_18;
  wire                _zz_19;
  wire                _zz_20;
  wire                _zz_21;
  reg [534:0] ram [0:511];

  assign _zz_23 = (io_push_valid && io_push_ready);
  assign _zz_24 = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_25 = pushCC_pushPtr[8:0];
  assign _zz_26 = (popCC_popPtrPlus >>> 1'b1);
  assign _zz_27 = _zz_11[8:0];
  assign _zz_28 = _zz_12[518 : 518];
  assign _zz_29 = {io_push_payload_user,{io_push_payload_last,{io_push_payload_resp,{io_push_payload_id,io_push_payload_data}}}};
  assign _zz_30 = 1'b1;
  assign _zz_31 = pushCC_popPtrGray[0];
  assign _zz_32 = (popCC_pushPtrGray[0] ^ _zz_13);
  always @ (posedge clkB_clk) begin
    if(_zz_1) begin
      ram[_zz_25] <= _zz_29;
    end
  end

  always @ (posedge clkA_clk) begin
    if(_zz_30) begin
      _zz_22 <= ram[_zz_27];
    end
  end

  ddr4_mmBufferCC_2 popToPushGray_buffercc (
    .io_dataIn     (popToPushGray[9:0]                      ), //i
    .io_dataOut    (popToPushGray_buffercc_io_dataOut[9:0]  ), //o
    .clkB_clk      (clkB_clk                                ), //i
    .clkB_reset    (clkB_reset                              )  //i
  );
  ddr4_mmBufferCC_3 pushToPopGray_buffercc (
    .io_dataIn     (pushToPopGray[9:0]                      ), //i
    .io_dataOut    (pushToPopGray_buffercc_io_dataOut[9:0]  ), //o
    .clkA_clk      (clkA_clk                                ), //i
    .clkA_reset    (clkA_reset                              )  //i
  );
  always @ (*) begin
    _zz_1 = 1'b0;
    if(_zz_23)begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 10'h001);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[9 : 8] == (~ pushCC_popPtrGray[9 : 8])) && (pushCC_pushPtrGray[7 : 0] == pushCC_popPtrGray[7 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign _zz_2 = (pushCC_popPtrGray[1] ^ _zz_3);
  assign _zz_3 = (pushCC_popPtrGray[2] ^ _zz_4);
  assign _zz_4 = (pushCC_popPtrGray[3] ^ _zz_5);
  assign _zz_5 = (pushCC_popPtrGray[4] ^ _zz_6);
  assign _zz_6 = (pushCC_popPtrGray[5] ^ _zz_7);
  assign _zz_7 = (pushCC_popPtrGray[6] ^ _zz_8);
  assign _zz_8 = (pushCC_popPtrGray[7] ^ _zz_9);
  assign _zz_9 = (pushCC_popPtrGray[8] ^ _zz_10);
  assign _zz_10 = pushCC_popPtrGray[9];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_10,{_zz_9,{_zz_8,{_zz_7,{_zz_6,{_zz_5,{_zz_4,{_zz_3,{_zz_2,(_zz_31 ^ _zz_2)}}}}}}}}});
  assign popCC_popPtrPlus = (popCC_popPtr + 10'h001);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign io_pop_valid = (! popCC_empty);
  assign _zz_11 = ((io_pop_valid && io_pop_ready) ? popCC_popPtrPlus : popCC_popPtr);
  assign _zz_12 = _zz_22;
  assign io_pop_payload_data = _zz_12[511 : 0];
  assign io_pop_payload_id = _zz_12[515 : 512];
  assign io_pop_payload_resp = _zz_12[517 : 516];
  assign io_pop_payload_last = _zz_28[0];
  assign io_pop_payload_user = _zz_12[534 : 519];
  assign _zz_13 = (popCC_pushPtrGray[1] ^ _zz_14);
  assign _zz_14 = (popCC_pushPtrGray[2] ^ _zz_15);
  assign _zz_15 = (popCC_pushPtrGray[3] ^ _zz_16);
  assign _zz_16 = (popCC_pushPtrGray[4] ^ _zz_17);
  assign _zz_17 = (popCC_pushPtrGray[5] ^ _zz_18);
  assign _zz_18 = (popCC_pushPtrGray[6] ^ _zz_19);
  assign _zz_19 = (popCC_pushPtrGray[7] ^ _zz_20);
  assign _zz_20 = (popCC_pushPtrGray[8] ^ _zz_21);
  assign _zz_21 = popCC_pushPtrGray[9];
  assign io_popOccupancy = ({_zz_21,{_zz_20,{_zz_19,{_zz_18,{_zz_17,{_zz_16,{_zz_15,{_zz_14,{_zz_13,_zz_32}}}}}}}}} - popCC_popPtr);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_popPtrGray;
  always @ (posedge clkB_clk) begin
    if(clkB_reset) begin
      pushCC_pushPtr <= 10'h0;
      pushCC_pushPtrGray <= 10'h0;
    end else begin
      if((io_push_valid && io_push_ready))begin
        pushCC_pushPtrGray <= (_zz_24 ^ pushCC_pushPtrPlus);
      end
      if(_zz_23)begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @ (posedge clkA_clk) begin
    if(clkA_reset) begin
      popCC_popPtr <= 10'h0;
      popCC_popPtrGray <= 10'h0;
    end else begin
      if((io_pop_valid && io_pop_ready))begin
        popCC_popPtrGray <= (_zz_26 ^ popCC_popPtrPlus);
      end
      if((io_pop_valid && io_pop_ready))begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
    end
  end


endmodule
