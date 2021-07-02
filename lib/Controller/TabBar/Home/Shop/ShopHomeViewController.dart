
import 'package:auto_size_text/auto_size_text.dart';
import 'package:one/Controller/TabBar/Home/Shop/ShopDetailsViewController.dart';
import 'package:one/Controller/TabBar/Home/Shop/ShopGoodsViewController.dart';
import 'package:one/Model/ShopCategory.dart';
import 'package:one/Model/ShopNavitems.dart';
import 'package:one/Model/ShopProductsModel.dart';
import 'package:one/Provider/ShopManager.dart';
import 'package:one/Views/CardSeries/CardRefresherGridView.dart';
import 'package:one/Views/SBImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 购物商城首页
 */
class ShopHomeViewController extends StatefulWidget {

  ShopHomeViewController();

  @override
  _ShopHomeViewControllerState createState() => _ShopHomeViewControllerState();
}

class _ShopHomeViewControllerState extends State<ShopHomeViewController> {

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {


    List<Widget> slivers = [];

    /// banner
    SliverFixedExtentList header = SliverFixedExtentList(
      itemExtent: 180,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _buildSwiper(context);
      }, childCount: 1),
    );
    slivers.add(header);


    SliverToBoxAdapter tpl = SliverToBoxAdapter(
      child: SizedBox(height: 32),
    );
    slivers.add(tpl);

    /// items
    SliverGrid grid = new SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (_, int index) {
          ShopCategory item = items[index];
          return CardRefresherGridViewItem(
            url: item.image,
            title: item.name,
            onTap: () async {

              routePush(ShopGoodsViewController(category: item,));
            },
          );
        },
        childCount: items.length <= 8 ? items.length : 8,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 10.0, crossAxisSpacing: 1.0),
    );
    slivers.add(grid);


    SliverStickyHeader jobList = SliverStickyHeader(
      sticky: false,
      header: Container(
        margin: EdgeInsets.only(top: 32.0, bottom: 12.0),
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Text("新品推荐"),
              Image.asset("images/shop/line_botm.jpg")
            ],
          ),
        ),
      ),
      sliver: new SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (_, int index) {
            ShopProductsModel products = arrivalslist[index];

            return InkWell(
              child: Container(
                color: Colors.white,
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
                      child: AutoSizeText(products.name, maxLines: 2, minFontSize: 8, maxFontSize: 12, style: TextStyle(fontSize: 12), textAlign: TextAlign.left,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
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
          },
          childCount: arrivalslist.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10.0, crossAxisSpacing: 1.0, childAspectRatio: 0.9),
      ),
    );
    slivers.add(jobList);





    return Container(
      child: CupertinoScrollbar(
          child: LayoutBuilder(
            builder: (_, __) {
              return SmartRefresher(
                enablePullDown: true,
                onTwoLevel: () {},
                controller: _refreshController,
                header: MaterialClassicHeader(),
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  slivers: slivers,
                ),
              );
            },
          ),
      ),
    );
  }

  static List items = [];
  static List arrivalslist = [];
  _onRefresh() async {
    _refreshController.refreshFailed();
    items = await ShopManager.navitems();
    arrivalslist = await ShopManager.newArrivals();
    setState(() {

    });

  }


  _buildSwiper(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        ShopProductsModel banner = ShopManager.bannerlist[index];
        return SBImage(url: banner.images[0]);
      },
      itemCount: ShopManager.bannerlist.length,
      autoplay: false,
      onTap: (index) {
        ShopProductsModel banner = ShopManager.bannerlist[index];

        routePush(ShopDetailsViewController(productsModel: banner));
      },
      pagination: new SwiperPagination(alignment: Alignment.bottomLeft),
    );
  }

}
