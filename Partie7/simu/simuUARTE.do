vlib work


vcom -93 ../src/FDIV.vhd
vcom -93 ../src/UARTTX.vhd
vcom -93 ../src/UART_Conf.vhd
vcom -93 ../src/UART_Emission.vhd
vcom -93 ../simu/UART_Emission_tb.vhd

vsim UART_Emission_tb(Bench)

view signals
add wave -radix binary /uart_emission_tb/go
add wave -radix binary /uart_emission_tb/data
add wave -radix binary /uart_emission_tb/tx
run -all
