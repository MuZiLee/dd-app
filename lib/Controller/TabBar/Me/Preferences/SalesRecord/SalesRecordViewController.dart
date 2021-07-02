
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Model/ShopOrder.dart';
import 'package:demo2020/Provider/ShopManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 销售记录
class SalesRecordViewController extends StatefulWidget {
  static String routeName = "me/preferences/salesRecord";
  @override
  _SalesRecordViewControllerState createState() => _SalesRecordViewControllerState();
}

class _SalesRecordViewControllerState extends State<SalesRecordViewController> {

  RefreshController refreshController = RefreshController(initialRefresh: true);

  List orderlist = [];

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "销售记录",
      child: CardRefresher(
        onRefresh: _onRefresh,
        refreshController: refreshController,
        child: orderlist.length < 1 ? Error404View() : ListView.builder(itemBuilder: (_, index) {

          ShopOrder order = orderlist[index];

          String timestamp = "";
          if (order.create_time != null) {
            DateTime dateTime = DateTime.parse(order.create_time);
            timestamp = TimelineUtil.formatByDateTime(dateTime, locale: 'zh').toString();
          }

          return Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            color: Colors.white,
            child: Slidable(
              actionPane: SlidableScrollActionPane(),
              actionExtentRatio: 0.25,
              closeOnScroll: false,
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 58.0,
                                      height: 58.0,
                                      child: SBImage(
                                        url: order.order.images[0],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 24.0,
                                          height: 24.0,
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: InkWell(
                                            child: ClipRRect(
                                              child: SBImage(url: order.euser.avatar),
                                              borderRadius: BorderRadius.all(Radius.circular(100)),
                                            ),
                                            onTap: () async{
                                              routePush(ConversationViewController(order.euser.phone));
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text("卖家："+order.user.username.replaceRange(1, order.user.username.length, "*"), style: TextStyle(fontSize: 10)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text("下单时间："+timestamp, style: TextStyle(fontSize: 10)),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: Text(order.order.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                      maxLines: 2),
                                ),
                                Text("¥ "+order.price.toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                                Text("收件人:${order.addres.name}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12)),
                                Text("联系电话:${order.addres.phone}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12)),
                                Text("收货地址:${order.addres.province+order.addres.city+order.addres.district+order.addres.addres}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text(order.status == 0 ? "待发货" : order.status == 1 ? "已发货" : "已完成"),
                                ),
                              ),
                              onTap: () async{
                                if (order.status == 2) {
                                  return;
                                }
                                CardShowActionSheetController(
                                    context,
                                    title: "签收",
                                    subtitle: order.order.name+"\n\n"+"亲，您收到商品了吗？",
                                    actions: [
                                      CupertinoActionSheetAction(
                                        child: Text("去发货"),
                                        onPressed: () async{
                                          if (await ShopManager.deliverGoods(oid: order.id)) {
                                            await _onRefresh();
                                            pop();
                                          }
                                        },
                                      ),
                                    ]
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(height: 1.0)
                  ],
                ),
                onTap: () {
                  setState(() {

                  });
                },
              ),
            ),
          );
        },
          itemCount: orderlist.length,
        ),
      ),
    );
  }

  _onRefresh() async {
    //orderlist
    orderlist = await ShopManager.salesRecord();
    setState(() {

    });
  }

}
