module top_module (
    input  [3:0] SW,
    input  [3:0] KEY,
    output [3:0] LEDR
);

    wire [3:0] q;

    MUXDFF dff3 (
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(KEY[3]),
        .R(SW[3]),
        .Q(q[3])
    );

    MUXDFF dff2 (
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(q[3]),
        .R(SW[2]),
        .Q(q[2])
    );

    MUXDFF dff1 (
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(q[2]),
        .R(SW[1]),
        .Q(q[1])
    );

    MUXDFF dff0 (
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(q[1]),
        .R(SW[0]),
        .Q(q[0])
    );

    assign LEDR = q;

endmodule


module MUXDFF (
    input clk,
    input E,
    input L,
    input w,
    input R,
    output reg Q
);

    wire d;

    assign d = L ? R : (E ? w : Q);

    always @(posedge clk)
        Q <= d;

endmodule