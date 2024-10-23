current_design MaskedAes

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_fanout 20 [current_design]
set_max_transition 3 [current_design]
set_max_area 0

set clock_ports [get_ports {\
    p_clk \
    p_io_clk \
}]

set clk_input_ports [get_ports {\
    p_reset \
}]

set uart_input_ports [get_ports {\
    p_io_reset \
    p_io_rx \
}]

set clk_output_ports [get_ports {\
}]

set uart_output_ports [get_ports {\
    p_io_tx \
    p_io_done \
}]

set_driving_cell -lib_cell sg13g2_IOPadIn -pin pad $clock_ports
set_driving_cell -lib_cell sg13g2_IOPadIn -pin pad $clk_input_ports
set_driving_cell -lib_cell sg13g2_IOPadIn -pin pad $uart_input_ports
set_driving_cell -lib_cell sg13g2_IOPadOut4mA -pin pad $clk_output_ports
set_driving_cell -lib_cell sg13g2_IOPadOut4mA -pin pad $uart_output_ports

set_ideal_network [get_pins u_pad_clk/p2c]
set_ideal_network [get_pins u_pad_io_clk/p2c]
create_clock [get_pins u_pad_clk/p2c] -name p_clk -period 40 -waveform {0 20}
create_clock [get_pins u_pad_io_clk/p2c] -name p_io_clk -period 100 -waveform {0 50}
set_clock_uncertainty 0.15 [get_clocks p_clk]
set_clock_uncertainty 0.15 [get_clocks p_io_clk]
set_clock_transition 0.25 [get_clocks p_clk]
set_clock_transition 0.25 [get_clocks p_io_clk]

set_false_path -from [get_clocks p_clk] -to [get_clocks p_io_clk]
set_false_path -from [get_clocks p_io_clk] -to [get_clocks p_clk]

set_input_delay  8 -clock p_clk    [get_ports { p_clk }]
set_input_delay  8 -clock p_io_clk [get_ports { p_io_clk }]
set_input_delay  8 -clock p_clk    $clk_input_ports
set_input_delay  8 -clock p_io_clk $uart_input_ports
set_output_delay 8 -clock p_clk    $clk_output_ports
set_output_delay 8 -clock p_io_clk $uart_output_ports

set_load -pin_load 5 [all_inputs]
set_load -pin_load 5 [all_outputs]
