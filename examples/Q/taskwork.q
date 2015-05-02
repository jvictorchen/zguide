//  Task worker
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket

\l qzmq.q

ctx: zctx.new[];

//  Socket to receive messages on
receiver: zsocket.new[ctx;zmq.PULL];
zsocket.connect[receiver;`$"tcp://localhost:5557"];

// Socket to send messages to 
sender: zsocket.new[ctx;zmq.PUSH];
zsocket.connect[sender;`$"tcp://localhost:5558"];

while[1b and not zctx.interrupted[];

  str: zstr.recv[receiver];
  // Show progress
  1 str, "."; 
  // Do the work
  zclock.sleep "I"$str;
  // Send results to sink
  zstr.send[sender;""]];

1 "\n";

zsocket.destroy[ctx;sender];
zsocket.destroy[ctx;receiver];
zctx.destroy[ctx];

\\