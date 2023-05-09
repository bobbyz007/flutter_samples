import 'package:flutter/material.dart';

///代码路径 lib/common/no_data_widget.dart
class NoDataWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String noDataText;
  const NoDataWidget({
    Key? key,
    this.onTap,
    this.noDataText = "暂无数据",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return Center(
        child: Text(noDataText),
      );
    }
    return Center(
      child: InkWell(
        onTap: onTap,
        onDoubleTap: onTap,
        child: Text(noDataText),
      ),
    );
  }
}
