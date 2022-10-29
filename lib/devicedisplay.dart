import 'package:flutter/material.dart';
import 'communicator.dart';
import 'dart:convert';
import 'dart:async';

var current_states;
class Server {
	final Stream _stream = Stream.periodic(
		const Duration(seconds:1),
		(int count) {
			print('from controller');
			Server().update();
		},
			
	);
	Stream<dynamic> get stream => _stream;
	update () {
		Future request = Net.talk_to_server();
		request.then((value) {
			Map<String, dynamic> NewStates = jsonDecode(value);
			if (NewStates is! Null) {
			       current_states = NewStates;
			};
			print(current_states);
			print(current_states['j324u']);
			var prob = (current_states).runtimeType;
			print('eita $prob');
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
	GenericIconButton(@required this.iconsym, @required this.radical, @required this.gadget_index);
	@override
	_GenericIconButtonState createState() => _GenericIconButtonState(this.iconsym, this.radical, this.gadget_index);
}

class _GenericIconButtonState extends State<GenericIconButton> {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	bool lock_state () {
		if (current_states.containsKey('j324u')) {
			return current_states['j324u'].toString()[gadget_index]=='3' ? true:false;
		} else {
			return false;
		}
	}
	final revert_button = () {
		print('revert');
	};
	get tooltip_render { 
		var execution = lock_state() ? 'Allowed' : 'Disabled';
		var inverse = lock_state() ? 'disable' : 'enable';
		return "${radical} is ${execution}. Click to ${inverse}";
	}
	get iconColor {
		return lock_state() ? Colors.green : Colors.black;
	}
	_GenericIconButtonState(@required this.iconsym, @required this.radical, @required this.gadget_index);
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
				setState(() {
				});
			},
			tooltip: tooltip_render,
		);
	}	
}

class _DeviceDisplayState extends State<DeviceDisplay> {
	final String devtag;
	_DeviceDisplayState(@required this.devtag);
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(devtag),
					StreamBuilder<dynamic>(
						stream: Server().stream,
						builder: (
								BuildContext context,
								AsyncSnapshot<dynamic> snapshot,
						) {
							return Row (
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									GenericIconButton (Icons.lock, 'Lock', 0),
									GenericIconButton (Icons.lightbulb, 'Light', 1),
									GenericIconButton (Icons.ac_unit, 'Air conditioner', 2),
								], //   row's children
							); //   row 
						}, // stream's builder
					), // Stream
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

