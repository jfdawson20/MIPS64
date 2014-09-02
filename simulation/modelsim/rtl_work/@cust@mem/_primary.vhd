library verilog;
use verilog.vl_types.all;
entity CustMem is
    port(
        p_clk           : in     vl_logic;
        p_reset_l       : in     vl_logic;
        p_readRequest   : in     vl_logic;
        p_writeRequest  : in     vl_logic;
        p_Address       : in     vl_logic_vector(63 downto 0);
        p_InputData     : in     vl_logic_vector(63 downto 0);
        p_OutputData    : out    vl_logic_vector(63 downto 0);
        p_MemWait       : out    vl_logic
    );
end CustMem;
