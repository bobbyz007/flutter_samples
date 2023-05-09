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
      routes: <String, WidgetBuilder> {
        '/first': (context) => FirstPage(),
        '/second': (context) => SecondPage()
      },
      initialRoute: '/first',
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
            Navigator.pushNamed(context, '/second');
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
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
