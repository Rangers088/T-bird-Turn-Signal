library ieee;
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;

entity lab3_g5 is
	port(reset, clk, left, right, haz, brk: in std_logic;
			lights: out bit_vector (5 downto 0));
end lab3_g5;

architecture state_machine of lab3_g5 is
	--Added from prof.
	signal clk2: std_logic;
	
	-- Declares the different states
	type state_type is (idle, right1, right2, right3, left1, left2, left3, brake);
	
	-- Allows both state and nextState to access the states
	signal state: state_type;
	signal nextState: state_type;
	
begin
	-- Declares conditions
	ns : process(reset, left, right, brk, haz)
	
	-- Start of state process
	begin
		if reset = '0' then
			case state is
			
					when idle =>
						lights <= "000000";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						elsif left = '1' then
							nextState <= left1;
						elsif right = '1' then
							nextState <= right1;
						else
							nextState <= idle;
						end if;
						
					when right1 =>
						lights <= "000100";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						elsif right = '1' then
							nextState <= right2;
						else
							nextState <= idle;
						end if;
						
					when right2 =>
						lights <= "000110";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						elsif right = '1' then
							nextState <= right3;
						else
							nextState <= idle;
						end if;
						
					when right3 =>
						lights <= "000111";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= left3;
						else
							nextState <= idle;
						end if;
							
					when left1 =>
						lights <= "001000"
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						elsif left = '1' then
							nextState <= left2;
						else
							nextState <= idle;
						end if;
						
					when left2 =>
						lights <= "011000";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						elsif left = '1' then
							nextState <= left2;
						else
							nextState <= idle;
						end if;
						
					when left3 =>
						lights <= "111000";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						else
							nextState <= idle;
						end if;
					
					when break =>
						lights <= "111111";
						if brk = '1' then
							nextState <= break;
						elsif haz = '1' then
							nextState <= right3;
						else
							nextState <= idle;
						end if;
			
			end case;
			
			--Added from prof
	Delay: lpm_counter generic map(lpm_width=>24)
					port map (clock=>clk, cout=>clk2);
					
end state_machine;