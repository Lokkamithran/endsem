set autoscale
set term png
set title "Throughput"
set xlabel "Time (s)"
set ylabel "Throughput (kbps)"
set out "wireless_throughput.png"


plot "wireless_tgraph.dat" using 1:2 with linespoints
