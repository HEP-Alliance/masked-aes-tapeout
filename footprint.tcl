set IO_LENGTH 180
set IO_WIDTH 80
set BONDPAD_SIZE 70
set MAX_NUM_HPADS 4
set MAX_NUM_VPADS 3

proc calc_horizontal_pad_location {index} {
    global IO_LENGTH
    global IO_WIDTH
    global MAX_NUM_HPADS

    set DIE_WIDTH [expr {[lindex $::env(DIE_AREA) 2] - [lindex $::env(DIE_AREA) 0]}]
    set PAD_AREA_WIDTH [expr {$DIE_WIDTH - $IO_LENGTH - $IO_LENGTH}]
    set HORIZONTAL_PAD_DISTANCE [expr {$PAD_AREA_WIDTH / ( $MAX_NUM_HPADS + 1 )}]

    return [expr {$IO_LENGTH - ( $IO_WIDTH / 2 ) + $HORIZONTAL_PAD_DISTANCE * ( $index + 1 )}]
}

proc calc_vertical_pad_location {index} {
    global IO_LENGTH
    global IO_WIDTH
    global MAX_NUM_VPADS

    set DIE_HEIGHT [expr {[lindex $::env(DIE_AREA) 3] - [lindex $::env(DIE_AREA) 1]}]
    set PAD_AREA_HEIGHT [expr {$DIE_HEIGHT - $IO_LENGTH - $IO_LENGTH}]
    set VERTICAL_PAD_DISTANCE [expr {$PAD_AREA_HEIGHT / ( $MAX_NUM_VPADS + 1 )}]

    return [expr {$IO_LENGTH - ( $IO_WIDTH / 2 ) + $VERTICAL_PAD_DISTANCE * ( $index + 1 )}]
}

# IOLib.lef defines sg13g2_ioSite for the sides, but no corner site
make_fake_io_site -name sg13g2_ioCSite -width $IO_LENGTH -height $IO_LENGTH

# Create IO Rows
make_io_sites \
    -horizontal_site sg13g2_ioSite \
    -vertical_site sg13g2_ioSite \
    -corner_site sg13g2_ioCSite \
    -offset $BONDPAD_SIZE

######## Place Pads ########
place_pad -row IO_EAST -location [calc_vertical_pad_location 0] {u_pad_vddcore_0}
place_pad -row IO_EAST -location [calc_vertical_pad_location 1] {u_pad_gndcore_0}

place_pad -row IO_WEST -location [calc_vertical_pad_location 0] {u_pad_vddcore_1}
place_pad -row IO_WEST -location [calc_vertical_pad_location 1] {u_pad_gndcore_1}
place_pad -row IO_WEST -location [calc_vertical_pad_location 2] {u_pad_io_done}

place_pad -row IO_NORTH -location [calc_horizontal_pad_location 0] {u_pad_vddpad_0}
place_pad -row IO_NORTH -location [calc_horizontal_pad_location 1] {u_pad_gndpad_0}
place_pad -row IO_NORTH -location [calc_horizontal_pad_location 2] {u_pad_io_tx}
place_pad -row IO_NORTH -location [calc_horizontal_pad_location 3] {u_pad_io_rx}

place_pad -row IO_SOUTH -location [calc_horizontal_pad_location 0] {u_pad_vddpad_1}
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location 1] {u_pad_gndpad_1}
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location 2] {u_pad_io_clk}
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location 3] {u_pad_io_reset}

# Place corners
place_corners sg13g2_Corner

# Place IO fill
set iofill {sg13g2_Filler10000
            sg13g2_Filler4000
            sg13g2_Filler2000
            sg13g2_Filler1000
            sg13g2_Filler400
            sg13g2_Filler200} ;
place_io_fill -row IO_NORTH {*}$iofill
place_io_fill -row IO_SOUTH {*}$iofill
place_io_fill -row IO_WEST {*}$iofill
place_io_fill -row IO_EAST {*}$iofill

# Place the bondpads
place_bondpad -bond bondpad_70x70 u_pad_* -offset {5.0 -70.0}

# Connect ring signals
connect_by_abutment

remove_io_rows
