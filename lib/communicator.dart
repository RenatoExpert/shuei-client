import 'dart:typed_data';
import 'dart:io';

void main() {
	talk_to_server();
}

void talk_to_server() async {
	final socket = await Socket.connect('localhost', 2000);
	print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
	await sendCommands(socket, '{"type":"client"}');
	socket.listen(
		(Uint8List data) {
			final serverResponse = String.fromCharCodes(data);
			print('Server: $serverResponse');
		},

		onError:(error) {
			print(error);
			socket.destroy();
		},

		onDone: () {
			print('Server left.');
			socket.destroy();
		},
	);
}

Future<void> sendCommands(Socket socket, String message) async {
	print('Client: $message');
	socket.write(message);
	await Future.delayed(Duration(seconds:2));
}
