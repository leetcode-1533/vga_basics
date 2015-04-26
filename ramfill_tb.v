module ramfill_tb;

// module ramfill(clk_adc,enable,reset,finfished,adc_data,vga_data,CounterX);
reg clk;
wire [7:0] CounterX;
reg enable,reset;
wire finished;

ramfill u0(
	.clk_adc(clk), 
	.reset	(reset),
	.enable (enable),
	.finished (finished), 
	.CounterX	(CounterX));

always  
   #5 clk = ~clk; 
    
initial begin
	reset = 0;
	enable = 0;
	clk = 1;

	#10 reset = 1;//after 10 tickets
	#10 reset = 0;//then after 10 tickets,reset is set 1 after reset == 1 is kept for 10 tickets
	#10 enable = 1;
	#20000 reset = 1;//try again
	#200 reset = 0;
	#2000 enable = 1;
	#2000 enable = 0;
	#200 reset = 0;
	#25 $finish; 
end


initial  begin
    $monitor("ticket:%g\t,enable:%b\t,reset:%b\t,x:%d\t,finished :%b",$time,enable,reset,CounterX,finished); 
end 

endmodule
