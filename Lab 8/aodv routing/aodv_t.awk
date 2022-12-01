#============== throughput.awk ================

BEGIN {
recv=0;
gotime = 0;
time = 0;
time_interval=0.1;
}
#body
{
        event = $1
        time = $2
        protocol = $7
        packet_size = $8

 if(time>gotime) {

  print gotime, (packet_size * recv * 8.0)/1000; #packet size * ... gives results in kbps
  gotime+= time_interval;
  recv=0;
  }

#========Calculate throughput==========

if (( event == "r") && (protocol == "tcp"))
{
 recv++;
}
} #body


END {
;
}
