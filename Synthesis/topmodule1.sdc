set_units -time 40000.0ps
set_units -capacitance 1000.0fF

current_design topmodule1

create_clock -name clk -period 1 -waveform {0 0.5} [get_ports clk]
create_clock -name vclk -period 1 -waveform {0 0.5} 

set_clock_uncertainty -setup 0.2 [get_clocks clk]
set_clock_uncertainty -hold 0.1 [get_clocks clk]

set_load -max 0.1 [get_ports [all_outputs ]]
