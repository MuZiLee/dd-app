
import 'package:one/Model/FavoritesModel.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:one/config.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovprogresshud/progresshud.dart';

class FavoritesManager {

  static add({@required int type, @required String title, @required String subtitle, @required int cid, @required String image}) async {
    var url = "favorites/add";
    var src = image.substring(Config.BASE_URL.length,image.length);
    var arguments = {
      "type": type, "title": title, "subtitle": subtitle, "cid": cid, "image": src
    };
    Progresshud.show();
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    Progresshud.dismiss();
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 查询是否收藏过
   */
  static isFavorites({int type, int cid}) async {
    var url = "favorites/isFavorites";
    var arguments = {
      "type": type, "cid": cid
    };
    Progresshud.show();
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    Progresshud.dismiss();
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 删除收藏
   */
  static del({int type, int cid}) async {
    var url = "favorites/del";
    var arguments = {
      "type": type, "cid": cid
    };
    Progresshud.show();
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    Progresshud.dismiss();
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 我的收藏
   */
  static getList() async {
    var url = "favorites/getList";
    Progresshud.show();
    SBResponse response = await SBRequest.post(url);
    Progresshud.dismiss();
    List favorites = [];
    response.data.map((json){
      favorites.add(FavoritesModel.fromJson(json));
    }).toList();

    return favorites;
  }

}