set term png
set autoscale
set xtic auto
set ytic auto
set title "Throughput"
set xlabel "Time"
set ylabel "BPS"

set out "UDP_TCP_throughput.png"

plot "UDP_TCP_t.dat" using 1:2 with linespoints
