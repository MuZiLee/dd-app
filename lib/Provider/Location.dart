import 'dart:io';

import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter_amap_location_plugin/flutter_amap_location_plugin.dart';
import 'package:permission/permission.dart';


class Location {

  static String longitude = "113.992164";
  static String latitude = "22.975588";
  static String city = "广州市";


  static updateCurrentLocations(bool isShow) async {
    await startLocation(isShow);
  }


  static startLocation(bool isShow) async{



    if (Platform.isAndroid) {
      FlutterAmapLocationPlugin.onLocationUpdate.listen((AMapLocation location) async {
        print("location =${location.longitude},${location.latitude}，${location.address}");
        if (location.city != null) {
          city = location.city;
          longitude = location.longitude.toString();
          latitude = location.latitude.toString();
          if (isShow == true) {
            // ZKCommonUtils.showToast("位置已更新");
          }
        } else {
          if (isShow == true) {
            ZKCommonUtils.showLongToast("获取定位仅失败或未开启定位");
          }
        }


        await FlutterAmapLocationPlugin.stopLocation();
      });
      await FlutterAmapLocationPlugin.startLocation();
    } else {
      AMapLocation location = await FlutterAmapLocationPlugin.getLocation(needAddress: true);

      if (location.city != null) {
        print("location =${location.longitude},${location.latitude}，${location.address}");
        city = location.city;
        longitude = location.longitude.toString();
        latitude = location.latitude.toString();
        if (isShow == true) {
          // ZKCommonUtils.showToast("位置已更新");
        }
      } else {
        if (isShow == true) {
          ZKCommonUtils.showLongToast("获取定位仅失败或未开启定位");
        }
      }
    }

  }


  static stop() {
    FlutterAmapLocationPlugin.stopLocation();
  }




}