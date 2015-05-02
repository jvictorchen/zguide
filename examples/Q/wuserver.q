// Weather update server 
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates
\l qzmq.q

ctx: zctx.new[];
publisher: zsocket.new[ctx;zmq`PUB];
rc: zsocket.bind[publisher;`$"tcp://*:5556"];

while[1b and not zctx.interrupted[];
  zipcode: first 1 + 1?100000; // random number between 1 and 100000
  temperature: first -80 + 1?215; 
  relhumidity: first 10 + 1?50;
  txt: " " sv string (zipcode;temperature;relhumidity);
  zstr.send[publisher;txt]
  ];
  
zsocket.destroy[ctx; publisher];
zctx.destroy[ctx];

\\