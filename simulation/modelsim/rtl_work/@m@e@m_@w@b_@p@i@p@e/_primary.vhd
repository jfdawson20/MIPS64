library verilog;
use verilog.vl_types.all;
entity MEM_WB_PIPE is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_MEM_MemData   : in     vl_logic_vector(63 downto 0);
        p_MEM_WB_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_MEM_ALUResult : in     vl_logic_vector(63 downto 0);
        p_MEM_RegDest   : in     vl_logic_vector(4 downto 0);
        p_WB_MemData    : out    vl_logic_vector(63 downto 0);
        p_WB_ALUResult  : out    vl_logic_vector(63 downto 0);
        p_WB_RegDest    : out    vl_logic_vector(4 downto 0);
        p_WB_WB_Ctrl_Bus: out    vl_logic_vector(31 downto 0);
        p_MEM_WB_Flush  : in     vl_logic;
        p_MEM_WB_Stall  : in     vl_logic
    );
end MEM_WB_PIPE;
