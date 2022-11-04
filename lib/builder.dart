import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';
import 'devicedisplay.dart';

Map<String, dynamic> serversheet = { "type": "client" };
Map<String, dynamic> current_states = {};
final host = 'shuei.shogunautomacao.com.br';
final port = 2000;
var main_socket;
final main_stream = main_socket.asBroadcastStream();

var builder = StreamBuilder<dynamic>(
	stream: main_stream.asBroadcastStream(),
	builder: (
		BuildContext context,
		AsyncSnapshot<dynamic> snapshot,
	) {
		try {
			current_states = jsonDecode(
				String.fromCharCodes(snapshot.data)
			);
			print(current_states);
			print('received');
			return Column (
				children: List.generate(current_states.length, (index) {
					if (current_states.length != 0) {
						return DeviceDisplay(current_states.keys.elementAt(index), main_socket);
					} else {
						return Text('No gadgets to display :-(');
					}
				}),
				mainAxisAlignment: MainAxisAlignment.center,
			);
		} catch (e) {
			return Text("Error: $e");
		}
	}
);

connect () async {
	print('Connecting...');
	main_socket = await Socket.connect(host, port);
	await main_socket.write('{"type":"client"}\n');
}
