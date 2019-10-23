class apb_tr extends uvm_sequence_item;
   rand bit [31:0]  addr;
   rand bit [31:0]  data;
   rand bit         write;
 
   `uvm_object_utils_begin (apb_tr)
      `uvm_field_int (addr, UVM_ALL_ON)
      `uvm_field_int (data, UVM_ALL_ON)
      `uvm_field_int (write, UVM_ALL_ON)
   `uvm_object_utils_end
 
   function new (string name = "apb_tr");
      super.new (name);
   endfunction
 
   constraint c_addr { addr inside {0, 4, 8};}
endclass