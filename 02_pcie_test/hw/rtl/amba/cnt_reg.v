//-------------------------------------------------------------------
// Author        : shanhua.jianglong
// work No.      : 161764
// Time          : 2018-6-3
// Filename      : cnt_reg.v
// Description   : counter CBB 
//-------------------------------------------------------------------
module cnt_reg #(
    parameter                       WIDTH = 32          )
(
    input                           clk_sys             ,
    input                           rst                 ,

    input                           cnt_en              ,
    input                           cnt_clr             ,
    output  reg [WIDTH-1:0]         dout                );

always@(posedge clk_sys or posedge rst)
begin
    if(rst == 1'b1) begin
        dout <= {WIDTH{1'b0}};
    end
    else if(cnt_clr == 1'b1) begin
        dout <= {WIDTH{1'b0}};
    end
    else if(cnt_en == 1'b1) begin
        dout <= dout + {{(WIDTH-1){1'b0}},1'b1};
    end
    else;
end
endmodule


