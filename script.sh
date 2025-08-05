iverilog -o tb.vvp tb.v
echo 
vvp tb.vvp
echo 
gtkwave tb.vcd