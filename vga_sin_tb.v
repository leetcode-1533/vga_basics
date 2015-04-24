// module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished);
module vga_sin_tb;

reg clk;
wire [7:0] CounterY,CounterX;
wire [11:0] color;

reg enable,reset;
wire finished;

vga_sin U0(
	.CounterX	(CounterX),
	.clk	(clk),
	.reset	(reset),
	.enable (enable),
	.finished (finished), 
	.color	(color)
	);

always  
   #5 clk = ~clk; 
    
initial begin
	reset = 0;
	enable = 0;
	clk = 1;

	#10 reset = 1;//after 10 tickets
	#10 reset = 0;//then after 10 tickets,reset is set 1 after reset == 1 is kept for 10 tickets
	#10 enable = 1;
	#20000 enable = 0; // enable == 1 for 20000000 tickets
	#5 reset = 1;//try again
	#200 enable = 1;
	#25 $finish; 
end


initial  begin
    $monitor("ticket:%g\t,enable:%b\t,reset:%b\t,x:%d\t,y:%d\t,finished :%b",$time,enable,reset,CounterX,CounterY,finished); 
 end 



endmodule
