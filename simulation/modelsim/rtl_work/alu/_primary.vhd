library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        p_ALUop         : in     vl_logic_vector(3 downto 0);
        p_SHAMT         : in     vl_logic_vector(4 downto 0);
        p_A             : in     vl_logic_vector(63 downto 0);
        p_B             : in     vl_logic_vector(63 downto 0);
        p_R             : out    vl_logic_vector(63 downto 0);
        p_zero          : out    vl_logic;
        p_overflow      : out    vl_logic
    );
end alu;
