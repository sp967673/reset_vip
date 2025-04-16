
`ifndef RESET_TRANSACTION_SV
`define RESET_TRANSACTION_SV

class reset_transaction extends uvm_sequence_item;
  rand int reset_width_cycles;  // Duration of reset in clock cycles
  rand bit sync_to_clock;       // Whether to align with clock edge
  rand int delay_before_reset;  // Cycles to wait before asserting reset
  rand bit active_low;          // Active low (0) or active high (1) reset
  
  `uvm_object_utils_begin(reset_transaction)
    `uvm_field_int(reset_width_cycles, UVM_DEFAULT)
    `uvm_field_int(sync_to_clock, UVM_DEFAULT)
    `uvm_field_int(delay_before_reset, UVM_DEFAULT)
    `uvm_field_int(active_low, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "reset_transaction");
    super.new(name);
  endfunction
  
  constraint reasonable_values {
    reset_width_cycles inside {[1:100]};
    delay_before_reset inside {[0:50]};
  }
endclass

`endif //RESET_TRANSACTION_SV
