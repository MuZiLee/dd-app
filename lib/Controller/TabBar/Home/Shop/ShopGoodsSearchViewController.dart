import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopDetailsViewController.dart';
import 'package:demo2020/Model/ShopCategory.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';
import 'package:demo2020/Provider/ShopProviders.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/SearchBarView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopGoodsSearchViewController extends StatefulWidget {
  ShopCategory category;

  ShopGoodsSearchViewController({this.category});

  @override
  _ShopGoodsSearchViewControllerState createState() =>
      _ShopGoodsSearchViewControllerState();
}

class _ShopGoodsSearchViewControllerState extends State<ShopGoodsSearchViewController> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List currentGoodslist = [];
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: "商品搜索",
        child: CardRefresher(
          onRefresh: () => _onRefresh(context),
          refreshController: _refreshController,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: SearchBarView(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _onRefresh(context);
                  },
                  onChanged: (value) {
                      keyword = value;
                      _onRefresh(context);
                  },
                ),
              ),
              Expanded(
                child: currentGoodslist.length > 0
                    ? _buildGoodsList(context, currentGoodslist)
                    : Error404View(),
              ),


            ],
          ),
        ));
  }

  _buildGoodsList(BuildContext context, List productslist) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 32.0),
      child: GridView.builder(
        itemCount: productslist.length,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 10.0,
            //横轴间距
            crossAxisSpacing: 1.0,
            //子组件宽高长度比例
            childAspectRatio: 0.9),
        itemBuilder: (BuildContext context, int index) {
          return getItemContainer(productslist[index], context);
        },
      ),
    );
  }

  Widget getItemContainer(ShopProductsModel products, context) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                child: SBImage(
                  url: products.images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: AutoSizeText(
                products.name,
                maxLines: 2,
                minFontSize: 8,
                maxFontSize: 12,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text("¥" + products.price.toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
            )
          ],
        ),
      ),
      onTap: () {
        routePush(ShopDetailsViewController(productsModel: products));
      },
    );
  }

  _onRefresh(BuildContext context) async {
    currentGoodslist = await ShopProviders.searchGoods(keyword);
    _refreshController.refreshFailed();
    setState(() {

    });
  }
}
