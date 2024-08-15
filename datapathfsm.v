`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2024 15:16:29
// Design Name: 
// Module Name: datapathfsm
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

module register(data_out,data_in,load,clk);
input[15:0] data_in;
input load,clk;
output reg[15:0] data_out;
always@(posedge clk)
if (load) data_out <= data_in;
endmodule

module sub(in1,in2,data_out);
input[15:0] in1,in2;
output reg[15:0] data_out;
always@(*)
data_out <= in1 - in2;
endmodule

module compare(in1,in2,gt,lt,eq);
input[15:0] in1,in2;
output gt, lt, eq;
assign gt = in1 > in2;
assign lt = in1 < in2;
assign eq = in1 == in2;
endmodule

module mux(data_out,in1,in2,sel);
input[15:0] in1,in2;
input sel;
output [15:0] data_out;
assign data_out = sel? in2:in1;
endmodule

module datapathfsm(Ans,gt,lt,eq,ldA,ldB,sel,sel_in,data_in,clk);
input ldA,ldB,sel,sel_in,clk;
input[15:0] data_in;
output gt,lt,eq;
output [15:0] Ans;
wire[15:0] A_out,B_out,X,Y,Bus,Subout;
register A(A_out,Bus,ldA,clk);
register B(B_out,Bus,ldB,clk);
mux mux_in1(X,A_out,B_out,sel);
mux mux_in2(Y,B_out,A_out,sel);
mux load(Bus,Subout,data_in,sel_in);
sub sb(X,Y,Subout);
compare comp(A_out,B_out,gt,lt,eq);
assign Ans = A_out;
endmodule