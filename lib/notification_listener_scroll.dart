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
      home: ScrollNotificationPage(),
    );
  }
}

class ScrollNotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScrollNotificationPageState();
  }
}

class ScrollNotificationPageState extends State<ScrollNotificationPage> {
  String progressIndicator = "0%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
            setState(() {
              progressIndicator = "${(progress * 100).toInt()} %";
            });
            return true;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Title $index'),);
                  },
                itemCount: 100,
                itemExtent: 50.0,
              ),
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.black54,
                child: Text(progressIndicator),
              )
            ],
          ),
        ),
      )
    );
  }
}