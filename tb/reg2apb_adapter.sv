class reg2apb_adapter extends uvm_reg_adapter;
   `uvm_object_utils (reg2apb_adapter)
 
   function new (string name = "reg2apb_adapter");
      super.new (name);
   endfunction
 
   virtual function uvm_sequence_item reg2bus (const ref uvm_reg_bus_op rw);
      apb_tr tr = apb_tr::type_id::create ("tr");
      tr.write = (rw.kind == UVM_WRITE) ? 1: 0;
      tr.addr  = rw.addr;
      tr.data  = rw.data;
      `uvm_info ("adapter", $sformatf ("reg2bus addr=0x%0h data=0x%0h kind=%s", tr.addr, tr.data, rw.kind.name), UVM_DEBUG) 
      return tr; 
   endfunction
 
   virtual function void bus2reg (uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
      apb_tr tr;
      if (! $cast (tr, bus_item)) begin
         `uvm_fatal ("reg2apb_adapter", "Failed to cast bus_item to tr")
      end
 
      rw.kind = tr.write ? UVM_WRITE : UVM_READ;
      rw.addr = tr.addr;
      rw.data = tr.data;
      `uvm_info ("adapter", $sformatf("bus2reg : addr=0x%0h data=0x%0h kind=%s status=%s", rw.addr, rw.data, rw.kind.name(), rw.status.name()), UVM_DEBUG)
   endfunction
endclass