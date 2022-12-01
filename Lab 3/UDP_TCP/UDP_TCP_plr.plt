set term png small
set autoscale
set xtic auto
set ytic auto
set title "Packet Loss Ratio"
set xlabel "Time"
set ylabel "PLR"
set out "UDP_TCP_plr.png"

plot "UDP_TCP_plr.dat" using 1:2 with linespoints
