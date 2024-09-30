----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.07.2024 20:19:22
-- Design Name: 
-- Module Name: nueron - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.utilities.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;A

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- change in_size - 27, and weights(0 to 8) 


entity nueron is 
    generic(w: weights(0 to 9) :=("00000000000000000000110101","00000000000000000000110101", "00000000000000000000110101",
                                  "00000000000000000000110101","00000000000000000000110101", "00000000000000000000110101",
                                  "00000000000000000000110101","00000000000000000000110101", "00000000000000000000110101",
                                  "00000000000000000000110101");
            in_size : natural :=30);
    port ( input : in STD_LOGIC_VECTOR(in_size - 1 downto 0);           
           output: out STD_LOGIC_VECTOR(25 downto 0));
end nueron;

--- specifically for size 27
architecture layer1 of nueron is
begin
  FORWARD_PASS: process(input)
    variable mul: STD_LOGIC_VECTOR(25 downto 0):="00000000000000000000000000";
    variable sum: weights(0 to 10) := (others => (others => '0')); 
    --variable sum: std_logic_vector(25 downto 0):=(others => '0');
    variable int: STD_LOGIC_VECTOR(25 downto 0):="00000000000000000000000000";
    variable ans: STD_LOGIC_VECTOR(25 downto 0):="00000000000000000000000000";   
    begin
    for i in 0 to 9 loop
           
        --   report "Value of mul: " & to_string(mul) severity note; 
             int := to_convert(input(i*3 + 2 downto i*3));
             mul := multiply(w(i),int);
             sum(i + 1) := sum(i) + mul;                  
     end loop; 
     
         
    ans := ReLU(sum(10));    
    output <= ans;
    
    end process FORWARD_PASS;
end layer1;    

-- 26*8 + 26 = 234
architecture layer2 of nueron is 
begin 
    FORWARD_PASS: process(input)
    
    variable mul: STD_LOGIC_VECTOR(25 downto 0):=(others =>'0');
    variable sum: weights(0 to 9) := (others => (others => '0'));   
    variable int: STD_LOGIC_VECTOR(25 downto 0):= (others =>'0');
    variable ans: STD_LOGIC_VECTOR(25 downto 0):=(others =>'0');   
    
    begin    
    for i in 0 to 8 loop
         int := input(i*26 + 25 downto i*26);
         mul := multiply(w(i),int);
         sum(i + 1) := sum(i) + mul;
    end loop;    
    
    ans := sigmoid(sum(9));
    output <= ans;    
    end process FORWARD_PASS;
end layer2;            
        
    
 