import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(ChangeNotifierProvider<Counter>.value(
  value: Counter(),
  child: const MyApp(),
));

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
      body: Center(
        child: CounterLabel(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${counter.count}'),
        OutlinedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
          },
          child: Text('next page'),
        ),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('second page'),
      ),
      /*body: Center(
        child: Text('${counter.count}'),
      ),*/
      body: Center(
        child: Consumer<Counter>(
          builder: (context, Counter counter, _) => Text('${counter.count}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int count = 0;
  // get method: 不用括号
  int get counter => count;

  void increment() {
    count++;
    notifyListeners();
  }
}

