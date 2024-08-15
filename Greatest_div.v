`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 16:04:26
// Design Name: 
// Module Name: Greatest_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Greatest_div(data_in,start,Greatest_div,done,Enter_num2,Enter_num1);
input [15:0] data_in;
input start;
output [15:0] Greatest_div;
output done,Enter_num1,Enter_num2;
reg clk;
// Initializing a clk of 50 ns
initial
begin 
clk = 1'b0;
forever #50 clk = ~clk;
end 
controlpath Con(ldA,ldB,sel,sel_in,done,clk,lt,gt,eq,start,Enter_num1,Enter_num2);
datapathfsm DP(Greatest_div,gt,lt,eq,ldA,ldB,sel,sel_in,data_in,clk);
endmodule