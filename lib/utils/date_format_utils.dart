import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/27.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class DateFormatUtils {
  ///获取当前时间
  static String getCurrentTime({format = "HH:mm:ss"}) {
    DateTime dateTime = DateTime.now();
    //格式化时间 import 'package:intl/intl.dart';
    String _formatTime = DateFormat(format).format(dateTime);
    return _formatTime;
  }

  ///将DateTime格式化为String
  static String dateTimeToString({
    required DateTime dateTime,
    format = "yyyy-MM-dd HH:mm:ss",
  }) {
    String _formatTime = DateFormat(format).format(dateTime);
    return _formatTime;
  }
  ///将String类型的日期转为DateTime
  static DateTime stringToDate({
    required String strTime,
    format = "yyyy-MM-dd HH:mm:ss",
  }) {
    DateTime _dateTime = DateFormat(format).parse(strTime);
    return _dateTime;
  }
}
