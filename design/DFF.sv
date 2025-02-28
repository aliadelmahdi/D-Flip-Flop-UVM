// D flip-flop module
module DFF (DFF_if dff_if);
    logic clk;          // Clock signal
    logic rst;          // Reset signal (active high)
    logic d;            // D input (data to be stored)
    logic en;           // Enable signal
    logic q;            // Output Q (stores the value of D)

    assign clk = dff_if.clk;
    assign rst = dff_if.rst;
    assign d = dff_if.d;
    assign en = dff_if.en;

    assign dff_if.q = q;

// Sequential block triggered on the rising edge of the clock
always @(posedge clk) begin
    if(rst)                 // If reset is active, set Q to 0
        q <= 1'b0;
    else begin
            if(en)          // If enable is high, store D in Q
                q <= d;
            else            // If enable is low, retain the current value of Q
                q <= q;
    end
end

cover property (@(posedge clk) (en && d == 1'b1) |=> (q == 1'b1)); 
cover property (@(posedge clk) (en && d == 1'b0) |=> (q == 1'b0));

endmodule
