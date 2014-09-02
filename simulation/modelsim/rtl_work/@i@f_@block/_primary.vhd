library verilog;
use verilog.vl_types.all;
entity IF_Block is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_INST_MemDataIn: in     vl_logic_vector(63 downto 0);
        p_INST_MemWait  : in     vl_logic;
        p_IF_INST_MemAddress: out    vl_logic_vector(63 downto 0);
        p_IF_INST_MemRead: out    vl_logic;
        p_IF_Instruction: out    vl_logic_vector(63 downto 0);
        p_PC_Counter    : out    vl_logic_vector(63 downto 0)
    );
end IF_Block;
