/////////VideoDriver_VGA

`timescale 1ns / 1ps


module VideoDriver_VGA(
    output reg [3:0] vga_r,
    output reg [3:0] vga_g,
    output reg [3:0] vga_b,
    output reg vga_hs,
    output reg vga_vs,
    //for tests
//    output reg clk_out,
//    output wire [31:0] count,
    //output wire pix_clock,
//    output reg [9:0] h_cnt,    //horizontal pixel count
//    output reg [9:0] v_cnt,    //vertical pixel count
    //for tests^
    input clk,
    input reset
    );
    
    //internal signals
    wire pix_clock;      //pixel display clock
    
//here we're using a clock divider to slow our clock down    
//The lower the resolution(and refresh rate) of our monitor the slower our clock will need to be
//so our output can match to our screen
//for a 800 x 600 resolution monitor at 60hz we'll need 40 Mhz
//the clock divider file i used is changed to account for this

//for the sake fo overexplaing:(clock_divider file)
//we need to achieve 40Mhz so we use a formula 
        //count value = (input clock freq) / (desired output freq) = 100Mhz / 40 Mhz = 2.5
        //so we set our value to 2.5 - 1 = 1.5 or 2 for safety

//this is great for us since a higher resolution would mean we'd need a very fast clock
//so a shitty resolution will work fine
//instantiate clock
    clock_divider clock_divider_40Mhz(
        .clk(clk),
        .reset(reset),    
        .sclk(pix_clock)
        //.count(count)
    );

    
    //keep track of timing
    reg [9:0] h_cnt;    //horizontal pixel count
    reg [9:0] v_cnt;    //vertical pixel count
    
  
    
//our main loop running on the slowed down pixel clock
//the settings for our h and v count also depend on refresh rate and resolution
//a vga microcontroller website can help calculate our sync times
//always @(posedge pix_clock) begin
////testing purposes
//    //clk_out <= pix_clock;
//    //reset the screen when reset is on
//    if (reset) begin
//        h_cnt = 10'd0;
//        v_cnt = 10'd0;
//    end else begin
    
//    //setting to output at specific count time for test purposes
//        if (h_cnt < 656 && h_cnt >= 752) begin
//            vga_hs <= 1'b0;
//        end else begin
//            vga_hs <= 1'b1;
//        end
        
//     //setting to output at specific count time for test purposes
//        if (v_cnt == 412 || v_cnt == 413) begin
//            vga_vs <= 1'b1;
//        end else begin
//            vga_vs <= 1'b0;
//        end
//     //our values for h_count and v_count must be calculated here
//     //this is based on the # of pixels and lines of our chosen resolution
//     //since were doing 800 x 600 we do as follows
     
//     //these loops output random data for test purposes
//        if (h_cnt < 800 && v_cnt < 600) begin
//            if (h_cnt == 0 || v_cnt == 0 || h_cnt == 639 || v_cnt == 399) begin
//                vga_r <= 4'hF;
//                vga_g <= 4'h0;
//                vga_b <= 4'h0;
//            end else if (h_cnt[0] && v_cnt[1]) begin
//                vga_r <= 4'hF;
//                vga_g <= 4'hF;
//                vga_b <= 4'hF;
//            end else begin
//                vga_r <= 4'h0;
//                vga_g <= 4'hF;
//                vga_b <= 4'h0;
//            end
            
//            //output nothing
//        end else begin
//            vga_r <= 4'h0;
//            vga_g <= 4'h0;
//            vga_b <= 4'h0;
//        end
        
        
//        //output random stuff for test purposes
//        if (h_cnt < 800) begin
//            h_cnt <= h_cnt + 1;
//        end else begin
//            h_cnt <= 10'd0;
//            if (v_cnt < 449) begin
//                v_cnt <= v_cnt + 1;
//            end else begin
//                v_cnt <= 10'd0;
//            end
//        end
//    end
//end

// VGA Horizontal Sync
always @(posedge pix_clock) begin
        if (h_cnt >= 500 && h_cnt < 800) begin  //656 752
            vga_hs <= 1'b0;
        end else begin
            vga_hs <= 1'b1;
        end
    end


// VGA Vertical Sync
always @(posedge pix_clock) begin
        if (v_cnt == 412 || v_cnt == 413) begin  //og 412 413
            vga_vs <= 1'b1;
        end else begin
            vga_vs <= 1'b0;
        end
    end


// Control Process
always @(posedge pix_clock) begin
    if (reset) begin
        v_cnt <= 10'd0;
        h_cnt <= 10'd0;
    end else begin
        if (h_cnt < 800 && v_cnt < 600) begin
            if (h_cnt == 0 || v_cnt == 0 || h_cnt == 639 || v_cnt == 399) begin
                vga_r <= 4'hF;
                vga_g <= 4'h0;  //og 0
                vga_b <= 4'hF;  //og 0
            end else  if (h_cnt == 100 || v_cnt == 1 || h_cnt == 600 || v_cnt == 200) begin
                vga_r <= 4'hF;
                vga_g <= 4'h0;  //og 0
                vga_b <= 4'h0;  //og 0
            end else if (h_cnt[0] && v_cnt[1]) begin
                vga_r <= 4'hF;
                vga_g <= 4'hF;
                vga_b <= 4'hF;
            end else begin
                vga_r <= 4'h0;      //og 0
                vga_g <= 4'hF;
                vga_b <= 4'h0;      //og 0
            end
        end else begin
            vga_r <= 4'h0;
            vga_g <= 4'h0;
            vga_b <= 4'h0;
        end
        
        if (h_cnt < 800) begin
            h_cnt <= h_cnt + 1;
        end else begin
            h_cnt <= 10'd0;
            if (v_cnt < 600) begin
                v_cnt <= v_cnt + 1;
            end else begin
                v_cnt <= 10'd0;
            end
        end
    end
end    
endmodule
