class my_sequence extends uvm_sequence;
   `uvm_object_utils (my_sequence)
   function new (string name = "my_sequence");
      super.new (name);
   endfunction

   ral_sys_traffic    m_ral_model;  
 
   virtual task body ();
      int rdata;
      uvm_status_e   status;
      uvm_reg        my_reg;
      int            reg_idx = 1;
      uvm_config_db #(ral_sys_traffic)::get (null, "uvm_test_top", "m_ral_model", m_ral_model);

      my_reg = m_ral_model.cfg.get_reg_by_name("ctrl");
      `uvm_info("body", $sformatf("reg=%s", my_reg.get_full_name()), UVM_MEDIUM)
   endtask
endclass