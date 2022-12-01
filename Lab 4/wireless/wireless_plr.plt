set autoscale
set term png
set title "Packet Loss Ratio"
set xlabel "Time (s)"
set ylabel "PLR"
set out "wireless_plr.png"

plot "wireless_plrgraph.dat" using 1:4 with linespoints
