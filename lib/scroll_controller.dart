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
      home: ScrollControllerPage(),
    );
  }
}

class ScrollControllerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScrollControllerPageState();
  }
}

class ScrollControllerPageState extends State<ScrollControllerPage> {
  ScrollController controller = ScrollController();
  bool showTopBtn = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if(controller.offset < 1000 && showTopBtn) {
        setState(() {
          showTopBtn = false;
        });
      } else if(controller.offset >= 1000 && !showTopBtn) {
        setState(() {
          showTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(title: Text('List Item $index'),);
        },
        itemCount: 100,
        itemExtent: 50.0,
        controller: controller,
      ),
      floatingActionButton: !showTopBtn ? null : FloatingActionButton(
        onPressed: () {
            controller.animateTo(0, duration: Duration(microseconds: 200), curve: Curves.bounceIn);
          },
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}