module mux8_1 (A,S,Y);
    
    input wire [7:0] A;
    input wire [2:0] S;
    output Y;

    wire road1,road2,road3;

    mux4_1 mux0 (.S(S[1:0]),.A(A[7:4]),.Y(road1));
    mux4_1 mux1 (.S(S[1:0]),.A(A[3:0]),.Y(road2));

    mux2_1 mux2 (.X(road3),.A0(road1),.A1(road2),.S(S[2]));

    assign Y = road3;

endmodule

module mux4_1 (
    S   ,
    A   ,
    Y 
);
    input wire [1:0] S;
    input wire [3:0] A;
    output reg Y;

    always @(*) begin
        case (S)
            2'b00: Y = A[0];
            2'b01: Y = A[1]; 
            2'b10: Y = A[2]; 
            2'b11: Y = A[3]; 
            default: Y = 0;
        endcase
    end
endmodule

module mux2_1 (
    X   ,
    A0  ,
    A1  ,
    S 
);
    input wire A0,A1,S;
    output reg X;
    always @(*) begin
        if(S)
            X = A1;
        else
            X = A0;
    end
endmodule

