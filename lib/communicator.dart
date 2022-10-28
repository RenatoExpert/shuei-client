import 'dart:typed_data';
import 'dart:io';

class Net {
	static void talk_to_server() async {
		final socket = await Socket.connect('localhost', 2000);
		print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
		await Net.sendCommands(socket, '{ "type":"client" }\n');
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
	static Future<void> sendCommands(Socket socket, String message) async {
		print('Client: $message');
		socket.write(message);
	}
}
