class reg_rw_test extends base_test;
   `uvm_component_utils (reg_rw_test)
    
    my_sequence m_seq;
   
   function new (string name="reg_rw_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual task main_phase(uvm_phase phase);

      phase.raise_objection(this);
      m_seq = my_sequence::type_id::create("m_seq");

      m_seq.model = m_ral_model;


      m_seq.start(m_env.m_agent.m_seqr);

      phase.drop_objection(this);
   endtask
endclass