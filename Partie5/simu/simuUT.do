vlib work

vcom -93 ../src/Data_memory.vhd
vcom -93 ../src/ALU.vhd
vcom -93 ../src/Extende_generic.vhd
vcom -93 ../src/Banc_de_Registres.vhd
vcom -93 ../src/Mux2v1_generic.vhd
vcom -93 ../src/Unite_de_Traitement_Avance.vhd
vcom -93 ../simu/Unite_de_Traitement_Avance_tb.vhd

vsim Unite_de_Traitement_Avance_tb(Bench)

view signals

add wave -radix binary /unite_de_traitement_avance_tb/op
add wave -radix unsigned /unite_de_traitement_avance_tb/ra
add wave -radix unsigned /unite_de_traitement_avance_tb/rb
add wave -radix unsigned /unite_de_traitement_avance_tb/rw

add wave -radix decimal /unite_de_traitement_avance_tb/imm
add wave -radix binary /unite_de_traitement_avance_tb/flag
add wave -radix binary /unite_de_traitement_avance_tb/we
add wave -radix hexadecimal /Unite_de_Traitement_Avance_tb/UTS/BR/Banc
add wave -radix binary /unite_de_traitement_avance_tb/wren
add wave -radix hexadecimal /Unite_de_Traitement_Avance_tb/UTS/DM/Banc
run -all