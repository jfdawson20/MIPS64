library verilog;
use verilog.vl_types.all;
entity ID_IE_PIPE is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_ID_DataA      : in     vl_logic_vector(63 downto 0);
        p_ID_DataB      : in     vl_logic_vector(63 downto 0);
        p_ID_SignExtend : in     vl_logic_vector(63 downto 0);
        p_ID_RegDestRT  : in     vl_logic_vector(4 downto 0);
        p_ID_RegDestRD  : in     vl_logic_vector(63 downto 0);
        p_ID_PC_Counter : in     vl_logic_vector(63 downto 0);
        p_ID_IE_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_ID_MEM_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_ID_WB_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_IE_DataA      : out    vl_logic_vector(63 downto 0);
        p_IE_DataB      : out    vl_logic_vector(63 downto 0);
        p_IE_SignExtend : out    vl_logic_vector(63 downto 0);
        p_IE_RegDestRT  : out    vl_logic_vector(4 downto 0);
        p_IE_RegDestRD  : out    vl_logic_vector(63 downto 0);
        p_IE_PC_Counter : out    vl_logic_vector(63 downto 0);
        p_IE_IE_Ctrl_Bus: out    vl_logic_vector(31 downto 0);
        p_IE_MEM_Ctrl_Bus: out    vl_logic_vector(31 downto 0);
        p_IE_WB_Ctrl_Bus: out    vl_logic_vector(31 downto 0);
        p_ID_IE_Stall   : in     vl_logic;
        p_ID_IE_Flush   : in     vl_logic
    );
end ID_IE_PIPE;
