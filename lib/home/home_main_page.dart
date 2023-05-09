//3.3 /lib/code2/main_data35.dart
//bottomNavigationBar配制底部导航栏菜单
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/global_config.dart';
import '../utils/log_util.dart';
import 'home_item_page.dart';

//lib/src/page/home/home_main_page.dart
//主页面的根布局
class HomeMainPage extends StatefulWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeMainState();
  }
}
///代码清单11-8 应用的首页面
class _HomeMainState extends State<HomeMainPage> {
  //当前显示页面的标签
  int _tabIndex = 0;
  //[PageView]使用的控制器
  final PageController _pageController = PageController();

  //底部导航栏使用到的图标
  final List<Icon> _normalIcon = [
    const Icon(Icons.home),
    const Icon(Icons.message),
    const Icon(Icons.people)
  ];

  //底部导航栏使用到的标题文字
  final List<String> _normalTitle = [
    "首页",
    "消息",
    "我的",
  ];
  StreamSubscription? _homeSubscription;

  @override
  void initState() {
    super.initState();
    _homeSubscription =
        rootStreamController.stream.listen((GlobalBean globalBean) {
      //刷新消息
      LogUtil.e("消息传递 刷新消息 ${globalBean.data.toString()}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    //移除监听
    _homeSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold 用来搭建页面的主体结构
    return Scaffold(
      //页面的主内容区
      //可以是单独的StatefulWidget 也可以是当前页面构建的如Text文本组件
      body: PageView(
        //设置PageView不可滑动切换
        physics: NeverScrollableScrollPhysics(),
        //PageView的控制器
        controller: _pageController,
        //PageView中的三个子页面
        children: <Widget>[
          //第一个页面
          HomeItemMainPage(),
          //第二个页面
          HomeItemMainPage(),
          HomeItemMainPage(),
          //个人中心
          HomeItemMainPage(),
        ],
      ),
      //底部导航栏
      bottomNavigationBar: buildTipsBottomAppBar(),
    );
  }
  ///代码清单11-8-1
  BottomAppBar buildTipsBottomAppBar() {
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          bottomAppBarItem(0,99),
          bottomAppBarItem(1),
          bottomAppBarItem(2),
          bottomAppBarItem(3),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      shape: CircularNotchedRectangle(),
    );
  }

  int _currentIndex = 0;
  List<IconData> normalImgUrls = [
    Icons.home,
    Icons.menu,
    Icons.menu_book_rounded,
    Icons.people,
  ];
  List<IconData> selectedImgUrls = [
    Icons.home,
    Icons.menu,
    Icons.menu_book_rounded,
    Icons.people,
  ];

  //代码清单11-8-2
  List<String> titles = ["首页", "分类", "阅读", "我的"];

  Expanded bottomAppBarItem(int index, [int tips = 0]) {
    //设置默认未选中的状态
    TextStyle style = TextStyle(fontSize: 12, color: Colors.grey);
    //这里使用的是图标 读者可使用自己的小图片 用Image来加载
    IconData iconData = normalImgUrls[index];
    Color iconColor = Colors.grey;
    if (_currentIndex == index) {
      //选中的话
      style = TextStyle(fontSize: 13, color: Colors.blue);
      iconData = selectedImgUrls[index];
      iconColor = Colors.blue;
    }
    //小红点UI构建
    Widget redTips = buildRedTips(tips);
    //构造返回的Widget
    Widget item = SizedBox(
      height: 64,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(iconData, size: 25, color: iconColor),
                Text(
                  titles[index],
                  style: style,
                )
              ],
            ),
            redTips,
          ],
        ),
        onTap: () {
          if (_currentIndex != index) {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
            setState(() {});
          }
        },
      ),
    );
    return Expanded(child: item);
  }

  Widget buildRedTips(int tips) {
    if (tips == 0) {
      return const SizedBox();
    }
    String tipsStr = tips.toString();
    if (tips >= 100) {
      tipsStr = "...";
    }
    return Align(
      alignment: const Alignment(0.3, -0.7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1),
            height: 12,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              tipsStr,
              style: const TextStyle(fontSize: 6, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  //lib/src/page/home/home_main_page.dart
  //构建底部导航栏
  BottomNavigationBar buildBottomNavigation() {
    //创建一个 BottomNavigationBar
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(label: _normalTitle[0], icon: _normalIcon[0]),
        BottomNavigationBarItem(icon: _normalIcon[1], label: _normalTitle[1]),
        BottomNavigationBarItem(icon: _normalIcon[2], label: _normalTitle[2]),
      ],
      //显示效果
      type: BottomNavigationBarType.fixed,
      //当前选中的页面
      currentIndex: _tabIndex,
      //图标的大小
      iconSize: 24.0,
      //点击事件
      onTap: (index) {
        //切换PageView中的页面显示
        _pageController.jumpToPage(index);
        _tabIndex = index;
        setState(() {});
      },
    );
  }
}
