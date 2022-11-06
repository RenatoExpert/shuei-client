import 'package:flutter/material.dart';
import 'dart:io';
import 'gadgetbutton.dart';

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

