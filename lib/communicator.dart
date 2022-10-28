import 'dart:typed_data';
import 'dart:io';

class Net {
	static Future talk_to_server() async {
		final socket = await Socket.connect('localhost', 2000);
		var gstatus;
		print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
		await Net.sendCommands(socket, '{ "type":"client" }\n');
		socket.listen(
			(Uint8List data) {
				final serverResponse = String.fromCharCodes(data);
				print('Server: $serverResponse');
				gstatus = serverResponse;
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
		return gstatus;
	}
	static Future<void> sendCommands(Socket socket, String message) async {
		print('Client: $message');
		socket.write(message);
	}
}
