class reset_seq extends uvm_sequence;
   `uvm_object_utils (reset_seq)
   function new (string name = "reset_seq");
      super.new (name);
   endfunction

   virtual apb_if    vif; 

   task body ();
      if (!uvm_config_db #(virtual apb_if) :: get (null, "uvm_test_top.*", "apb_if", vif)) 
         `uvm_fatal ("VIF", "No vif")

      `uvm_info ("RESET", "Running reset ...", UVM_MEDIUM);
      vif.presetn <= 0;
      @(posedge vif.pclk) vif.presetn <= 1;
      @(posedge vif.pclk);
   endtask
endclass
