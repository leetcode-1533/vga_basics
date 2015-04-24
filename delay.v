module delay(clk,enable,reset,finished);

// module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished);

// to draw a whole screen:0.000768
// to draw a whole line:6.4e-06
// to delay at 48hz rate:0.02083325mhz needed(positive edge)520833.3333

input clk,enable,reset;
output finished;

parameter cycle = 'd520833;

reg [19:0] counter; // log2(520833.333) ~= 19
wire countermaxed = (counter == cycle);
assign finished = countermaxed;

always @(posedge clk)
begin
	if(reset == 1)
		counter <= 0;
	else
	begin
	if(countermaxed)
	  	counter <= 0;
	else if(enable == 1)
	  	counter <= counter + 1;
	end
end

endmodule