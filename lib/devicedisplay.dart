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
							GadgetButton (Icons.lock, 'Lock', 0, this.uuid, this.sender),
							GadgetButton (Icons.lightbulb, 'Light', 1, this.uuid, this.sender),
							GadgetButton (Icons.ac_unit, 'Air conditioner', 2, this.uuid, this.sender),
							IconButton(
								icon: Icon(Icons.build),
								onPressed: () {},
								tooltip: "Controller's settings",
							),
						], //   row's children
					), //   row 
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

