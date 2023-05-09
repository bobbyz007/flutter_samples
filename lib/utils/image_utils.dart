import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/6/2.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */

/// lib/image_utils.dart
/// 图片操作工具类
class ImageUtils {
  //单例模式创建
  static final ImageUtils imageUtils = ImageUtils._();

  ///用来将普通图片路径下的
  Dio ?_dio;

  //私有化构造
  ImageUtils._() {
    ///创建DIO
    _dio = new Dio();
  }
}
