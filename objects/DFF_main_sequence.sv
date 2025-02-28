package DFF_main_sequence_pkg;

    import uvm_pkg::*;
    import DFF_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class DFF_main_sequence extends uvm_sequence #(DFF_seq_item);

        `uvm_object_utils (DFF_main_sequence);
        DFF_seq_item seq_item;

        function new(string name = "DFF_main_sequence");
            super.new(name);            
        endfunction
        
        task body;

            repeat(10000) begin
                seq_item = DFF_seq_item::type_id::create("seq_item");
                start_item(seq_item);
                assert(seq_item.randomize()) else $error("Randomization Failed");
                finish_item(seq_item);
            end

        endtask
    endclass : DFF_main_sequence

endpackage : DFF_main_sequence_pkg