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
var main_stream = StreamController();

connect () async {
	print('Connecting...');
	while (true) {
		try {
			main_socket = await Socket.connect(host, port);
			print('Connected!');
			await main_socket.write('{"type":"client"}\n');
			print('Waiting for updates...');
			var broadcast = main_socket.asBroadcastStream();
			main_stream.addStream(broadcast);
			broadcast.listen((message) {
				print("RECEIVED SOMETHING");
			}, onError:(e) {
				print("ON ERROR");
				main_socket.close();
				connect();
			}, onDone:() {
				print("ON DONE");
				main_socket.close();
				connect();
			});
			break;
		} catch(e) {
			print("Server connection failed ${e}");
			sleep(Duration(seconds:1));
			print("Retrying...");
		}
	}
}

var builder = StreamBuilder<dynamic>(
	stream: main_stream.stream,
	builder: (
		BuildContext context,
		AsyncSnapshot<dynamic> snapshot,
	) {
		switch (snapshot.connectionState) {
			case ConnectionState.waiting:
				return Column (
					children: <Widget> [
						Text('Connecting to server...'),
						CircularProgressIndicator(),
					]
				);
			case ConnectionState.none:
				return Text('Things are so calm by here...');
			case ConnectionState.done:
				print("Socket seems disconnected");
				return Text('Connection is lost.\nTrying to reconnect...');
			case ConnectionState.active:
				if (snapshot.hasData) {
					try {
						try {
							final raw_string = String.fromCharCodes(snapshot.data);
							print(raw_string);
							current_states = jsonDecode(raw_string);
						} catch (e) {
							print("Parsing info ${e}");
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
				} else if (snapshot.hasError) {
					return Text("${snapshot.error}");
				} else {
					return CircularProgressIndicator();
				}
		}
	}
);
