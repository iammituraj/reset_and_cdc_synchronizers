/*===============================================================================================================================
   Module       : Reset Synchronizer

   Description  : Reset Synchronizer synchronizes the assertion and de-assertion of asynchronous reset and generates a
                  fully synchronous reset to the design's clock domain.              

   Developer    : Mitu Raj, chip@chipmunklogic.com at Chipmunk Logic ™, https://chipmunklogic.com
   Notes        : Attribute ASYNC_REG used to PAR the flops together in Xilinx FPGAs.
   License      : Open-source.
   Date         : Aug-18-2022
===============================================================================================================================*/

/*-------------------------------------------------------------------------------------------------------------------------------
                                                R E S E T   S Y N C H R O N I Z E R
-------------------------------------------------------------------------------------------------------------------------------*/

module reset_sync #(
   
   // Configurable parameters   
   parameter STAGES  = 2             // No. of flops in the chain, min. 2
)

(
   input  logic clk         ,        // Clock @ destination clock domain   
   input  logic i_rst_async ,        // Asynchronous reset
   output logic o_rst_sync           // Synchronized reset
) ;

(* ASYNC_REG = "TRUE" *)
logic [STAGES-1: 0] sync_ff ;

// Synchronizing logic
always @(posedge clk) begin   
   sync_ff <= {sync_ff [STAGES-2 : 0], i_rst_async} ; 
end

// Synchronized reset
assign o_rst_sync = sync_ff [STAGES-1] ;

endmodule

/*-------------------------------------------------------------------------------------------------------------------------------
                                                R E S E T   S Y N C H R O N I Z E R
-------------------------------------------------------------------------------------------------------------------------------*/