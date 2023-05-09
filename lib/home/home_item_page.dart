import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/common/loading_widget.dart';
import 'package:flutter_samples/common/no_data_widget.dart';
import 'package:flutter_samples/utils/color_utils.dart';

import '../net/loading_statues.dart';

//lib/src/page/home/home_item_page.dart
//首页面显示的视频列表播放页面
class HomeItemMainPage extends StatefulWidget {
  final String ?content;

  const HomeItemMainPage({Key? key, this.content}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomeItemState();
  }
}

//当前页面被装载在[PageView]中，使用KeepAlive使用页面保持状态
class _HomeItemState extends State<HomeItemMainPage> with AutomaticKeepAliveClientMixin {
  //页面保持状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //设置状态栏的颜色 有AppBar时，会被覆盖
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: buildScafflod(),
      value: const SystemUiOverlayStyle(
          //状态栏的背景
          statusBarColor: Colors.white,
          //状态栏文字颜色为黑色
          statusBarIconBrightness: Brightness.dark,
          //底部navigationBar背景颜色
          systemNavigationBarColor: Colors.white),
    );
  }

  Widget buildScafflod() {
    return Scaffold(
      backgroundColor: Colors.white,
      //页面的主内容 先来个居中
      body: Container(
        color: ColorUtils.getRandomColor(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: buildAnimatedSwitcher(),
      ),
    );
  }

  ///AnimatedSwitcher 的基本使用
  AnimatedSwitcher buildAnimatedSwitcher() {
    return AnimatedSwitcher(
      //动画执行切换时间
      duration: const Duration(milliseconds: 600),
      //动画构建器 构建指定动画类型
      transitionBuilder: (Widget child, Animation<double> animation) {
        //执行缩放动画
        return ScaleTransition(child: child, scale: animation);
      },
      //执行动画的子 Widget
      //只有子 Widget 被切换时才会触发动画
      child: buildMainWidget(),
    );
  }

  buildMainWidget() {
    LoadingStatues _loadingStatues = LoadingStatues.success;
    if (_loadingStatues == LoadingStatues.loading) {
      return LoadingWidget();
    } else if (_loadingStatues == LoadingStatues.noData) {
      return const NoDataWidget();
    } else if (_loadingStatues == LoadingStatues.faile) {
      return NoDataWidget(
        noDataText: "加载失败 点击重新加载",
        onTap: () {},
      );
    }
    return Container(
      child: Text("加载成功显示的页面 ${widget.content}"),
    );
  }
}
