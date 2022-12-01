set autoscale
set xtic auto
set ytic auto
set title "Throughput"
set xlabel "Time"
set ylabel "BPS"

plot "mesh_tgraph.dat" using 1:4 with linespoints
