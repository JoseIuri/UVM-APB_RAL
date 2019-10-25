interface apb_if (input pclk, input presetn);
   logic [31:0]   paddr;
   logic [31:0]   pwdata;
   logic [31:0]   prdata;
   logic          pwrite;
   logic          psel;
   logic          penable;
   logic          presetn;
endinterface