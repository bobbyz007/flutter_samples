import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/4.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
///
///代码清单11-3
/// 全局通信配置页面 lib/global/global_config.dart
class GlobalBean {
  GlobalMessageType messageType;
  dynamic data;
  GlobalBean({required this.messageType, this.data});
}

//全局数据更新流控制器
//多订阅流
StreamController<GlobalBean> rootStreamController =
    StreamController.broadcast();
//全局路由导航Key
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
// 注册 RouteObserver  作为 navigation observer.
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
//全局通信类型 目前只定义了一个颜色过滤
enum GlobalMessageType { mainThemColor }
