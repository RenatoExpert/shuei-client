import 'package:flutter/material.dart';

class DeviceDisplay extends StatefulWidget {
	final String uuid;
	DeviceDisplay(@required this.uuid);
	@override
	_DeviceDisplayState createState() => _DeviceDisplayState(this.uuid);
}

class GenericIconButton extends StatefulWidget {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	final String uuid;
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
		return '2';
		/*
		if (current_states.containsKey(this.uuid)) {
			return current_states[this.uuid].toString()[gadget_index];
		} else {
			return 'null';
		}
		*/
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
				/*
				stack_commands.({
					"uuid": this.uuid,
					"cmd" : "revertstate",
					"args": {
						"pair_id": this.gadget_index.toString(),
					}
				});
				*/
				print("Got a click");
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
					Text(this.uuid),
					Row (
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							GenericIconButton (Icons.lock, 'Lock', 0, this.uuid),
							GenericIconButton (Icons.lightbulb, 'Light', 1, this.uuid),
							GenericIconButton (Icons.ac_unit, 'Air conditioner', 2, this.uuid),
						], //   row's children
					), //   row 
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

