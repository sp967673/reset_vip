
`ifndef RESET_VIP_PKG
`define RESET_VIP_PKG

`include "reset_if.sv"

package reset_vip_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `timescale 1ns/1ps

  `include "reset_transaction.sv"
  `include "reset_driver.sv"
  `include "reset_monitor.sv"
  `include "reset_agent.sv"
  `include "reset_sequences.sv"

endpackage

`endif //RESET_VIP_PKG_SV
