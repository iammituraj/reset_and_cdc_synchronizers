/*===============================================================================================================================
   Module       : Reset Synchronizer

   Description  : Reset Synchronizer synchronizes the de-assertion of asynchronous reset to the design's clock domain.               

   Developer    : Mitu Raj, chip@chipmunklogic.com at Chipmunk Logic ™, https://chipmunklogic.com
   Notes        : -
   License      : Open-source.
   Date         : Aug-17-2022
===============================================================================================================================*/

/*-------------------------------------------------------------------------------------------------------------------------------
                                                R E S E T   S Y N C H R O N I Z E R
-------------------------------------------------------------------------------------------------------------------------------*/

module reset_sync #(
   
   // Configurable parameters   
   parameter STAGES  = 2    ,        // No. of flops in the chain, min. 2
   parameter RST_POL = 1'b0          // Reset polarity
)

(
   input  logic clk         ,        // Clock @ destination clock domain   
   input  logic i_rst_async ,        // Asynchronous reset
   output logic o_rst_sync           // Asynchronous Reset with de-assertion synchronized
) ;

`define RESET (i_rst_async ^ RST_POL)

(* ASYNC_REG = "TRUE" *)
logic [STAGES-1: 0] sync_ff ;

// Synchronizing logic
always @(posedge clk or negedge `RESET) begin
   
   if (!`RESET) begin
      sync_ff <= STAGES'(RST_POL) ;
   end
   else begin
      sync_ff <= {sync_ff [STAGES-2 : 0], ~RST_POL} ;     
   end  

end

// Synchronized signal
assign o_rst_sync = sync_ff [STAGES-1] ;

endmodule

/*-------------------------------------------------------------------------------------------------------------------------------
                                                R E S E T   S Y N C H R O N I Z E R
-------------------------------------------------------------------------------------------------------------------------------*/