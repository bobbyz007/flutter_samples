import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdf_plugin/flutter_pdf_viewer.dart';
import 'package:flutter_pdf_plugin/pdf_viewer_scaffold.dart';
import '../global/user_helper.dart';
import '../utils/navigator_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/21.
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
/// 西瓜视频 https://www.ixigua.com/home/3662978423///
///便捷打开用户协议弹框
///lib/app/page/common/user_protocol_page.dart
showUserProtocolPage({required BuildContext context}) async {
  //打开用户隐私协议页面
  return NavigatorUtils.openPageByFade(
    context,
    UserProtocolRequestPage(),
    opaque: false,
  );
}

///lib/app/page/common/user_protocol_page.dart
///用户隐私协议页面
class UserProtocolRequestPage extends StatefulWidget {
  const UserProtocolRequestPage({Key? key}) : super(key: key);

  @override
  _UserProtocolState createState() => _UserProtocolState();
}

class _UserProtocolState extends State<UserProtocolRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 14),
                  width: 280,
                  height: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 1, bottom: 14),
                        child: Text(
                          "温馨提示",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      buildSingleChildScrollView(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              closeApp();
                            },
                            child: Text("不同意"),
                          ),
                          SizedBox(
                            height: 34,
                            child: TextButton(
                              onPressed: () async {
                                UserHelper.getInstance.userProtocol = true;
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("同意"),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///关闭应用的功能
  Future<void> closeApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  //协议说明文案
  String userPrivateProtocol =
      "我们一向尊重并会严格保护用户在使用本产品时的合法权益（包括用户隐私、用户数据等）不受到任何侵犯。本协议（包括本文最后部分的隐私政策）是用户（包括通过各种合法途径获取到本产品的自然人、法人或其他组织机构，以下简称“用户”或“您”）与我们之间针对本产品相关事项最终的、完整的且排他的协议，并取代、合并之前的当事人之间关于上述事项的讨论和协议。本协议将对用户使用本产品的行为产生法律约束力，您已承诺和保证有权利和能力订立本协议。用户开始使用本产品将视为已经接受本协议，请认真阅读并理解本协议中各种条款，包括免除和限制我们的免责条款和对用户的权利限制（未成年人审阅时应由法定监护人陪同），如果您不能接受本协议中的全部条款，请勿开始使用本产品";

  late TapGestureRecognizer _registProtocolRecognizer;
  late TapGestureRecognizer _privacyProtocolRecognizer;

  ///生命周期函数 页面创建时执行一次
  @override
  void initState() {
    super.initState();
    //注册协议的手势
    _registProtocolRecognizer = TapGestureRecognizer();
    //隐私协议的手势
    _privacyProtocolRecognizer = TapGestureRecognizer();
  }

  ///生命周期函数 页面销毁时执行一次
  @override
  void dispose() {
    super.dispose();

    ///销毁
    _registProtocolRecognizer.dispose();
    _privacyProtocolRecognizer.dispose();
  }

  ///lib/app/page/common/user_protocol_page.dart
  ///构建隐私协议的富文本
  Widget buildSingleChildScrollView() {
    return Expanded(
      //可滑动的适配
      child: SingleChildScrollView(
        child: Padding(
          //左右边距
          padding: EdgeInsets.only(left: 18, right: 18),
          //富文本
          child: buildRichText(),
        ),
      ),
    );
  }

  ///lib/app/page/common/user_protocol_page.dart
  ///构建富文本
  RichText buildRichText() {
    return RichText(
      //文字居中
      textAlign: TextAlign.center,
      //文字区域
      text: TextSpan(
        text: "请您本产品之前，请务必仔细阅读并理解",
        style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(
            text: "《用户协议》",
            style: TextStyle(color: Colors.blue),
            //点击事件
            recognizer: _registProtocolRecognizer
              ..onTap = () {
                //打开用户协议
                openUserProtocol();
              },
          ),
          TextSpan(
            text: "与",
            style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
            text: "《隐私协议》",
            style: TextStyle(color: Colors.blue),
            //点击事件
            recognizer: _privacyProtocolRecognizer
              ..onTap = () {
                //打开隐私协议
                openPrivateProtocol();
              },
          ),
          //后续显示的文本内容
          TextSpan(text: userPrivateProtocol)
        ],
      ),
    );
  }
  ///代码清单11-5 打开用户协议
  ///lib/common/user_protocol_page.dart
  void openPrivateProtocol() {
    NavigatorUtils.pushPage(
      context: context,
      page: PdfNetScaffold(
          pdfUrl: "http://www.jinbangshichuang.com/20201209105650.pdf"),
    );
  }

  ///打开隐私协议
  void openUserProtocol() {
    // showWebViewPage(
    //     context: context,
    //     pageTitle: "隐私协议",
    //     pageUrl: "https://blog.csdn.net/zl18603543572");
  }



}
///代码清单11-6 打开pdf 本地路径

class PdfLocalPage extends StatelessWidget {
  String localPath = "";
  PdfLocalPage(this.localPath);

  @override
  Widget build(BuildContext context) {
    return PdfScaffold(
      appBar: AppBar(title: Text("加载本地路径")),
      path: localPath,
    );
  }
}