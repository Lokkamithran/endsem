# A 100 node example for ad-hoc simulation with AODV

# Define options
set val(chan)		Channel/WirelessChannel		;# channel type
set val(prop)		Propagation/TwoRayGround    ;# radio-propagation model
set val(netif)		Phy/WirelessPhy		    	;# network interface type

set val(mac)		Mac/802_11		    		;# MAC Type
set val(ifq)		Queue/DropTail/PriQueue     ;# interface queue type
set val(ll)			LL			    			;# link layer type
set val(ant)		Antenna/OmniAntenna	  	 	;# antenna model
set val(ifqlen)		50			 		  		;# max packet in ifq
set val(nn)			15			    			;# number of mobilnodes
set val(rp)			AODV			    		;# routing protocol
set val(x)			500			    			;# X dimensions of topography
set val(y)			400			    			;# Y dimensions of topography
set val(stop)		40			    			;# time of simulation end

set ns		[new Simulator]
set tracefd	  [open aodv.tr w]
set windowVsTime2 [open win.tr w]
set namtrace	  [open aodv.nam w]

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

proc finish {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
	exec nam aodv.nam
	exit 0
}

#set up topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

# Create nn mobilenodes [$val(nn)] and attach them to the channel.

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

for {set i 0} {$i < $val(nn) } { incr i } {
	set node_($i) [$ns node]
	$node_($i) set X_ [ expr 10+round(rand()*480) ]
	$node_($i) set Y_ [ expr 10+round(rand()*380) ]
	$node_($i) set Z_ 0.0
}

for {set i 0} {$i < $val(nn) } { incr i } {
	$ns at [ expr 3+round(rand()*5) ] "$node_($i) setdest [ expr 10+round(rand()*480) ] [ expr 10+round(rand()*380) ] [ expr 2+round(rand()*15) ]"
}

# Set a TCP connection between node_(2) and node_(11)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(2) $tcp
$ns attach-agent $node_(11) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"

# Printing the window size
proc plotWindow {tcpSource file} {
global ns
set time 0.01
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "plotWindow $tcpSource $file" }
$ns at 1.1 "plotWindow $tcp $windowVsTime2"

# Define node initial position in nam
for {set i 0} {$i < $val(nn) } { incr i } {
	# 30 defines the node size for nam
	$ns initial_node_pos $node_($i) 30
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
}

# ending nam and the simulation
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"end simulation\" ; $ns halt"

$ns run