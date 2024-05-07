`timescale 1ns / 1ps

module tb_VideoDriver_VGA;

    reg clk;
    //tests
//    wire [31:0] count;
//    wire clk_out;
//    wire pix_clock;
//    wire [9:0] h_cnt;
//    wire [9:0] v_cnt;
    //tests
    reg reset;
    wire [3:0] vga_r;
    wire [3:0] vga_g;
    wire [3:0] vga_b;
    wire vga_hs;
    wire vga_vs;

    VideoDriver_VGA dut (
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs),
        //tests
//        .clk_out(clk_out),
//        .count(count),
//        .pix_clock(pix_clock),
//        .h_cnt(h_cnt),
//        .v_cnt(v_cnt),
        //tests
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always begin
        #10 clk = ~clk; // Invert clk every 5 time units
    end
        
    // Reset generation
    initial begin
        clk = 1'b0;
        reset = 1'b0;
        #10; 
        reset = 1'b1; // Release reset after 10 time units
        #10;
        reset = 1'b0;
        #10 reset = 1'b1; // Release reset after 10 time units
        reset = 1'b0;
        
    end

    // Monitor
//    initial begin
//        $monitor("Time=%0t, vga_r=%h, vga_g=%h, vga_b=%h, vga_hs=%b, vga_vs=%b", $time, vga_r, vga_g, vga_b, vga_hs, vga_vs);
//    end

    // Stop simulation after a certain time
//    initial begin
//        #10000 $finish;
//    end

endmodule
