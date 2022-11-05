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

connect () async {
	print('Connecting...');
	while (true) {
		try {
			main_socket = await Socket.connect(host, port);
			await main_socket.write('{"type":"client"}\n');
			break;
		} catch(e) {
			print("Server connection failed ${e}");
			sleep(Duration(seconds:1));
			print("Retrying...");
		}
	}
}

var builder = StreamBuilder<dynamic>(
	stream: main_stream.asBroadcastStream(),
	builder: (
		BuildContext context,
		AsyncSnapshot<dynamic> snapshot,
	) {
		try {
			try {
				current_states = jsonDecode(
					String.fromCharCodes(snapshot.data)
				);
			} catch (e) {
				print(e);
			}
			if (current_states.isEmpty) {
				return Text('Listening for new gadgets...');
			} else if (current_states.length > 0) {
				return Column (
					children: List.generate(current_states.length, (index) {
							return DeviceDisplay(current_states.keys.elementAt(index), main_socket);
					}),
					mainAxisAlignment: MainAxisAlignment.center,
				);
			} else {
				return Text("Unknown error");
			}
		} catch (e) {
			return Text("Error: $e");
		}
	}
);
