module traffic (  input          pclk,
                  input          presetn,
                  input [31:0]   paddr,
                  input [31:0]   pwdata,
                  input          psel,
                  input          pwrite,
                  input          penable,
 
                  // Outputs
                  output [31:0]  prdata);
 
   reg [3:0]      ctl_reg;    // profile, blink_red, blink_yellow, mod_en RW
   reg [1:0]      stat_reg;   // state[1:0] 
   reg [31:0]     timer_0;    // timer_g2y[31:20], timer_r2g[19:8], timer_y2r[7:0] RW
   reg [31:0]     timer_1;    // timer_g2y[31:20], timer_r2g[19:8], timer_y2r[7:0] RW
 
   reg [31:0]     data_in;
   reg [31:0]     rdata_tmp;
 
   // Set all registers to default values
   always @ (posedge pclk) begin
      if (!presetn) begin
         data_in <= 0;
         ctl_reg  <= 0; 
         stat_reg <= 0; 
         timer_0  <= 32'hcafe_1234; 
         timer_1  <= 32'hface_5678;
      end
   end
 
   // Capture write data
   always @ (posedge pclk) begin
      if (presetn & psel & penable) 
         if (pwrite) 
            case (paddr)
               'h0   : ctl_reg <= pwdata;
               'h4   : timer_0 <= pwdata;
               'h8   : timer_1 <= pwdata;
               'hc   : stat_reg <= pwdata;
            endcase
   end
 
   // Provide read data
   always @ (penable) begin
      if (psel & !pwrite) 
         case (paddr)
            'h0 : rdata_tmp <= ctl_reg;
            'h4 : rdata_tmp <= timer_0;
            'h8 : rdata_tmp <= timer_1;
            'hc : rdata_tmp <= stat_reg;
         endcase
   end
 
   assign prdata = (psel & penable & !pwrite) ? rdata_tmp : 'hz;
 
endmodule