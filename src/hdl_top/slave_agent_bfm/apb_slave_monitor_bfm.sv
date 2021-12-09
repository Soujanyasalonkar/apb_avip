`ifndef APB_SLAVE_MONITOR_BFM_INCLUDED_
`define APB_SLAVE_MONITOR_BFM_INCLUDED_

//-------------------------------------------------------
// Importing apb global package
//-------------------------------------------------------
import apb_global_pkg::*;

//--------------------------------------------------------------------------------------------
// Inteface       : apb Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy 
// to call the tasks and functions from apb monitor bfm to apb monitor proxy
//--------------------------------------------------------------------------------------------
interface apb_slave_monitor_bfm (input bit pclk,
                                 input bit preset_n,
                                 input bit [2:0]pprot,
                                 input bit pslverr,
                                 input bit pready,
                                 input logic penable,
                                 input logic pwrite,
                                 input logic [ADDRESS_WIDTH-1:0] paddr,
                                 input logic pselx,
                                 input logic [DATA_WIDTH-1:0] pwdata,
                                 input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                                 input logic [DATA_WIDTH-1:0] prdata);
  //-------------------------------------------------------
  // Importing uvm_pkg file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Creating handle for apb slave monitor proxy
  //-------------------------------------------------------
  import apb_slave_pkg::apb_slave_monitor_proxy;
  apb_slave_monitor_proxy apb_slave_mon_proxy_h;
 
  initial begin
   `uvm_info("apb slave monitor bfm",$sformatf("APB SLAVE MONITOR BFM"),UVM_LOW);
  end

  //-------------------------------------------------------
  // Task: wait_for_preset_n
  // Waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_preset_n();
    @(posedge preset_n);
    `uvm_info("SLAVE_MONITOR_BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    
    @(negedge preset_n);
    `uvm_info("SLAVE_MONITOR_BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask: wait_for_preset_n

  //-------------------------------------------------------
  // Task: drive_idle_state
  // This task waits for the apb on interface
  //
  // Parameter: 
  // pselx - this signal selects the slave
  // penable - enable signal
  //-------------------------------------------------------
  //task wait_for_idle_state();
  //  @(negedge pclk);
  //  while (pselx == '0) begin
  //    @(negedge pclk);
  //    `uvm_info("SLAVE_MONITOR_BFM",$sformatf("WAITING FOR THE IDLE STATE"),UVM_HIGH)
  //  end
  //  `uvm_info("SLAVE_MONITOR_BFM",$sformatf("IDLE STATE"),UVM_HIGH)
  //endtask: wait_for_idle_state

  //-------------------------------------------------------
  // Task: wait_for_transfer_start
  // Waits for penable to be active high
  //
  // Parameter:
  // penable - enable signal
  //-------------------------------------------------------
  //task wait_for_transfer_start();
  //  @(negedge pclk);
  //  while (penable==1 && pready==1 && pselx==1) begin
  //    @(negedge pclk);
  //  end
  // `uvm_info("SLAVE_MONITOR_BFM",$sformatf("WAITING FOR THE TRANSFER TO START"),UVM_HIGH)
  //endtask: wait_for_transfer_start

  task sample_data(output apb_transfer_char_s apb_data_packet,input apb_transfer_cfg_s apb_cfg_packet);
    if(penable==1 && pready==1 && $countones(pselx)==1) begin
      //TODO(saha): if condition for write and read
      apb_data_packet.prdata = prdata;
      apb_data_packet.pwdata = pwdata;
    end
   `uvm_info("SLAVE_MONITOR_BFM",$sformatf("SLAVE_SAMPLE_DATA"),UVM_HIGH)
  endtask: sample_data

endinterface : apb_slave_monitor_bfm

`endif

