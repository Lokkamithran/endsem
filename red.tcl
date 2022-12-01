#create a new simulator
set ns [new Simulator]

#opening NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#create the tcp/ftp flows
set num_flows 4

#defining a finish procedure
proc finish {} {
	global ns nf num_flows
	$ns flush-trace
	#close the nam trace file
	close $nf
	#execute the nam file in background
	exec nam out.nam &
	exit 0
}

#create the basic 3 backbone nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 15Mb 3ms RED
$ns duplex-link $n1 $n2 20Mb 25ms DropTail

#give position for the link on nam
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right

#set monitors for link between n0, n1 and n2 for nam
$ns duplex-link-op $n0 $n1 queuePos 0.5
$ns duplex-link-op $n1 $n2 queuePos 0.5

$ns queue-limit $n0 $n1 200
$ns queue-limit $n1 $n2 200

#monitor and trace the queues for comparison
set qmon [$ns monitor-queue $n0 $n1 [open redq.tr w] 0.03];
[$ns link $n0 $n1] queue-sample-timeout; 
set qmon2 [$ns monitor-queue $n1 $n2 [open droptail.tr w] 0.03];
[$ns link $n1 $n2] queue-sample-timeout; 

for {set i 1} {$i<=$num_flows} {incr i} {
    
    set tcpsrc($i) [new Agent/TCP]
    $ns attach-agent $n0 $tcpsrc($i) 
    $tcpsrc($i) set class_ 2
    $tcpsrc($i) set window_ 4000

    #create sink and connect src, sink and node
    set tcpsink($i) [new Agent/TCPSink]
    $ns attach-agent $n2 $tcpsink($i)
    $ns connect $tcpsrc($i) $tcpsink($i)
    $tcpsrc($i) set fid_ $i

    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcpsrc($i)
    $ftp($i) set type_ FTP
}


for {set j 1} {$j<=$num_flows} {incr j} {
    $ns at 0.0 "$ftp($j) start"
    $ns at 3.0 "$ftp($j) stop"
}

$ns at 3.0 "finish"

#Run the simulation
$ns run