import 'package:flutter/material.dart';

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
	final bool _lock_state = false;
	get tooltip_render { 
			if (_lock_state) return 'ola';
			else return "no";
	}
	_GenericIconButtonState(@required this.iconsym, @required this.radical);
	@override
	Widget build(BuildContext context) {
		return IconButton(
			icon: Icon(
				iconsym,
				semanticLabel: radical,
				size: 30,
			),
			onPressed: () {},
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

