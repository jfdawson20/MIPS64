library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        p_OpCode        : in     vl_logic_vector(5 downto 0);
        p_FUNCT         : in     vl_logic_vector(5 downto 0);
        p_BranchType    : in     vl_logic_vector(4 downto 0);
        IE_Control      : out    vl_logic_vector(32 downto 0);
        MEM_Control     : out    vl_logic_vector(32 downto 0);
        WB_Control      : out    vl_logic_vector(32 downto 0)
    );
end controller;
