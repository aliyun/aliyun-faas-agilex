`include "prj_define.vh"


module asyn_fifo
#(
parameter   VENDOR          = `PRJ_VENDOR       ,
parameter   DEVICE          = `PRJ_DEVICE       ,
parameter   RAM_TYPE        = "BLOCK_RAM"       ,
parameter   WIDTH           = 10                ,
parameter   DEPTHBIT        = 5                 ,
parameter   AFULL_ROOM      = 8                 ,
parameter   ECC             = `ECC_CORR         ,
parameter   PARITY_CHECK    = `PARITY_CHECK
)
(
input                   wrst         ,
input                   rrst         ,
input                   wclk         ,
input                   wen          ,
input[WIDTH-1:0]        wdata        ,
output logic            afull        ,

input                   rclk         ,
input                   ren          ,
output[WIDTH-1:0]       rdata        ,
output                  empty        ,

output[DEPTHBIT:0]      wusedw       ,
output[DEPTHBIT:0]      rusedw       ,
output logic            overflow     ,
output logic            underflow    ,
output logic            err
);


function integer power2;
    input integer value;

    power2 = 1;
    while(value > 0) begin
        power2 = power2 << 1;
        value = value - 1;
    end
endfunction

// add mod for resource consideration.
localparam LOCAL_PARITY_CHECK = (RAM_TYPE == "DISTRIBUTE_RAM") ? "NO" : PARITY_CHECK ;

//
localparam  DEPTH             = power2(DEPTHBIT);
localparam  AFULL_SIZE        = DEPTH - AFULL_ROOM;
localparam  PARITY_CELL_WIDTH = (VENDOR=="INTEL") ? 32 : 35;
localparam  PARIT_WIDTH       = (WIDTH+PARITY_CELL_WIDTH-1)/PARITY_CELL_WIDTH;
localparam  CALC_BITS         = PARIT_WIDTH*PARITY_CELL_WIDTH;
localparam  ECC_CELL_WIDTH    = (VENDOR=="INTEL") ? 32 : 64;
localparam  ECC_COL_NUM       = (WIDTH+ECC_CELL_WIDTH-1)/ECC_CELL_WIDTH;
localparam  WIDTH_ECC         = ECC_CELL_WIDTH*ECC_COL_NUM;
localparam  WIDTH1            = (ECC=="YES" && RAM_TYPE=="BLOCK_RAM") ? WIDTH_ECC
                                              : (LOCAL_PARITY_CHECK=="YES") ? WIDTH+PARIT_WIDTH : WIDTH;


logic                   full;
logic[WIDTH1-1:0]       ram_wdata;
logic[WIDTH1-1:0]       ram_rdata;
logic[1:0]              eccstatus;
logic                   injectsbiterr;
logic                   injectdbiterr;
logic                   sbiterr;
logic                   dbiterr;


generate
    if(VENDOR=="INTEL") begin
        always_ff @(posedge wclk)
        begin
            if(wrst)
                overflow <= 1'b0;
            else if(full & wen)
                overflow <= 1'b1;
        end

        always_ff @(posedge rclk)
        begin
            if(rrst)
                underflow <= 1'b0;
            else if(empty & ren)
                underflow <= 1'b1;
        end

        always_ff @(posedge wclk)
        begin
            if(wrst)
                afull <= 1'b0;
            else if(wusedw < (power2(DEPTHBIT)-AFULL_ROOM))
                afull <= 1'b0;
            else
                afull <= 1'b1;
        end
    end
endgenerate


assign ram_wdata[WIDTH-1:0] = wdata;
assign rdata = ram_rdata[WIDTH-1:0];


generate
    if(VENDOR=="INTEL" && ECC=="YES" && RAM_TYPE=="BLOCK_RAM") begin
//        assign ram_wdata[WIDTH1-1:WIDTH] = '0;
        assign err = &eccstatus; //uncorrect error
    end
    else if(VENDOR=="XILINX" && ECC=="YES" && RAM_TYPE=="BLOCK_RAM") begin
//        assign ram_wdata[WIDTH1-1:WIDTH] = '0;
        always_ff @(posedge rclk)
        begin
            if(rrst)
                err <= 1'b0;
            else if(dbiterr)
                err <= 1'b1;
        end
    end
    else if(LOCAL_PARITY_CHECK=="YES") begin
        logic[PARIT_WIDTH-1:0]      w_check_bits;
        logic[PARIT_WIDTH-1:0]      r_check_bits;
        logic[CALC_BITS-1:0]        wdata_tmp;
        logic[CALC_BITS-1:0]        rdata_tmp;
        logic[PARIT_WIDTH-1:0]      check_err;
        logic[PARIT_WIDTH-1:0]      check_err_reg;
        logic                       empty_reg;
        integer                     i;

        assign wdata_tmp = wdata | {CALC_BITS{1'b0}};
        assign rdata_tmp = rdata | {CALC_BITS{1'b0}};
        assign r_check_bits = ram_rdata[WIDTH1-1:WIDTH];
        assign ram_wdata[WIDTH1-1:WIDTH] = w_check_bits;

        always_comb
        begin
            for(i=0; i<PARIT_WIDTH; i++) begin
                w_check_bits[i] = ^wdata_tmp[(i+1)*PARITY_CELL_WIDTH-1-:PARITY_CELL_WIDTH];
                check_err[i]    = ^{rdata_tmp[(i+1)*PARITY_CELL_WIDTH-1-:PARITY_CELL_WIDTH], r_check_bits[i]};
            end
        end

        always_ff @(posedge rclk)
        begin
            if(rrst) begin
                check_err_reg <= '0;
                empty_reg     <= 1'b1;
            end
            else begin
                check_err_reg <= check_err;
                empty_reg     <= empty;
            end
        end

        always_ff @(posedge rclk)
        begin
            if(rrst)
                err <= 1'b0;
            else if(empty_reg==1'b0 && check_err_reg!='0)
                err <= 1'b1;
        end
    end
    else begin
        assign err = 1'b0;
    end
endgenerate


generate
    if(VENDOR=="INTEL" && ECC=="YES" && RAM_TYPE=="BLOCK_RAM") begin
        localparam  MEM_TYPE = "M20K";
        dcfifo  dcfifo_component
        (
            .aclr (wrst),
            .data (ram_wdata),
            .rdclk (rclk),
            .rdreq (ren),
            .wrclk (wclk),
            .wrreq (wen),
            .q (ram_rdata),
            .rdempty (empty),
            .rdusedw (rusedw),
            .wrfull (full),
            .wrusedw (wusedw),
            .eccstatus (eccstatus),
            .rdfull (),
            .wrempty ()
        );
        defparam
            dcfifo_component.enable_ecc  = "TRUE",
            dcfifo_component.intended_device_family  = DEVICE,
            dcfifo_component.lpm_hint  = {"RAM_BLOCK_TYPE=",MEM_TYPE,",DISABLE_DCFIFO_EMBEDDED_TIMING_CONSTRAINT=TRUE"},
            dcfifo_component.lpm_numwords  = DEPTH,
            dcfifo_component.lpm_showahead  = "ON",
            dcfifo_component.lpm_type  = "dcfifo",
            dcfifo_component.lpm_width  = WIDTH1,
            dcfifo_component.lpm_widthu  = DEPTHBIT,
            dcfifo_component.overflow_checking  = "OFF",
            dcfifo_component.rdsync_delaypipe  = 5,
            dcfifo_component.read_aclr_synch  = "ON",
            dcfifo_component.underflow_checking  = "OFF",
            dcfifo_component.use_eab  = "ON",
            dcfifo_component.write_aclr_synch  = "ON",
            dcfifo_component.wrsync_delaypipe  = 5;
    end
    else if(VENDOR=="INTEL") begin
        localparam  MEM_TYPE = (RAM_TYPE=="DISTRIBUTE_RAM") ? "MLAB" : "M20K";
        dcfifo  dcfifo_component
        (
            .aclr (wrst),
            .data (ram_wdata),
            .rdclk (rclk),
            .rdreq (ren),
            .wrclk (wclk),
            .wrreq (wen),
            .q (ram_rdata),
            .rdempty (empty),
            .rdusedw (rusedw),
            .wrfull (full),
            .wrusedw (wusedw),
            .eccstatus (),
            .rdfull (),
            .wrempty ()
        );
        defparam
            dcfifo_component.enable_ecc  = "FALSE",
            dcfifo_component.intended_device_family  = DEVICE,
            dcfifo_component.lpm_hint  = {"RAM_BLOCK_TYPE=",MEM_TYPE,",DISABLE_DCFIFO_EMBEDDED_TIMING_CONSTRAINT=TRUE"},
            dcfifo_component.lpm_numwords  = DEPTH,
            dcfifo_component.lpm_showahead  = "ON",
            dcfifo_component.lpm_type  = "dcfifo",
            dcfifo_component.lpm_width  = WIDTH1,
            dcfifo_component.lpm_widthu  = DEPTHBIT,
            dcfifo_component.overflow_checking  = "OFF",
            dcfifo_component.rdsync_delaypipe  = 5,
            dcfifo_component.read_aclr_synch  = "ON",
            dcfifo_component.underflow_checking  = "OFF",
            dcfifo_component.use_eab  = "ON",
            dcfifo_component.write_aclr_synch  = "ON",
            dcfifo_component.wrsync_delaypipe  = 5;
    end
    else if(VENDOR=="XILINX") begin
        localparam  MEM_TYPE = (RAM_TYPE=="DISTRIBUTE_RAM") ? "distributed"
                                 : ((RAM_TYPE=="BLOCK_RAM") ? "block" : "ultra");
        localparam  ECC_MODE = (ECC=="YES" && RAM_TYPE=="BLOCK_RAM") ? "both_encode_and_decode" : "no_ecc";

        assign injectsbiterr = '0;
        assign injectdbiterr = '0;

        logic wr_rst_busy;
        logic rd_rst_busy;
        logic prog_empty;
        logic overflow_xil;
        logic underflow_xil;

        xpm_fifo_async
        #(
            .FIFO_MEMORY_TYPE    (MEM_TYPE),         //string; "auto", "block", or "distributed";
            .ECC_MODE            (ECC_MODE),         //string; "no_ecc" or "en_ecc";
            .RELATED_CLOCKS      (0),                //positive integer; 0 or 1
            .FIFO_WRITE_DEPTH    (DEPTH),            //positive integer
            .WRITE_DATA_WIDTH    (WIDTH1),           //positive integer
            .WR_DATA_COUNT_WIDTH (DEPTHBIT+1),       //positive integer
            .PROG_FULL_THRESH    (DEPTH-AFULL_ROOM), //positive integer
            .FULL_RESET_VALUE    (0),                //positive integer; 0 or 1
            .USE_ADV_FEATURES    ("0707"),           //string; "0000" to "1F1F";
            .READ_MODE           ("fwft"),           //string; "std" or "fwft";
            .FIFO_READ_LATENCY   (0),                //positive integer;
            .READ_DATA_WIDTH     (WIDTH1),           //positive integer
            .RD_DATA_COUNT_WIDTH (DEPTHBIT+1),       //positive integer
            .PROG_EMPTY_THRESH   (10),               //positive integer
            .DOUT_RESET_VALUE    ("0"),              //string
            .CDC_SYNC_STAGES     (3),                //positive integer
            .WAKEUP_TIME         (0)                 //positive integer; 0 or 2;
        )
        u_xpm_fifo_async
        (
            .rst           (wrst),
            .wr_clk        (wclk),
            .wr_en         (wen),
            .din           (ram_wdata),
            .full          (full),
            .overflow      (overflow_xil),
            .prog_full     (afull),
            .wr_data_count (wusedw),
            .almost_full   (),
            .wr_ack        (),
            .wr_rst_busy   (wr_rst_busy),
            .rd_clk        (rclk),
            .rd_en         (ren),
            .dout          (ram_rdata),
            .empty         (empty),
            .underflow     (underflow_xil),
            .rd_rst_busy   (rd_rst_busy),
            .prog_empty    (prog_empty),
            .rd_data_count (rusedw),
            .almost_empty  (),
            .data_valid    (),
            .sleep         (1'b0),
            .injectsbiterr (injectsbiterr),
            .injectdbiterr (injectdbiterr),
            .sbiterr       (sbiterr),
            .dbiterr       (dbiterr)
        );

        always_ff @(posedge wclk)
        begin
            if(wrst)
                overflow <= 1'b0;
            else if(overflow_xil)
                overflow <= 1'b1;
        end

        always_ff @(posedge rclk)
        begin
            if(rd_rst_busy)
                underflow <= 1'b0;
            else if(underflow_xil)
                underflow <= 1'b1;
        end
    end
endgenerate


endmodule
