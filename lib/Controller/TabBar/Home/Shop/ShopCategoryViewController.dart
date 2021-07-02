
import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopDetailsViewController.dart';
import 'package:demo2020/Model/ShopCategory.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';
import 'package:demo2020/Provider/ShopManager.dart';
import 'package:demo2020/Provider/ShopProviders.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



/**
 * 商品类别
 */
class ShopCategoryViewController extends StatefulWidget {
  @override
  _ShopCategoryViewControllerState createState() =>
      _ShopCategoryViewControllerState();
}

class _ShopCategoryViewControllerState
    extends State<ShopCategoryViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: CategoryLeftWidget(),
          ),
          Expanded(
            child: CategoryRightWidget(),
          )
        ],
      ),
    );
  }
}

/**
 * 左侧选项
 */
class CategoryLeftWidget extends StatefulWidget {
  @override
  _CategoryLeftWidgetState createState() => _CategoryLeftWidgetState();
}

class _CategoryLeftWidgetState extends State<CategoryLeftWidget> {
  static List categorylist = [];
  ScrollController controller = ScrollController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    categorylist = await ShopManager.categorylist();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (categorylist.length < 1) {
      return Container();
    } else {
      return Container(
        color: Colors.white,
        child: ListView.builder(
          controller: controller,
          itemBuilder: (_, index) {
            ShopCategory item = categorylist[index];

            return ListTile(
              title: SBImage(
                url: item.image,
                width: 32,
                height: 32,
                fit: BoxFit.fitHeight,
              ),
              subtitle: Text(item.name, textAlign: TextAlign.center),
              onTap: () {
                Progresshud.show();
                Provider.of<ShopProviders>(context, listen: false).setCurrentCategory(category: item);
                setState(() {});
              },
            );
          },
          itemCount: categorylist.length,
        ),
      );
    }
  }
}

/**
 * 右侧内容
 */
class CategoryRightWidget extends StatefulWidget {
  CategoryRightWidget();

  @override
  _CategoryRightWidgetState createState() => _CategoryRightWidgetState();
}

class _CategoryRightWidgetState extends State<CategoryRightWidget> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProviders>(
      builder: (_, provider, child) {
        return Container(
          child: CardRefresher(
            onRefresh: _onRefresh,
            refreshController: _refreshController,
            child: provider.currentGoodslist.length > 0
                ? _buildGoodsList(context, provider.currentGoodslist)
                : Error404View(),
          ),
        );
      },
    );
  }

  _buildGoodsList(BuildContext context, List productslist) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 32.0),
      child: GridView.builder(
        itemCount: productslist.length,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 2,
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
                width: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.25) / 2,
                child: SBImage(
                  url: products.images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.25) / 2,
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: AutoSizeText(products.name, maxLines: 2, minFontSize: 8, maxFontSize: 12, style: TextStyle(fontSize: 12), textAlign: TextAlign.left,),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.25) / 2,
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text("¥"+products.price.toString(), style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
            )
          ],
        ),
      ),
      onTap: () {
        routePush(ShopDetailsViewController(productsModel: products));
      },
    );

  }

  _onRefresh() async {
    _refreshController.refreshFailed();
  }
}
