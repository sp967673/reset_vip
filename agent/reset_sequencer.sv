
`ifndef RESET_SEQUENCER_SV
`define RESET_SEQUENCER_SV

class reset_sequencer extends uvm_sequencer #(reset_transaction);
    `uvm_component_utils(reset_sequencer)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
endclass

`endif //RESET_SEQUENCER_SV

