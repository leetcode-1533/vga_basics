module sel_clk(clk1,clk2,clk3,in_p,clk_62);

input clk1,clk2,clk3;
input [1:0] in_p;

output reg clk_62;

always @(in_p)
begin
	case(in_p)
		'd0:clk_62 = clk1;
		'd1:clk_62 = clk2;
		'd2:clk_62 = clk3;
		default: clk_62 = clk1;
	endcase
end

endmodule
