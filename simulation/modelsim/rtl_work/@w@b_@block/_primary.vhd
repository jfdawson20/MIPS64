library verilog;
use verilog.vl_types.all;
entity WB_Block is
    port(
        p_WB_MemData    : in     vl_logic_vector(63 downto 0);
        p_WB_ALUResult  : in     vl_logic_vector(63 downto 0);
        p_WB_RegDestIN  : in     vl_logic_vector(4 downto 0);
        p_WB_PC_4       : in     vl_logic_vector(63 downto 0);
        p_WB_Ctrl_Bus   : in     vl_logic_vector(31 downto 0);
        p_WB_WritebackData: out    vl_logic_vector(63 downto 0);
        p_WB_RegDestOUT : out    vl_logic_vector(4 downto 0);
        p_RegWrite      : out    vl_logic
    );
end WB_Block;
