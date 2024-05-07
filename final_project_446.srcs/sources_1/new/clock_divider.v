`timescale 1ns / 1ps
module clock_divider(

input clk,
input reset,
output reg sclk
//output reg [31:0] count
);

reg [31:0] count;

    always@(posedge clk or posedge reset)
        begin
    if(reset == 1'b1) begin
    count <= 32'd0;
    sclk <= 1'b0;
        end else begin
    if(count == 32'd1) begin //this is for 10s, 50000000 for 1 sec
    count <= 32'd0;
    sclk <= ~sclk;
        end else begin
    count <= count + 1;
        end
    end
    end
    endmodule
