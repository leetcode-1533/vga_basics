module modisign(adc_data,vga_data,shift);

// horizonal resize 
input [13:0] adc_data;
output reg [7:0] vga_data;

input [3:0] shift; // 0, 1, 2, 3
// matlab function provided for calculate bits real shift 


// original center is 8191 {13[1]}, the center shift as well.
always @ *
begin
	case(shift)
	0:
	begin
		vga_data = (adc_data >> 7) - 4 ;
	end
	1:
	begin
		vga_data = (adc_data >> 8) + 28 ;
	end
	2:
	begin
		vga_data = (adc_data >> 9) + 44 ;
	end
	3:
	begin
		vga_data = (adc_data >> 10) + 52 ;
	end
	4:
	begin
		vga_data = (adc_data >> 6) - 68 ;
	end
	8:
	begin
		vga_data = (adc_data >> 5) - 196 ;
	end
	12:
	begin
		vga_data = (adc_data >> 4) - 452 ;
	end
	default:
	begin
		vga_data = (adc_data >> 7) - 4 ;
	end

	endcase
end
// values of data_shift :( as resolution goes lower
// shift by 7: 4
// shift by 8:

endmodule