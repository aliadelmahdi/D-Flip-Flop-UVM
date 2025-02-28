package DFF_sequencer_pkg;

    import uvm_pkg::*;
    import DFF_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class DFF_sequencer extends uvm_sequencer #(DFF_seq_item);

        `uvm_component_utils(DFF_sequencer);

        function new(string name = "DFF_sequence", uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass : DFF_sequencer

endpackage : DFF_sequencer_pkg