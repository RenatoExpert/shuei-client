import 'package:flutter/material.dart';

class DeviceDisplay extends StatefulWidget {
	final String devtag;
	DeviceDisplay(@required this.devtag);
	@override
	_DeviceDisplayState createState() => _DeviceDisplayState(this.devtag);
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
							IconButton(
								icon: Icon(
									Icons.lock,
									semanticLabel: 'Lock',
									size: 30,
								),
								onPressed: () {},
							),
							IconButton(
								icon: Icon(
									Icons.lightbulb,
									semanticLabel: 'Light',
									size: 30,
								),
								onPressed: () {},
							),
							IconButton(
								icon: Icon(
									Icons.ac_unit,
									semanticLabel: 'Air conditioner',
									size: 30,
								),
								onPressed: () {},
								tooltip: 'Turn ON/OFF switch',
							),
						], //   row's children
					), //   row 
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

