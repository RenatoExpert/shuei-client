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
StreamController<dynamic> main_stream = StreamController.broadcast();

connect () async {
	print('Connecting...');
	while (true) {
		try {
			main_socket = await Socket.connect(host, port);
			print('Connected!');
			await main_socket.write('{"type":"client"}\n');
			print('Waiting for updates...');
			var broadcast = main_socket.asBroadcastStream();
			broadcast.where((message)=>message!=Null);
			broadcast.listen((message) {
				try {
					main_stream.sink.add(jsonDecode(String.fromCharCodes(message)));
				} catch (e) {
					print("Parsing info ${e}");
				}
				print("RECEIVED SOMETHING");
			}, onError:(e) {
				print("ON ERROR");
				main_socket.close();
				main_stream.sink.addError(e);
				connect();
			}, onDone:() {
				print("ON DONE");
				main_stream.sink.addError("Connection ended");
				connect();
			});
			break;
		} catch(e) {
			print("Server connection failed ${e}");
			await Future.delayed(Duration(seconds:3));
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
						CircularProgressIndicator(),
						Text('Connecting to server...'),
					],
					mainAxisAlignment: MainAxisAlignment.center,
				);
			case ConnectionState.none:
				return Text('Things are so calm by here...');
			case ConnectionState.done:
				print("Socket seems disconnected");
				return Text('Connection is lost.\nTrying to reconnect...');
			case ConnectionState.active:
				if (snapshot.hasData) {
					final states = snapshot.data;
					if (snapshot.data.isEmpty) {
						return Text('Listening for new gadgets...');
					} else if (states.length > 0) {
						return Column (
							children: List.generate(states.length, (index) {
									return DeviceDisplay(states.keys.elementAt(index), main_socket);
							}),
							mainAxisAlignment: MainAxisAlignment.center,
						);
					}
				}
		}
		return Column (
			children: <Widget> [
				CircularProgressIndicator(),
				Text('Connection lost. Reconnecting...'),
			],
			mainAxisAlignment: MainAxisAlignment.center,
		);
	}
);
