interface DFF_if (clk);

    input bit clk;

    logic rst;          // Reset signal (active high)
    logic d;            // D input (data to be stored)
    logic en;           // Enable signal
    logic q;            // Output Q (stores the value of D)

    // DUT modport
    modport DUT (
        input rst,clk,d,en,
        output q
    );  

endinterface : DFF_if