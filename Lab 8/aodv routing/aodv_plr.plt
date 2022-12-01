set autoscale
set xtic auto
set ytic auto
set title "PLR"
set xlabel "time"
set ylabel "dropped/sent"

plot "aodv_plr.dat" using 1:4 with linespoints