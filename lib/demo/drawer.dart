import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: DrawerPage(),
    );
  }
}

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerPageState();
  }
}

class _DrawerPageState extends State<DrawerPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
      ),
      drawer: MyDrawer(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu Header', style: TextStyle(color: Colors.yellow, fontSize: 24),),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Message'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ],
      ),
    );
  }
}