#============== throughput.awk ================

BEGIN {
recv1=0;
recv3=0;
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

 if(time>gotime) {
	print gotime, 1, 4, (packet_size * recv1 * 8.0)/1000; #results in kbps
	print gotime, 3, 4, (packet_size * recv3 * 8.0)/1000;
	gotime+= time_interval;
	recv1=0;
	recv3=0;
  }

#========Calculate throughput==========

if (( event == "r") && ( pktType == "cbr" ) && (node_a == "1"))
{
 recv1++;
}
if (( event == "r") && ( pktType == "cbr" ) && (node_a == "3"))
{
 recv3++;
}
}


END {
;
}
