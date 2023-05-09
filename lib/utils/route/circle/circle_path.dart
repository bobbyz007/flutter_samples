
//lib/code1/route/circle_path.dart
import 'dart:math';

import 'package:flutter/cupertino.dart';
///裁切的路径
class CirclePath extends CustomClipper<Path> {

  ///变化比率从0-1
  final double value;
  ///圆心中心点
  Offset ?centerOffset;
  ///点击事件触发的Key
  GlobalKey key;

  CirclePath(this.value,{ this.centerOffset,required this.key}){
    if(key.currentContext!=null&&key.currentContext!.findRenderObject()!=null){
      //获取position
      RenderObject? renderBox = key.currentContext!.findRenderObject();
      if(renderBox!=null){
        //获取指定的Widget的位置信息
        Size size = renderBox.paintBounds.size;
        //获取指定的Widget的位置信息
        //获取矩阵
        Matrix4 matrix4 = renderBox.getTransformTo(null);
        var translation = matrix4.getTranslation();
        ///获取 Offset
        Offset offset1 = Offset(translation.x, translation.y);
        centerOffset = offset1;
      }
    }
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    ///半径的最大值并不是屏幕的宽或者高，而是屏幕的对角线长度
    double radius = value * sqrt(size.height * size.height + size.width * size.width);
    ///配置圆心
    centerOffset ??=Offset(size.width,size.height);
    ///添加圆形路径
    path.addOval(Rect.fromCircle(center: centerOffset!,radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}