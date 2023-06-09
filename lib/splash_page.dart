import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/utils/log_util.dart';
import 'package:flutter_samples/utils/navigator_utils.dart';
import 'package:flutter_samples/utils/sp_utils.dart';

import 'global/sp_key.dart';
import 'home/home_main_page.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/20.
///
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// gongzhonghao biglead
/// gongzhonghao biglead
/// github https://github.com/zhaolongs
/// bili https://space.bilibili.com/513480210
/// zhihu https://www.zhihu.com/people/zhao-long-90-89
/// csdn https://blog.csdn.net/zl18603543572
/// 西瓜视频 https://www.ixigua.com/home/3662978423/// lib/src/splash_page.dart
/// 第一次 新手引导页面
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //填充布局
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //底部可滑动的图片
            buildPageView(),
            //右上角显示的计数
            buildTopDate(),
            //左下角显示的进入首页面按钮
            buildBottomButton(),
          ],
        ),
      ),
    );
  }

  ///代码清单11-7 底部可滑动的图片
  ///lib/splash_page.dart
  Widget buildPageView() {
    //PageView用于整屏切换效果
    //默认情况下是左右切换
    return PageView.builder(
      //滑动视频滑动结束时回调
      //参数 value PageView当前显示的页面索引
      onPageChanged: (value) {
        LogUtil.e("pageView on changed $value");
        //修改右上角的页面角标
        buildTopText(value);
      },
      //构建条目的总个数，如这里的4
      itemCount: 4,
      //每一页的显示Widget
      itemBuilder: (BuildContext context, int postion) {
        //这里直接使用的是本地资源目录下的图片
        return Center(
          child: CachedNetworkImage(
            imageUrl: 'https://0.0.0.0/',
            fit: BoxFit.fitHeight,
          ),
        );
      },
    );
  }

  // lib/src/splash_page.dart
  //构建的右上角显示的计数
  Widget buildTopDate() {
    return Positioned(
      //右上角对齐
      top: 40, right: 20,
      //动画过渡 圆形 ->矩形 ;  矩形 ->圆形
      child: AnimatedContainer(
        //中心对齐
        alignment: Alignment.center,
        //过渡结束后判断是否显示周信息
        onEnd: () {
          if (topWidth == 130) {
            isShowWeek = true;
          } else {
            isShowWeek = false;
          }
          setState(() {});
        },
        //当前容器的尺寸信息
        width: topWidth,
        height: topHeight,
        //动画过渡执行的时间为 200 毫秒
        duration: Duration(milliseconds: 400),
        //动画插值器
        curve: Curves.easeIn,
        //用来设置边框装饰
        decoration: BoxDecoration(
          //边框圆角
          borderRadius: BorderRadius.all(
            Radius.circular(topRadius),
          ),
          //边框颜色与粗细
          border: Border.all(
            width: 3,
            color: Colors.redAccent,
          ),
        ),
        //显示的文本
        child: buildTopTextColumn(),
      ),
    );
  }

  //显示的文本
  Column buildTopTextColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //显示的页面角标
        Text(
          text1,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 16, color: Colors.indigo),
        ),

        //最后一页显示周信息
        isShowWeek
            ? Text(
                text2,
                style: TextStyle(fontSize: 22, color: Colors.indigo),
              )
            : Container()
      ],
    );
  }

  Widget buildBottomButton() {
    if (isShowWeek) {
      return Positioned(
        bottom: 40,
        left: 20,
        child: InkWell(
          onTap: () {
            //保存标识
            SPUtil.save(spUserIsFirstKey, true);
            //跳转首页
            NavigatorUtils.openPageByFade(context, HomeMainPage(),
                isReplace: true);
          },
          child: Container(
            //内边距
            padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
            alignment: Alignment.center,
            //圆角边框
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 3,
                  color: Colors.indigo,
                )),
            child: Text(
              "去首页",
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  // lib/src/splash_page.dart
  //构建的右上角显示的计数数据
  String text1 = "1";
  String text2 = "";

  //右上角显示计数的容大小
  double topWidth = 40;
  double topHeight = 40;

  //右上角显示计数的边框圆角
  //默认容器的大小为40，这里设置的边框圆角为 20
  //所以展示出来的是一个圆形
  double topRadius = 20;

  //是否显示当前时间是第几周
  //因为只有在最后一页才显示的
  bool isShowWeek = false;

  void buildTopText(int value) {
    //如果不是最后一页，右上角的计数始终是圆形
    if (value < 3) {
      text1 = "${value + 1}";
      text2 = "";
      topWidth = 40;
      topHeight = 40;
      topRadius = 20;
      isShowWeek = false;
    } else {
      //如果是最后一页
      //修改显示的文本为当前的时间
      text1 = "2022-05-06";

      //当前星期几
      text2 = "早期四";

      //修改容器为矩形
      topWidth = 130;
      topHeight = 80;
      topRadius = 2;
    }
    setState(() {});
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
