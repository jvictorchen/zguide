//  Task sink
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket

\l qzmq.q

ctx: zctx.new[];

receiver: zsocket.new[ctx;zmq.PULL];
zsocket.bind[receiver;`$"tcp://*:5558"];

// Wait for start of batch
str: zstr.recv[receiver];

// Start our clock now 
start_time: zclock.time[];

// process one 
proc_one: {[task_nbr]
  msg: zstr.recv[receiver];
  1 $[0 = task_nbr mod 10;":";"."];
  };

proc_one each til 100;

end_time: zclock.time[];

1 "Total elapsed time: ", string[end_time - start_time], "msec\n";

zsocket.destroy[ctx;receiver];
zctx.destroy[ctx];

\\


