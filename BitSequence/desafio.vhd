-- CAIO MADEIRA
--------------------------------------
-- Biblioteca
--------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

--------------------------------------
-- Entidade
--------------------------------------
ENTITY desafio IS
    PORT (
        reset, clock, inA, inB : IN STD_LOGIC;
        found : OUT STD_LOGIC);
END ENTITY;

--------------------------------------
-- Arquitetura
--------------------------------------
ARCHITECTURE behaviour OF desafio IS
    TYPE state IS (S0, S1, S2, S3, S4, S5);
    -- EA = Estado atual; PE = Proximo estado
    SIGNAL ACTUAL_STATE, NEXT_STATE : state;
BEGIN

    PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            ACTUAL_STATE <= S0;
        ELSIF rising_edge(clock) THEN
            ACTUAL_STATE <= NEXT_STATE;
        END IF;
    END PROCESS;

    PROCESS (ACTUAL_STATE, inA, inB)
    BEGIN
        CASE ACTUAL_STATE IS
                -- S0 (IDLE)
            WHEN S0 =>
                IF inB = '1' THEN
                    NEXT_STATE <= S1;
                ELSE
                    NEXT_STATE <= S0;
                END IF;

                -- S1
            WHEN S1 =>
                IF inA = '0' AND inB = '1' THEN
                    NEXT_STATE <= S2;
                ELSE
                    IF inA = '1' AND inB = '1' THEN
                        NEXT_STATE <= ACTUAL_STATE;
                    ELSIF inB = '0' THEN
                        NEXT_STATE <= S0;
                    END IF;
                END IF;

                -- S2
            WHEN S2 =>
                IF inA = '1' AND inB = '0' THEN
                    NEXT_STATE <= S3;
                ELSE
                    -- Verificar essa linha novamente mais tarde
                    IF inA = '1' AND inB = '0' THEN
                        NEXT_STATE <= ACTUAL_STATE;
                    ELSE
                        NEXT_STATE <= S0;
                    END IF;
                END IF;

                -- S3
            WHEN S3 =>
                IF inA = '1' AND inB = '1' THEN
                    NEXT_STATE <= S4;
                ELSE
                    NEXT_STATE <= S0;
                END IF;

                -- S4
            WHEN S4 =>
                IF inA = '0' AND inB = '1' THEN
                    NEXT_STATE <= S5;
                ELSE
                    IF inA = '0' AND inB = '1' THEN
                        NEXT_STATE <= S2;
                    ELSE
                        NEXT_STATE <= S0;
                    END IF;
                END IF;

                -- S5
            WHEN S5 =>
                IF inA = '0' AND inB = '0' THEN
                    NEXT_STATE <= S0;
                ELSE
                    IF inA = '1' AND inB = '0' THEN
                        NEXT_STATE <= S3;
                    ELSIF inA = '0' AND inB = '1' THEN
                        NEXT_STATE <= S2;
                    END IF;
                END IF;
        END CASE;
    END PROCESS;

    found <= '1' WHEN ACTUAL_STATE = S5 ELSE '0';

END ARCHITECTURE;
