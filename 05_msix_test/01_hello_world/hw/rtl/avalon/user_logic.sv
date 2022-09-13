// Generator : SpinalHDL v1.5.0    git head : 83a031922866b078c411ec5529e00f1b6e79f8e7
// Component : user_logic
// Git hash  : 8f35d589e85fa17aeadd0f5b7f4f5a5dba5c7fcb
// Date      : 25/11/2021, 15:25:37


`define Response_defaultEncoding_type [1:0]
`define Response_defaultEncoding_OKAY 2'b00
`define Response_defaultEncoding_RESERVED 2'b01
`define Response_defaultEncoding_SLAVEERROR 2'b10
`define Response_defaultEncoding_DECODEERROR 2'b11


module user_logic (
  input               afu_pcie_core_clk,
  input               afu_pcie_core_rst,
  input               afu_sys_100m_clk,
  input               afu_sys_100m_rst,
  input               afu_user_clk,
  input               afu_user_rst,
  input               afu_user_div2_clk,
  input               afu_user_div2_rst,
  input               afu_c0_emif_clk,
  input               afu_c0_emif_user_rst,
  input               afu_c0_emif_init_done,
  input               afu_c1_emif_clk,
  input               afu_c1_emif_user_rst,
  input               afu_c1_emif_init_done,
  input               afu_c2_emif_clk,
  input               afu_c2_emif_user_rst,
  input               afu_c2_emif_init_done,
  input               afu_c3_emif_clk,
  input               afu_c3_emif_user_rst,
  input               afu_c3_emif_init_done,
  output              afu_c0_emif_avmm_read,
  output              afu_c0_emif_avmm_write,
  input               afu_c0_emif_avmm_waitRequest,
  output     [31:0]   afu_c0_emif_avmm_address,
  output     [6:0]    afu_c0_emif_avmm_burstCount,
  output     [63:0]   afu_c0_emif_avmm_byteEnable,
  output     [511:0]  afu_c0_emif_avmm_writeData,
  input               afu_c0_emif_avmm_readDataValid,
  input      [511:0]  afu_c0_emif_avmm_readData,
  output              afu_c1_emif_avmm_read,
  output              afu_c1_emif_avmm_write,
  input               afu_c1_emif_avmm_waitRequest,
  output     [31:0]   afu_c1_emif_avmm_address,
  output     [6:0]    afu_c1_emif_avmm_burstCount,
  output     [63:0]   afu_c1_emif_avmm_byteEnable,
  output     [511:0]  afu_c1_emif_avmm_writeData,
  input               afu_c1_emif_avmm_readDataValid,
  input      [511:0]  afu_c1_emif_avmm_readData,
  output              afu_c2_emif_avmm_read,
  output              afu_c2_emif_avmm_write,
  input               afu_c2_emif_avmm_waitRequest,
  output     [31:0]   afu_c2_emif_avmm_address,
  output     [6:0]    afu_c2_emif_avmm_burstCount,
  output     [63:0]   afu_c2_emif_avmm_byteEnable,
  output     [511:0]  afu_c2_emif_avmm_writeData,
  input               afu_c2_emif_avmm_readDataValid,
  input      [511:0]  afu_c2_emif_avmm_readData,
  output              afu_c3_emif_avmm_read,
  output              afu_c3_emif_avmm_write,
  input               afu_c3_emif_avmm_waitRequest,
  output     [31:0]   afu_c3_emif_avmm_address,
  output     [6:0]    afu_c3_emif_avmm_burstCount,
  output     [63:0]   afu_c3_emif_avmm_byteEnable,
  output     [511:0]  afu_c3_emif_avmm_writeData,
  input               afu_c3_emif_avmm_readDataValid,
  input      [511:0]  afu_c3_emif_avmm_readData,
  output              afu_data_avmm_read,
  output              afu_data_avmm_write,
  input               afu_data_avmm_waitRequest,
  output              afu_data_avmm_lock,
  output     [63:0]   afu_data_avmm_address,
  output              afu_data_avmm_beginbursttransfer,
  output     [6:0]    afu_data_avmm_burstCount,
  output     [63:0]   afu_data_avmm_byteEnable,
  output     [511:0]  afu_data_avmm_writeData,
  input      `Response_defaultEncoding_type afu_data_avmm_response,
  input               afu_data_avmm_readDataValid,
  input      [511:0]  afu_data_avmm_readData,
  input               afu_mmio_avmm_read,
  input               afu_mmio_avmm_write,
  output              afu_mmio_avmm_waitRequest,
  input      [31:0]   afu_mmio_avmm_address,
  input      [7:0]    afu_mmio_avmm_byteEnable,
  input      [63:0]   afu_mmio_avmm_writeData,
  output              afu_mmio_avmm_readDataValid,
  output     [63:0]   afu_mmio_avmm_readData,
  output              user_msix_valid,
  input               user_msix_ready,
  output     [4:0]    user_msix_payload_vec,
  output     [7:0]    user_msix_payload_func
);
  reg        [63:0]   PCIeCD_DFH;
  wire       [127:0]  PCIeCD_UUID;
  reg        [63:0]   PCIeCD_targetAddr;
  reg                 PCIeCD_start;
  reg                 PCIeCD_done;
  wire                PCIeCD_mmioFactory_readAtCmd_valid;
  reg        [63:0]   PCIeCD_mmioFactory_readAtCmd_payload;
  reg                 PCIeCD_mmioFactory_readAtRsp_valid;
  reg        [63:0]   PCIeCD_mmioFactory_readAtRsp_payload;
  wire                PCIeCD_mmioFactory_doWrite;
  wire                PCIeCD_mmioFactory_doRead;
  wire       [127:0]  _zz_PCIeCD_mmioFactory_readAtCmd_payload;
  wire                when_hello_world_l105;
  wire                when_hello_world_l108;
  wire                when_BusSlaveFactory_l925;
  wire                when_BusSlaveFactory_l925_1;
  wire                when_BusSlaveFactory_l925_2;
  wire                when_BusSlaveFactory_l925_3;
  wire                when_BusSlaveFactory_l925_4;
  wire                when_BusSlaveFactory_l925_5;
  wire                when_BusSlaveFactory_l925_6;
  wire                when_BusSlaveFactory_l925_7;
  wire                when_BusSlaveFactory_l925_8;
  wire                when_AvalonMmSlaveFactory_l54;
  wire                when_AvalonMmSlaveFactory_l54_1;
  `ifndef SYNTHESIS
  reg [87:0] afu_data_avmm_response_string;
  `endif

  function [63:0] zz_PCIeCD_DFH(input dummy);
    begin
      zz_PCIeCD_DFH = 64'h0;
      zz_PCIeCD_DFH[60] = 1'b1;
      zz_PCIeCD_DFH[40] = 1'b1;
    end
  endfunction
  wire [63:0] _zz_1;

  `ifndef SYNTHESIS
  always @(*) begin
    case(afu_data_avmm_response)
      `Response_defaultEncoding_OKAY : afu_data_avmm_response_string = "OKAY       ";
      `Response_defaultEncoding_RESERVED : afu_data_avmm_response_string = "RESERVED   ";
      `Response_defaultEncoding_SLAVEERROR : afu_data_avmm_response_string = "SLAVEERROR ";
      `Response_defaultEncoding_DECODEERROR : afu_data_avmm_response_string = "DECODEERROR";
      default : afu_data_avmm_response_string = "???????????";
    endcase
  end
  `endif

  assign afu_c0_emif_avmm_read = 1'b0;
  assign afu_c0_emif_avmm_write = 1'b0;
  assign afu_c0_emif_avmm_address = 32'h0;
  assign afu_c0_emif_avmm_burstCount = 7'h0;
  assign afu_c0_emif_avmm_byteEnable = 64'h0;
  assign afu_c0_emif_avmm_writeData = 512'h0;
  assign afu_c1_emif_avmm_read = 1'b0;
  assign afu_c1_emif_avmm_write = 1'b0;
  assign afu_c1_emif_avmm_address = 32'h0;
  assign afu_c1_emif_avmm_burstCount = 7'h0;
  assign afu_c1_emif_avmm_byteEnable = 64'h0;
  assign afu_c1_emif_avmm_writeData = 512'h0;
  assign afu_c2_emif_avmm_read = 1'b0;
  assign afu_c2_emif_avmm_write = 1'b0;
  assign afu_c2_emif_avmm_address = 32'h0;
  assign afu_c2_emif_avmm_burstCount = 7'h0;
  assign afu_c2_emif_avmm_byteEnable = 64'h0;
  assign afu_c2_emif_avmm_writeData = 512'h0;
  assign afu_c3_emif_avmm_read = 1'b0;
  assign afu_c3_emif_avmm_write = 1'b0;
  assign afu_c3_emif_avmm_address = 32'h0;
  assign afu_c3_emif_avmm_burstCount = 7'h0;
  assign afu_c3_emif_avmm_byteEnable = 64'h0;
  assign afu_c3_emif_avmm_writeData = 512'h0;
  assign _zz_1 = zz_PCIeCD_DFH(1'b0);
  always @(*) PCIeCD_DFH = _zz_1;
  assign PCIeCD_UUID = 128'hc6aa954a9b914a37abc11d9f0709dcc3;
  assign afu_mmio_avmm_waitRequest = 1'b0;
  assign PCIeCD_mmioFactory_doWrite = ((! afu_mmio_avmm_waitRequest) && afu_mmio_avmm_write);
  assign PCIeCD_mmioFactory_doRead = ((! afu_mmio_avmm_waitRequest) && afu_mmio_avmm_read);
  assign afu_mmio_avmm_readDataValid = PCIeCD_mmioFactory_readAtRsp_valid;
  assign afu_mmio_avmm_readData = PCIeCD_mmioFactory_readAtRsp_payload;
  assign PCIeCD_mmioFactory_readAtCmd_valid = PCIeCD_mmioFactory_doRead;
  always @(*) begin
    PCIeCD_mmioFactory_readAtCmd_payload = 64'h0;
    case(afu_mmio_avmm_address)
      32'h0 : begin
        PCIeCD_mmioFactory_readAtCmd_payload[63 : 0] = PCIeCD_DFH;
      end
      32'h00000003 : begin
        PCIeCD_mmioFactory_readAtCmd_payload[63 : 0] = PCIeCD_targetAddr;
      end
      32'h00000004 : begin
        PCIeCD_mmioFactory_readAtCmd_payload[0 : 0] = PCIeCD_start;
      end
      32'h00000005 : begin
        PCIeCD_mmioFactory_readAtCmd_payload[0 : 0] = PCIeCD_done;
      end
      default : begin
      end
    endcase
    if(when_AvalonMmSlaveFactory_l54) begin
      PCIeCD_mmioFactory_readAtCmd_payload[63 : 0] = _zz_PCIeCD_mmioFactory_readAtCmd_payload[63 : 0];
    end
    if(when_AvalonMmSlaveFactory_l54_1) begin
      PCIeCD_mmioFactory_readAtCmd_payload[63 : 0] = _zz_PCIeCD_mmioFactory_readAtCmd_payload[127 : 64];
    end
  end

  assign _zz_PCIeCD_mmioFactory_readAtCmd_payload = PCIeCD_UUID;
  assign afu_data_avmm_read = 1'b0;
  assign afu_data_avmm_write = PCIeCD_start;
  assign afu_data_avmm_lock = 1'b0;
  assign afu_data_avmm_address = (PCIeCD_targetAddr >>> 6);
  assign afu_data_avmm_beginbursttransfer = PCIeCD_start;
  assign afu_data_avmm_burstCount = 7'h01;
  assign afu_data_avmm_byteEnable = 64'h0000000001ffffff;
  assign afu_data_avmm_writeData = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000061626162696c41206d6f72462021646c726f77206f6c6c6548;
  assign when_hello_world_l105 = (afu_data_avmm_write && (! afu_data_avmm_waitRequest));
  assign when_hello_world_l108 = (afu_data_avmm_write && afu_data_avmm_waitRequest);
  assign user_msix_valid = 1'b0;
  assign user_msix_payload_func = 8'h0;
  assign user_msix_payload_vec = 5'h0;
  assign when_BusSlaveFactory_l925 = afu_mmio_avmm_byteEnable[0];
  assign when_BusSlaveFactory_l925_1 = afu_mmio_avmm_byteEnable[1];
  assign when_BusSlaveFactory_l925_2 = afu_mmio_avmm_byteEnable[2];
  assign when_BusSlaveFactory_l925_3 = afu_mmio_avmm_byteEnable[3];
  assign when_BusSlaveFactory_l925_4 = afu_mmio_avmm_byteEnable[4];
  assign when_BusSlaveFactory_l925_5 = afu_mmio_avmm_byteEnable[5];
  assign when_BusSlaveFactory_l925_6 = afu_mmio_avmm_byteEnable[6];
  assign when_BusSlaveFactory_l925_7 = afu_mmio_avmm_byteEnable[7];
  assign when_BusSlaveFactory_l925_8 = afu_mmio_avmm_byteEnable[0];
  assign when_AvalonMmSlaveFactory_l54 = ((afu_mmio_avmm_address & (~ 32'h0)) == 32'h00000001);
  assign when_AvalonMmSlaveFactory_l54_1 = ((afu_mmio_avmm_address & (~ 32'h0)) == 32'h00000002);
  always @(posedge afu_pcie_core_clk) begin
    if(afu_pcie_core_rst) begin
      PCIeCD_start <= 1'b0;
      PCIeCD_done <= 1'b0;
      PCIeCD_mmioFactory_readAtRsp_valid <= 1'b0;
    end else begin
      PCIeCD_mmioFactory_readAtRsp_valid <= PCIeCD_mmioFactory_readAtCmd_valid;
      if(when_hello_world_l105) begin
        PCIeCD_done <= 1'b1;
        PCIeCD_start <= 1'b0;
      end else begin
        if(when_hello_world_l108) begin
          PCIeCD_done <= 1'b0;
        end
      end
      case(afu_mmio_avmm_address)
        32'h00000004 : begin
          if(PCIeCD_mmioFactory_doWrite) begin
            if(when_BusSlaveFactory_l925_8) begin
              PCIeCD_start <= afu_mmio_avmm_writeData[0];
            end
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge afu_pcie_core_clk) begin
    PCIeCD_mmioFactory_readAtRsp_payload <= PCIeCD_mmioFactory_readAtCmd_payload;
    case(afu_mmio_avmm_address)
      32'h00000003 : begin
        if(PCIeCD_mmioFactory_doWrite) begin
          if(when_BusSlaveFactory_l925) begin
            PCIeCD_targetAddr[7 : 0] <= afu_mmio_avmm_writeData[7 : 0];
          end
          if(when_BusSlaveFactory_l925_1) begin
            PCIeCD_targetAddr[15 : 8] <= afu_mmio_avmm_writeData[15 : 8];
          end
          if(when_BusSlaveFactory_l925_2) begin
            PCIeCD_targetAddr[23 : 16] <= afu_mmio_avmm_writeData[23 : 16];
          end
          if(when_BusSlaveFactory_l925_3) begin
            PCIeCD_targetAddr[31 : 24] <= afu_mmio_avmm_writeData[31 : 24];
          end
          if(when_BusSlaveFactory_l925_4) begin
            PCIeCD_targetAddr[39 : 32] <= afu_mmio_avmm_writeData[39 : 32];
          end
          if(when_BusSlaveFactory_l925_5) begin
            PCIeCD_targetAddr[47 : 40] <= afu_mmio_avmm_writeData[47 : 40];
          end
          if(when_BusSlaveFactory_l925_6) begin
            PCIeCD_targetAddr[55 : 48] <= afu_mmio_avmm_writeData[55 : 48];
          end
          if(when_BusSlaveFactory_l925_7) begin
            PCIeCD_targetAddr[63 : 56] <= afu_mmio_avmm_writeData[63 : 56];
          end
        end
      end
      default : begin
      end
    endcase
  end


endmodule
