
`ifndef RESET_SEQUENCES_SV
`define RESET_SEQUENCES_SV

class base_reset_sequence extends uvm_sequence #(reset_transaction);

  rand int reset_width = 10;
  rand int delay = 0;
  rand bit sync = 1;
  rand bit active_low = 1;

  `uvm_object_utils_begin(base_reset_sequence)
      `uvm_field_int (reset_width, UVM_ALL_ON)
      `uvm_field_int (delay,       UVM_ALL_ON)
      `uvm_field_int (sync,        UVM_ALL_ON)
      `uvm_field_int (active_low,  UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "base_reset_sequence");
    super.new(name);
  endfunction
  
  task body();
    reset_transaction tr;
    
    tr = reset_transaction::type_id::create("tr");
    start_item(tr);
    assert(tr.randomize() with {
      reset_width_cycles == local::reset_width;
      delay_before_reset == local::delay;
      sync_to_clock == local::sync;
      active_low == local::active_low;
    });
    finish_item(tr);
  endtask
endclass

// Short synchronous reset sequence
class short_sync_reset_sequence extends base_reset_sequence;
  `uvm_object_utils(short_sync_reset_sequence)
  
  function new(string name = "short_sync_reset_sequence");
    super.new(name);
    reset_width = 2;
    delay = 1;
    sync = 1;
  endfunction
endclass

// Long asynchronous reset sequence
class long_async_reset_sequence extends base_reset_sequence;
  `uvm_object_utils(long_async_reset_sequence)
  
  function new(string name = "long_async_reset_sequence");
    super.new(name);
    reset_width = 20;
    delay = 5;
    sync = 0;
  endfunction
endclass

`endif //RESET_SEQUENCES_SV
