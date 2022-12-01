set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Yellow

set nf [open wired.nam w]
$ns namtrace-all $nf

set tf [open wired.tr w]
$ns trace-all $tf

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam wired.nam
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
$ns duplex-link-op $n3 $n2 orient left




#Setup a TCP connection
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n0 $tcp0
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $tcp0 $sink
$tcp0 set fid_ 1

#Setup a FTP over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP

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
$ns at 0.5 "$ftp0 start"
$ns at 3.0 "$ftp0 stop"
$ns at 1.5 "$ftp1 start"
$ns at 3.5 "$ftp1 stop"
$ns at 2.2 "$ftp2 start"
$ns at 4.5 "$ftp2 stop"

# #Detach tcp and sink agents (not really necessary)
# $ns at 4.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n2 $sink"
# $ns at 4.5 "$ns detach-agent $n1 $tcp1 ; $ns detach-agent $n2 $sink1"
# $ns at 4.5 "$ns detach-agent $n3 $tcp2 ; $ns detach-agent $n2 $sink2"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run