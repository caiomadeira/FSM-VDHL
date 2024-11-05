-- CAIO MADEIRA


--------------------------------------
-- Biblioteca
--------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--------------------------------------
-- Entidade
--------------------------------------
entity desafio is
    port(reset, clock, inA, inB: in std_logic;
        found: out std_logic);
end entity;

--------------------------------------
-- Arquitetura
--------------------------------------
architecture behaviour of desafio is
  type state is (S0, S1, S2, S3, S4, S5);
  -- EA = Estado atual; PE = Proximo estado
  signal ACTUAL_STATE, NEXT_STATE: state;
begin          

  process(clock, reset)
  begin
      if reset = '1' then 
        ACTUAL_STATE <= S0;
      elsif rising_edge(clock) then
        ACTUAL_STATE <= NEXT_STATE;
      end if;
  end process;

  process(ACTUAL_STATE, inA, inB)
  begin
    case ACTUAL_STATE is
      -- S0 (IDLE)
      when S0 => 
        if inB = '1' then
          NEXT_STATE <= S1;
        else
          NEXT_STATE <= S0;
        end if;

        -- S1
        when S1 =>
          if inA = '0' AND inB = '1' then
            NEXT_STATE <= S2;
          else
            NEXT_STATE <= S0;
          end if;

        -- S2
        when S2 =>
            if inA = '1' AND inB = '0' then
              NEXT_STATE <= S3;
            else
              NEXT_STATE <= S0;
            end if;

        -- S3
        when S3 =>
            if inA = '1' AND inB = '1' then
              NEXT_STATE <= S4;
            else
              NEXT_STATE <= S0;
            end if;
        
        -- S4
        when S4 =>
              if inA = '0' AND inB = '1' then
                NEXT_STATE <= S5;
              else
                NEXT_STATE <= S0;
              end if;

        -- S5
        when S5 =>
              if inA = '0' AND inB = '0' then
                NEXT_STATE <= S0;
              else 
                NEXT_STATE <= S0;
              end if;
    end case;
  end process;

  found <= '1' when ACTUAL_STATE = S5 else '0';

end architecture;