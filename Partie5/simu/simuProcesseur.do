vlib work

vcom -93 ../src/ALU.vhd
vcom -93 ../src/Banc_de_Registres.vhd
vcom -93 ../src/Data_memory.vhd
vcom -93 ../src/Decodeur_Instruction.vhd
vcom -93 ../src/Extende_generic.vhd
vcom -93 ../src/Instruction_Memory.vhd
vcom -93 ../src/Mux2v1_generic.vhd
vcom -93 ../src/Reg_Aff.vhd
vcom -93 ../src/Reg_PC.vhd
vcom -93 ../src/Reg_PSR.vhd
vcom -93 ../src/Unite_de_Gestion_des_Instructions.vhd
vcom -93 ../src/Unite_de_Traitement_Avance.vhd
vcom -93 ../src/Processeur.vhd
vcom -93 ../simu/Processeur_tb.vhd

vsim Processeur_tb(Bench)

view signals
add wave -radix hexadecimal /processeur_tb/P/Afficheur
add wave /processeur_tb/P/DI/instr_courante
add wave -radix hexadecimal /processeur_tb/P/UT/BR/Banc
add wave -radix decimal /processeur_tb/P/UT/DM/Banc

run -all