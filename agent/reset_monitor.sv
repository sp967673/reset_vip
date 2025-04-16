  

`ifndef RESET_MONITOR_SV
`define RESET_MONITOR_SV

class reset_monitor extends uvm_monitor;
  virtual reset_if vif;
  uvm_analysis_port #(reset_transaction) ap;
  
  `uvm_component_utils(reset_monitor)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(negedge vif.reset_n or posedge vif.reset_n);
      detect_reset();
    end
  endtask
  
  virtual task detect_reset();
    reset_transaction tr;
    int reset_count = 0;
    bit active_low = (vif.reset_n === 0); // Detect polarity
    
    tr = reset_transaction::type_id::create("tr");
    tr.active_low = active_low;
    
    // Wait for reset assertion
    if (active_low) wait(vif.reset_n === 0);
    else wait(vif.reset_n === 1);
    
    // Count cycles while reset is active
    while (active_low ? (vif.reset_n === 0) : (vif.reset_n === 1)) begin
      @(posedge vif.clock);
      reset_count++;
    end
    
    tr.reset_width_cycles = reset_count;
    ap.write(tr);
    
    `uvm_info("MON", $sformatf("Detected reset: %0s for %0d cycles",
      active_low ? "active-low" : "active-high",
      reset_count), UVM_MEDIUM)
  endtask
endclass

`endif //RESET_MONITOR_SV
