set autoscale
set term png
set title "Throughput"
set xlabel "Time (s)"
set ylabel "Throughput (kbps)"
set out "wireless25_throughput.png"

plot "wireless25_throughput.dat" using 1:2 with linespoints
