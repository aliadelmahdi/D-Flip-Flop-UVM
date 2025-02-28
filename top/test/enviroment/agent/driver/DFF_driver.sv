package DFF_driver_pkg;

    import uvm_pkg::*;
    import DFF_config_pkg::*;
    import DFF_main_sequence_pkg::*;
    import DFF_reset_sequence_pkg::*;
    import DFF_seq_item_pkg::*;

    `include "uvm_macros.svh"

    class DFF_driver extends uvm_driver #(DFF_seq_item);
        `uvm_component_utils(DFF_driver)
        virtual DFF_if dff_if;
        DFF_seq_item stimulus_seq_item;

        function new(string name = "DFF_driver", uvm_component parent);
            super.new(name,parent);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stimulus_seq_item = DFF_seq_item::type_id::create("stimulus_seq_item");
                seq_item_port.get_next_item(stimulus_seq_item);

                dff_if.rst = stimulus_seq_item.rst;
                dff_if.en = stimulus_seq_item.en;
                dff_if.d = stimulus_seq_item.d;
                dff_if.q = stimulus_seq_item.q;

                @(negedge dff_if.clk)
                seq_item_port.item_done();
                `uvm_info("run_phase",stimulus_seq_item.sprint(),UVM_HIGH)
            end
        endtask
    endclass : DFF_driver

endpackage : DFF_driver_pkg