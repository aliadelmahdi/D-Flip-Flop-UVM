package DFF_test_pkg;

    import  uvm_pkg::*,
            DFF_env_pkg::*,
            DFF_config_pkg::*,
            DFF_driver_pkg::*,
            DFF_main_sequence_pkg::*,
            DFF_reset_sequence_pkg::*,
            DFF_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class DFF_test extends uvm_test;

        `uvm_component_utils(DFF_test)
        DFF_env dff_env;
        DFF_config dff_cnfg;
        virtual DFF_if dff_if;
        DFF_main_sequence dff_main_seq;
        DFF_reset_sequence dff_reset_seq;

        function new(string name = "DFF_test", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            dff_env = DFF_env::type_id::create("env",this);
            dff_cnfg = DFF_config::type_id::create("DFF_config",this);
            dff_main_seq = DFF_main_sequence::type_id::create("main_seq",this);
            dff_reset_seq = DFF_reset_sequence::type_id::create("reset_seq",this);

            if(!uvm_config_db #(virtual DFF_if)::get(this,"","dff_if",dff_cnfg.dff_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the virtual interface of the DFF form the configuration database");

            uvm_config_db # (DFF_config)::set (this , "*" , "CFG",dff_cnfg );
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);

            // Reset sequence
            `uvm_info("run_phase","stimulus Generation started",UVM_LOW)
            dff_reset_seq.start(dff_env.dff_agent.dff_seqr);
            `uvm_info("run_phase","Reset Deasserted",UVM_LOW)
            
            // Main Sequence
            `uvm_info("run_phase", "Stimulus Generation Started",UVM_LOW)
            dff_main_seq.start(dff_env.dff_agent.dff_seqr);
            `uvm_info("run_phase", "Stimulus Generation Ended",UVM_LOW) 

            phase.drop_objection(this);
        endtask
    endclass : DFF_test
endpackage : DFF_test_pkg