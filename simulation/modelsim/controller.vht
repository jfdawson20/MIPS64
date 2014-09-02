-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "08/26/2014 11:05:17"
                                                            
-- Vhdl Test Bench template for design  :  controller
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY controller_vhd_tst IS
END controller_vhd_tst;
ARCHITECTURE controller_arch OF controller_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL IE_Control : STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL MEM_Control : STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL WB_Control : STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL p_BranchType : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL p_FUNCT : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL p_OpCode : STD_LOGIC_VECTOR(5 DOWNTO 0);
COMPONENT controller
	PORT (
	IE_Control : OUT STD_LOGIC_VECTOR(32 DOWNTO 0);
	MEM_Control : OUT STD_LOGIC_VECTOR(32 DOWNTO 0);
	WB_Control : OUT STD_LOGIC_VECTOR(32 DOWNTO 0);
	p_BranchType : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	p_FUNCT : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	p_OpCode : IN STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : controller
	PORT MAP (
-- list connections between master ports and signals
	IE_Control => IE_Control,
	MEM_Control => MEM_Control,
	WB_Control => WB_Control,
	p_BranchType => p_BranchType,
	p_FUNCT => p_FUNCT,
	p_OpCode => p_OpCode
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END controller_arch;
