module counter_tb;


// module clear(CounterX,CounterY,clk,reset,enable,finished);
wire [7:0] CounterY,CounterX;
reg clk;

reg reset,enable;
wire finished;

clear U0(
	.CounterX	(CounterX),
	.CounterY	(CounterY),
	.clk	(clk),
	.reset	(reset),
	.enable (enable),
	.finished (finished)
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
	#200000 enable = 0; // enable == 1 for 20000000 tickets
	#5 reset = 1;//try again
	#200 enable = 1;
	#25 $finish; 
end


initial  begin
    $monitor("ticket:%g\t,enable:%b\t,reset:%b\t,x:%d\t,y:%d\t,finished :%b",$time,enable,reset,CounterX,CounterY,finished); 
 end 



endmodule


