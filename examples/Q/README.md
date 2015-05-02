zeroMQ - Q examples
=====================

Uses qzmq or https://github.com/jaeheum/qzmq.
qzmq follows czmq rather than libzmq and examples here are translations from libzmq to czmq/qzmq.

## Chapter 1

    q hwserver.q -q / in one terminal

	q hwclient.q -q / in another terminal

    q version.q -q  / version reporting 

    q wuserver.q -q  / weather update server 

    q wuclient.q -zip 10001 -q  / weather update client 



	q identity.q -q
	
	q mtserver.q -q / is a multithreaded hwserver.q

	
## License
See LICENSE in examples directory.
