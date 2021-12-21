`ifndef APB_SLAVE_24b_INCLUDED_
`define APB_SLAVE_24b_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_24b_seq
// Extends the apb_slave_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class apb_slave_24b_seq extends apb_slave_base_seq;
  `uvm_object_utils(apb_slave_24b_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name="apb_slave_24b_seq");
  extern task body();
endclass : apb_slave_24b_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_slave_vd_vws
//--------------------------------------------------------------------------------------------
function apb_slave_24b_seq::new(string name="apb_slave_24b_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : Body
// Creates the req of type slave transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task apb_slave_24b_seq::body();
  req=apb_slave_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize())
  begin
    `uvm_error(get_type_name(),"randomization failed");
  end
  req.print();
  finish_item(req);
endtask : body

`endif
