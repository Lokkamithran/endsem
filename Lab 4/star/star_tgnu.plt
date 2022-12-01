set autoscale
set xtic auto
set ytic auto
set title "Throughput"
set xlabel "Time"
set ylabel "BPS"

plot "star_tgraph.dat" using 1:2 with linespoints
