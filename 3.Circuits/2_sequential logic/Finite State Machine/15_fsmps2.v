module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
);

    localparam [1:0] X  = 2'b00,
                     Y1 = 2'b01,
                     Y2 = 2'b10,
                     Z  = 2'b11;

    reg [1:0] state, next;

    // State transition logic (combinational)
    always @(*) begin
        case(state)
            X :  next = (in[3]) ? Y1 : X;
            Y1:  next = Y2;
            Y2:  next = Z;
            Z :  next = (in[3]) ? Y1 : X;
            default: next = X;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= X;
        else
            state <= next;
    end

    // Output logic
    assign done = (state == Z);

endmodule