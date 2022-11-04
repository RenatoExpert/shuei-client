import 'package:flutter/material.dart';

class DeviceDisplay extends StatefulWidget {
	final String uuid;
	final Socket sender;
	DeviceDisplay(@required this.uuid, @required this.sender);
	@override
	_DeviceDisplayState createState() => _DeviceDisplayState(this.uuid, this.sender);
}

class GenericIconButton extends StatefulWidget {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String uuid;
	final Socket sender;
	GenericIconButton(@required this.iconsym, @required this.radical, @required this.gadget_index, @required this.uuid, @required this.sender);
	@override
	_GenericIconButtonState createState() => _GenericIconButtonState(this.iconsym, this.radical, this.gadget_index, this.uuid);
}

class _GenericIconButtonState extends State<GenericIconButton> {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String uuid;
	final Socket sender;
	String lock_state () {
		return '2';
		/*
		if (current_states.containsKey(this.uuid)) {
			return current_states[this.uuid].toString()[gadget_index];
		} else {
			return 'null';
		}
		*/
	}
	final flip = () {
		print('revert');
		/*
		stack_commands.({
			"uuid": this.uuid,
			"cmd" : "revertstate",
			"args": {
				"pair_id": this.gadget_index.toString(),
			}
		});
		*/
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
				flip();
			},
			tooltip: tooltip_render,
		);
	}	
}

class _DeviceDisplayState extends State<DeviceDisplay> {
	final String uuid;
	final Socket sender;
	_DeviceDisplayState(@required this.uuid, this.sender);
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

