module top;
  import uvm_pkg::*;
  import my_pkg::*;
  
  parameter min_cover = 70;
  parameter min_transa = 2000;
  bit pclk;
  bit presetn;
  
  always #10 pclk = ~pclk;

  initial begin
    presetn = 0;
    #10 presetn = 1;
  end

  apb_if   apb_if (pclk, presetn);

  traffic  pB0 (.pclk    (apb_if.pclk),
                .presetn (apb_if.presetn),
                .paddr   (apb_if.paddr),
                .pwdata  (apb_if.pwdata),
                .prdata  (apb_if.prdata),
                .psel    (apb_if.psel),
                .pwrite  (apb_if.pwrite),
                .penable (apb_if.penable));

  initial begin 
    `ifdef XCELIUM
       $recordvars();
    `endif
    `ifdef VCS
       $vcdpluson;
    `endif
    `ifdef QUESTA
       $wlfdumpvars();
       set_config_int("*", "recording_detail", 1);
    `endif
    
    uvm_config_db #(virtual apb_if)::set (null, "uvm_test_top.*", "apb_if", apb_if);
    run_test ("reg_rw_test");
  end
endmodule