class apb_monitor extends uvm_monitor;
   `uvm_component_utils (apb_monitor)
   function new (string name="apb_monitor", uvm_component parent);
      super.new (name, parent);
   endfunction
 
   uvm_analysis_port #(apb_tr)  mon_ap;
   virtual apb_if                vif;
 
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      mon_ap = new ("mon_ap", this);
      uvm_config_db #(virtual apb_if)::get (null, "uvm_test_top.*", "apb_if", vif);
   endfunction
 
   virtual task run_phase (uvm_phase phase);
      fork
         @(posedge vif.presetn);
         forever begin
            @(posedge vif.pclk);
            if (vif.psel & vif.penable & vif.presetn) begin
               apb_tr tr = apb_tr::type_id::create ("tr");
               tr.addr = vif.paddr;
               if (vif.pwrite)
                  tr.data = vif.pwdata;
               else
                  tr.data = vif.prdata;
               tr.write = vif.pwrite;
               mon_ap.write (tr);
            end 
         end
      join_none
   endtask
endclass
