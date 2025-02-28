package DFF_monitor_pkg;

    import uvm_pkg::*;
    import DFF_seq_item_pkg::*;

    `include "uvm_macros.svh"

    class DFF_monitor extends uvm_monitor;

        `uvm_component_utils (DFF_monitor)
        virtual DFF_if dff_if;
        DFF_seq_item response_seq_item;
        uvm_analysis_port #(DFF_seq_item) monitor_ap;

        function new(string name = "DFF_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor_ap = new ("monitor_ap",this);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                response_seq_item = DFF_seq_item::type_id::create("response_seq_item");
                @(negedge dff_if.clk);
                response_seq_item.rst = dff_if.rst;
                response_seq_item.en = dff_if.en;
                response_seq_item.d = dff_if.d;
                response_seq_item.q = dff_if.q;
                
                monitor_ap.write(response_seq_item);
                `uvm_info("run_phase", response_seq_item.sprint(), UVM_HIGH)
            end

        endtask
    endclass : DFF_monitor

endpackage : DFF_monitor_pkg