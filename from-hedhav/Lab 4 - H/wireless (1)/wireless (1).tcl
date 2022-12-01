# Simulator Instance Creation
set ns [new Simulator]

#Fixing the co-ordinate of simutaion area
set val(x) 500
set val(y) 500
# Define options
set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model

set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(ifq) Queue/DropTail/PriQueue ;# interface queue type
set val(ll) LL ;# link layer type
set val(ant) Antenna/OmniAntenna ;# antenna model
set val(ifqlen) 200 ;# max packet in ifq
set val(nn) 4 ;# number of mobilenodes
set val(rp) AODV ;# routing protocol
set val(x) 500 ;# X dimension of topography
set val(y) 400 ;# Y dimension of topography
# set val(stop) 10.0 ;# time of simulation end

# set up topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

#Nam File Creation nam – network animator
set namfile [open wireless.nam w]

#Tracing all the events and cofiguration
$ns namtrace-all-wireless $namfile $val(x) $val(y)

#Trace File creation
set tracefile [open wireless.tr w]

#Tracing all the events and cofiguration
$ns trace-all $tracefile

# general operational descriptor- storing the hop details in the network
create-god $val(nn)

# configure the nodes
$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace ON

# Node Creation
set n1 [$ns node]
$n1 set X_ 200
$n1 set Y_ 100
$n1 set Z_ 0
$n1 label N1

set n2 [$ns node]
$n2 set X_ 200
$n2 set Y_ 300
$n2 set Z_ 0
$n2 label N2

set n3 [$ns node]
$n3 set X_ 100
$n3 set Y_ 300
$n3 set Z_ 0
$n3 label N3

set n4 [$ns node]
$n4 set X_ 100
$n4 set Y_ 100
$n4 set Z_ 0
$n4 label N4


#Size of the node
$ns initial_node_pos $n1 30
$ns initial_node_pos $n2 30
$ns initial_node_pos $n3 30
$ns initial_node_pos $n4 30

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
 
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
 
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

set udp3 [new Agent/UDP]
$ns attach-agent $n3 $udp3
 
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3

set null0 [new Agent/Null]
$ns attach-agent $n4 $null0
$ns connect $udp1 $null0
$ns connect $udp2 $null0
$ns connect $udp3 $null0 

$ns at 1.0 "$cbr1 start"
$ns at 8.0 "$cbr1 stop"

$ns at 2.0 "$cbr2 start"
$ns at 7.0 "$cbr2 stop"

$ns at 2.5 "$cbr3 start"
$ns at 9.0 "$cbr3 stop"

$ns at 10.0 "finish"


proc finish {} {
  global namfile tracefile ns
  $ns flush-trace
  close $namfile
  close $tracefile
  #executing nam file
  exec nam wireless.nam &
}

#Starting scheduler
$ns run






