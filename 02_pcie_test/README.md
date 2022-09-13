The list of register:

      RSV                     = 32'h2020_0918;
      CMD_FIFO_MODE           = 32'h0;
      CMD_COPY_MODE           = 32'h1;
      WR_PFER_MODE            = 32'h2;
      RD_PFER_MODE            = 32'h3;


      AFU_DFH                 = 64'h0000_0000_0000_0000;
      AFU_ID_L                = 64'h0000_0000_0000_0008;
      AFU_ID_H                = 64'h0000_0000_0000_0010;

      ADDR_RSV                = 16'h0018;
      ADDR_WORK_MODE          = 16'h0020;
      ADDR_WORK_EN            = 16'h0028;
      ADDR_WORK_STOP          = 16'h0030;
      ADDR_WR_TEST_NUM        = 16'h0038;
      ADDR_WR_ADDR_H          = 16'h0040;
      ADDR_WR_ADDR_L          = 16'h0048;
      ADDR_WR_LEN             = 16'h0050;  
      ADDR_RD_TEST_NUM        = 16'h0058; 
      ADDR_RD_ADDR_H          = 16'h0060;
      ADDR_RD_ADDR_L          = 16'h0068;
      ADDR_RD_LEN             = 16'h0070;
      ADDR_FUNCTION_NUM       = 16'h0078;
      ADDR_RD_DATA_STORAGE    = 16'h0080;
      ADDR_RD_DATA_CLEAR      = 16'h0088;
      ADDR_RD_DATA            = 16'h0090;

      ADDR_FIFO_CMD_NUM       = 16'h0098; 
      ADDR_FIFO_STATUS        = 16'h00a0;
      ADDR_WR_TIME_COST_H     = 16'h00a8;
      ADDR_WR_TIME_COST_L     = 16'h00b0;
      ADDR_RD_TIME_COST_H     = 16'h00b8;
      ADDR_RD_TIME_COST_L     = 16'h00c0;
      ADDR_RD_TIME_DELAY      = 16'h00c8;
      ADDR_WR_SEND_CNT_H      = 16'h00d0;
      ADDR_WR_SEND_CNT_L      = 16'h00d8;
      ADDR_RD_SEND_CNT_H      = 16'h00e0;
      ADDR_RD_SEND_CNT_L      = 16'h00e8;
      ADDR_RD_TOTAL_TIME_H    = 16'h00f0;
      ADDR_RD_TOTAL_TIME_L    = 16'h00f8;

      ADDR_COPY_WR_ADDR_H     = 16'h0100;
      ADDR_COPY_WR_ADDR_L     = 16'h0108;
      ADDR_COPY_RD_ADDR_H     = 16'h0110;
      ADDR_COPY_RD_ADDR_L     = 16'h0118;
      ADDR_COPY_SIZE          = 16'h0120;
      ADDR_COPY_MODE          = 16'h0128;
      ADDR_COPY_SEED          = 16'h0130;
      ADDR_COPY_STATUS        = 16'h0138;
      ADDR_COPY_TIME_COST     = 16'h0140;
                                               
      ADDR_STAT               = 16'h0148;
      ADDR_FIFO_STAT_0        = 16'h0150;
      ADDR_FIFO_STAT_1        = 16'h0158;
      ADDR_FIFO_STAT_2        = 16'h0160;
      ADDR_FIFO_STAT_3        = 16'h0168;
      ADDR_FIFO_STAT          = 16'h0170;
      ADDR_COPY_CNT           = 16'h0178;
      ADDR_AXI_CMD_CNT        = 16'h0180;
      ADDR_AXI_WR_CNT         = 16'h0188;
      ADDR_AXI_RD_CNT         = 16'h0190;
