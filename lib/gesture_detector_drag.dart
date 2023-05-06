import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: DragPage(),
    );
  }
}

class DragPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DragPageState();
  }
}

class DragPageState extends State<DragPage> {
  double top = 200.0;
  double left = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('top: ${top}'),
                Text('left: ${left}')
              ],
            )
          ),
          Positioned(
            top: top,
            left: left,
            child: GestureDetector (
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: Text('Drag', style: TextStyle(color: Colors.white),),
              ),

              onPanDown: (e) {
                print("onPanDown: ${e.globalPosition}");
              },
              onPanUpdate: (e) {
                setState(() {
                  left += e.delta.dx;
                  top += e.delta.dy;
                });
              },
              onPanEnd: (e) {
                print("onPanEnd: ${e.velocity.toString()}");
              },
            ),
          )
        ],
      ),
    );
  }
}