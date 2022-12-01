set autoscale
set xtic auto
set ytic auto
set title "Packet Loss Ratio"
set xlabel "Time"
set ylabel "PLR"

plot "wired_plrgraph.dat" using 1:4 with linespoints
