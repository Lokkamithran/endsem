set ns [new Simulator]
$ns rtproto DV

set nf [open ring.nam w]
$ns namtrace-all $nf

set tf [open ring.tr w]
$ns trace-all $tf

proc finish {} {
        global ns nf tf
        $ns flush-trace
        close $nf
        close $tf
        exec nam ring.nam
        exit 0
        }

#Creating Nodes
for {set i 0} {$i<7} {incr i} {
set n($i) [$ns node]
}

#Creating Links
for {set i 0} {$i<7} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%7]) 512Kb 5ms DropTail
}

$ns duplex-link-op $n(0) $n(1) queuePos 1
$ns duplex-link-op $n(0) $n(6) queuePos 1

$ns duplex-link-op $n(0) $n(1) orient right-down
$ns duplex-link-op $n(1) $n(2) orient down
$ns duplex-link-op $n(2) $n(3) orient left-down
$ns duplex-link-op $n(3) $n(4) orient left-up
$ns duplex-link-op $n(4) $n(5) orient up
$ns duplex-link-op $n(5) $n(6) orient right-up
$ns duplex-link-op $n(0) $n(6) orient left
#Creating UDP agent and attching to node 0
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0

#Creating Null agent and attaching to node 3
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

$ns connect $udp0 $null0


#Creating a CBR agent and attaching it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

$ns rtmodel-at 0.4 down $n(2) $n(3)
$ns rtmodel-at 1.0 up $n(2) $n(3)

$ns at 0.01 "$cbr0 start"
$ns at 1.5 "$cbr0 stop"

$ns at 2.0 "finish"
$ns run
