import 'package:flutter/material.dart';
import 'package:triangle_seekbar/triangle_seekbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Triangle Seekbar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double seekbarValue = 5.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$seekbarValue",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
                width: 1,
              ),
              TriangleSeekbar(
                onChanged: (value) {
                  setState(() {
                    seekbarValue = value;
                  });
                },
                value: seekbarValue,
                height: 150,
                min: 1,
                max: 10,
              ),
            ]),
      ),
    );
  }
}
