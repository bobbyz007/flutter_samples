import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Bank"),
            BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Contact"),
            BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Music")
          ],
        ),
        body: const Center(
          child: Text('Contacts'),
        ),
      ),
    );
  }
}