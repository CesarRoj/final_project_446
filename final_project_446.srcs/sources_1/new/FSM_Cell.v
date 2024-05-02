`timescale 1ns / 1ps
typedef enum {N, X, O} states;

module Cell(
        input clk,
        input Sel,
        input Turn,
        input Reset,

        output reg [1:0] State
    );

    states PS, NS;

    always_ff @ (posedge clk) begin
        if (Reset)
            PS = N;
        else
            PS = NS;
    end

    always_comb begin
        case(PS)
            N   :   begin
                State = 'b00;

                if (Sel && ~Turn)
                    NS = X;
                else if (Sel && Turn)
                    NS = O;
                else
                    NS = PS;
            end

            X  :    begin
                State = 'b01;
                NS = PS;
            end

            O  :    begin
                State = 'b11;
                NS = PS;
            end

            default : begin
                NS = N;
            end
        endcase
    end
endmodule