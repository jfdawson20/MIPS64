library verilog;
use verilog.vl_types.all;
entity addrDyn is
    port(
        p_CI            : in     vl_logic;
        p_A             : in     vl_logic_vector(63 downto 0);
        p_B             : in     vl_logic_vector(63 downto 0);
        p_R             : out    vl_logic_vector(63 downto 0);
        p_CO            : out    vl_logic;
        p_OVL           : out    vl_logic
    );
end addrDyn;
