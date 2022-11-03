import 'package:flutter/material.dart';
import 'devicedisplay.dart';
import 'dart:async';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuei Client',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Shuei Client Home Page'),
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
  late Stream main_stream;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
	  main_stream = widget.socket.asBroadcastStream();
	  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<dynamic>(
		stream: main_stream,
		builder: (
			BuildContext context,
			AsyncSnapshot<dynamic> snapshot,
		) {
			return Column (
				children: List.generate(current_states.length, (index) {
					if (current_states.length != 0) {
						return DeviceDisplay(current_states.keys.elementAt(index));
					} else {
						return Text('No gadgets to display :-(');
					}
				}),
				mainAxisAlignment: MainAxisAlignment.center,
			);
		}
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
