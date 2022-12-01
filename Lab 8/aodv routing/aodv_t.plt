set autoscale
set xtic auto
set ytic auto
set title "Throughput"
set xlabel "time"
set ylabel "kbps"

plot "aodv_t.dat" using 1:2 with linespoints