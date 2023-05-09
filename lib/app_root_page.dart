import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'global/global_config.dart';
import 'index_page.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/25.
///
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// gongzhonghao biglead
/// github https://github.com/zhaolongs
/// bili https://space.bilibili.com/513480210
/// zhihu https://www.zhihu.com/people/zhao-long-90-89
/// csdn https://blog.csdn.net/zl18603543572
/// 西瓜视频 https://www.ixigua.com/home/3662978423
/// lib/app/app_root_page.dart
class AppRootPage extends StatefulWidget {
  const AppRootPage({Key? key}) : super(key: key);

  @override
  _AppRootPageState createState() => _AppRootPageState();
}

///代码清单11-2
///根视图配置 lib/app_root_page.dart
class _AppRootPageState extends State<AppRootPage> {
  //默认过滤的颜色
  Color _defaultFilterColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: rootStreamController.stream,
      initialData: GlobalBean(
        data: Colors.transparent,
        messageType: GlobalMessageType.mainThemColor,
      ),
      builder: (BuildContext context, AsyncSnapshot<GlobalBean> snapshot) {
        //获取数据
        if (snapshot.data != null &&
            snapshot.data!.messageType == GlobalMessageType.mainThemColor) {
          _defaultFilterColor = snapshot.data!.data;
        }
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
              //动态生成过滤颜色
              _defaultFilterColor,
              //过滤模式
              BlendMode.color),
          //构建MaterialApp根组件
          child: buildMaterialApp(),
        );
      },
    );
  }

  ///代码清单11-2
  ///MaterialApp 组件 lib/app_root_page.dart
  MaterialApp buildMaterialApp() {
    return MaterialApp(
      //应用的主题
      theme: ThemeData(
        //主背景色
        primaryColor: Colors.blue,
        //Scaffold脚手架的背景色
        scaffoldBackgroundColor: Color(0xffeeeeee),
      ),
      //应用程序默认显示的页面
      home: IndexPage(),
      //dubug模式下不显示debug标签
      debugShowCheckedModeBanner: false,
      //国际化语言环境
      localizationsDelegates: const [
        //初始化默认的 Material 组件本地化
        GlobalMaterialLocalizations.delegate,
        //初始化默认的 通用 Widget 组件本地化
        GlobalWidgetsLocalizations.delegate,
        //支持使用 CupertinoAlertDialog 的代理
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: globalNavigatorKey,
      //路由导航观察者配置
      navigatorObservers: [routeObserver],
      //配置程序语言环境
      locale: const Locale('zh', 'CN'),
    );
  }

  @override
  void dispose() {
    //注销全局流订阅
    rootStreamController.close();
    super.dispose();
  }
}
