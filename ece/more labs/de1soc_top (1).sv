

`timescale 1ns / 1ns // `timescale time_unit/time_precision

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
	
	
	// < Instantiate your module here> 	

// 	part1(.a(SW[7:4]), 
// 			.b(SW[3:0]),
// 			.c_in(SW[8]),
// 			.s(LEDR[3:0]),
// 			.c_out(LEDR[9:6])
// 			);
			
 	part2(.A(SW[7:4] & HEX[2]), 
 			.B(SW[3:0] & HEX[0]),
 			.Function(KEY[1:0]),
 			.ALUout(LEDR[7:0] & HEX[4:3])
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

module part2(input logic[3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);
	logic temp;
	logic d[3:0];  // this was like this before logic c1[3:0]; 
	logic OR, AND;
	part1 p0(.a(A), .b(B) ,.c_in(0) , .s(d[3:0]) ,.c_out(temp)); // added .() here becuase of connection 
	
	assign OR = |(A | B);          
    assign AND = &(A & B);
    
	always_comb 
	begin

		case(Function)
            0: ALU_Out = {4'b0, d[3:0]};  // we need a 8bit output, d[3:0] gives 4 bits only, we put 4 other bits as zero  since it is A+B, adding zero wont make any difference         
            1: ALU_Out = (OR) ? 8'b00000001 : 8'b0; // this means if input is 1 in or operation, output will be 1, else output is zero
            2: ALU_Out = (AND) ? 8'b00000001 : 8'b0; 
	//		8'b00000001 : ALUout = (|A)|(|B); //(A[0] | B[0]) |(A[1] |B[1]) | (A[2] | B[2]) | (A[3] | B[3]);
	//		8'b00000001 : ALUout = (&A) &(&B);//(A[0] | B[0]) |(A[1] |B[1]) | (A[2] | B[2]) | (A[3] | B[3]);
			//0: ALUout = c1[3:0];
			//((|A)|(|B)) 
				//1: ALUout = 8'b00000001;
			//endcase
			//((&A) &(&B))
				//2: ALUout = 8'b00000001;
			//endcase
			defualt: ALUout ={A, B};
			
			
		endcase
	end
endmodule 
	
	
	
	
	 
	




