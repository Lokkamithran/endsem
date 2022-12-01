set output 'tahoe_t.png'
set terminal png

set xrange[0: ]
set yrange[0: ]

plot 'tahoe' using 1:2 title "TCP Throughput" with lines