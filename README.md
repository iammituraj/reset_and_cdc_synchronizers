# reset_and_cdc_synchronizers
## 1. Async Reset Synchronizer 
Synchronizes the de-assertion of asynchronous reset to the design's clock domain.

Source file: [areset_sync.sv](areset_sync.sv)

## 2. Reset Synchronizer 
Synchronizes both the assertion & de-assertion of an asynchronous reset and generates a fully synchronous reset to the design's clock domain.
This suitable for FPGA designs.

Source file: [reset_sync.sv](reset_sync.sv)

## 3. CDC Synchronizer 
Synchronizes 1-bit signal from source clock domain safely to destination clock domain.

Source files: 

[cdc_sync.sv](cdc_sync.sv) -- without reset

[cdc_sync_with_sync.sv](cdc_sync_with_clr.sv) -- with async reset

[cdc_sync_with_rst.sv](cdc_sync_with_rst.sv) -- with fully sync reset (suitable for FPGAs)

Comments
--------
All codes are fully synthesizable and tested. All are open-source codes, free to use, modify and distribute without any conflicts of interest with the original developer.

Developer
---------
Mitu Raj, iammituraj@gmail.com, chip@chipmunklogic.com
