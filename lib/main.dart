import 'package:flutter/material.dart';
import 'builder.dart';
import 'dart:async';

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Shuei Client',
			theme: ThemeData(
				primarySwatch: Colors.indigo,
			),
			home: const MyHomePage(title: 'Shuei Client Home Page'),
			debugShowCheckedModeBanner: false,
		);
	}
}

class MyHomePage extends StatefulWidget {
	const MyHomePage({super.key, required this.title});
	final String title;
	@override
	State<MyHomePage> createState() => _MyHomePageState();
}

class ServerDialog extends StatefulWidget {
	const ServerDialog({super.key});
	@override
	ServerDialogState createState() {
		return ServerDialogState();
	}
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
													print('Saving... ${value}');
												},
												validator: (String? value) {
													return (value!=Null && value == '#') ? 'Do not use the char "#"!' : null;
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
												print('Saving... ${value}');
											},
											validator: (String? value) {								
												return (value!=Null && value == '#') ? 'Do not use the char "#"!' : null;
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
															print('heeey');
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

class _MyHomePageState extends State<MyHomePage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: Center(child:builder),
			floatingActionButton: FloatingActionButton (
				onPressed: () => showDialog(
					context: context,
					builder: (BuildContext context) {
						return ServerDialog();
					},
				),
				tooltip: 'Server settings',
				child: Icon(Icons.settings),
			),
		);
	}
	@override
	void initState() {
		super.initState();
		WidgetsBinding.instance.addPostFrameCallback((_)=> connect());
	}
}
