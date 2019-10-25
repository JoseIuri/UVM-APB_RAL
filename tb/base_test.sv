class base_test extends uvm_test;
   `uvm_component_utils (base_test)

   traffic_env             m_env;
   ral_block_traffic_cfg   m_ral_model;

   function new (string name = "base_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_env = traffic_env::type_id::create ("m_env", this);
      
      m_ral_model = ral_block_traffic_cfg::type_id::create("jb_reg_block");
      m_ral_model.build();

      m_env.m_ral_model = m_ral_model;

//      factory.set_type_override_by_type(ral_sample1::get_type(), my_sample::get_type()); 
//      factory.print();
   endfunction

   virtual task reset_phase (uvm_phase phase);
      super.reset_phase (phase);
      phase.raise_objection (this);
      phase.drop_objection (this);
   endtask

   virtual task main_phase (uvm_phase phase);
      phase.raise_objection (this);
      phase.drop_objection (this);
   endtask
endclass