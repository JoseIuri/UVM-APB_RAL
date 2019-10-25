class my_sequence extends uvm_reg_sequence();
   `uvm_object_utils (my_sequence)
   function new (string name = "my_sequence");
      super.new (name);
   endfunction
 
   virtual task body ();

      ral_block_traffic_cfg    m_ral_model;  
      
      uvm_reg_data_t rdata;
      uvm_status_e   status;
      int            reg_idx = 1;

      $cast(m_ral_model, model);

      write_reg(m_ral_model.ctrl, status, 32'd3);
      write_reg(m_ral_model.timer[0], status, 32'b00000010000000000000100000000001);
      write_reg(m_ral_model.timer[1], status, 32'd0);
      read_reg(m_ral_model.timer[1], status, rdata );
   
   endtask
endclass