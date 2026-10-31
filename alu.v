module alu (
    input  wire [7:0] A,          // 8-bit Input Operand A
    input  wire [7:0] B,          // 8-bit Input Operand B
    input  wire [2:0] ALUControl, // 3-bit Operation Control Signal
    output reg  [7:0] Result,     // 8-bit Output Result
    output wire       Zero        // High if Result == 0
);

    // Zero flag output logic
    assign Zero = (Result == 8'b0) ? 1'b1 : 1'b0;

    // Combinational logic block for ALU operations
    always @(*) begin
        case (ALUControl)
            3'b000: Result = A + B;                      // ADD
            3'b001: Result = A - B;                      // SUB
            3'b010: Result = A & B;                      // AND
            3'b011: Result = A | B;                      // OR
            3'b100: Result = A ^ B;                      // XOR
            3'b101: Result = ($signed(A) < $signed(B)) ? 8'd1 : 8'd0; // SLT (Set Less Than)
            default: Result = 8'b0;
        endcase
    end

endmodule
