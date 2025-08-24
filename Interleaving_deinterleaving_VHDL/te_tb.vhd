LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY combined_interleaver IS
END combined_interleaver;

ARCHITECTURE Behavioral OF combined_interleaver IS

COMPONENT interleaver_deinterleaver
    GENERIC (
        DATA_WIDTH : integer := 4
    );
    PORT (
        clk           : IN  STD_LOGIC;
        reset         : IN  STD_LOGIC;
        mode          : IN  STD_LOGIC;
        data_in1      : IN  STD_LOGIC_VECTOR(3 downto 0);
        data_in2      : IN  STD_LOGIC_VECTOR(3 downto 0);
        data_in3      : IN  STD_LOGIC_VECTOR(3 downto 0);
        data_in4      : IN  STD_LOGIC_VECTOR(3 downto 0);
		  data_out      : OUT STD_LOGIC_VECTOR(15 downto 0);
        di_data_in    : IN  STD_LOGIC_VECTOR(15 downto 0);
        di_data_out1  : OUT STD_LOGIC_VECTOR(3 downto 0);
        di_data_out2  : OUT STD_LOGIC_VECTOR(3 downto 0);
        di_data_out3  : OUT STD_LOGIC_VECTOR(3 downto 0);
        di_data_out4  : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END COMPONENT;

SIGNAL clk           : STD_LOGIC := '0';
SIGNAL reset         : STD_LOGIC := '1';
SIGNAL mode          : STD_LOGIC := '0';
SIGNAL data_in1      : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL data_in2      : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL data_in3      : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL data_in4      : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL data_out      : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL di_data_in    : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL di_data_out1  : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL di_data_out2  : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL di_data_out3  : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL di_data_out4  : STD_LOGIC_VECTOR(3 downto 0);

CONSTANT clk_period : time := 10 ns;

BEGIN

uut: interleaver_deinterleaver
    GENERIC MAP (
        DATA_WIDTH => 4
    )
    PORT MAP (
        clk           => clk,
        reset         => reset,
        mode          => mode,
        data_in1      => data_in1,
        data_in2      => data_in2,
        data_in3      => data_in3,
        data_in4      => data_in4,
		  data_out      => data_out,
        di_data_in    => di_data_in,
        di_data_out1  => di_data_out1,
        di_data_out2  => di_data_out2,
        di_data_out3  => di_data_out3,
        di_data_out4  => di_data_out4
    );

clk_process: PROCESS
BEGIN
    WHILE true LOOP
        clk <= '0';
        WAIT FOR clk_period / 2;
        clk <= '1';
        WAIT FOR clk_period / 2;
    END LOOP;
END PROCESS;

stim_proc: PROCESS
BEGIN

    reset <= '1';
    WAIT FOR 20 ns;
    reset <= '0';
    WAIT FOR 10 ns;
	 
    mode <= '0'; 
    data_in1 <= "1100";  
    data_in2 <= "1010";	 
    data_in3 <= "0110"; 
    data_in4 <= "0011";
    WAIT FOR 50 ns;

    mode <= '1';  
	     di_data_in <= data_out;

    WAIT FOR 50 ns;

    WAIT;
END PROCESS;
END Behavioral;