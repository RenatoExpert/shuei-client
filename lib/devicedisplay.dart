import 'package:flutter/material.dart';
import 'communicator.dart';
import 'dart:convert';
import 'dart:async';

Map<String, dynamic> current_states = {};
List stack_commands = [];
Map<String, dynamic> serversheet = {
	"type" : "client",
	"commands" : [],
};

class Server {
	final Stream _stream = Stream.periodic(
		const Duration(seconds:1),
		(int count) {
			Server().update();
		},
			
	);
	Stream<dynamic> get stream => _stream;
	update () {
		List transitional = List.from(stack_commands);
		stack_commands.removeWhere((command) => transitional.contains(command));
		serversheet['commands'] = transitional;
		Future request = Net.talk_to_server(serversheet);
		request.then((value) {
			Map<String, dynamic> NewStates = jsonDecode(value);
			if (NewStates is! Null) {
			       current_states = NewStates;
			};
			print(current_states);
			var prob = (current_states).runtimeType;
		});
	}
}

class DeviceDisplay extends StatefulWidget {
	final String devtag;
	DeviceDisplay(@required this.devtag);
	@override
	_DeviceDisplayState createState() => _DeviceDisplayState(this.devtag);
}

class GenericIconButton extends StatefulWidget {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String this.uuid;
	GenericIconButton(@required this.iconsym, @required this.radical, @required this.gadget_index, @required this.uuid);
	@override
	_GenericIconButtonState createState() => _GenericIconButtonState(this.iconsym, this.radical, this.gadget_index, this.uuid);
}

class _GenericIconButtonState extends State<GenericIconButton> {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String uuid;
	String lock_state () {
		if (current_states.containsKey(this.uuid)) {
			return current_states[this.uuid].toString()[gadget_index];
		} else {
			return 'null';
		}
	}
	final revert_button = () {
		print('revert');
	};
	get tooltip_render { 
		var isActive = lock_state() == '2'|| lock_state() =='3'; 
		var execution = isActive  ? 'Allowed' : 'Disabled';
		var inverse = isActive ? 'disable' : 'enable';
		return "${radical} is ${execution}. Click to ${inverse}";
	}
	get iconColor {
		switch (lock_state()) {
			case '0':
				return Colors.black;
				break;
			case '1':
				return Colors.red;
				break;
			case '2':
				return Colors.yellow;
				break;
			case '3':
				return Colors.green;
				break;
		}
	}
	_GenericIconButtonState(@required this.iconsym, @required this.radical, @required this.gadget_index, @required this.uuid);
	@override
	Widget build(BuildContext context) {
		return IconButton(
			icon: Icon(
				iconsym,
				color: iconColor,
				semanticLabel: radical,
				size: 30,
			),
			onPressed: () {
				stack_commands.add({
					"uuid": "j324u",
					"cmd" : "revertstate",
					"args": {
						"pair_id": this.gadget_index.toString(),
					}
				});
				print("Got a click");
				print(stack_commands);
			},
			tooltip: tooltip_render,
		);
	}	
}

class _DeviceDisplayState extends State<DeviceDisplay> {
	final String uuid;
	_DeviceDisplayState(@required this.uuid);
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(this.uuid'),
					StreamBuilder<dynamic>(
						stream: Server().stream,
						builder: (
								BuildContext context,
								AsyncSnapshot<dynamic> snapshot,
						) {
							return Row (
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									GenericIconButton (Icons.lock, 'Lock', 0, this.uuid),
									GenericIconButton (Icons.lightbulb, 'Light', 1, this.uuid),
									GenericIconButton (Icons.ac_unit, 'Air conditioner', 2, this.uuid),
								], //   row's children
							); //   row 
						}, // stream's builder
					), // Stream
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

