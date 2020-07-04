//if select line s=00101, out=a+b
//if s=00110, out= a-b;
//if s=01000, a*b
//01011 --> a/b


module alu (a,b,s,out);                 //clk is used as an input, so it should be declared in the brackets
input [39:0]a,b;
input [4:0]s;
input clk;                              //before it can be used as a reg, it should be declared as output
reg [39:0]c,d;
output [39:0]out;

reg i;

always @ (posedge clk)
begin
if (s==5'b00101)                         // begin and end should encapsulate all the operations
out = a+b;
else if (s==5'b1000)
begin                               //the number should be 5 bits, 1000 is a 4 bit number which should be changed
out= a*b;
else if (s==5'b00110)
out = a-b;
else if (s==5'b01011)
out = a/b;
end
endmodule


`timescale 1ns/1ps
module alu_test;
reg [39:0]a,b;
reg clk;
reg [4:0]select;
wire out;                      // out is a 40 bit bus, it should be declared as [39:0]out
alu uut (a,b,out,select);      // the declarations in brackets should be exactly the same as declared in the module 
initial
begin
$dumpfile("alua.vcd");
$dumpvars(0, alu_test);
a= 40'h000000000b;
b= 40'h0000000003;
clk=0;
s= 5'b00101;                   // s is undeclared, it is meant to be select...
end

always
begin
#3 clk=~clk;
end

always
begin

s = 5'b00111;              // again, s is meant to be select and s should not be used
#10 s = 5'b00110;
#10 s = 5'b01000;          // I have used _ to clearly count the no. of bits in binary representations of numbers
#10 s = 5'b01011;

end

endmodule
