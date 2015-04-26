module clear(CounterX,CounterY,clk,reset,enable,finished,color);

input clk;
input reset,enable;

output reg [7:0] CounterX,CounterY;
output finished;

wire [14:0] address;

wire CounterXmaxed = (CounterX==8'd159); // 159
wire CounterYmaxed = (CounterY==8'd119); // 119
assign finished = ((CounterXmaxed == 1) && (CounterYmaxed == 1));

assign address = CounterX + CounterY * 160;

always @(posedge clk)
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

always @ (posedge clk)
begin
	if(reset == 1)
		CounterY <= 0;
	else
	begin
		if(CounterXmaxed == 1)
		begin
			if(CounterYmaxed)
				CounterY <= 0;
			else if(enable == 1)
				CounterY <= CounterY + 1;
		end
	end
end

// output color;
// endmodule


output [11:0] color = {12{rambuffer}};
wire rambuffer;
ram_background ram_entity(
 	.address(address),
 	.clock(clk),
 	.wren(1'b0),
 	.q(rambuffer));

endmodule