class traffic_env extends uvm_env;
   `uvm_component_utils (traffic_env)      

   ral_sys_traffic                m_ral_model;         // Register Model
   reg2apb_adapter                m_reg2apb;           // Convert Reg Tx <-> Bus-type packets
   uvm_reg_predictor #(apb_tr)   m_apb2reg_predictor; // Map APB tx to register in model
   apb_agent                      m_agent;             // Agent to drive/monitor transactions
   
   function new (string name = "traffic_env", uvm_component parent);
      super.new (name, parent);
   endfunction
   
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_agent = apb_agent::type_id::create ("m_agent", this);

      m_ral_model          = ral_sys_traffic::type_id::create ("m_ral_model", this);
      m_reg2apb            = reg2apb_adapter :: type_id :: create ("m_reg2apb");
      m_apb2reg_predictor  = uvm_reg_predictor #(apb_tr) :: type_id :: create ("m_apb2reg_predictor", this);
 
      m_ral_model.build ();
      m_ral_model.lock_model ();
      
      uvm_config_db #(ral_sys_traffic)::set (null, "uvm_test_top", "m_ral_model", m_ral_model);

      uvm_reg::include_coverage ("*", UVM_CVR_ALL);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);

      m_apb2reg_predictor.map       = m_ral_model.default_map;
      m_apb2reg_predictor.adapter   = m_reg2apb;

      m_agent.m_mon.mon_ap.connect (m_apb2reg_predictor.bus_in);
      m_ral_model.default_map.set_sequencer(m_agent.m_seqr, m_reg2apb);
   endfunction

endclass