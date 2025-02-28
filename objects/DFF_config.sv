package DFF_config_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class DFF_config extends uvm_object;

        `uvm_object_utils (DFF_config);
        virtual DFF_if dff_if;

        function new(string name = "DFF_config");
            super.new(name);
        endfunction
    endclass : DFF_config

endpackage : DFF_config_pkg