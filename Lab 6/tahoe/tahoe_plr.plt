set autoscale
set term png
set title "Packet Loss Ratio"
set xlabel "Time (s)"
set ylabel "PLR"
set out "tahoe_plr.png"

plot "tahoe_plr.dat" using 1:4 with linespoints
