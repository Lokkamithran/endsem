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

 if(time>gotime && sent!=0) {

  print gotime, dropped, sent, dropped/sent;
  gotime += time_interval;
  sent=0;
  dropped=0;
  }
if (( event == "r"))
{
	sent++;
}
if (( event == "D"))
{
	dropped++;
}
} #body

END {
	;
}
