#============== throughput.awk ================

BEGIN {
recv=0;
#sent=0;
#dropped=0;
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

  print gotime, (packet_size * recv * 8.0)/1000; #packet size * ... gives results in kbps
  gotime+= time_interval;
  recv=0;
  }

#========Calculate throughput==========

if (( event == "r") && ( pktType == "tcp" ))
{
 recv++;
}
#if (( event == "+"))
#{
#	sent++;
#}
#if (( event == "d"))
#{
#	dropped++;
#}


} #body


END {
	print("Packet loss ratio is: ", dropped/sent);
}
