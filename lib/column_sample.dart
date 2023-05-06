import 'package:flutter/material.dart';

void main() => runApp(TextFieldWidget());

class TextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Login in"),),
        body: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Please input your username or email",
                prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Please input your password",
                prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),

            SizedBox(height: 15,),
            Container(
              height: 46.0,
              width: 300,
              child: OutlinedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                  backgroundColor:MaterialStatePropertyAll<Color>(Colors.blue),
                  overlayColor: MaterialStatePropertyAll<Color>(Colors.pink),
                ),
                child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}