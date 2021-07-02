

import 'package:demo2020/Model/ShopCategory.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovprogresshud/progresshud.dart';

class ShopProviders extends ChangeNotifier {

  ShopProviders() {

    setCurrentCategory(fid: 0);
  }

  ShopCategory currentCategory;
  List currentGoodslist = [];
  setCurrentCategory({ShopCategory category, int fid}) async{
    currentCategory = category;
    var url = "shop/goodsByType";
    SBResponse response = await SBRequest.post(url, arguments: {"tid": category != null ? category.id : fid});
    Progresshud.dismiss();
    if (response.code == 0) {
      currentGoodslist = [];
      response.data.map((json){
        currentGoodslist.add(ShopProductsModel.fromJson(json));
      }).toList();

      if (category != null) {
        notifyListeners();
      }
      return currentGoodslist;
    }
  }

  static getGoods(int tid) async{

    var url = "shop/goodsByType";
    SBResponse response = await SBRequest.post(url, arguments: {"tid": tid});

    List goodslist = [];
    response.data.map((json){
      goodslist.add(ShopProductsModel.fromJson(json));
    }).toList();

    return goodslist;
  }

  /**
   * 搜索职位
   */
  static searchGoods(String keyword,{int page = 1, int limit = 15}) async {
    var url = "shop/searchGoods";
    var arguments = {
      "keyword": keyword,
      "page": page,
      "limit": limit,
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List jobs = [];
    response.data.map((json) {
      jobs.add(ShopProductsModel.fromJson(json));
    }).toList();
    return jobs;
  }


}