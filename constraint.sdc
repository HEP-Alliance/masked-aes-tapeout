current_design MaskedAesTop

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_fanout 20 [current_design]
set_max_transition 3 [current_design]
set_max_area 0

set clock_ports [get_ports {\
    p_io_clk \
}]

set io_clk_input_ports [get_ports {\
    p_io_reset \
    p_io_rx \
}]

set io_clk_output_ports [get_ports {\
    p_io_tx \
    p_io_done \
}]

set_driving_cell -lib_cell sg13g2_IOPadIn -pin pad $clock_ports
set_driving_cell -lib_cell sg13g2_IOPadIn -pin pad $io_clk_input_ports
set_driving_cell -lib_cell sg13g2_IOPadOut4mA -pin pad $io_clk_output_ports

set_ideal_network [get_pins u_pad_io_clk/p2c]
create_clock [get_pins u_pad_io_clk/p2c] -name p_io_clk -period 20.8333333
set_clock_uncertainty 0.15 [get_clocks p_io_clk]
set_clock_transition 0.25 [get_clocks p_io_clk]

set_input_delay  2 -clock p_io_clk [get_ports { p_io_clk }]
set_input_delay  2 -clock p_io_clk $io_clk_input_ports
set_output_delay 2 -clock p_io_clk $io_clk_output_ports

set_load -pin_load 5 [all_inputs]
set_load -pin_load 5 [all_outputs]
