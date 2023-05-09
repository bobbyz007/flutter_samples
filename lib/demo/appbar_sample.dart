import 'package:flutter/material.dart';

void main() => runApp(const AppBarSample());

class AppBarSample extends StatelessWidget {
  const AppBarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Basic AppBar'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: choices[0].icon),
            IconButton(onPressed: () {}, icon: choices[1].icon),
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            })
          ],
          actionsIconTheme: const IconThemeData(
            color: Colors.red
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('ApppBar'),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final Icon icon;
}

const List<Choice> choices = <Choice> [
  Choice(title: 'Car', icon: Icon(Icons.directions_car)),
  Choice(title: 'Bicycle', icon: Icon(Icons.directions_bike)),
  Choice(title: 'Boat', icon: Icon(Icons.directions_boat)),
  Choice(title: 'Train', icon: Icon(Icons.train)),
];
