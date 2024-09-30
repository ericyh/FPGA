----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.07.2024 20:45:38
-- Design Name: 
-- Module Name: utilities - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package utilities is
    function multiply(
        a, b : in std_logic_vector(25 downto 0)
    ) return std_logic_vector;
    
    function "+" (
    a, b: std_logic_vector(25 downto 0)
    ) return std_logic_vector;
    
    function to_convert(
        a: in std_logic_vector(2 downto 0))
     return std_logic_vector;
     
    function sigmoid (
        a : std_logic_vector(25 downto 0)
    ) return std_logic_vector ;
    
    function ReLU(
        a: std_logic_vector(25 downto 0)
    ) return std_logic_vector ;
    
    type weights is array(natural range <>) of std_logic_vector(25 downto 0);
    type matrix is array(natural range <>) of weights(0 to 9);
end package utilities;

package body utilities is
    function multiply(
        a, b : in std_logic_vector(25 downto 0)
    ) return std_logic_vector is
    variable inter : std_logic_vector(51 downto 0);
    variable ans   : std_logic_vector(25 downto 0);
    constant vec1 : std_logic_vector(12 downto 0) := "0000000000000";
    constant vec2 : std_logic_vector(12 downto 0) := "1111111111111";
    begin
        inter := std_logic_vector(unsigned(a) * unsigned(b));
        if inter(24) = '1' then
            ans := vec2 & inter(24 downto 12);
        else
            ans:= vec1 & inter(24 downto 12);
        end if;
    return ans; 
    end;
    
    function "+" (
        a, b :  std_logic_vector(25 downto 0)
    ) return std_logic_vector is 
    variable ans : std_logic_vector(25 downto 0) := (others => '0');
    begin
        ans:= std_logic_vector(unsigned(a) + unsigned(b));
        return ans;
    end;
    
    function to_convert(a : in std_logic_vector(2 downto 0))
    return std_logic_vector is
    constant vec1 : std_logic_vector := "00000000000";
    constant vec2 : std_logic_vector := "000000000000";
    begin
        return vec1 & a & vec2;  
    end;
    
    function sigmoid (
        a : std_logic_vector(25 downto 0)
    ) return std_logic_vector is
    
    constant minus_one : std_logic_vector(25 downto 0) := "11111111111111000000000000";
    constant one  : std_logic_vector(25 downto 0) := "00000000000001000000000000";
    variable result : std_logic_vector(25 downto 0);
    begin 
        if signed(a) >= signed(one) then             
            return  one;
        elsif signed(a) <= signed(minus_one) then 
            result := "00000000000000000000000000"; 
            return result;
        else
            result := std_logic_vector(signed(a) + signed(one));
            return '0' & result(25 downto 1);
        end if;
    end;
    
    function ReLU(
        a: std_logic_vector(25 downto 0)
    ) return std_logic_vector is    
    constant zero: STD_LOGIC_VECTOR(25 downto 0):="00000000000000000000000000"; 
    begin
        if a(25) = '1' then
            return zero;
        else
            return a;
        end if;
    end;
end package body utilities;


