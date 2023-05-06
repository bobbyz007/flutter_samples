import 'package:flutter/material.dart';

void main() => runApp(ListViewWidget());

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(color: Colors.blue,);

    return MaterialApp(
      home: Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(title: Text("Item $index"),);
            },
            separatorBuilder: (context, index) {
              return divider;
            },
            itemCount: 100
        ),

      ),
    );
  }
}