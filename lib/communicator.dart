import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';

class Net {
	static Future<String> talk_to_server(serversheet) async {
		final host = 'shuei.shogunautomacao.com.br';
		final port = 2000;
		final socket = await Socket.connect(host, port);
		String gstatus = '{}';
		print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
		var greetstr = jsonEncode(serversheet);
		socket.write(greetstr+'\n');
		var waitback = socket.listen(
			(Uint8List data) {
				final received = String.fromCharCodes(data);
				print(received);
				gstatus = received;
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
		socket.destroy();
		return gstatus;
	}
}
