class reset_test extends uvm_test;
  `uvm_component_utils(reset_test)
  
  // Test environment
  reset_env env;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = reset_env::type_id::create("env", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    base_reset_sequence seq;
    
    phase.raise_objection(this);
    
    // Create and start sequence with specific parameters
    seq = base_reset_sequence::type_id::create("seq");
    assert(seq.randomize() with {
      reset_width == 8;
      delay == 3;
      sync == 1;
      active_low == 1;
    });
    seq.start(env.reset_agent.sequencer);
    
    // Start another sequence with different parameters
    #100;
    assert(seq.randomize() with {
      reset_width == 15;
      delay == 0;
      sync == 0;
      active_low == 0;
    });
    seq.start(env.reset_agent.sequencer);
    
    phase.drop_objection(this);
  endtask
endclass
