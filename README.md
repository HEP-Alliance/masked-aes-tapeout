[OpenROAD-flow-scripts](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts) design configuration for an ASIC implementing a masked AES with [IHP's open PDK](https://github.com/IHP-GmbH/IHP-Open-PDK).

## The Design

The masked AES was built from here: https://github.com/HEP-Alliance/MaskedAesTestbed

## The ASIC

To build the ASIC, set up OpenROAD-flow-scripts, clone this repository as `<ORFS-Root>/flow/designs/ihp-sg13g2/masked_aes` and run the build like any other ORFS design.

### Metal Fill

Metal fill has to be performed on the output GDS using a KLayout script provided as part of the IHP PDK. The script is currently work-in-progress here: https://github.com/IHP-GmbH/IHP-Open-PDK/pull/229
