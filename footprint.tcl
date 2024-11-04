set IO_LENGTH 180
set BONDPAD_SIZE 70

# sg13g2_io.lef defines sg13g2_ioSite for the sides, but no corner site
make_fake_io_site -name sg13g2_ioCSite -width $IO_LENGTH -height $IO_LENGTH

# Create IO Rows
make_io_sites \
    -horizontal_site sg13g2_ioSite \
    -vertical_site sg13g2_ioSite \
    -corner_site sg13g2_ioCSite \
    -offset $BONDPAD_SIZE

######## Place Pads ########
place_pads -row IO_EAST \
    u_pad_vddcore_0 \
    u_pad_gndcore_0

place_pads -row IO_WEST \
    u_pad_vddcore_1 \
    u_pad_gndcore_1 \
    u_pad_io_done

place_pads -row IO_NORTH \
    u_pad_vddpad_0 \
    u_pad_gndpad_0 \
    u_pad_io_tx \
    u_pad_io_rx

place_pads -row IO_SOUTH \
    u_pad_vddpad_1 \
    u_pad_gndpad_1 \
    u_pad_io_clk \
    u_pad_io_reset

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
place_bondpad -bond bondpad_70x70 u_pad_* -offset "5.0 -$BONDPAD_SIZE.0"

# Connect ring signals
connect_by_abutment

remove_io_rows
