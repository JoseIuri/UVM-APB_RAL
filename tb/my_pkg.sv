package my_pkg;

// Import the UVM library and include the UVM macros
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "apb_tr.sv"

`include "./reg_lib/ral_cfg_stat.sv"
`include "./reg_lib/ral_cfg_timer.sv"
`include "./reg_lib/ral_cfg_ctl.sv"
`include "./reg_lib/ral_block_traffic_cfg.sv"
//`include "./reg_lib/ral_sys_traffic.sv"

`include "reg2apb_adapter.sv"

//`include "./seq_lib/reset_seq.sv"
`include "./seq_lib/my_sequence.sv"

`include "apb_monitor.sv"
`include "apb_driver.sv"
`include "apb_agent.sv"
`include "traffic_scoreboard.sv"
`include "traffic_env.sv"

`include "base_test.sv"
`include "block_test.sv"
`include "reg_rw_test.sv"

endpackage