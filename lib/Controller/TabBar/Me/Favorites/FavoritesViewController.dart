//
//  文件名：FavoritesViewController
//  所在包名：Controller.Member.Favorites
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-10-27
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/Controller/WebBrowser/WebBrowserViewController.dart';
import 'package:one/Model/FavoritesModel.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/FavoritesManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/CardSeries/CardViewSeriesFavorite.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/config.dart';

/// 我的收藏

import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class FavoritesViewController extends StatefulWidget {
  static const routeName = "/me/Favorites";

  @override
  _FavoritesViewControllerState createState() => _FavoritesViewControllerState();
}

class _FavoritesViewControllerState extends State<FavoritesViewController> {



  RefreshController _refreshController = RefreshController(initialRefresh: true);
  void _onRefresh() async{
    /// TODU:
    collect_list();

    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: '我的收藏',
      child: CardRefresher(
        onRefresh: _onRefresh,
        child: buildListView(),
      )
    );
  }

  buildListView() {
    return CardRefresherListView(
      itemCount: _favoritesList.length,
      itemBuilder: (_, index) {

        FavoritesModel favorites = _favoritesList[index];

        return GestureDetector(
          onTap: () {
            if (favorites.type == FavoriteType.jobType) {
              var url = Config.BASE_URL + "/share/detailJob.html?id=${favorites.cid}";
              routePush(WebBrowserViewController(title: favorites.title, url: url));
            } else {
              var url = Config.BASE_URL + "/aritcle/aritcleRead.html?id=${favorites.cid}";
              routePush(WebBrowserViewController(title: favorites.title, url: url));
            }
          },
          child: CardViewSeriesFavorite(
            image: favorites.image,
            title: favorites.title,
            subtitle: favorites.subtitle,
            type: favorites.type,
//            id: favorites.id.toString(),
            timestamp: favorites.create_time,
          ),
        );
      },
    );
  }

  static List _favoritesList = [];

  collect_list() async{

    _favoritesList = await FavoritesManager.getList();
    setState(() {

    });
  }

}
