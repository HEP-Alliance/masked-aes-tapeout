[OpenROAD-flow-scripts](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts) design configuration for an ASIC implementing a AES with [IHP's open PDK](https://github.com/IHP-GmbH/IHP-Open-PDK).

## The Design

The AES was built from here: https://github.com/HEP-Alliance/MaskedAesTestbed

```sh
$ nix-shell
> mill tb.runMain tb.AesTb
```

## The ASIC

To build the ASIC, set up OpenROAD-flow-scripts, clone this repository as `<ORFS-Root>/flow/designs/ihp-sg13g2/masked_aes` and run the build like any other ORFS design.

### Sealring

The sealring was generated using a script included with IHP's open PDK.

Clone the PDK and set up the technology in KLayout. The following command creates the sealring:

```sh
$ klayout -n sg13g2 -zz -r <IHP-repo-root>/ihp-sg13g2/libs.tech/klayout/tech/scripts/sealring.py -rd width=1120.0 -rd height=810.0 -rd output=sealring.gds
```

The generated sealring has to be moved by -60 in both directions, which can be done in KLayout.

## Caveats

Information on steps that are not fully automated yet as well as known issues.

### Metal Fill

Metal fill has to be performed on the output GDS using a KLayout script provided as part of the IHP PDK. The script is currently work-in-progress here: https://github.com/IHP-GmbH/IHP-Open-PDK/pull/229

### DRC Violations

The "maximal" design rule check currently reports a selection of violations that we have no control over. The issues are tracked here:

- https://github.com/IHP-GmbH/IHP-Open-PDK/issues/245
- https://github.com/IHP-GmbH/IHP-Open-PDK/issues/250
