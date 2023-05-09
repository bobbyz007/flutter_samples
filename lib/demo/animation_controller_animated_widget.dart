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
      home: ParallelPage(),
    );
  }
}

class ParallelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParallelPageState();
  }
}

class ParallelPageState extends State<ParallelPage> with SingleTickerProviderStateMixin<ParallelPage>{
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    // easeIn: fast->slow
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      } else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ParallelAnimateWidget(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ParallelAnimateWidget extends AnimatedWidget {
  final opacityTween = Tween(begin: 0.1, end: 1.0);
  final sizeTween = Tween(begin: 0.0, end: 300.0);

  ParallelAnimateWidget({Key? key, required Animation<double> animation}): super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    dynamic animation = listenable;
    return Center(
      child: Opacity(
        opacity: opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: sizeTween.evaluate(animation),
          width: sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}