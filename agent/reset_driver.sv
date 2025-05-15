
`ifndef RESET_DRIVER_SV
`define RESET_DRIVER_SV

class reset_driver extends uvm_driver #(reset_transaction);
  virtual reset_if vif;
  
  `uvm_component_utils(reset_driver)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if (!uvm_config_db#(virtual reset_if)::get(this, "", "vif", vif))
          `uvm_fatal("NOVIF", $sformatf("Cannot get interface"))
  endfunction: build_phase
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive_reset(req);
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive_reset(reset_transaction tr);
    // Wait for initial delay
    repeat(tr.delay_before_reset) @(posedge vif.clock);
    
    // Align with clock if requested
    if (tr.sync_to_clock) begin
        @(posedge vif.clock);
    end else begin
        #($urandom_range(1,3) * 1ps);
    end
    
    // Assert reset
    vif.reset_n = tr.active_low ? 0 : 1;
    
    // Hold reset for specified duration
    repeat(tr.reset_width_cycles) @(posedge vif.clock);
    
    // Deassert reset
    vif.reset_n = tr.active_low ? 1 : 0;
    
    `uvm_info("DRV", $sformatf("Reset driven: %0s for %0d cycles, %0s to clock",
      tr.active_low ? "active-low" : "active-high",
      tr.reset_width_cycles,
      tr.sync_to_clock ? "synchronous" : "asynchronous"), UVM_MEDIUM)
  endtask
endclass

`endif //RESET_DRIVER_SV
