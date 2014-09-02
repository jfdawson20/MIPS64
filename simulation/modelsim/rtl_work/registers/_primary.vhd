library verilog;
use verilog.vl_types.all;
entity registers is
    port(
        p_rst_l         : in     vl_logic;
        p_clk           : in     vl_logic;
        p_we            : in     vl_logic;
        p_din           : in     vl_logic_vector(63 downto 0);
        p_writeaddr     : in     vl_logic_vector(4 downto 0);
        p_readaddr1     : in     vl_logic_vector(4 downto 0);
        p_readaddr2     : in     vl_logic_vector(4 downto 0);
        p_dout1         : out    vl_logic_vector(63 downto 0);
        p_dout2         : out    vl_logic_vector(63 downto 0)
    );
end registers;
