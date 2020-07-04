//if select line s=00101, out=a+b
//if s=00110, out= a-b;
//if s=01000, a*b
//01011 --> a/b


module alu (a,b,s,clk,out);        //clk is used as an input, so it should be declared in the brackets
input [39:0]a,b;
input [4:0]s;
input clk;
output [39:0]out;                  //before it can be used as a reg, it should be declared as output
reg [39:0] out;
reg [39:0]c,d;


always @ (posedge clk)
begin                              // begin and end should encapsulate all the operations
if (s==5'b00_10_1)
out = a+b;
else if (s==5'b01_00_0)              //the number should be 5 bits, 1000 is a 4 bit number which should be changed
out= a*b;
else if (s==5'b00_11_0)
out = a-b;
else if (s==5'b01_01_1)
out = a/b;
end
endmodule


`timescale 1ns/1ps
module alu_test;
reg [39:0]a,b;
reg clk;
reg [4:0]select;
wire [39:0]out;                          // out is a 40 bit bus, it should be declared as [39:0]out
alu uut (a,b,select,clk,out);            // the declarations in brackets should be exactly the same as declared in the module 
initial
begin
$dumpfile("alua.vcd");
$dumpvars(0, alu_test);
a= 40'h00_00_00_00_0b;
b= 40'h00_00_00_00_03;
clk=0;
select= 5'b00_10_1;                           // s is undeclared, it is meant to be select...
end

always
begin
#3 clk=~clk;
end

always
begin

select = 5'b00_11_1;                         // again, s is meant to be select and s should not be used
#10 select = 5'b00_11_0;
#10 select = 5'b01_00_0;                     // I have used _ to clearly count the no. of bits in binary representations of numbers
#10 select = 5'b01_01_1;

end

endmodule
