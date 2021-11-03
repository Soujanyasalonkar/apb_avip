`ifndef APB_GLOBAL_PKG_INCLUDED_
`define APB_GLOBAL_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_global_pkg
// Used for storing required enums, parameters and defines
//--------------------------------------------------------------------------------------------
package apb_global_pkg;

  //Parameter : NO_OF_SLAVES
  //Used to set number of slaves required
  parameter int NO_OF_SLAVES = 1;

  //Parameter : MASTER_AGENT_ACTIVE
  //Used to set the master agent either active or passive
  parameter MASTER_AGENT_ACTIVE = 1;

  //Parameter : SLAVE_AGENT_ACTIVE
  //Used to set the slave agent either active or passive
  parameter SLAVE_AGENT_ACTIVE = 1;

  //Parameter : ADDRESS_LENGTH
  //Used to set the address length to the address bus
  //Maximum Value is 32
  parameter ADDRESS_LENGTH = 32;

  //Parameter : DATA_LENGTH
  //Used to set the data length 
  //Maximum Value is 32
  parameter DATA_LENGTH = 32;



endpackage : apb_global_pkg

`endif
