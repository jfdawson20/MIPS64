library verilog;
use verilog.vl_types.all;
entity IF_ID_PIPE is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_IF_ID_IN_Instruction: in     vl_logic_vector(63 downto 0);
        p_IF_PC_Counter : in     vl_logic_vector(63 downto 0);
        p_IF_ID_OUT_Instruction: out    vl_logic_vector(63 downto 0);
        p_ID_PC_Counter : out    vl_logic_vector(63 downto 0);
        p_IF_ID_Stall   : in     vl_logic;
        p_IF_ID_Flush   : in     vl_logic
    );
end IF_ID_PIPE;
