library verilog;
use verilog.vl_types.all;
entity IE_MEM_PIPE is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_IE_BranchAddress: in     vl_logic_vector(63 downto 0);
        p_IE_ALUResult  : in     vl_logic_vector(63 downto 0);
        p_IE_RegDest    : in     vl_logic_vector(4 downto 0);
        p_IE_WriteOut   : in     vl_logic_vector(63 downto 0);
        p_IE_MEM_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_IE_WB_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_IE_ALUZero    : in     vl_logic;
        p_MEM_BranchAddress: out    vl_logic_vector(63 downto 0);
        p_MEM_ALUResult : out    vl_logic_vector(63 downto 0);
        p_MEM_RegDest   : out    vl_logic_vector(4 downto 0);
        p_MEM_MEM_Ctrl_Bus: out    vl_logic_vector(31 downto 0);
        p_MEM_WB_Ctrl_Bus: out    vl_logic_vector(31 downto 0);
        p_MEM_WriteOut  : out    vl_logic_vector(63 downto 0);
        p_MEM_ALUZero   : out    vl_logic;
        p_IE_MEM_Stall  : in     vl_logic;
        p_IE_MEM_Flush  : in     vl_logic
    );
end IE_MEM_PIPE;
