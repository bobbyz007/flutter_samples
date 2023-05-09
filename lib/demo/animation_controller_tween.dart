import 'package:flutter/material.dart';

void main() => runApp(MyAnimPage());

class MyAnimPage extends StatelessWidget {
  final GlobalKey<HeartAnimState> animKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Animation'),
        ),
        body: HeartAnimPage(key: animKey),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.update),
          onPressed: () {
            if(!animKey.currentState!.controller.isAnimating) {
              animKey.currentState!.controller.forward();
            } else {
              animKey.currentState!.controller.stop();
            }
          },
        ),
      ),
    );
  }
}

class HeartAnimPage extends StatefulWidget {
  HeartAnimPage({required Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeartAnimState();
  }
}

class HeartAnimState extends State<HeartAnimPage> with SingleTickerProviderStateMixin<HeartAnimPage> {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut, reverseCurve: Curves.easeOut)
      ..addListener(() {
        setState(() {});
      });
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      } else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    animation = Tween(begin: 50.0, end: 200.0).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.favorite, color: Colors.red, size: animation.value,)
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}