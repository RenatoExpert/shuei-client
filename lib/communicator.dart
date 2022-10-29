import 'dart:typed_data';
import 'dart:io';

class Net {
	static Future<String> talk_to_server() async {
		final socket = await Socket.connect('localhost', 2000);
		var gstatus;
		print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
		await Net.sendCommands(socket, '{ "type":"client" }\n');
		var waitback = socket.listen(
			(Uint8List data) {
				gstatus = String.fromCharCodes(data);
			},

			onError:(error) {
				print(error);
				socket.destroy();
			},

			onDone: () {
				print('its done');
				socket.destroy();
			},
		);
		await waitback.asFuture<void>();
		return gstatus;
	}
	static Future<void> sendCommands(Socket socket, String message) async {
		print('Client: $message');
		socket.write(message);
	}
}
