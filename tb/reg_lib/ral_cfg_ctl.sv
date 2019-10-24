// Register definition for the register called "ctl"
class ral_cfg_ctl extends uvm_reg;
    rand uvm_reg_field mod_en;      // Enables the module
    rand uvm_reg_field bl_yellow;   // Blinks yellow
    rand uvm_reg_field bl_red;      // Blinks red
    rand uvm_reg_field profile;     // 1 : Peak, 0 : Off-Peak

    `uvm_object_utils(ral_cfg_ctl)

    function new(string name = "traffic_cfg_ctrl");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    // Build all register field objects
    virtual function void build();
        this.mod_en     = uvm_reg_field::type_id::create("mod_en",,   get_full_name());
        this.bl_yellow  = uvm_reg_field::type_id::create("bl_yellow",,get_full_name());
        this.bl_red     = uvm_reg_field::type_id::create("bl_red",,   get_full_name());
        this.profile    = uvm_reg_field::type_id::create("profile",,  get_full_name());

        // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible); 
        this.mod_en.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 0);
        this.bl_yellow.configure(this, 1, 1, "RW", 0, 3'h4, 1, 0, 0);
        this.bl_red.configure(this, 1, 2, "RW", 0, 1'h0, 1, 0, 0);
        this.profile.configure(this, 1, 3, "RW", 0, 1'h0, 1, 0, 0);
    endfunction
endclass