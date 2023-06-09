
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/27.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
/// 加密处理工具类  EncryptUtils 类名调用
/// lib/utils/encrypt_utils.dart
class EncryptUtils {
  /// md5 加密
  static String encodeMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// Base64 编码 加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64 编码 解密
  static String decodeBase64(String data) {
    List<int> bytes = base64Decode(data);
    String result = utf8.decode(bytes);
    return result;
  }

  /// AES 加密
  static String encodeAes(String aesKey, String data) {
    if(aesKey.length!=32){
      throw "key必需是32位";
    }
    final key = encrypt.Key.fromUtf8(aesKey);
    final iv = encrypt.IV.fromLength(16); //偏移量
    final encrypter = encrypt.Encrypter(encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc,
    ));
    //加密
    encrypt.Encrypted encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  /// AES 解密
  static String decodeAes(String aesKey, String data) {
    final key = encrypt.Key.fromUtf8(aesKey);
    final iv = encrypt.IV.fromLength(16); //偏移量
    final encrypter = encrypt.Encrypter(encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc,//加密模式
    ));
    //解密
    final decrypted = encrypter.decrypt64(data, iv: iv);
    return decrypted;
  }
}
