package DFF_coverage_pkg;
    import uvm_pkg::*;
    import DFF_driver_pkg::*,
           DFF_main_sequence_pkg::*,
           DFF_reset_sequence_pkg::*,
           DFF_seq_item_pkg::*,
           DFF_config_pkg::*,
           DFF_sequencer_pkg::*,
           DFF_monitor_pkg::*,
           DFF_config_pkg::*;
    `include "uvm_macros.svh"

    class DFF_coverage extends uvm_component;
        `uvm_component_utils(DFF_coverage)

        // Analysis Export for receiving transactions from monitors
        uvm_analysis_export #(DFF_seq_item) cov_export;

        uvm_tlm_analysis_fifo #(DFF_seq_item) cov_dff;

        DFF_seq_item seq_item_cov;

        // Covergroup definitions
        covergroup dff_cov_grp;
            option.per_instance = 1; // Each instance of this covergroup is independent

            // Coverpoint for D input
            coverpoint seq_item_cov.d {
                bins d_zero = {0};
                bins d_one  = {1};
            }

            // Coverpoint for Enable signal
            coverpoint seq_item_cov.en {
                bins en_disabled = {0};
                bins en_enabled  = {1};
            }

            // Coverpoint for Reset signal
            coverpoint seq_item_cov.rst {
                bins rst_inactive = {0};
                bins rst_active   = {1};
            }

        endgroup

        // Constructor
        function new (string name = "DFF_coverage", uvm_component parent);
            super.new(name, parent);
            dff_cov_grp = new();
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            cov_export = new("cov_export", this);
            cov_dff = new("cov_dff", this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            cov_export.connect(cov_dff.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // Get the next transaction from the analysis FIFO.
                cov_dff.get(seq_item_cov);
                dff_cov_grp.sample();
            end
        endtask
    endclass : DFF_coverage

endpackage : DFF_coverage_pkg