module clear(CounterX,CounterY,clk,lock);

input clk,lock;

output reg [7:0] CounterX,CounterY;


wire CounterXmaxed = (CounterX==8'b10011111); // 159
wire CounterYmaxed = (CounterY==8'b01110111); // 119

always @(posedge clk)
if(CounterXmaxed)
  CounterX <= 0;
else
begin
  CounterX <= CounterX + lock;
end

always @(negedge clk )
if(CounterXmaxed)
begin
	if(CounterYmaxed)
		CounterY <= 0;
	else
		 CounterY <= CounterY + lock;
end

endmodule