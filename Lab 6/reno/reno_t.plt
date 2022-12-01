set output 'reno_t.png'
set terminal png

set xrange[0: ]
set yrange[0: ]

plot 'reno' using 1:2 title "TCP Throughput" with lines