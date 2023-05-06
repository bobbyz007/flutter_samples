import 'package:flutter/material.dart';

void main() => runApp(TapBoxA());

class TapBoxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TapBoxAState();
  }
}

class TapBoxAState extends State<TapBoxA> {
  bool active = false;
  void handleTap() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(color: active ? Colors.lightGreen[700] : Colors.grey[600]),
        child: Center(
          child: Text(
            active ? "Active" : "Inactive",
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}