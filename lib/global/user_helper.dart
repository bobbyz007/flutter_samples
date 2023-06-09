import 'package:flutter_samples/global/sp_key.dart';

import '../utils/sp_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/24.
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
/// 西瓜视频 https://www.ixigua.com/home/3662978423///lib/src/common/user_helper.dart
///用户信息辅助操作类
class UserHelper {
  // 私有构造函数
  UserHelper._() {
    // 具体初始化代码
  }

  ///获取单例对象
  static UserHelper getInstance = UserHelper._();

  ///用户基本信息模型
  UserBean? _userBean;

  ///获取 UserBean
  UserBean? getuserBean() => _userBean;

  ///userBean的设置方法
  set userBean(UserBean bean) {
    _userBean = bean;

    ///缓存用户信息
    SPUtil.saveObject(spUserBeanKey, bean);
  }

  ///判断用户是否登录的便捷方法
  bool get userIsLogin => _userBean == null ? false : true;

  ///是否同同意隐私与用户协议
  bool _userProtocol = false;

  bool get userProtocol => _userProtocol;

  set userProtocol(bool flag) {
    _userProtocol = flag;

    ///保存同意的标识
    SPUtil.save(spUserProtocolKey, flag);
  }

  ///判断用户是否同意用户协议便捷方法
  bool get isUserProtocol => _userProtocol;

  ///用来初始化用户信息的缓存数据
  Future<bool> init() async {
    ///加载缓存数据
    Map<String, dynamic>? map = SPUtil.getObject(spUserBeanKey);
    if (map != null) {
      _userBean = UserBean.fromJson(map);
    }
    return Future.value(true);
  }

  //退出登录 清除数据
  void exitLogin() {
    _userBean = null;
    SPUtil.remove(spUserBeanKey);
  }
}

class UserBean {
  String? userName;
  String? userFlag;

  UserBean(
    this.userName,
    this.userFlag,
  );

  UserBean.fromJson(Map<String, dynamic> map) {
    userName = map["userName"];
    userFlag = map["userFlag"];
  }

  @override
  String toString() {
    return 'UserBean{userName: $userName, userFlag: $userFlag}';
  }
}
