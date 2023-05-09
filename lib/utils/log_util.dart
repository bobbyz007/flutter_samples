

import 'package:flutter/material.dart';

///lib/utils/log_util.dart 
///日志输出工具类
class LogUtil {
  ///打印log的标签
  static const String _defaultLogTag = "flutter_log";
  //是否是debug模式,true: log  不输出.
  static bool _debugMode=false;
  ///log日志的长度
  static int _maxLogLength=130;

  ///可以在程序启动的时候调用此方法来修改日志标识
  static void init({
    String tag = _defaultLogTag,
    bool isDebug = false,
    int maxLen = 130,
  }) {
    _debugMode = isDebug;
    _maxLogLength = maxLen;
  }
  ///外部调用 输出日志的方法
  static void e(Object object, {String tag="flutter"}) {
    if(_debugMode){
      _printLog(tag, ' e ', object);
    }
  }
  ///内部实现日志输出方法
  static void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    if (da.length <= _maxLogLength) {
      debugPrint("$tag$stag $da");
      return;
    }
    //日志过长 需要分行输出
    debugPrint(
        '$tag$stag — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLogLength) {
        debugPrint("$tag$stag| ${da.substring(0, _maxLogLength)}");
        da = da.substring(_maxLogLength, da.length);
      } else {
        debugPrint("$tag$stag| $da");
        da = "";
      }
    }
    debugPrint(
        '$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }
}
