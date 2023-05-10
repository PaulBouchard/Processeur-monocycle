vlib work

vcom -93 ../src/Reg_PC.vhd
vcom -93 ../src/Extende_generic.vhd
vcom -93 ../src/Mux2v1_generic.vhd
vcom -93 ../src/Instruction_Memory.vhd
vcom -93 ../src/Unite_de_Gestion_des_Instructions.vhd
vcom -93 ../simu/Unite_de_Gestion_tb.vhd

vsim Unite_de_Gestion_tb(Bench)

view signals

add wave -radix binary /Unite_de_Gestion_tb/npcsel
add wave -radix decimal /Unite_de_Gestion_tb/offset
add wave -radix hexadecimal /Unite_de_Gestion_tb/instruction
add wave -radix decimal /Unite_de_Gestion_tb/UG/R/PCOUT
run -all