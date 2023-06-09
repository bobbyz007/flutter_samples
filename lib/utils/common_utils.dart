import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/utils/view/widget_triangle.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/6/16.
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
/// 西瓜视频 https://www.ixigua.com/home/3662978423
class CommonUtils {
  static showLoadingDialog(BuildContext context, String msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => Future.value(false),
                child: Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SpinKitCubeGrid(color: Colors.white),
                        Container(height: 10.0),
                        Text(msg ?? '正在加载',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  static showAlertDialog(BuildContext context, String title, String text) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  text ?? '',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showChooseDialog(
      BuildContext context, Size size, double dx, double dy) {
    final double wx = size.height;
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Text(''),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Positioned(
                  left: 10.0,
                  top: dy < h / 2 ? dy + wx / 2 : null,
                  bottom: dy < h / 2 ? null : (h - dy + wx / 2),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    width: w - 20.0,
                    child: GestureDetector(
                      child: Column(
                        children: const <Widget>[
                          ListTile(
                              leading: Icon(Icons.highlight_off),
                              title: Text('不感兴趣'),
                              subtitle: Text('减少这类内容')),
                          Divider(),
                        ],
                      ),
                      onTap: () {
                        // final snackBar = SnackBar(
                        //   content: Text('随便写着玩的，别点了...'),
                        //   backgroundColor: Colors.blueAccent,
                        //   duration: Duration(minutes: 1), // 持续时间
                        //   //animation,
                        // );
                        // Scaffold.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: dx - 10.0,
                  top: dy < h / 2 ? dy - wx / 2 : null,
                  bottom: dy < h / 2 ? null : (h - dy - wx / 2),
                  child: ClipPath(
                    clipper: Triangle(dir: dy - h / 2),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      color: Colors.white,
                      child: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
