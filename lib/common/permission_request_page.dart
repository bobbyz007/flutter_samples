import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/log_util.dart';
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


/// 代码清单11-5 动态权限申请弹框
/// lib/common/permission_request_page.dart
showPermissionRequestPage({
  required BuildContext context,
  required List<Permission> permissionList,
  required List<String> noPassMessageList,
}) async {
  ///透明的方式打开权限请求 Widget
  dynamic result = await NavigatorUtils.openPageByFade(
    context,
    PermissionRequestPage(
      permissionList: permissionList,
      noPassMessageList: noPassMessageList,
    ),
    opaque: false,
  );
  return result;
}

/// 代码清单11-5-1 动态权限申请实现类
class PermissionRequestPage extends StatefulWidget {
  ///当前要申请的权限
  final List<Permission> permissionList;
  ///权限申请不通过里页面显示的内容
  final List<String> noPassMessageList;

  const PermissionRequestPage({
    Key? key,
    required this.permissionList,
    required this.noPassMessageList,
  }) : super(key: key);

  @override
  _PermissionRequestState createState() => _PermissionRequestState();
}

/// 代码清单11-5-2 动态权限申请实现类
class _PermissionRequestState extends State<PermissionRequestPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    LogUtil.e("权限请求页面");
    WidgetsBinding.instance!.addObserver(this); //添加观察者
    ///检查权限
    checkPermissonFunction();
  }

  @override
  void dispose() {
    //销毁观察者
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  ///是否打开发设置中心
  bool isOpenSetting = false;
  ///生命周期变化时回调
  //  resumed:应用可见并可响应用户操作
  //  inactive:用户可见，但不可响应用户操作
  //  paused:已经暂停了，用户不可见、不可操作
  //  suspending：应用被挂起，此状态IOS永远不会回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && isOpenSetting) {
      isOpenSetting = false;
      checkPermissonFunction();
    }
  }

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
            children: [buildNoPassTips()],
          ),
        ),
      ),
    );
  }


  /// 代码清单11-5-3 权限申请过程
  List<String> noPassList = [];//未通过
  List<String> goSettingList = [];//未通过需要跳转设置中心

  void checkPermissonFunction() async {
    noPassList.clear();
    goSettingList.clear();
    //动态权限申请发起
    Map<Permission, PermissionStatus> statuses =
        await widget.permissionList.request();
    //返回结果集 statuses
    Iterable<Permission> keys = statuses.keys;
    //遍历循环检查看权限是否申请通过
    for (Permission keyName in keys) {
      //获取权限申请结果
      PermissionStatus? keyValue = statuses[keyName];
      //判断未通过的权限
      if (keyValue != null && !keyValue.isGranted) {
        //获取权限在原集合中的索引
        int index = widget.permissionList.indexOf(keyName);
        //根据索引获取权限描述
        String message = widget.noPassMessageList[index];
        //判断权限是否是用户选择（拒绝且不再提示）
        if (keyValue.isPermanentlyDenied||keyValue.isDenied) {
          goSettingList.add(message);
        } else {
          noPassList.add(message);
        }
      }
    }
    if (noPassList.isEmpty && goSettingList.isEmpty) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {});
    }
  }


  buildNoPassTips() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        width: 280,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
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
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: noPassList.length + goSettingList.length,
              itemBuilder: (BuildContext context, int index) {
                int len1 = noPassList.length;
                int len2 = goSettingList.length;
                if (index < len1) {
                  String message = noPassList[index];
                  return Row(
                    children: [
                      Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 18,
                      ),
                      Expanded(
                          child: Text(
                        message,
                        style: TextStyle(color: Colors.red),
                      )),
                    ],
                  );
                }
                String message = goSettingList[index - len1];
                return Row(
                  children: [
                    Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 18,
                    ),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 34,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("取消"),
                  ),
                ),
                noPassList.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: 34,
                        child: TextButton(
                          onPressed: () {
                            checkPermissonFunction();
                          },
                          child: const Text("重新授权"),
                        ),
                      ),
                goSettingList.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: 34,
                        child: TextButton(
                          onPressed: () async{
                            isOpenSetting = await openAppSettings();
                          },
                          child: const Text("去设置中心"),
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
