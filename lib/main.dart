import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janus Supervisor',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Janus Supervisor Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DeviceController extends Center {
    @override
    var child = Column(
      // Invoke "debug painting" (press "p" in the console, choose the
      // "Toggle Debug Paint" action from the Flutter Inspector in Android
      // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      // to see the wireframe for each widget.
      //
      // Column has various properties to control how it sizes itself and
      // how it positions its children. Here we use mainAxisAlignment to
      // center the children vertically; the main axis here is the vertical
      // axis because Columns are vertical (the cross axis would be
      // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            const Text(
                'TAG Device/Room',
            ),
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
                            semanticLabel: 'Lock',
                            size: 30,
                        ),
                        onPressed: () {},
                    ),
                    IconButton(
                        icon: Icon(
                            Icons.ac_unit,
                            semanticLabel: 'Lock',
                            size: 30,
                        ),
                        onPressed: () {},
                        tooltip: 'Turn ON/OFF switch',
                    ),
                ], //   row's children
            ), //   row 
        ], //   columns' children
    ); //   column
} //    class

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DeviceController(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
