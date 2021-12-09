`ifndef APB_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_
`define APB_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : apb_slave_seq_item_converter
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class apb_slave_seq_item_converter extends uvm_object;
  
//------------------------------------------------------------------------------------------
// Externally defined Tasks and Functions
//------------------------------------------------------------------------------------------
  extern function new(string name = "apb_slave_seq_item_converter");
  extern static function void from_class(input apb_slave_tx input_conv_h, output apb_transfer_char_s output_conv);
  extern static function void to_class(input apb_transfer_char_s input_conv, output apb_slave_tx output_conv_h);
  extern function void do_print(uvm_printer printer);


endclass : apb_slave_seq_item_converter

//-------------------------------------------------------
// Construct: new
//
// Parameters:
// name - apb_slave_seq_item_converter
//-------------------------------------------------------
function apb_slave_seq_item_converter::new(string name ="apb_slave_seq_item_converter");
  super.new(name);
endfunction:new

//--------------------------------------------------------------------------------------------
// Function: from_class
// Converting seq_item transactions into struct data items
//
// Parameters:
// name - apb_slave_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::from_class(input apb_slave_tx input_conv_h, 
                                                       output apb_transfer_char_s output_conv);
  // output_conv.pprot = input_conv_h.pprot;
  //output_conv.pselx = input_conv_h.pselx;
  //output_conv.pwrite = input_conv_h.pwrite;
  //output_conv.pstrb = input_conv_h.pstrb;  
  //output_conv.pready = input_conv_h.pready;
 
 `uvm_info("apb_seq_item_conv_from_class",$sformatf("----------------------------------------"),UVM_HIGH);

  output_conv.paddr = input_conv_h.paddr;
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the paddr = \n %p",output_conv.paddr),UVM_HIGH);

 output_conv.pselx = input_conv_h.pselx;
 // $cast(output_conv.pselx,input_conv_h.pselx);
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pselx = \n %p",output_conv.pselx),UVM_HIGH);

  output_conv.pwdata = input_conv_h.pwdata;
  `uvm_info("apb_slave_seq_item_conv_class",$sformatf("After ramdomizing pwdata = \n %p",output_conv.pwdata),UVM_HIGH); 
    
 //output_conv.pprot = input_conv_h.pprot;
  $cast(output_conv.pprot,input_conv_h.pprot);
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pprot = \n %p",output_conv.pprot),UVM_HIGH);

  //output_conv.pslverr = input_conv_h.pslverr;
  $cast(output_conv.pslverr,input_conv_h.pslverr);
  `uvm_info("apb_slave_seq_item_conv_class",$sformatf("After ramdomizing pslverr = \n %p",output_conv.pslverr),UVM_HIGH);
  
  output_conv.prdata = input_conv_h.prdata;
  `uvm_info("apb_slave_seq_item_conv_class",$sformatf("After ramdomizing prdata = \n %p",output_conv.prdata),UVM_HIGH);
 
   output_conv.no_of_wait_states = input_conv_h.no_of_wait_states;
 `uvm_info("apb_seq_item_conv_from_class",$sformatf("----------------------------------------"),UVM_HIGH);

 endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: to_class
// Converting struct data items into seq_item transactions
//
// Parameters:
// name - apb_slave_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::to_class(input apb_transfer_char_s input_conv, 
                                                      output apb_slave_tx output_conv_h);
  output_conv_h = new();

  //output_conv_h.pprot = input_conv.pprot;
  //output_conv_h.pselx = input_conv.pselx;
  //output_conv_h.pwrite = input_conv.pwrite;
  //output_conv_h.pstrb = input_conv.pstrb;
  //output_conv_h.pready = input_conv.pready;
  
  `uvm_info("apb_seq_item_conv_to_class",$sformatf("---------------------------------"),UVM_HIGH);

  output_conv_h.paddr = input_conv.paddr;
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the paddr = \n %p",output_conv_h.paddr),UVM_HIGH);


  output_conv_h.pwdata = input_conv.pwdata;
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pwdata = \n %p",output_conv_h.pwdata),UVM_HIGH);

  output_conv_h.pselx = input_conv.pselx;
  //$cast(output_conv_h.pselx,input_conv.pselx);
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pselx = \n %p",output_conv_h.pselx),UVM_HIGH);
  
  //output_conv.pprot = input_conv_h.pprot;
  $cast(output_conv_h.pprot,input_conv.pprot);
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pprot = \n %p",output_conv_h.pprot),UVM_HIGH);



  //output_conv_h.pslverr = input_conv.pslverr;
  $cast(output_conv_h.pslverr,input_conv.pslverr);
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pslverr = \n %p",output_conv_h.pslverr),UVM_HIGH);

  //output_conv_h.pslverr = input_conv.pslverr;
  $cast(output_conv_h.pwrite,input_conv.pwrite);
  `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the pwrite = \n %p",output_conv_h.pwrite),UVM_HIGH);

  output_conv_h.prdata = input_conv.prdata;
 `uvm_info("apb_seq_item_conv_class",$sformatf("After randomizing the prdata = \n %p",output_conv_h.prdata),UVM_HIGH);
  
  output_conv_h.no_of_wait_states = input_conv.no_of_wait_states;

 `uvm_info("apb_seq_item_conv_class_to_class",$sformatf("----------------------------------------"),UVM_HIGH);

endfunction: to_class

//-------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//-------------------------------------------------------
function void apb_slave_seq_item_converter::do_print(uvm_printer printer);
  apb_transfer_char_s apb_st;
  super.do_print(printer);
  
    printer.print_field($sformatf("pwdata"),apb_st.pwdata,DATA_WIDTH,UVM_HEX);
    printer.print_field($sformatf("prdata"),apb_st.prdata,DATA_WIDTH,UVM_HEX);
    printer.print_field("pslverr",apb_st.pslverr,1,UVM_BIN);
    printer.print_field("no_of_wait_states",apb_st.no_of_wait_states,UVM_DEC);

   // printer.print_field("pprot",apb_st.pprot,2,UVM_BIN);
    printer.print_field("pselx",apb_st.pselx,NO_OF_SLAVES,UVM_BIN);
    //printer.print_field("pwrite",apb_st.pwrite,1,UVM_BIN);
    //printer.print_field("pstrb",apb_st.pstrb,DATA_WIDTH/8,UVM_BIN);
    //printer.print_field("pready",apb_st.pready,1,UVM_BIN);
  
  endfunction: do_print
`endif

