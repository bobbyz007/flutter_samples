import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/splash_page.dart';
import 'package:flutter_samples/utils/navigator_utils.dart';
import 'package:flutter_samples/utils/sp_utils.dart';
import 'package:flutter_samples/welcome_page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_root_page.dart';
import 'bean/bean_app_setting.dart';
import 'common/permission_request_page.dart';
import 'common/user_protocol_page.dart';
import 'global/global_config.dart';
import 'global/sp_key.dart';
import 'global/user_helper.dart';
import 'net/dio_utils.dart';
import 'utils/log_util.dart';

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
/// 西瓜视频 https://www.ixigua.com/home/3662978423///lib/src/index_page.dart
///启动页面
class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

/// 代码清单11-4 启动页面 lib/index_page.dart
class _IndexPageState extends State<IndexPage> {
  ///lib/app/index_page.dart
  ///构建[IndexPage]中的显示内容
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///层叠布局
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ///构建背景
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/welcome_bg.jpeg",
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: const Color(0x50ffffff),
              ),
            ),
            buildLoading(),
          ],
        ),
      ),
    );
  }
  ///网络请求加载
  LoadingStatues _loadingStatues = LoadingStatues.loading;
  String _errMsg = "";
  buildLoading() {
    if (_loadingStatues == LoadingStatues.loading) {
      //显示一个加载小圆圈
      return const CupertinoActivityIndicator();
    }
    //加载失败 显示原因 点击重新发起加载
    if (_loadingStatues == LoadingStatues.faile) {
      return TextButton(
        onPressed: () {
          _loadingStatues = LoadingStatues.loading;
          setState(() {});
          initData();
        },
        child: Text(_errMsg),
      );
    }
  }

  ///-------------------------------------------------------------------------------------------------------------

  /// 代码清单11-4-1 动态权限申请 lib/index_page.dart
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //检查权限
      checkPermissonFunction();
    });
  }

  void checkPermissonFunction() async {
    //权限请求封装功能
    dynamic result = await showPermissionRequestPage(
      context: context,
      permissionList: [
        Permission.location,
        Permission.storage,
      ],
      noPassMessageList: ["获取位置权限", "获取文件存储权限"],
    );
    //初始化数据
    initData();
  }
  ///-------------------------------------------------------------------------------------------------------------
  /// 代码清单11-4-2 初始化功能
  ///用户是否第一次使用
  bool _userFirst = false;
  void initData() async {
    //获取当前的运行环境
    //当App运行在Release环境时，inProduction为true；
    //当App运行在Debug和Profile环境时，inProduction为false。
    const bool inProduction = bool.fromEnvironment("dart.vm.product");
    //为ture时输出日志
    const bool isLog = !inProduction;
    //初始化统计
    //初始化本地存储工具
    await SPUtil.init();
    //初始化日志工具
    LogUtil.init(tag: "flutter_log", isDebug: isLog);
    bool isSuccess = await requestNet();
    if(!isSuccess){
      return;
    }


    //获取用户是否第一次登录
    _userFirst = SPUtil.getBool(spUserIsFirstKey);
    //获取用户隐私协议的状态
    bool _userProtocol = SPUtil.getBool(spUserProtocolKey);
    //记录
    UserHelper.getInstance.userProtocol = _userProtocol;
    //初始化用户的登录信息
    UserHelper.getInstance.init();
    //下一步
    openUserProtocol();
  }
  ///-------------------------------------------------------------------------------------------------------------
  /// 代码清单11-4-3 网络请求加载配置
  Future<bool>  requestNet() async{
    ResponseInfo responseInfo = await requestSetting();
    if (!responseInfo.success) {
      _errMsg = responseInfo.message;
      _loadingStatues = LoadingStatues.faile;
      setState(() {});
      return false;
    }
    return true;
  }
  Future<ResponseInfo> requestSetting() async {
    //网络请求获取APP的配置信息
    ResponseInfo responseInfo =
    await DioUtils.instance.getRequest(url: HttpHelper.SETTING_URL);
    if (responseInfo.success) {
      //解析数据
      AppSettingBean settingBean = AppSettingBean.fromMap(responseInfo.data);
      //配置APP主题
      if (settingBean.appThemFlag == 1) {
        //将APP设置成灰色主题
        rootStreamController.add(GlobalBean(
          messageType: GlobalMessageType.mainThemColor,
          data: Colors.grey,
        ));
      }
    }
    return responseInfo;
  }
  ///-------------------------------------------------------------------------------------------------------------
  /// 代码清单11-4-4 用户协议与页面跳转说明
  void openUserProtocol() async {
    //已同意用户隐私协议 下一步
    if (UserHelper.getInstance.isUserProtocol) {
      LogUtil.e("用户已同意用户隐私协议 下一步");
      openNext();
    } else {
      LogUtil.e("未同意用户协议 弹框显示");
      //未同意用户协议 弹框显示
      await showUserProtocolPage(context: context);
      openNext();
    }
  }
  void openNext() {
    //获取配置信息
    if (_userFirst == false) {
      LogUtil.e("第一次 进入引导页面");
      ///第一次 隐藏logo 显示左右滑动的引导
      NavigatorUtils.openPageByFade(context, SplashPage(), isReplace: true);
    } else {
      LogUtil.e("非首次 进入首页面");
      ///非第一次 隐藏logo 显示欢迎
      NavigatorUtils.openPageByFade(context, WelcomePage(), isReplace: true);
    }
  }









}
