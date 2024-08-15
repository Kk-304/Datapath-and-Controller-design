`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 16:02:05
// Design Name: 
// Module Name: controlpath
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


module controlpath(ldA,ldB,sel,sel_in,done,clk,lt,gt,eq,start,n1,n2);
input clk,lt,gt,eq,start;
output reg ldA,ldB,sel,sel_in;
output reg done,n1,n2;
reg[2:0] state;
parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;
always@(posedge clk)
begin
case(state)
S0: if(start) state <= S1;
S1: state <= S2;
S2: begin
#20 if(eq) state <= S5;
else if(lt) state <= S3;
else if(gt) state <= S4;
end
S3: begin
#20 if(eq) state <= S5;
else if(lt) state <= S3;
else if(gt) state <= S4;
end
S4: begin
#20 if(eq) state <= S5;
else if(lt) state <= S3;
else if(gt) state <= S4;
end
S5: begin
state <= S5;
end
default: state <= S0;
endcase
end

always@(state)
begin
case(state)
S0: begin
sel_in <= 1;
ldA <= 1;
ldB <= 0;
done <= 0;
n1 <= 1'b1;
n2 <= 1'b0;
end
S1: begin
sel_in <= 1;
ldA <= 0;
ldB <= 1;
n1 <= 1'b0;
n2 <= 1'b1;
end
S2: begin
n1 <= 1'b0;
n2 <= 1'b0;
if(eq) done <= 1;
else if(lt) begin
sel <= 1;
sel_in <= 0;
#10 ldA <= 0;
ldB <= 1;
end
else if(gt) begin
sel <= 0;
sel_in <= 0;
#10 ldA <= 1;
ldB <= 0;
end
end
S3: begin
if(eq) done <= 1;
else if(lt) begin
sel <= 1;
sel_in <= 0;
#10 ldA <= 0;
ldB <= 1;
end
else if(gt) begin
sel <= 0;
sel_in <= 0;
#10 ldA <= 1;
ldB <= 0;
end
end
S4: begin
if(eq) done <= 1;
else if(lt) begin
sel <= 1;
sel_in <= 0;
#10 ldA <= 0;
ldB <= 1;
end
else if(gt) begin
sel <= 0;
sel_in <= 0;
#10 ldA <= 1;
ldB <= 0;
end
end
S5: begin
done <= 1;
sel <= 0;
ldA <= 0;
ldB <= 0;
end
default: begin ldA<=0;ldB<=0; end
endcase
end
endmodule