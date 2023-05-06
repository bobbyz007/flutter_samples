import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Components',
      home: HeroAPage(),
      theme: ThemeData(
          primarySwatch: Colors.purple
      ),
    );
  }
}

class HeroAPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('first page'),
      ),
      body: Container(
        child: Center(
          child: GestureDetector(
            child: Hero(
              tag: "avatar",
              child: Image.asset("assets/flutter_icon.png", width: 100, height: 100, fit: BoxFit.fill,),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HeroBPage()));
            }
          ),
        ),
      ),
    );
  }
}

class HeroBPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
      ),
      body: Center(
        child: GestureDetector(
            child: Hero(
              tag: "avatar",
              child: Image.asset("assets/flutter_icon.png", width: 300, height: 300, fit: BoxFit.fill,),
            ),
            onTap: () {
              Navigator.pop(context);
            }
        ),
      ),
    );
  }
}