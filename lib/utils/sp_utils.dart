///lib/utils/sp_utils.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  ///静态实例
  static SharedPreferences? _sharedPreferences;

  ///应用启动时需要调用
  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(true);
  }

  // 异步保存基本数据类型
  static Future<bool> save(String key, dynamic value) async {
    if (_sharedPreferences == null) {
      return false;
    }
    if (value is String) {
      await _sharedPreferences!.setString(key, value);
    } else if (value is bool) {
      await _sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences!.setDouble(key, value);
    } else if (value is int) {
      await _sharedPreferences!.setInt(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences!.setStringList(key, value);
    }
    return true;
  }

  // 异步读取
  static String getString(String key)  {
    if (_sharedPreferences == null) {
      return "";
    }
    return _sharedPreferences!.getString(key) ?? "";
  }

  static int getInt(String key)  {
    return _sharedPreferences!.getInt(key) ?? 0;
  }

  static bool getBool(String key)  {
    return _sharedPreferences!.getBool(key) ?? false;
  }

  static double getDouble(String key)  {
    return _sharedPreferences!.getDouble(key) ?? 0.0;
  }

  ///保存自定义对象
  static Future<bool> saveObject(String key, dynamic value) async {
    if (_sharedPreferences == null) {
      return false;
    }

    ///通过 json 将Object对象编译成String类型保存
    await _sharedPreferences!.setString(key, json.encode(value));
    return true;
  }

  ///获取自定义对象
  ///返回的是 Map<String,dynamic> 类型数据
  static getObject<T>(String key) {
    if (_sharedPreferences == null) {
      return null;
    }
    String? _data = _sharedPreferences!.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  ///保存列表数据
  static Future<bool> putObjectList(String key, List<Object> list) async {
    ///将Object的数据类型转换为String类型
    List<String>? _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    if (_sharedPreferences == null) {
      return false;
    }
    _sharedPreferences!.setStringList(key, _dataList);
    return true;
  }

  ///获取对象集合数据
  ///返回的是List<Map<String,dynamic>>类型
  static List<Map>? getObjectList(String key) {
    if (_sharedPreferences == null) return null;
    List<String>? dataLis = _sharedPreferences!.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    }).toList();
  }

  static void remove(String spUserBeanKey) {
    if (_sharedPreferences == null) return;
    _sharedPreferences!.remove(spUserBeanKey);
  }
}
