// I take the sequence - red green yellow in the output regs of outpA & outpB

module tlc(clk,rst,inpA,inpB,outpA,outpB);

  input clk,rst,inpA,inpB;
  output reg[2:0] outpA,outpB;
  reg[2:0]state;
  
  parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5;
  
  always@(posedge clk or posedge rst)

    begin
    
    if(rst)
      begin
      state<=S0;
      outpA=3'b010;
      outpB=3'b100;
      end
    
    else
      case(state)
    
        S0:if(inpA)
        begin
          state<=S0;
          outpA=3'b010;
          outpB=3'b100;
        end
        else
        begin
          state<=S1;
          outpA=3'b001;
          outpB=3'b001;
        end
        
        S1:if(1)
        begin
          state<=S2;
          outpA=3'b001;
          outpB=3'b001;
        end
        
        S2:if(1)
        begin
          state<=S3;
          outpA=3'b100;
          outpB=3'b010;
        end

       S3:if(inpB)
        begin
          state<=S3;
          outpA=3'b100;
          outpB=3'b010;
        end
        else
        begin
          state<=S4;
          outpA=3'b001;
          outpB=3'b001;
        end

        S4:if(1)
        begin
          state<=S5;
          outpA=3'b001;
          outpB=3'b001;
        end
  
        S5:if(1)
        begin
          state<=S0;
          outpA=3'b010;
          outpB=3'b100;
        end
        
      endcase
    end
    
endmodule


`timescale 10ns/1ps
module tlc_testbench;

reg clock,r;
reg iptA,iptB;
wire [2:0] outpA,outpB;

tlc uut (clock,r,iptA,iptB,outpA,outpB);

initial begin

clock = 0;
r = 1;
iptA=1;
iptB=0;
#60 r=0;

$dumpfile ("tlc.vcd"); 
$dumpvars(0,tlc_testbench);

iptA=1;
#20 iptA=0;
#20 iptB=0;
#20 iptA=1;
#20 iptB=0;
#20 iptA=1;
#20 iptA=0;
#20 iptA=0;
#20 iptB=1;
#20 iptB=0;
#20 iptB=1;
#20 iptA=0;
#20 iptB=0;
#20 iptB=1;
#20 iptA=0;
#20 iptA=1;

end

always

#3 clock = ~clock;

endmodule


  
