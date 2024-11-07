-- CAIO MADEIRA | 24280006
-- TENTATIVA E CODIGO SEPARANDO AS SEQUENCIAS
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

-- Estados para A: (0110)
    TYPE stateA IS (A0, A1, A2, A3, A4);
    SIGNAL ACTUAL_STATE_A, NEXT_STATE_A : stateA;
-- Estados para B: (11011)
    TYPE stateB IS (B0, B1, B2, B3, B4, B5);
    SIGNAL ACTUAL_STATE_B, NEXT_STATE_B : stateB;

BEGIN
    -- FSM para A
        PROCESS(clock, reset)
        BEGIN 
            IF reset = '1' THEN
                ACTUAL_STATE_A <= A0;
            ELSIF rising_edge(clock) THEN
                ACTUAL_STATE_A <= NEXT_STATE_A;
            END IF;
        END PROCESS;

        PROCESS(ACTUAL_STATE_A, inA)
        BEGIN 
            CASE ACTUAL_STATE_A IS
                -----------------
                -- A0
                -----------------            
                WHEN A0 =>
                    IF inA = '0' THEN
                        NEXT_STATE_A <= A1;
                    ELSE
                        NEXT_STATE_A <= A0;
                    END IF;
                -----------------
                -- A1
                -----------------
                WHEN A1 =>
                    IF inA = '1' THEN
                        NEXT_STATE_A <= A2;
                    ELSE
                        NEXT_STATE_A <= A0;
                    END IF;            
                -----------------
                -- A2
                -----------------
                WHEN A2 =>
                    IF inA = '1' THEN
                        NEXT_STATE_A <= A3;
                    ELSE
                        NEXT_STATE_A <= A0;
                    END IF;         
                -----------------
                -- A3
                -----------------
                WHEN A3 =>
                    IF inA = '0' THEN
                        NEXT_STATE_A <= A4;
                    ELSE
                        NEXT_STATE_A <= A0;
                    END IF;     
                -----------------
                -- A4
                -----------------
                WHEN A4 => 
                    NEXT_STATE_A <= A0;
            END CASE;
        END PROCESS;
    -- FSM para B
    PROCESS(clock, reset)
    BEGIN 
        IF reset = '1' THEN
            ACTUAL_STATE_B <= B0;
        ELSIF rising_edge(clock) THEN
            ACTUAL_STATE_B <= NEXT_STATE_B;
        END IF;
    END PROCESS;

    PROCESS(ACTUAL_STATE_B, inB)
    BEGIN 
        CASE ACTUAL_STATE_B IS
            -----------------
            -- B0
            -----------------            
            WHEN B0 =>
                IF inB = '1' THEN
                    NEXT_STATE_B <= B1;
                ELSE
                    NEXT_STATE_B <= B0;
                END IF;
            -----------------
            -- B1
            -----------------            
            WHEN B1 =>
                IF inB = '1' THEN
                    NEXT_STATE_B <= B2;
                ELSE
                    NEXT_STATE_B <= B0;
                END IF;           
            -----------------
            -- B2
            -----------------            
            WHEN B2 =>
                IF inB = '0' THEN
                    NEXT_STATE_B <= B3;
                ELSE
                    NEXT_STATE_B <= B1;
                END IF;
            -----------------
            -- B3
            -----------------            
            WHEN B3 =>
                IF inB = '1' THEN
                    NEXT_STATE_B <= B4;
                ELSE
                    NEXT_STATE_B <= B0;
                END IF;
            -----------------
            -- B4
            -----------------            
            WHEN B4 =>
                IF inB = '1' THEN
                    NEXT_STATE_B <= B5;
                ELSE
                    NEXT_STATE_B <= B0;
                END IF;
            -----------------
            -- B5
            -----------------            
            WHEN B5 => 
                NEXT_STATE_B <= B0;
        END CASE;
    END PROCESS;

    found <= '1' WHEN (ACTUAL_STATE_A = A4 AND ACTUAL_STATE_B = B5) ELSE '0';

END ARCHITECTURE;
