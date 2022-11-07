import 'package:flutter/material.dart';
import 'builder.dart';
import 'serverdialog.dart';
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
