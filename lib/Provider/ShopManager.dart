import 'package:demo2020/Model/ShopCartModel.dart';
import 'package:demo2020/Model/ShopCategory.dart';
import 'package:demo2020/Model/ShopNavitems.dart';
import 'package:demo2020/Model/ShopOrder.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopManager extends ChangeNotifier {
  static navitems() async {
    var url = "shop/categorylist";
    var arguments = {"page": 1, "limit": 8};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    List items = [];
    response.data.map((json) {
      items.add(ShopCategory.fromJson(json));
    }).toList();

    return items;
  }

  static List bannerlist = [];

  static getBannerlist() async {
    var url = "shop/bannerlist";

    SBResponse response = await SBRequest.post(url);
    print(response.data);
    List productslist = [];
    response.data.map((json) {
      productslist.add(ShopProductsModel.fromJson(json));
    }).toList();
    bannerlist = productslist;
    return productslist;
  }

  static categorylist({int page = 1, int limit = 100}) async {
    var url = "shop/categorylist";
    var arguments = {"page": page, "limit": limit};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    List items = [];
    response.data.map((json) {
      items.add(ShopCategory.fromJson(json));
    }).toList();

    return items;
  }

  static arrProducts(var arguments) async {
    var url = "shop/arrProducts";

    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  static myProducts() async {
    var url = "shop/myProducts";

    SBResponse response = await SBRequest.post(url);
    print(response.data);
    List productslist = [];
    response.data.map((json) {
      productslist.add(ShopProductsModel.fromJson(json));
    }).toList();
    return productslist;
  }

  /**
   * 新品推荐
   */
  static newArrivals() async {
    var url = "shop/newArrivals";

    SBResponse response = await SBRequest.post(url);
    print(response.data);
    List productslist = [];
    response.data.map((json) {
      productslist.add(ShopProductsModel.fromJson(json));
    }).toList();

    return productslist;
  }

  /**
   * 添加购物车
   */
  static addCard({int sid, int cid, double price, int count}) async {
    var url = "shop/addCard";
    var arguments = {"sid": sid, "cid": cid, "price": price, "count": count};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 查看我的购物车
   */
  static getCardlist() async {
    var url = "shop/getCardlist";
    SBResponse response = await SBRequest.post(url);
    print(response.data);
    List orderlist = [];
    response.data.map((json) {
      orderlist.add(ShopCartModel.fromJson(json));
    }).toList();

    return orderlist;
  }

  /**
   * 删除我的购物车
   */
  static deleteCard({int cid}) async {
    var url = "shop/deleteCard";
    var arguments = {"cid": cid};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 添加订单收货地址
   */
  static addOrderAddres(province, city, area, address, name, phone) async {
    var url = "shop/addOrderAddres";
    var arguments = {"province", "city", "area", "address", "name", "phone"};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }



  /**
   * addOrder
   * 添加订单
   *
   * cid
   * euid
   * addid
   * count
   */
  static addOrder({int cid, int euid, int count, int addid, double price}) async {
    var url = "shop/addOrder";
    var arguments = {
      "cid": cid,
      "euid": euid,
      "count": count,
      "price": price,
      "addid": addid
    };

    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 我的订单列表
   */
  static myOrder() async {
    var url = "shop/myOrder";
    SBResponse response = await SBRequest.post(url);
    List orderlist = [];
    response.data.map((json){
      orderlist.add(ShopOrder.fromJson(json));
    }).toList();
    return orderlist;
  }

  /**
   * 签收
   * status = 2
   */
  static signFor({int oid}) async {
    var url = "shop/signFor";
    SBResponse response = await SBRequest.post(url, arguments: {"oid": oid});
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 销售记录
   */
  static salesRecord() async {
    var url = "shop/salesRecord";
    SBResponse response = await SBRequest.post(url);
    List orderlist = [];
    response.data.map((json){
      orderlist.add(ShopOrder.fromJson(json));
    }).toList();
    return orderlist;
  }

  /**
   * 发货
   */
  static deliverGoods({int oid}) async {
    var url = "shop/deliverGoods";
    SBResponse response = await SBRequest.post(url, arguments: {"oid": oid});
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

}
