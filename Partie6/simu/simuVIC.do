vlib work

vcom -93 ../src/VIC.vhd
vcom -93 ../simu/VIC_tb.vhd

vsim VIC_tb(Bench)

view signals

add wave -radix binary /VIC_tb/V/clk
add wave -radix binary /VIC_tb/V/rst
add wave -radix binary /VIC_tb/V/irq_serv
add wave -radix binary /VIC_tb/V/irq0
add wave -radix binary /VIC_tb/V/irq1
add wave -radix binary /VIC_tb/V/irq
add wave -radix hexadecimal /VIC_tb/V/vicpc


run -all