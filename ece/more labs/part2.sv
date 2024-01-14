module de1soc_top 
(
    input logic CLOCK_50,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic [6:0] HEX2,
    output logic [6:0] HEX3,
    output logic [6:0] HEX4,
    output logic [6:0] HEX5,

    input logic [3:0] KEY,
    output logic [9:0] LEDR,
    input logic [9:0] SW
);
	
	
	part1 u0(.a(SW[7:4]), 
			.b(SW[3:0]),
			.c_in(SW[8]),
			.s(LEDR[3:0]),
			.c_out(LEDR[9:6])
			);
			
			
endmodule
	

//
//
//
//module mux7to1(input logic [9:7] MuxSelect, input logic [6:0] MuxIn, output logic Out);
//	always_comb
//		begin
//			case(MuxSelect)
//			3'b000 : Out = MuxIn [0]; // Case 0
//			3'b001 : Out = MuxIn [1]; // Case 1
//			3'b010 : Out = MuxIn [2]; // Case 2
//			3'b011 : Out = MuxIn [3];
//			3'b100 : Out = MuxIn [4];
//			3'b101 : Out = MuxIn [5];
//			3'b110 : Out = MuxIn [6];
//			default :  Out = 3'b111;
//			
//		endcase
//	end
//endmodule

///fin
module FA(input logic a, b, c_in, output logic s, c_out);
	assign s= a^b^c_in;
	assign c_out = (a&b) | (c_in &a) | (c_in &b);
endmodule

module part1(input logic [3:0] a, b, input logic c_in, output logic [3:0]s, c_out);
	 logic c1, c2, c3;
	 
	 FA u0(a[0], b[0], c_in, s[0], c1);
	 FA u1(a[1], b[1], c1, s[1], c2);
	 FA u2(a[2], b[2], c2, s[2], c3);
	 FA u3(a[3], b[3], c3, s[3], c_out);
endmodule
	 
	




