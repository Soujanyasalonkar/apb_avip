`ifndef APB_MASTER_TX_INCLUDED_
`define APB_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_tx.
// This class holds the data items required to drive stimulus to dut 
// and also holds methods that manipulate those data items
//--------------------------------------------------------------------------------------------
//import apb_global_pkg::*;

 class apb_master_tx extends uvm_sequence_item;
  `uvm_object_utils(apb_master_tx)

  //Variable : paddr
  //Address selected in apb_slave
  rand bit [ADDRESS_WIDTH-1:0]paddr;

  //Variable : pprot
  //Used for different access
  rand protection_type_e pprot;
  //rand bit [2:0]pprot;

  //Variable : pselx
  //Used to select the slave
  rand slave_no_e pselx;

  //Variable : penable
  //Used to write data when penable is high
  bit penable;

  //Variable : pwrite
  //Write when pwrite is 1 and read is 0
  //rand bit pwrite;
  rand tx_type_e pwrite;

  //variable : transfer_size
  //Used to dcide the transfer size of the pwdata
  rand transfer_size_e transfer_size;

  //Variable : pwdata
  //Used to store the wdata
  rand bit [DATA_WIDTH-1:0]pwdata;

  //Variable : pstrb
  //Used to transfer the data to pwdata bus
  rand bit [(DATA_WIDTH/8)-1:0]pstrb;              
    
  //Variable : pready
  //Used to extend the transfer
  bit pready;

  //Variable : prdata
  //Used to store the rdata from the slave
  bit [DATA_WIDTH-1:0]prdata;

  //Variable : pslverr
  //Goes high when a transfer fails
  slave_error_e  pslverr;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new   (string name = "apb_master_tx");
  extern function void  do_copy(uvm_object rhs);
  extern function bit   do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void  do_print(uvm_printer printer);

  //-------------------------------------------------------
  // Constraints defined on variables pselx,
  //-------------------------------------------------------
  // pselx inside (16'd0, 16'd1, 16'd2, 16'd4 and so on), instead we can use onehot encoding
  // $onehot0(pselx) will either selects all bits to be 0, or only one bit should be high(1)
  constraint pselx_c1  { $countones(pselx) == 1; }

  constraint pselx_c2 { pselx >0 && pselx < 2**NO_OF_SLAVES;}

  constraint pwdata_c3 {soft pwdata inside {[0:100]};}

  // MSHA:constraint paddr_c4 {if(pselx == SLAVE_0)
  // MSHA:                        paddr>=0 && paddr <=2**11;
  // MSHA:                        //paddr inside {[0:11]};
  // MSHA:                      else if(pselx == SLAVE_1)
  // MSHA:                        paddr>= 2**14 && paddr <= 2**25;
  // MSHA:                      else if(pselx == SLAVE_2)
  // MSHA:                        paddr>= 2**28 && paddr <= 2**39;
  // MSHA:                      else if(pselx == SLAVE_3)
  // MSHA:                        paddr>= 2**42 && paddr <= 2**53;
  // MSHA:                      else if(pselx == SLAVE_4)
  // MSHA:                        paddr>= 2**56 && paddr <= 2**67;
  // MSHA:                      else if(pselx == SLAVE_5)
  // MSHA:                        paddr>= 2**70 && paddr <= 2**81;
  // MSHA:                      else if(pselx == SLAVE_6)
  // MSHA:                        paddr>= 2**84 && paddr <= 2**95;
  // MSHA:                      else if(pselx == SLAVE_7)
  // MSHA:                        paddr>= 2**98 && paddr <= 2**109;
  // MSHA:                      else if(pselx == SLAVE_8)
  // MSHA:                        paddr>= 2**112 && paddr <= 2**123;
  // MSHA:                      else if(pselx == SLAVE_9)
  // MSHA:                        paddr>= 2**126 && paddr <= 2**137;
  // MSHA:                      else if(pselx == SLAVE_10)
  // MSHA:                        paddr>= 2**140 && paddr <= 2**151;
  // MSHA:                      else if(pselx == SLAVE_11)
  // MSHA:                        paddr>= 2**154 && paddr <= 2**165;
  // MSHA:                      else if(pselx == SLAVE_12)
  // MSHA:                        paddr>= 2**168 && paddr <= 2**179;
  // MSHA:                      else if(pselx == SLAVE_13)
  // MSHA:                        paddr>= 2**182 && paddr <= 2**193;
  // MSHA:                      else if(pselx == SLAVE_14)
  // MSHA:                        paddr>= 2**196 && paddr <= 2**207;
  // MSHA:                      else if(pselx == SLAVE_15)
  // MSHA:                        paddr>= 2**210 && paddr <= 2**221;
  // MSHA:                      }

  //TODO(saha): use below for inline constraints
  // constraint pwdata_c { pwdata WRITE | READ }
 
  //This constraint is used to decide the pwdata size based om transfer size
  constraint transfer_size_c {if(transfer_size == BIT_8)
                                $countones (pstrb) == 1;
                              else if(transfer_size == BIT_16)
                                  $countones (pstrb) == 2;
                              else if(transfer_size == BIT_24)
                                $countones (pstrb) == 3;
                              else 
                                $countones (pstrb) == 4;
}
endclass : apb_master_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes the class object
//
// Parameters:
// name - apb_master_tx
//--------------------------------------------------------------------------------------------
function apb_master_tx::new(string name = "apb_master_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_copy
// Copy method is implemented using handle rhs
//
// Parameters:
// rhs - uvm_object
//--------------------------------------------------------------------------------------------
function void apb_master_tx::do_copy (uvm_object rhs);
  apb_master_tx apb_master_tx_copy_obj;

  if(!$cast(apb_master_tx_copy_obj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  paddr   = apb_master_tx_copy_obj.paddr;
  pprot   = apb_master_tx_copy_obj.pprot;
  pselx   = apb_master_tx_copy_obj.pselx;
  penable = apb_master_tx_copy_obj.penable;
  //pwrite  = apb_master_tx_copy_obj.pwrite;
  pwdata  = apb_master_tx_copy_obj.pwdata;
  pstrb   = apb_master_tx_copy_obj.pstrb;
  pready  = apb_master_tx_copy_obj.pready;
  prdata  = apb_master_tx_copy_obj.prdata;
  pslverr = apb_master_tx_copy_obj.pslverr;

endfunction : do_copy

//--------------------------------------------------------------------------------------------
// Function: do_compare
// Compare method is implemented using handle rhs
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function bit apb_master_tx::do_compare (uvm_object rhs, uvm_comparer comparer);
  apb_master_tx apb_master_tx_compare_obj;

  if(!$cast(apb_master_tx_compare_obj,rhs)) begin
    `uvm_fatal("FATAL_APB_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(apb_master_tx_compare_obj, comparer) &&
  paddr   == apb_master_tx_compare_obj.paddr &&
  pprot   == apb_master_tx_compare_obj.pprot &&
  pselx   == apb_master_tx_compare_obj.pselx &&
  penable == apb_master_tx_compare_obj.penable &&
  //pwrite  == apb_master_tx_compare_obj.pwrite &&
  pwdata  == apb_master_tx_compare_obj.pwdata &&
  pstrb   == apb_master_tx_compare_obj.pstrb &&
  pready  == apb_master_tx_compare_obj.pready &&
  prdata  == apb_master_tx_compare_obj.prdata &&
  pslverr == apb_master_tx_compare_obj.pslverr;

endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
// Parameters:
// printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void apb_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  
  printer.print_string ("pselx",   pselx.name()                        );
  printer.print_field  ("penable", penable,     $bits(penable), UVM_DEC);
  printer.print_field  ("paddr",   paddr,       $bits(paddr),   UVM_HEX);
  printer.print_string ("pwrite",  pwrite.name());
  printer.print_field  ("pwdata",  pwdata,      $bits(pwdata),  UVM_HEX);
  printer.print_string ("transfer_size",transfer_size.name()           );
  printer.print_field  ("pstrb",   pstrb,       $bits(pstrb),   UVM_BIN);
  printer.print_string ("pprot",   pprot.name()                        );
  printer.print_field  ("pready",  pready,      $bits(pready),  UVM_DEC);
  printer.print_field  ("prdata",  prdata,      $bits(prdata),  UVM_HEX);
  printer.print_string ("pslverr", pslverr.name()                      );
  endfunction : do_print

//function bit apb_master_tx::slave_select();
  //`uvm_info(get_type_name(),"SLAVE_SELECT",UVM_LOW);
  //return '0;
//endfunction : slave_select

`endif

