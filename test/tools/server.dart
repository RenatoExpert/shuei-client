import 'dart:core';
import 'dart:async';
import 'dart:io';

var socket;

class Server {
	var socket;

	sendEmpty() {
		print(this.socket);
		//this.socket.add('{}');
	}

	Server() { 
		var serverFuture = ServerSocket.bind('0.0.0.0', 2000);
		final self = this;
		serverFuture.then(
			(var server) {
				print('server function');
				server.listen((Socket sock) {
					self.socket = sock;
					self.socket.listen((List<int> data) {
						String result = new String.fromCharCodes(data);
						print(data);
						print(result.substring(0, result.length - 1));
					});
					print(self.socket);
				});
			}
		);
	}
}
