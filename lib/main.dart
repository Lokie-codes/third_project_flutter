import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Color Picker'),
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
  final Map<String, Color> colors = {
    'purple': Colors.purpleAccent,
    'blue': Colors.blueAccent,
    'yellow': Colors.yellowAccent,
    'pink': Colors.pinkAccent,
    'teal': Colors.tealAccent,
    'orange': Colors.orangeAccent
  };
  Color? selectedColor;

  @override
  void initState() {
    _getStoredColor();
    super.initState();
  }

void _getStoredColor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? colorName = prefs.getString('color');
  setState(() {
    selectedColor = colors[colorName];
  });
}
void _setColor(String colorName, Color color) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('color', colorName);
  setState(() {
    selectedColor = color;
  });
}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
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
          children: [
            Center(
              child: Text(
                'You are operating on ${kIsWeb ? "the web" : Platform.operatingSystem}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            for (var entry in colors.entries)
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: entry.value,
                    minimumSize: const Size(300, 60),
                  ),
                  child: const Text(''),
                  onPressed: () => _setColor(entry.key, entry.value),
                ),
              ),
          ],
        ),
      ),
      
    );
  }
}
