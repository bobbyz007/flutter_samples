import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/3.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class HttpHelper {
  static const String BASE_HOST = "http://127.0.0.1:3000/";

  //获取应用的基本配制信息
  static const String SETTING_URL = BASE_HOST+"setting";
  //获取文章列表
  static const String ARTICLE_LIST_URL = BASE_HOST+"article/list";
  //用户登录
  static const String UWER_LOGIN_URL = BASE_HOST+"user/login";

  //应用的版本信息
  static const String APP_VERSION_URL = BASE_HOST+"app/version";
}
