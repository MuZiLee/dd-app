

import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter_amap_location_plugin/amap_location_option.dart';
import 'package:flutter_amap_location_plugin/flutter_amap_location_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location {

  static AMapLocation amap = AMapLocation(latitude: 22.975588, longitude: 113.992164, city: "东莞市");
  static updateCurrentLocations() async {
    if (!await requestPermission()) {
      ZKCommonUtils.showLongToast("未开启定位功能");
    } else {
      await _getLocation();
    }
  }

  static _getLocation() async {
//    amap = await FlutterAmapLocationPlugin.getLocation(needAddress: false);
//    amap = AMapLocation(latitude: 22.975588, longitude: 113.992164, city: "东莞市");
//    print("定位信息: ${amap?.longitude}，${amap?.latitude}，${amap?.address}");
//    amap.longitude = double.parse("");
//    amap.latitude = double.parse("");
    return amap;
  }


  static Future<bool> requestPermission() async {
    final permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      ZKCommonUtils.showToast('需要定位权限!');
      return false;
    }
  }

}