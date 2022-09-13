module usr_amm_dfx
(
  input             clk            ,
  input             rst            ,
  input             usr_clk        ,
  input             amm_wr         ,
  input             amm_rd         ,
  input             amm_rvld       ,
  input             amm_ready      ,
  output reg [31:0] amm_wr_cmd_cnt ,
  output reg [31:0] amm_rd_cmd_cnt ,
  output reg [31:0] amm_rd_data_cnt
);

reg [31:0] amm_stat_wr_cmd_cnt ;
reg [31:0] amm_stat_rd_cmd_cnt ;
reg [31:0] amm_stat_rd_data_cnt;
reg [31:0] amm_stat_wr_cmd_cnt_dly ;
reg [31:0] amm_stat_rd_cmd_cnt_dly ;
reg [31:0] amm_stat_rd_data_cnt_dly;
always @(posedge usr_clk)
begin
  amm_stat_wr_cmd_cnt_dly  <= amm_stat_wr_cmd_cnt; 
  amm_stat_rd_cmd_cnt_dly  <= amm_stat_rd_cmd_cnt; 
  amm_stat_rd_data_cnt_dly <= amm_stat_rd_data_cnt; 
  amm_wr_cmd_cnt  <= amm_stat_wr_cmd_cnt_dly; 
  amm_rd_cmd_cnt  <= amm_stat_rd_cmd_cnt_dly; 
  amm_rd_data_cnt <= amm_stat_rd_data_cnt_dly; 
end

always @(posedge clk)
begin
  if(rst)
      amm_stat_wr_cmd_cnt <= 32'h0;
  else if(amm_ready & amm_wr)
      amm_stat_wr_cmd_cnt <= amm_stat_wr_cmd_cnt + 32'h1;
  else
      amm_stat_wr_cmd_cnt <= amm_stat_wr_cmd_cnt;
end

always @(posedge clk)
begin
  if(rst)
      amm_stat_rd_cmd_cnt <= 32'h0;
  else if(amm_ready & amm_rd)
      amm_stat_rd_cmd_cnt <= amm_stat_rd_cmd_cnt + 32'h1;
  else
      amm_stat_rd_cmd_cnt <= amm_stat_rd_cmd_cnt;
end

always @(posedge clk)
begin
  if(rst)
      amm_stat_rd_data_cnt <= 32'h0;
  else if(amm_rvld)
      amm_stat_rd_data_cnt <= amm_stat_rd_data_cnt + 32'h1;
  else
      amm_stat_rd_data_cnt <= amm_stat_rd_data_cnt;
end

endmodule
