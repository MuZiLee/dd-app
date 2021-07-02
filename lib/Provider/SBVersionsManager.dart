
import 'dart:io';

import 'package:demo2020/Model/VersionModel.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';

class SBVersionsManager {
  
  static VersionModel version;
  static update() async {
    var url = "versions/update";
    var arguments = {
      "system" : Platform.isIOS ? "ios" : "android"
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      version = VersionModel.fromJson(response.data);
      return version;
    } else {
      return VersionModel();
    }
  }
}