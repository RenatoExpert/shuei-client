import 'package:flutter/material.dart';
import 'communicator.dart';
import 'dart:convert';

var Current_States = {};
final update_states = () async {
	Current_States = jsonDecode(await Net.talk_to_server());
};

class DeviceDisplay extends StatefulWidget {
	final String devtag;
	DeviceDisplay(@required this.devtag);
	@override
	_DeviceDisplayState createState() => _DeviceDisplayState(this.devtag);
}

class GenericIconButton extends StatefulWidget {
	final IconData iconsym;
	final String radical;
	GenericIconButton(@required this.iconsym, @required this.radical);
	@override
	_GenericIconButtonState createState() => _GenericIconButtonState(this.iconsym, this.radical);
}

class _GenericIconButtonState extends State<GenericIconButton> {
	final IconData iconsym;
	final String radical;
	bool lock_state () => Current_States['j324u'] == '333';
	final revert_button = () {
		setState() {
			update_states();
		}
	};
	get tooltip_render { 
		var execution = lock_state() ? 'Allowed' : 'Disabled';
		var inverse = lock_state() ? 'disable' : 'enable';
		return "${radical} is ${execution}. Click to ${inverse}";
	}
	get iconColor {
		return lock_state() ? Colors.green : Colors.black;
	}
	_GenericIconButtonState(@required this.iconsym, @required this.radical);
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
					revert_button();
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
					Row (
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							GenericIconButton (Icons.lock, 'Lock'),
							GenericIconButton (Icons.lightbulb, 'Light'),
							GenericIconButton (Icons.ac_unit, 'Air conditioner'),
						], //   row's children
					), //   row 
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

