library verilog;
use verilog.vl_types.all;
entity MIPS64 is
    port(
        p_clk           : in     vl_logic;
        p_rst_l         : in     vl_logic;
        p_INST_MemDataIn: in     vl_logic_vector(63 downto 0);
        p_INST_MemWait  : in     vl_logic;
        p_INST_MemAddress: out    vl_logic_vector(63 downto 0);
        p_INST_MemRead  : out    vl_logic;
        p_DATA_MemDataIn: in     vl_logic_vector(63 downto 0);
        p_DATA_MemWait  : in     vl_logic;
        p_DATA_MemDataOut: out    vl_logic_vector(63 downto 0);
        p_DATA_MemAddress: out    vl_logic_vector(63 downto 0);
        p_DATA_MemRead  : out    vl_logic;
        p_DATA_MemWrite : out    vl_logic_vector(3 downto 0)
    );
end MIPS64;
