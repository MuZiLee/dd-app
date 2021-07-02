
import 'dart:convert';

import 'package:demo2020/Controller/Login/LoginViewController.dart';
import 'package:demo2020/Model/AdModel.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_random_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nav_router/nav_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API extends ChangeNotifier {

  static Future<SBResponse> getResponse(String url, {arguments}) async{
    return await SBRequest.post(url, arguments: arguments);
  }

  /**
   * 获取广告
   * 0: 启动广告
   * 1: banner广告
   * 2: 职位广告
   */
  static List bannerAdlist = [];
  static getAdList({int type = 0, int page = 1, int limit = 15}) async{
    var url = "ad/getAdList";
    var arguments = {
      "type": type
      ,"page": page
      ,"limit": limit
    };
    SBResponse response = await getResponse(url, arguments: arguments);
    var ads = [];
    if (response?.data != null) {
      response?.data?.map((item){
        ads.add(AdModel.fromJson(item));
      })?.toList();
    }

    if (type == 1 && ads.length > 0) {
      bannerAdlist = ads;
    }
    return ads;
  }






}