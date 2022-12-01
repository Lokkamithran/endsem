set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Yellow

set tf [open wired.tr w]
$ns trace-all $tf
#Open the NAM trace file
set nf [open wired.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    #Close the NAM trace file
    close $nf
    #Execute NAM on the trace file
    exec nam wired.nam &
    exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n3 $n2 1.7Mb 20ms DropTail

#Give node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n3 $n2 orient right
 
#Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 2

#Setup a FTP over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

set tcp2 [new Agent/TCP]
$tcp2 set class_ 3
$ns attach-agent $n3 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 3

#Setup a FTP over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP

#Schedule events for the CBR and FTP agents
# $ns at 0.1 "$cbr start"
$ns at 0.1 "$ftp start"
$ns at 0.4 "$ftp stop"
$ns at 0.1 "$ftp1 start"
$ns at 0.4 "$ftp1 stop"
$ns at 0.1 "$ftp2 start"
$ns at 0.4 "$ftp2 stop"
# $ns at 4.5 "$cbr stop"


#Call the finish procedure after 5 seconds of simulation time
$ns at 0.5 "finish"

#Run the simulation
$ns run
