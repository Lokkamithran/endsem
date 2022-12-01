#============== throughput.awk ================

BEGIN {
recv1=0;
recv3=0;
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
	print gotime, (packet_size * recv1 * 8.0)/1000; #results in kbps
	gotime+= time_interval;
	recv1=0;
	recv3=0;
  }

#========Calculate throughput==========

if (( event == "r") && ( pktType == "tcp"))
{
 recv1++;
}

}

END {
	;
}
