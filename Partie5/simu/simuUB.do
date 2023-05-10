vlib work

vcom -93 ../src/ALU.vhd
vcom -93 ../src/Banc_de_Registres.vhd
vcom -93 ../src/Unite_de_Traitement.vhd
vcom -93 ../simu/Unite_de_Traitement_tb.vhd

vsim Unite_de_Traitement_tb(Bench)

view signals

add wave -radix binary /Unite_de_Traitement_tb/we
add wave -radix unsigned /Unite_de_Traitement_tb/ra
add wave -radix unsigned /Unite_de_Traitement_tb/rb
add wave -radix unsigned /Unite_de_Traitement_tb/rw

add wave -radix binary /Unite_de_Traitement_tb/op
add wave -radix hexadecimal /Unite_de_Traitement_tb/UB/BR/Banc
add wave -radix hexadecimal /Unite_de_Traitement_tb/UB/ALU/SUM
run -all