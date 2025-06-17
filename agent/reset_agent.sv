
`ifndef RESET_AGENT_SV
`define RESET_AGENT_SV

class reset_agent extends uvm_agent;
  reset_driver driver;
  uvm_sequencer #(reset_transaction) sequencer;
  reset_monitor monitor;

  virtual reset_if vif;
  
  `uvm_component_utils(reset_agent)
  
  function new(string name="reset_agent", uvm_component parent);
      super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      monitor = reset_monitor::type_id::create("monitor", this);

      if (get_is_active() == UVM_ACTIVE) begin
          driver = reset_driver::type_id::create("driver", this);
          sequencer = uvm_sequencer#(reset_transaction)::type_id::create("sequencer", this);
      end

      if (!uvm_config_db#(virtual reset_if)::get(this, "", "vif", vif)) begin
          `uvm_fatal("NOVIF", $sformatf("Cannot get interface"))
      end else begin
          uvm_config_db#(virtual reset_if)::set(this, "monitor", "vif", vif);
          uvm_config_db#(virtual reset_if)::set(this, "driver", "vif", vif);
      end

  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if (get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction
  
endclass

`endif //RESET_AGENT_SV
