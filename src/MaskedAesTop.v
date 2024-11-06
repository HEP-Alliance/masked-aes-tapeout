module MaskedAesTop (
  p_io_clk,
  p_io_reset,
  p_io_tx,
  p_io_rx,
  p_io_done
);

  input  p_io_clk;
  input  p_io_reset;
  output p_io_tx;
  input  p_io_rx;
  output p_io_done;

  AesTbMasked u_design (
    .io_clk(core_io_clk),
    .io_reset(core_io_reset),
    .io_tx(core_io_tx),
    .io_rx(core_io_rx),
    .io_done(core_io_done),
    .clk(core_clk),
    .reset(core_reset)
  ) ;

  wire core_io_clk;
  wire core_io_reset;
  wire core_io_tx;
  wire core_io_rx;
  wire core_io_done;
  wire core_clk;
  wire core_reset;

  // Unused wires
  assign core_clk = 0;
  assign core_reset = 0;

  (* keep *) sg13g2_IOPadIn u_pad_io_clk (.pad(p_io_clk), .p2c(core_io_clk)) ;
  (* keep *) sg13g2_IOPadIn u_pad_io_reset (.pad(p_io_reset), .p2c(core_io_reset)) ;
  (* keep *) sg13g2_IOPadOut4mA u_pad_io_tx (.pad(p_io_tx), .c2p(core_io_tx)) ;
  (* keep *) sg13g2_IOPadIn u_pad_io_rx (.pad(p_io_rx), .p2c(core_io_rx)) ;
  (* keep *) sg13g2_IOPadOut4mA u_pad_io_done (.pad(p_io_done), .c2p(core_io_done)) ;

  (* keep *) sg13g2_IOPadIOVdd u_pad_vddpad_0 () ;
  (* keep *) sg13g2_IOPadIOVdd u_pad_vddpad_1 () ;

  (* keep *) sg13g2_IOPadVdd u_pad_vddcore_0 () ;
  (* keep *) sg13g2_IOPadVdd u_pad_vddcore_1 () ;

  (* keep *) sg13g2_IOPadIOVss u_pad_gndpad_0 () ;
  (* keep *) sg13g2_IOPadIOVss u_pad_gndpad_1 () ;

  (* keep *) sg13g2_IOPadVss u_pad_gndcore_0 () ;
  (* keep *) sg13g2_IOPadVss u_pad_gndcore_1 () ;

endmodule
