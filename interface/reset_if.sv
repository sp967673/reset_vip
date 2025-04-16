
`ifndef RESET_IF_SV
`define RESET_IF_SV

interface reset_if(input bit clock);
  logic reset_n;
  
  // Clocking block for synchronous drives
  clocking drv_cb @(posedge clock);
    output reset_n;
  endclocking
  
  // Modport for driver
  modport drv_mp(clocking drv_cb, output reset_n);
  
  // Modport for monitor
  modport mon_mp(input clock, input reset_n);
endinterface

`endif //RESET_IF_SV
