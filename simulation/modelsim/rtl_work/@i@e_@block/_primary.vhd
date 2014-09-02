library verilog;
use verilog.vl_types.all;
entity IE_Block is
    port(
        p_IE_DataA      : in     vl_logic_vector(63 downto 0);
        p_IE_DataB      : in     vl_logic_vector(63 downto 0);
        p_IE_SignExtended: in     vl_logic_vector(63 downto 0);
        p_RegDestRT     : in     vl_logic_vector(4 downto 0);
        p_RegDestRD     : in     vl_logic_vector(4 downto 0);
        p_IE_Ctrl_Bus   : in     vl_logic_vector(31 downto 0);
        p_IE_PC         : in     vl_logic_vector(63 downto 0);
        p_IE_BranchAddress: out    vl_logic_vector(63 downto 0);
        p_IE_ALUResult  : out    vl_logic_vector(63 downto 0);
        p_IE_WriteData  : out    vl_logic_vector(63 downto 0);
        p_IE_ALUZero    : out    vl_logic;
        p_IE_Overflow   : out    vl_logic;
        p_IE_WriteAddress: out    vl_logic_vector(4 downto 0)
    );
end IE_Block;
