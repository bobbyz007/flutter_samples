import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Components',
      home: FirstPage(),
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('first page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: MaterialButton(
          color: Colors.pink,
          textColor: Colors.black,
          child: const Text('go to the second page'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return SecondPage();
            }));
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('second page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: const Text('go to the first page'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
