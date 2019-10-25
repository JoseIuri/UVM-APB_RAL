class traffic_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (traffic_scoreboard)

    bit [31:0] result;

    apb_tr tr_in;

    ral_block_traffic_cfg m_ral_model;

    uvm_analysis_imp #(apb_tr, traffic_scoreboard) apb_export;
 
    function new (string name = "traffic_scoreboard", uvm_component parent = null);
      super.new (name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        apb_export = new ("apb_export", this);
    endfunction

    virtual function void write (apb_tr t);
        tr_in = apb_tr::type_id::create("tr_in", this);
        tr_in.copy(t);

        if (!tr_in.write) begin
            case (tr_in.addr)
                'h0 : result = m_ral_model.ctrl.get_mirrored_value();
                'h4 : result = m_ral_model.timer[0].get_mirrored_value();
                'h8 : result = m_ral_model.timer[1].get_mirrored_value();
                'hc : result = m_ral_model.stat.get_mirrored_value();
            endcase

            if (result == tr_in.data) begin
                `uvm_info("MATCH", $sformatf("[MATCH]"), UVM_LOW)
            end
            else begin
                `uvm_error("REGISTER ERROR:", $sformatf("[MISSMATCH] Expected data value %0h actual %0h", result, tr_in.data))
            end
        end 

    endfunction
endclass