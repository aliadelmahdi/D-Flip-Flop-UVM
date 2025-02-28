module tb_top;

    import uvm_pkg::*;
    import DFF_env_pkg::*;
    import DFF_test_pkg::*;

    bit clk;

    // Clock Generation
    initial begin
        clk = 0;
        forever #1 clk = ~ clk;
    end

    DFF_env env_instance;
    DFF_test test;
    // Instantiate the interface
    DFF_if dff_if (clk);
    DFF DUT (dff_if);
    // Configure the UVM database and the test
    initial begin
        uvm_config_db #(virtual DFF_if)::set (null,"*","dff_if",dff_if);
        run_test("DFF_test");
    end
endmodule : tb_top