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
	
 			
endmodule

module FA(input logic a, b, c_in, output logic s, c_out);
	assign s= a^b^c_in;
	assign c_out = (a&b) | (c_in &a) | (c_in &b);
endmodule

module part1(input logic [3:0] a, b, input logic c_in, output logic [3:0]s, c_out);
	 logic c1, c2, c3,c4;
	 
	 FA u0(a[0], b[0], c_in, s[0], c1);
	 FA u1(a[1], b[1], c1, s[1], c2);
	 FA u2(a[2], b[2], c2, s[2], c3);
	 FA u3(a[3], b[3], c3, s[3], c4);
	 assign c_out[3]=c4;
	 assign c_out[2]=c3;
	 assign c_out[1]=c2;
	 assign c_out[0]=c1;
endmodule

module part2(input logic[3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);

	logic [3:0] d, carry;  // this was like this before logic c1[3:0]; 
	//logic OR, AND;
	part1 p0(.a(A), .b(B) , .c_in(0) , .s(d) ,.c_out(carry)); // added .() here becuase of connection 
	//assign OR = |(A | B);   
    	//assign AND = &(A & B);
	always_comb 
	begin
	case(Function)
            0: ALUout = {3'b0, carry[3], d};  //d we need a 8bit output, d[3:0] gives 4 bits only, we put 4 other bits as zero  since it is A+B, adding zero wont make any difference         
            1: ALUout = |(A|B); // this means if input is 1 in or operation, output will be 1, else output is zero
            2: ALUout = &(A & B); 
	    3: ALUout = {A, B};
	    default: ALUout = 8'b0;
	endcase
	end
endmodule 

