import 'package:flutter/material.dart';

class GenericIconButton extends StatelessWidget {
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
		var inverse' = isActive ? 'disable' : 'enable';
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
	GenericIconButton(@required this.iconsym, @required this.radical, @required this.gadget_index, @required this.uuid, @required this.sender);
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

