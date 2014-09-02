library verilog;
use verilog.vl_types.all;
entity MEM_Block is
    port(
        p_MEM_BranchAddress: in     vl_logic_vector(63 downto 0);
        p_MEM_ALUResult : in     vl_logic_vector(63 downto 0);
        p_MEM_WriteOut  : in     vl_logic_vector(63 downto 0);
        p_MEM_RegDest   : in     vl_logic_vector(4 downto 0);
        p_MEM_MEM_Ctrl_Bus: in     vl_logic_vector(31 downto 0);
        p_MEM_ALUZero   : in     vl_logic;
        p_MEM_DataMemWait: in     vl_logic;
        p_MEM_ReadDataIn: in     vl_logic_vector(63 downto 0);
        p_MEM_WriteDataOut: out    vl_logic_vector(63 downto 0);
        p_MEM_Address   : out    vl_logic_vector(63 downto 0);
        p_MEM_ReadData  : out    vl_logic;
        p_MEM_WriteData : out    vl_logic_vector(3 downto 0);
        p_MEM_Data      : out    vl_logic_vector(63 downto 0)
    );
end MEM_Block;
