//project defines 

`ifndef _proj_def_v_
`define _proj_def_v_

`default_nettype none
`define ADDR  5
`define WIDTH 64
`define BLOCKSIZE 32

/*Each stages control signals are packaged into a single bus */
/*The following defines sets the bus width */
`define IE_CTRL_SIZE 32
`define MEM_CTRL_SIZE 32 
`define WB_CTRL_SIZE 32

`endif