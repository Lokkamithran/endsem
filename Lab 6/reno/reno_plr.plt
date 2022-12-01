set autoscale
set term png
set title "Packet Loss Ratio"
set xlabel "Time (s)"
set ylabel "PLR"
set out "reno_plr.png"

plot "reno_plr.dat" using 1:4 with linespoints
