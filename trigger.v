module trigger(clk_in,clk_out);

input clk_in;
output clk_out;

assign clk_out = clk_down;
reg clk_down = 'b0;
always @(posedge clk_in)
begin
	clk_down = clk_down + 1;
end
// assign clk_out = clk_in;

endmodule