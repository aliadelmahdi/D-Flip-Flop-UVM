package DFF_env_pkg; 
    import  uvm_pkg::*,
            DFF_driver_pkg::*,
            DFF_scoreboard_pkg::*,
            DFF_main_sequence_pkg::*,
            DFF_reset_sequence_pkg::*,
            DFF_seq_item_pkg::*,
            DFF_sequencer_pkg::*,
            DFF_monitor_pkg::*,
            DFF_config_pkg::*,
            DFF_agent_pkg::*,
            DFF_coverage_pkg::*;
    `include "uvm_macros.svh"

    class DFF_env extends uvm_env;
        `uvm_component_utils(DFF_env)

        DFF_agent dff_agent;
        DFF_scoreboard dff_sb;
        DFF_coverage dff_cov;

        function new (string name = "DFF_env", uvm_component parent);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase );
        super.build_phase (phase);
            dff_agent = DFF_agent ::type_id ::create("dff_agent",this);
            dff_sb= DFF_scoreboard ::type_id ::create("sb",this);
            dff_cov= DFF_coverage ::type_id ::create("cov",this);
        endfunction

        function void connect_phase (uvm_phase phase );
            dff_agent.agent_ap.connect(dff_sb.sb_export);
            dff_agent.agent_ap.connect(dff_cov.cov_export);
        endfunction
    endclass : DFF_env
endpackage : DFF_env_pkg