package DFF_seq_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
 
    class DFF_seq_item extends uvm_sequence_item;

        `uvm_object_utils(DFF_seq_item)
        rand bit rst,en;
        rand logic d;
        logic q;
        function new(string name = "DFF_seq_item");
            super.new(name);
        endfunction

        constraint rst_cons {
            rst dist {
                0:= 97,
                1:= 3
            };
        }
        constraint en_cons {
            en dist {
                0:= 3,
                1:= 97
            };
        }
    endclass : DFF_seq_item

endpackage : DFF_seq_item_pkg