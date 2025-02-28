package DFF_reset_sequence_pkg;

    import uvm_pkg::*;
    import DFF_seq_item_pkg::*;

    `include "uvm_macros.svh"

    class DFF_reset_sequence extends uvm_sequence #(DFF_seq_item);

        `uvm_object_utils (DFF_reset_sequence)
        DFF_seq_item seq_item;

        function new (string name = "DFF_reset_sequence");
            super.new(name);
        endfunction

        task body;
            seq_item = DFF_seq_item::type_id::create("seq_item");

            start_item(seq_item);
                seq_item.rst = 0;
                seq_item.d = 0;
                seq_item.en = 0;
            finish_item(seq_item);

        endtask
    endclass : DFF_reset_sequence

endpackage : DFF_reset_sequence_pkg
