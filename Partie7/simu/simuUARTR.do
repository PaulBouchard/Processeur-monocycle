vlib work

vcom -93 ../src/FDIV.vhd
vcom -93 ../src/FDIV_Recep.vhd
vcom -93 ../src/UARTRX.vhd
vcom -93 ../src/UARTTX.vhd
vcom -93 ../src/UART_Emission.vhd
vcom -93 ../src/UART_Reception.vhd
vcom -93 ../simu/UART_Reception_tb.vhd

vsim UART_Reception_tb(Bench)

view signals
add wave -radix binary /uart_reception_tb/go
add wave -radix binary /uart_reception_tb/DATAIN
add wave -radix binary /uart_reception_tb/rx
add wave -radix binary /uart_reception_tb/DATAOUT
add wave -radix binary /uart_reception_tb/dav
add wave -radix binary /uart_reception_tb/erreur
run -all