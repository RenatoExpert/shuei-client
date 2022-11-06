import 'package:flutter/material.dart';
import 'dart:io';

class DeviceDisplay extends StatelessWidget {
	final String uuid;
	final Socket sender;
	DeviceDisplay(@required this.uuid, @required this.sender);
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(this.uuid),
					Row (
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							GenericIconButton (Icons.lock, 'Lock', 0, this.uuid, this.sender),
							GenericIconButton (Icons.lightbulb, 'Light', 1, this.uuid, this.sender),
							GenericIconButton (Icons.ac_unit, 'Air conditioner', 2, this.uuid, this.sender),
						], //   row's children
					), //   row 
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

class GenericIconButton extends StatefulWidget {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String uuid;
	final Socket sender;
	GenericIconButton(@required this.iconsym, @required this.radical, @required this.gadget_index, @required this.uuid, @required this.sender);
}

class _GenericIconButtonState extends State<GenericIconButton> {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String uuid;
	final Socket sender;
	String lock_state () {
		return '2';
	}
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
	_GenericIconButtonState(@required this.iconsym, @required this.radical, @required this.gadget_index, @required this.uuid, @required this.sender);
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
				this.sender.write('{ "uuid": "mycontroller", "command": "setstate", "args":{ "gpio":"3", "pinstate":"1"} }\n');
			},
			tooltip: tooltip_render,
		);
	}	
}

