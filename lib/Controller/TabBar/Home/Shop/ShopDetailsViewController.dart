
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopCartViewController.dart';
import 'package:demo2020/Controller/TabBar/SBTabbarViewController.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';
import 'package:demo2020/Provider/AddresManager.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Provider/ShopManager.dart';
import 'package:demo2020/Provider/ShopProviders.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopDetailsViewController extends StatefulWidget {

  ShopProductsModel productsModel;
  ShopDetailsViewController({this.productsModel});

  @override
  _ShopDetailsViewControllerState createState() => _ShopDetailsViewControllerState();
}

class _ShopDetailsViewControllerState extends State<ShopDetailsViewController> {



  @override
  Widget build(BuildContext context) {
    print(widget.productsModel.name);


    List<Widget> slivers = [];

    /// banner
    SliverFixedExtentList header = SliverFixedExtentList(
      itemExtent: 180,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _buildSwiper(context);
      }, childCount: 1),
    );
    slivers.add(header);


    String timestamp = "";
    if (widget.productsModel.create_time != null) {
      DateTime dateTime = DateTime.parse(widget.productsModel.create_time);
      timestamp = TimelineUtil.formatByDateTime(dateTime, locale: 'zh').toString();
    }

    if (widget.productsModel.user.username == "" || widget.productsModel.user.username == null) {
      widget.productsModel.user.username = "*??????";
    }

    SliverToBoxAdapter tpl = SliverToBoxAdapter(
      child: Column(

        children: [
          Row(
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 38.0,
                  height: 38.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: SBImage(url: widget.productsModel.user.avatar,),
                  ),
                ),
                onTap: () async{
                  /// ????????????
                  if (IM.isLogin == false) {
                    ZKCommonUtils.showToast("????????????,???????????????");
                    return;
                  }
                  await IM.enterConversation(phone: widget.productsModel.user.phone);
                  Navigator.pop(context);

                  routePush(ConversationViewController(widget.productsModel.user.phone));
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("?????????"+widget.productsModel.user.username.replaceRange(0, 1, "*"), style: TextStyle(fontSize: 12),),
                    ),
                    Container(
                      child: Text("???????????????"+timestamp, style: TextStyle(fontSize: 10),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(12.0),
            child: Text(widget.productsModel.name),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            child: Text("??"+widget.productsModel.price.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20.0)),
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.deepOrangeAccent,
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text("??????", style: TextStyle(color: Colors.white),),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productsModel.text)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    slivers.add(tpl);

    /// items
    SliverGrid grid = new SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (_, int index) {

          return SBImage(url: widget.productsModel.images[index]);
        },
        childCount: widget.productsModel.images.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, mainAxisSpacing: 0.0),
    );
    slivers.add(grid);


    return BaseScaffold(
      title: "????????????",
      child: CupertinoScrollbar(
        child: LayoutBuilder(
          builder: (_, __) {
            return CustomScrollView(
              slivers: slivers,
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 49.0,
        child: Row(
          children: [

            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text("??"+widget.productsModel.price.toString(), style: TextStyle(fontSize: 20.0, color: Colors.red)),
            ),
            Expanded(
              child: Container(),
            ),
            InkWell(
              child: Container(
                color: Colors.red,
                height: 49.0,
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Center(
                  child: Text("???????????????", style: TextStyle(color: Colors.white)),
                ),
              ),
              onTap: () async{

                if (widget.productsModel?.user?.id == null) {
                  ZKCommonUtils.showToast("????????????");
                  return;
                }
                if (widget.productsModel?.id == null) {
                  ZKCommonUtils.showToast("????????????");
                  return;
                }
                ZKCommonUtils.showToast("???????????????");
                await ShopManager.addCard(
                  sid: widget.productsModel.user.id,
                  cid: widget.productsModel.id,
                  count: 1,
                  price: widget.productsModel.price
                );
                await AddresManager.getAddreslist();
                routePush(ShopCartViewController());

              },
            ),

          ],
        ),
      ),
    );
  }

  _buildSwiper(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return SBImage(url: widget.productsModel.images[index]);
      },
      itemCount: widget.productsModel.images.length,
      autoplay: false,
      onTap: (index) {



      },
      pagination: new SwiperPagination(alignment: Alignment.bottomLeft),
    );
  }


}
