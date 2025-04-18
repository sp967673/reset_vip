module tb;
  import uvm_pkg::*;
  import reset_vip_pkg::*;
  
  bit clk;
  initial forever #5 clk = ~clk;
  
  // Instantiate the interface
  reset_if reset_intf(clk);
  
  // DUT instance (example)
  dut my_dut(
    .clk(clk),
    .reset_n(reset_intf.reset_n)
  );
  
  initial begin
    // Assign the virtual interface to the agent
    uvm_config_db#(virtual reset_if)::set(null, "uvm_test_top.env.reset_agent", "vif", reset_intf);
    
    // Start the test
    run_test("reset_test");
  end
endmodule
