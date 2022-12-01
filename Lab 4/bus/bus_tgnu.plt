set autoscale
set xtic auto
set ytic auto
set title "Throughput"
set xlabel "Time"
set ylabel "BPS"

plot "bus_tgraph.dat" using 1:2 with linespoints
