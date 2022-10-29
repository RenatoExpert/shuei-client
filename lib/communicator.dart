import 'dart:typed_data';
import 'dart:io';

class Net {
	static Future<String> talk_to_server() async {
		final host = 'shuei.shogunautomacao.com.br';
		final port = 2000;
		final socket = await Socket.connect(host, port);
		var gstatus;
		print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
		socket.write('{ "type":"client" }\n');
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
		socket.destroy();
		return gstatus;
	}
}
