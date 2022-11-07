import 'package:flutter/material.dart';
import 'headers.dart';

final portRegex = RegExp(r"^[0-9]+$");

class ServerDialog extends StatefulWidget {
	const ServerDialog({super.key});
	@override
	ServerDialogState createState() => ServerDialogState();
}

class ServerDialogState extends State<ServerDialog> {
	final _formKey = GlobalKey<FormState>();
	@override
	Widget build(BuildContext context) {
		return Expanded (
			child: SimpleDialog (
				title: Text('Server settings'),
				children: <Widget> [
				   	Padding (
						padding: EdgeInsets.all(32),
						child: Form (
							key: _formKey,
							autovalidateMode: AutovalidateMode.always,
							onChanged: () {},
							child: Wrap (
								children: <Widget> [
									Padding (
										padding: EdgeInsets.all(8.0),
										child: TextFormField (
												decoration: InputDecoration (
													icon: Icon(Icons.cloud),
													hintText: 'shuei.shogunautomacao.com.br',
													labelText: 'Address',
												),
												onSaved: (String? value) {
													print('Saving address... ${value}');
													host = value!=null ? value : host;
												},
												validator: (String? value) {
													return (value==null) ? 'Cannot be empty!' : null;
												},
											),
									),
									Padding (
										padding: EdgeInsets.all(8.0),
										child: TextFormField (
											decoration: InputDecoration (
												icon: Icon(Icons.polyline),
												hintText: '2000',
												labelText: 'Port',
											),
											onSaved: (String? value) {
												print('Saving port... ${value}');
												port = value!=null ? int.parse(value) : port;
											},
											validator: (String? value) {
												if (value!=null && portRegex.hasMatch(value)) {
													return null;
												} else {
													return 'Not a valid port';
												}
											},
										),
									),
									Padding (
										padding: EdgeInsets.all(8.0),
										child: Row (
											children: <Widget> [
												ElevatedButton (
													onPressed: () {
														if (_formKey.currentState!.validate()) {
															_formKey.currentState!.save();
															main_socket.close();
															Navigator.pop(context, 'Cancel');
														};
													},
													child: Icon(Icons.save),
												),
												ElevatedButton (
													onPressed: () {
														Navigator.pop(context, 'Cancel');
													},
													child: Icon(Icons.cancel),
												),
											],
										),
									),
								],
							),
						),
					),
				],
			),
		);
	}
}

