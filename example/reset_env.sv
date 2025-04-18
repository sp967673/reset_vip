class reset_env extends uvm_env;
  `uvm_component_utils(reset_env)
  
  reset_agent reset_agent;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_agent = reset_agent::type_id::create("reset_agent", this);
    reset_agent.is_active = UVM_ACTIVE;
  endfunction
endclass
