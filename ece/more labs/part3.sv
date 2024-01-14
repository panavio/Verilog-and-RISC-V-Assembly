

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
	
endmodule
	// < Instantiate your module here> 	


module part3(input logic A, B, input logic Function, output logic ALUout);	

	parameter N = 4;
    //logic d[N-1:0];
    // You will not be able to use your RCA from Part I–it only works for 4-bit inputs.1 
    //Instead, you can directly perform addition using the ‘+’ operator. The ‘+’ operator will
    //automatically instantiate the correctly sized adder based on the widths of your inputs
	input logic [N-1:0] A, B;
	input logic [1:0] Function;
	output logic [2*N-1:0] ALUout;
  //  assign d = A+B;
    	logic [2*N-1:0] Ans;

	always_comb 
	begin
		case(Function)
        		0: Ans = A+B;  
  	        	1: Ans = (|A)|(|B);
  	        	2: Ans = (&A) & (&B);
			3: Ans = {A, B};
		default: Ans =2'b0;
		endcase
	ALUout=Ans;
	end
endmodule

//Example of parametrization 

// module mux_2to1_Nbit ( MuxIn0 , MuxIn1 , MuxSelect , MuxOut )
//     parameter N = 4;
//     input logic [N -1:0] MuxIn0 , MuxIn1 ;
//     input logic MuxSelect ;
//     output logic [N -1:0] MuxOut ;
//     assign MuxOut = MuxSelect ? MuxIn0 , MuxIn1 ;
// endmodule

//There is now an additional line which indicates that a parameter called N as been created.
//The width of the signals MuxIn0, MuxIn1 and MuxOut is then set based on N . You can also
//specify a default value for the parameter (4 in this case).
	
	
	
	
	 
	




