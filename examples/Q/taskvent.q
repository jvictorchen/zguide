//  Task ventilator
//  Binds PUSH socket to tcp://localhost:5557
//  Sends batch of tasks to workers via that socket

\l qzmq.q 

ctx: zctx.new[];

//  Socket to send messages on
sender: zsocket.new[ctx;zmq.PUSH];
zsocket.bind[sender;`$"tcp://*:5557"];

// Socket to send start of batch message on
sink: zsocket.new[ctx;zmq.PUSH];
zsocket.connect[sink;`$"tcp://localhost:5558"];

1 "Press Enter when the workers are ready: ";
read0 0;
1 "Sending tasks to workers…\n";

zstr.send[sink;1#"0"];

workloads: 1 + 100?100;
total_msec: sum workloads;
zstr.send[sender;] each string workloads;

1 "Total expected cost: ", string[total_msec], " msec\n";

zclock.sleep 1000;

zsocket.destroy[ctx;sender];
zsocket.destroy[ctx;sink];
zctx.destroy[ctx];

\\