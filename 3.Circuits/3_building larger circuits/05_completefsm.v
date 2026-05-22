module top_module (
    input clk,
    input reset,
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack 
);

	localparam [3:0] s0 = 0,
					 s1 = 1,
					 s2 = 2,
					 s3 = 3,
					 s4 = 4,
					 s5 = 5,
					 s6 = 6,
					 s7 = 7,
					 s8 = 8,
					 s9 = 9;

	reg [3:0] state, next;

	always @(*) begin
		case (state) 
			s0: next = (data) ? s1 : s0;
			s1: next = (data) ? s2 : s0;
			s2: next = (data) ? s2 : s3;
			s3: next = (data) ? s4 : s0;
			s4: next = s5;
			s5: next = s6;
			s6: next = s7;
			s7: next = s8;
			s8: next = (done_counting) ? s9 : s8;
			s9: next = (ack) ? s0 : s9;
		endcase
	end

	always @(posedge clk) begin
		if (reset) state <= s0;
		else state <= next;
	end

	assign shift_ena = ((state == s4) | (state == s5) | (state == s6) | (state == s7));
	assign counting = (state == s8);
	assign done = (state == s9);

endmodule