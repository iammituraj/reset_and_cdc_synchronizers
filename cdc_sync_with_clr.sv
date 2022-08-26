/*===============================================================================================================================
   Module       : CDC Synchronizer

   Description  : CDC Synchronizer synchronizes 1-bit signal from source clock domain safely to destination clock domain.               

   Developer    : Mitu Raj, chip@chipmunklogic.com at Chipmunk Logic ™, https://chipmunklogic.com
   Notes        : Attribute ASYNC_REG used to PAR the flops together in Xilinx FPGAs.
   License      : Open-source.
   Date         : Aug-17-2022
===============================================================================================================================*/

/*-------------------------------------------------------------------------------------------------------------------------------
                                                   C D C   S Y N C H R O N I Z E R
-------------------------------------------------------------------------------------------------------------------------------*/

module cdc_sync_with_clr #(
   
   // Configurable parameters   
   parameter STAGES = 2             // No. of flops in the chain, min. 2
)

(
   input  logic clk        ,        // Clock @ destination clock domain
   input  logic rstn       ,        // Async Reset @ destination clock domain
   input  logic i_sig      ,        // Input signal, asynchronous
   output logic o_sig_sync          // Output signal synchronized to clk
) ;

(* ASYNC_REG = "TRUE" *)
logic [STAGES-1: 0] sync_ff ;

// Synchronizing logic
always @(posedge clk or negedge rstn) begin
   
   if (!rstn) begin
      sync_ff <= '0 ;
   end
   else begin
      sync_ff <= {sync_ff [STAGES-2 : 0], i_sig} ;     
   end  

end

// Synchronized signal
assign o_sig_sync = sync_ff [STAGES-1] ;

endmodule

/*-------------------------------------------------------------------------------------------------------------------------------
                                                   C D C   S Y N C H R O N I Z E R
-------------------------------------------------------------------------------------------------------------------------------*/