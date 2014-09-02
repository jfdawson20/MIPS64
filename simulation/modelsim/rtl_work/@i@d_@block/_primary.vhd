library verilog;
use verilog.vl_types.all;
entity ID_Block is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_ID_IN_Instruction: in     vl_logic_vector(63 downto 0);
        p_DataA         : out    vl_logic_vector(63 downto 0);
        p_DataB         : out    vl_logic_vector(63 downto 0);
        p_SignExtended  : out    vl_logic_vector(63 downto 0);
        p_RT_RegDest    : out    vl_logic_vector(4 downto 0);
        p_RD_RegDest    : out    vl_logic_vector(4 downto 0);
        p_WB_Data       : in     vl_logic_vector(63 downto 0);
        p_WB_Addr       : in     vl_logic_vector(4 downto 0);
        p_WB_WE         : in     vl_logic;
        p_IE_Ctrl_Bus   : out    vl_logic_vector(31 downto 0);
        p_MEM_Ctrl_Bus  : out    vl_logic_vector(31 downto 0);
        p_WB_Ctrl_bus   : out    vl_logic_vector(31 downto 0)
    );
end ID_Block;
