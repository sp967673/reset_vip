
`ifndef RESET_AGENT_SV
`define RESET_AGENT_SV

class reset_agent extends uvm_agent;
  reset_driver driver;
  reset_sequencer sequencer;
  reset_monitor monitor;
  
  `uvm_component_utils(reset_agent)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = reset_monitor::type_id::create("monitor", this);
    
    if (get_is_active() == UVM_ACTIVE) begin
      driver = reset_driver::type_id::create("driver", this);
      sequencer = reset_sequencer::type_id::create("sequencer", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    monitor.vif = vif;
    
    if (get_is_active() == UVM_ACTIVE) begin
      driver.vif = vif;
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction
  
  // Virtual interface assignment
  virtual reset_if vif;
endclass

`endif //RESET_AGENT_SV
