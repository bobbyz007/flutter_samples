import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///代码路径 lib/common/loading_widget.dart
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: 22,
      ),
    );
  }
}
