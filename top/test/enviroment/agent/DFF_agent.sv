package DFF_agent_pkg;
    import uvm_pkg::*,
    DFF_seq_item_pkg::*,
    DFF_driver_pkg::*,
    DFF_main_sequence_pkg::*,
    DFF_reset_sequence_pkg::*,
    DFF_sequencer_pkg::*,
    DFF_monitor_pkg::*,
    DFF_config_pkg::*;
    `include "uvm_macros.svh"
 
    class DFF_agent extends uvm_agent;

        `uvm_component_utils(DFF_agent)
        DFF_sequencer dff_seqr;
        DFF_driver dff_drv;
        DFF_monitor dff_mon;
        DFF_config dff_cnfg;
        uvm_analysis_port #(DFF_seq_item) agent_ap;

        function new(string name = "DFF_agent", uvm_component parent);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if(!uvm_config_db #(DFF_config)::get(this,"","CFG",dff_cnfg)) 
                `uvm_fatal ("build_phase","Unable to get configuration object from the database")
            
            dff_drv = DFF_driver::type_id::create("drv",this);
            dff_seqr = DFF_sequencer::type_id::create("dff_seqr",this);
            dff_mon = DFF_monitor::type_id::create("mon",this);
            agent_ap = new("agent_ap",this);
        endfunction

        function void connect_phase(uvm_phase phase);

            dff_drv.dff_if = dff_cnfg.dff_if;
            dff_mon.dff_if = dff_cnfg.dff_if;

            dff_drv.seq_item_port.connect(dff_seqr.seq_item_export);
            dff_mon.monitor_ap.connect(agent_ap);
        endfunction

    endclass : DFF_agent

endpackage : DFF_agent_pkg