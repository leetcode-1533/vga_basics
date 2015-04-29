module sign_gen(clk_dac,value,enable,reset,finished);

input clk_dac;
input enable,reset;
output finished;

output [13:0] value;

sin_test sin_entity(
	.address(CounterX),
	.clock(clk_dac),
	.wren(1'b0), 
	.q(value));

reg [9:0] CounterX;
// a 1024 counter
// module vga_sin(CounterX,color,clk,enable,reset,finished,read_CounterX,time_division);
wire CounterXmaxed = (CounterX=='d1023); // samples 1024
wire finished;
assign finished = (CounterXmaxed==1);


always @(posedge clk_dac)
begin
	if(reset == 1)
		CounterX <= 0;
	else
	begin
	if(CounterXmaxed)
	  	CounterX <= 0;
	else if(enable == 1)
	  	CounterX <= CounterX + 1;
	end
end

endmodule