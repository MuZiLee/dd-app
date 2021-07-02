
import 'package:demo2020/Model/AnnouncementModel.dart';
import 'package:demo2020/Model/ArticlesModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';

class ArticleManager {

  /**
   * 获取涨知识列表 or 获取公告列表
   * type 1 获取涨知识列表
   * type 2 获取公告列表
   */
  static getArticlelist(int type, {int page = 1, int limit = 100}) async {
    var url = "articles/getArticlelist";
    var arguments = {
      "page": page,
      "limit": limit,
      "type" : type
    };
    print(Account.user.owned);
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code != 0) {
      ZKCommonUtils.showToast(response.msg);
    }
    List articles = [];

    if (type == 1) {
      articles = [];
      response.data.map((json){

        articles.add(ArticlesModel.fromJson(json));
      }).toList();
    } else {
      articles = [];
      response.data.map((var json){
        bool visible = true;
        json['visible'].map((item){
          print(Account.user.owned);
          print(item);
          if (Account.user.owned.contains(int.parse(item)) && visible == true) {
            print("有：${json}");
            articles.add(AnnouncementModel.fromJson(json));
            visible = false;
          }
        }).toList();
      }).toList();
    }


    return articles;
  }

  /**
   * 购买文章
   */
  static buy({int id = 0}) async {
    var url = "articles/buy";
    var arguments = {
      "id" : id
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

}