package DFF_scoreboard_pkg;
    import uvm_pkg::*;
    import DFF_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class DFF_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(DFF_scoreboard)
        uvm_analysis_export #(DFF_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(DFF_seq_item) sb_dff;
        DFF_seq_item seq_item_sb;

        logic q_ref;
        int error_count = 0, correct_count = 0;

        function new(string name = "DFF_scoreboard",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            sb_export = new("sb_export",this);
            sb_dff=new("sb_dff",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            sb_export.connect(sb_dff.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sb_dff.get(seq_item_sb);
                check_results(seq_item_sb);
            end
        endtask

        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("At time %0t: Simulation Ends and Error count= %0d, Correct count = %0d",$time,error_count,correct_count),UVM_MEDIUM);
        endfunction

        function void check_results(DFF_seq_item seq_item_ch);
            golden_model(seq_item_ch);
            if (seq_item_ch.q != q_ref) begin
                error_count++;
                `uvm_error("run_phase","Comparison Error between the golden model and the DUT")
            end
            else
                correct_count++;
        endfunction

        function void golden_model(DFF_seq_item seq_item_chk);
            if(seq_item_chk.rst)
                q_ref = 0;
            else begin
                if(seq_item_chk.en)
                    q_ref = seq_item_chk.d;
                else
                    q_ref = q_ref;
            end
        endfunction

    endclass : DFF_scoreboard
endpackage : DFF_scoreboard_pkg