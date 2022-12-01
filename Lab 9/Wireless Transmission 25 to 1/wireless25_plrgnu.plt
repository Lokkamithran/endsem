set autoscale
set term png
set title "Packet Loss Ratio"
set xlabel "Time (s)"
set ylabel "PLR"
set out "wireless25_plr.png"

plot "wireless25_plr.dat" using 1:4 with linespoints
