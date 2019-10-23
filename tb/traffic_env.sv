class traffic_env extends uvm_env;
   `uvm_component_utils (traffic_env)
   
   apb_agent      m_agent;   
   reg_env        m_reg_env;
   
   function new (string name = "traffic_env", uvm_component parent);
      super.new (name, parent);
   endfunction
   
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_agent = apb_agent::type_id::create ("m_agent", this);
      m_reg_env = reg_env::type_id::create ("m_reg_env", this);
      uvm_reg::include_coverage ("*", UVM_CVR_ALL);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      m_reg_env.m_agent = m_agent;
//      m_reg_env.m_reg2apb.tmp_seqr = m_reg_env.m_agent.m_seqr;
      m_agent.m_mon.mon_ap.connect (m_reg_env.m_apb2reg_predictor.bus_in);
      m_reg_env.m_ral_model.default_map.set_sequencer(m_agent.m_seqr, m_reg_env.m_reg2apb);
   endfunction

endclass