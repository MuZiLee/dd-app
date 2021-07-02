import 'dart:io';
import 'package:flutter/foundation.dart';

class Config {
 static var _HOST_URL_DEBUG_ = "http://192.168.1.95";
//  static var _HOST_URL_DEBUG_ = "http://192.168.43.123";
//   static var _HOST_URL_RELEASE_ = "http://dandankj.com";
  static var BASE_URL = _HOST_URL_DEBUG_;

  static var resources = BASE_URL + "/resources/logo.png";
  static var addImage = BASE_URL + "/resources/addImage.png";
  static var LounchImage = BASE_URL + "/resources/launch.png";
}
