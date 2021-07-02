import 'dart:io';
import 'package:flutter/foundation.dart';

class Config {
 // static var _HOST_URL_DEBUG_ = "http://192.168.1.2";
 // static var _HOST_URL_DEBUG_ = "http://192.168.0.134";
static var _HOST_URL_DEBUG_ = "http://192.168.43.234"; // nava 4 热点
// static var _HOST_URL_DEBUG_ = "http://172.20.10.7"; //iphone 手机 热点
// static var _HOST_URL_DEBUG_ = "http://121.37.240.132"; //广州服务器
//   static var _HOST_URL_RELEASE_ = "http://dandankj.com";
  static var BASE_URL = _HOST_URL_DEBUG_;

  static var resources = BASE_URL + "/resources/logo.png";
  static var addImage = BASE_URL + "/resources/addImage.png";
  static var LounchImage = BASE_URL + "/resources/launch.png";
}
