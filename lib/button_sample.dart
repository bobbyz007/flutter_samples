import 'package:flutter/material.dart';

void main() => runApp(ButtonWidget());

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Button"),),
        body: Center(
          child: Column(
            children: <Widget>[
              FloatingActionButton(onPressed: () => print("float pressed"), child: Text('float'),),
              OutlinedButton(onPressed: () => print("outline pressed"), child: Text("outline")),
              IconButton(onPressed: () => print("icon pressed"), icon: Icon(Icons.thumb_up)),
              OutlinedButton(onPressed: () {}, child: Text("Submit"), style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                overlayColor: MaterialStatePropertyAll<Color>(Colors.pink),
                shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))
              ),)
            ],
          ),
        ),
        
      ),
    );
  }
}