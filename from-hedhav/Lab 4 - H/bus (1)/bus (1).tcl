set ns [new Simulator]

set nf [open bus.nam w]
$ns namtrace-all $nf

set tf [open bus.tr w]
$ns trace-all $tf

proc finish {} {
        global ns nf tf
        $ns flush-trace
        close $nf
        close $tf
        exec nam bus.nam
        exit 0
}

$ns color 1 Red

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns queue-limit $n0 $n1 50

$ns duplex-link-op $n0 $n1 orient right

set lan [$ns newLan "$n1 $n2 $n3 $n4 $n5" 0.5Mb 10ms LL Queue/DropTail MAC/-802_3 CHANNEL ]

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
$tcp0 set fid_ 1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n5 $sink1
$ns connect $tcp0 $sink1

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.03
$cbr0 attach-agent $tcp0

$ns at 0.2 "$cbr0 start" ;
$ns at 2.0 "$cbr0 stop"

$ns at 2.2 "finish"

$ns run

