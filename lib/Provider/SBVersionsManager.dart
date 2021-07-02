
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:one/Model/VersionModel.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';

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