// Weather update client
// Connects SUB socket to tcp://locahost:5556
// Collects weather updates and finds avg temp in zipcode 
\l qzmq.q 

ctx: zctx.new[];
subscriber: zsocket.new[ctx;zmq`SUB];
rc: zsocket.connect[subscriber;`$"tcp://localhost:5556"];

// use -zip ${zip} to pass in the zip code 
args: .Q.def[enlist[`zip]!enlist `10001] .Q.opt[.z.x];
// Subscribe to zipcode, default is NYC, 10001
filter: args`zip;
zsockopt.set_subscribe[subscriber;filter];

// Process one update
proc_one: {[dummy;subscriber]
  str: zstr.recv[subscriber];
  show "Received one: ", str;
  temperature: "I"$(" " vs str) 1;
  temperature
  };

avg_temp: avg proc_one[;subscriber] each til 5;

show "Average temperature for zipcode ",string[filter], " was ",string[avg_temp],"F";

zsocket.destroy[ctx; subscriber];
zctx.destroy ctx;
\\