// These registers are grouped together to form a register block called "cfg"
class ral_block_traffic_cfg extends uvm_reg_block;
  rand ral_cfg_ctl    ctrl;       // RW
  rand ral_cfg_timer  timer[2];   // RW
         ral_cfg_stat   stat;       // RO
 
  `uvm_object_utils(ral_block_traffic_cfg)
 
  function new(string name = "traffic_cfg");
    super.new(name, build_coverage(UVM_NO_COVERAGE));
  endfunction
 
  virtual function void build();
    this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 0);
    this.ctrl = ral_cfg_ctl::type_id::create("ctrl",,get_full_name());
    this.ctrl.configure(this, null, "");
    this.ctrl.build();
    this.default_map.add_reg(this.ctrl, `UVM_REG_ADDR_WIDTH'h0, "RW", 0);
 
 
    this.timer[0] = ral_cfg_timer::type_id::create("timer[0]",,get_full_name());
    this.timer[0].configure(this, null, "");
    this.timer[0].build();
    this.default_map.add_reg(this.timer[0], `UVM_REG_ADDR_WIDTH'h4, "RW", 0);
 
    this.timer[1] = ral_cfg_timer::type_id::create("timer[1]",,get_full_name());
    this.timer[1].configure(this, null, "");
    this.timer[1].build();
    this.default_map.add_reg(this.timer[1], `UVM_REG_ADDR_WIDTH'h8, "RW", 0);
 
    this.stat = ral_cfg_stat::type_id::create("stat",,get_full_name());
    this.stat.configure(this, null, "");
    this.stat.build();
    this.default_map.add_reg(this.stat, `UVM_REG_ADDR_WIDTH'hc, "RO", 0);
  endfunction 
endclass 