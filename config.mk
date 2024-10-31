export DESIGN_NICKNAME = masked_aes
export DESIGN_NAME = MaskedAes
export PLATFORM = ihp-sg13g2

export VERILOG_FILES = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/src/MaskedAes.v \
                       ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/src/AesTb.v \
                       ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/src/AES_Masked.v

export SDC_FILE = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export FOOTPRINT_TCL = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/footprint.tcl

export SEAL_GDS = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/sealring.gds

# (Sealring: roughly 60um)
# I/O pads: 180um
# Bondpads: 70um
# Margin for core power ring: 20um
# Total margin to core area: 270um
export DIE_AREA  =   0   0 940 940
export CORE_AREA = 270 270 670 670

export USE_FILL = 1
