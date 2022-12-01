#============== throughput.awk ================

BEGIN {
sent=0;
dropped=0;
gotime = 0;
time = 0;
time_interval=0.01;
}
#body
{
        event = $1
             time = $2
             node_a = $3
             node_b = $4
             pktType = $5
             packet_size = $6

 if(time>gotime && sent!=0) {

  print gotime, dropped, sent, dropped/sent;
  gotime += time_interval;
  sent=0;
  dropped=0;
  }
if (( event == "+"))
{
	sent++;
}
if (( event == "d"))
{
	dropped++;
}
} #body

END {
	;
}
