library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end entity;

architecture behavior of tb is

   -- Signals for the testbench
    signal reset : std_logic := '1';
    signal clock : std_logic := '0';
    signal inA : std_logic := '0';
    signal inB : std_logic := '0';
    signal found : std_logic;

    -- Clock period definition
    constant clock_period : time := 10 ns;

    type test_vector is record
      a, b, found : std_logic;
    end record; 

    type test_vector_array is array (natural range <>) of test_vector;
    constant test_vectors : test_vector_array := (
    -- inA, inB, found 
    ('0', '1', '0'), 
    ('0', '1', '0'),
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'), 
    ('0', '1', '0'), 
    ('0', '1', '0'),
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '1'), 
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'),
    ('0', '0', '0'), 
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '1', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'), 
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('0', '0', '0'), 
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '1', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('1', '0', '0'), 
    ('0', '1', '0'),
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('0', '0', '0'), 
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('0', '1', '0'),
    ('0', '0', '0'), 
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '1', '0'),
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('0', '0', '0'), 
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('1', '0', '0'),
    ('1', '1', '0'), 
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('0', '1', '0'),
    ('1', '0', '0'), 
    ('0', '1', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'), 
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'), 
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('1', '1', '0'), 
    ('0', '0', '0'),
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'), 
    ('0', '1', '0'),
    ('1', '0', '0'),
    ('1', '0', '0'),
    ('0', '1', '0'), 
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('1', '0', '0'),
    ('1', '1', '0'), 
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '1', '1'),
    ('1', '0', '0'), 
    ('1', '1', '0'),
    ('0', '1', '1'),
    ('1', '1', '0'),
    ('1', '0', '0'), 
    ('0', '1', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'), 
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0'),
    ('0', '1', '0'), 
    ('1', '0', '0'),
    ('0', '0', '0'),
    ('1', '1', '0'),
    ('0', '0', '0')
    --('1', '0', '1')  -- fail test
  );

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.desafio
        port map (
            reset => reset,
            clock => clock,
            inA => inA,
            inB => inB,
            found => found
        );

    -- Clock generation process
    clk_process :process
    begin
        clock <= '0';
        wait for clock_period / 2;
        clock <= '1';
        wait for clock_period / 2;
    end process;

    -- Stimulus process
    reset_and_verif_proc: process
    begin
        -- Initialize the reset
        reset <= '1';
        wait for clock_period * 2;
        reset <= '0';
        wait for clock_period;

        -- Check the output
        -- wait for clock_period * 5;  -- Wait for the detection
        -- assert (found = '1') report "FALHA!! voce nao encontrou corretamente" severity note;

        -- Finish simulation
        wait;
    end process;

  process
    begin
      for i in test_vectors'range loop
        inA <= test_vectors(i).a;  -- signal a = i^th-row-value of test_vector's a
        inB <= test_vectors(i).b;

        wait for clock_period;

        assert (found = test_vectors(i).found)
        report  ("test_vector " & integer'image(i) & " failed " & std_logic'image(found) & " --> " & std_logic'image(test_vectors(i).found)) severity note;
        -- image is used for string-representation of integer etc.
        
      end loop;
      wait;
  end process; 
        

end architecture;
