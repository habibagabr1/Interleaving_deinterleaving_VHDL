----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity interleaver_deinterleaver is
    Generic (
        DATA_WIDTH : integer := 4  
    );
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        mode      : in  STD_LOGIC;  
		  
        data_in1  : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        data_in2  : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        data_in3  : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        data_in4  : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		  
        data_out  : out STD_LOGIC_VECTOR((4*DATA_WIDTH)-1 downto 0);

        di_data_in : in  STD_LOGIC_VECTOR((4*DATA_WIDTH)-1 downto 0);


        di_data_out1 : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        di_data_out2 : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        di_data_out3 : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        di_data_out4 : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
    );
end interleaver_deinterleaver;

architecture Behavioral of interleaver_deinterleaver is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            di_data_out1 <= (others => '0');
            di_data_out2 <= (others => '0');
            di_data_out3 <= (others => '0');
            di_data_out4 <= (others => '0');
        elsif rising_edge(clk) then
            if mode = '0' then 
                for i in 0 to DATA_WIDTH-1 loop
                    data_out(4*i + 3) <= data_in1(i);
                    data_out(4*i + 2) <= data_in2(i);
                    data_out(4*i + 1) <= data_in3(i);
                    data_out(4*i)     <= data_in4(i);
                end loop;
            else  
                for i in 0 to DATA_WIDTH-1 loop
                    di_data_out1( i) <= di_data_in(4*i + 3);
                    di_data_out2( i) <= di_data_in(4*i + 2);
                    di_data_out3( i) <= di_data_in(4*i + 1);
                    di_data_out4( i) <= di_data_in(4*i);
                end loop;
                data_out <= (others => '0');  
            end if;
        end if;
    end process;
end Behavioral;