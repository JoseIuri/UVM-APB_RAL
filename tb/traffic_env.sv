class traffic_env extends uvm_env;
   `uvm_component_utils (traffic_env)      

   ral_block_traffic_cfg          m_ral_model;         // Register Model
   uvm_reg_predictor #(apb_tr)    m_apb2reg_predictor; // Map APB tx to register in model
   apb_agent                      m_agent;             // Agent to drive/monitor transactions
   traffic_scoreboard             m_scoreboard;        // Scoreboard
   
   function new (string name = "traffic_env", uvm_component parent);
      super.new (name, parent);
   endfunction
   
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_agent = apb_agent::type_id::create ("m_agent", this);

      m_ral_model          = ral_block_traffic_cfg::type_id::create ("m_ral_model", this);
      m_ral_model.build();
      m_apb2reg_predictor  = uvm_reg_predictor #(apb_tr) :: type_id :: create ("m_apb2reg_predictor", this);

      m_scoreboard = traffic_scoreboard::type_id::create("jb_fc_sub", this );
      
      uvm_config_db #(ral_block_traffic_cfg)::set (null, "uvm_test_top", "m_ral_model", m_ral_model);

      uvm_reg::include_coverage ("*", UVM_CVR_ALL);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);

      m_agent.ag_ap.connect(m_scoreboard.apb_export);
      
      m_ral_model.reg_map.set_auto_predict(0);
      m_ral_model.reg_map.set_sequencer(m_agent.m_seqr, m_agent.reg2apb);

      m_apb2reg_predictor.map       = m_ral_model.reg_map;
      m_apb2reg_predictor.adapter   = m_agent.reg2apb;
      m_agent.ag_ap.connect(m_apb2reg_predictor.bus_in);

      m_scoreboard.m_ral_model = m_ral_model;
   endfunction

endclass