class block_test extends base_test;
   `uvm_component_utils (block_test)
   function new (string name="block_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual task main_phase(uvm_phase phase);
      ral_block_traffic_cfg   m_ral_model;
      uvm_reg_block     blk;
      int               rdata;

      phase.raise_objection(this);
      uvm_config_db #(ral_block_traffic_cfg)::get (null, "uvm_test_top", "m_ral_model", m_ral_model);
      `uvm_info ("INFO", "This test simply checks the register model desired/mirrored values after reset", UVM_MEDIUM)

      `uvm_info ("BLOCK", $sformatf ("default_path = %s", m_ral_model.default_path.name()), UVM_MEDIUM)
      `uvm_info ("BLOCK", $sformatf ("get_name() = %s", m_ral_model.get_name()), UVM_MEDIUM)
      `uvm_info ("BLOCK", $sformatf ("get_full_name() = %s", m_ral_model.get_full_name()), UVM_MEDIUM)

      phase.drop_objection(this);
   endtask
endclass