import 'package:demo2020/Model/ShopProductsModel.dart';
import 'package:demo2020/Provider/ShopManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 我的商品
class MyGoodsViewController extends StatefulWidget {
  static String routeName = "me/preferences/myGoods";

  @override
  _MyGoodsViewControllerState createState() => _MyGoodsViewControllerState();
}

class _MyGoodsViewControllerState extends State<MyGoodsViewController> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  List productslist = [];

  _onRefresh() async {
    refreshController.refreshFailed();
    productslist = await ShopManager.myProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的商品",
      child: CardRefresher(
        refreshController: refreshController,
        onRefresh: _onRefresh,
        child: productslist.length < 1 ? Error404View() : ListView.builder(
          itemBuilder: (_, index) {
            ShopProductsModel products = productslist[index];

            return ListTile(
              leading: Container(
                width: 48.0,
                height: 48.0,
                child: SBImage(url: products.images[0]),
              ),
              trailing: Text(
                products.status == 0
                    ? "待审核"
                    : products.status == 1 ? "已上架" : "已下架",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              title: Text(products.name),
              subtitle: Text(
                products.text,
                maxLines: 1,
              ),
            );
          },
          itemCount: productslist.length,
        ),
      ),
    );
  }
}
