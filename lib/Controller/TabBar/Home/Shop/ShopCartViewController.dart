import 'package:one/Controller/TabBar/Home/Shop/Addres/AddressManagerViewController.dart';
import 'package:one/Controller/TabBar/Home/Shop/ShopPaysuccessful.dart';
import 'package:one/Model/AddresModel.dart';
import 'package:one/Model/ShopCartModel.dart';
import 'package:one/Model/WalletModel.dart';
import 'package:one/Provider/AddresManager.dart';
import 'package:one/Provider/ShopManager.dart';
import 'package:one/Provider/ShopProviders.dart';
import 'package:one/Provider/WalletManager.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 购物车
 */
class ShopCartViewController extends StatefulWidget {
  @override
  _ShopCartViewControllerState createState() => _ShopCartViewControllerState();
}

class _ShopCartViewControllerState extends State<ShopCartViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List cartlist = [];


  double total = 0.00;
  ShopCartModel currentOrder;
  List currentlist = [];
  List addreslist = [];

  @override
  Widget build(BuildContext context) {

    total = 0.00;
    cartlist.map((e) {
      ShopCartModel cart = e;
      if (cart.isSelect) {
        total = total + (cart.price * cart.count);
      }
    }).toList();



    return BaseScaffold(
      title: "购物车",
      actions: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Text("收货地址", style: TextStyle(color: Colors.white)),
            color: Colors.deepOrangeAccent,
            onPressed: ()=> routePush(AddressManagerViewController()).then((value) async{
              await _onRefresh();
            }),
          ),
        )
      ],
      child: CardRefresher(
        onRefresh: _onRefresh,
        refreshController: _refreshController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("收件人:"+AddresManager.defaultAddres.name, style: TextStyle(fontSize: 12)),
                  ),
                  Container(
                    child: Text("地址:" + AddresManager.defaultAddres.province + AddresManager.defaultAddres.province + AddresManager.defaultAddres.district + AddresManager.defaultAddres.addres, style: TextStyle(fontSize: 10)),
                  ),
                  Container(
                    child: Text("电话:"+AddresManager.defaultAddres.phone, style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (_, index) {
                  ShopCartModel cart = cartlist[index];
                  return Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    color: Colors.white,
                    child: Slidable(
                      actionPane: SlidableScrollActionPane(),
                      actionExtentRatio: 0.25,
                      closeOnScroll: false,
                      secondaryActions: [
                        IconSlideAction(
                          caption: '删除',
                          color: Colors.deepOrangeAccent,
                          icon: Icons.delete,
                          closeOnTap: true,
                          onTap: () async {
                            /// TODO: 发送删除请求成功后，删除数组，刷新页面
                            if (await ShopManager.deleteCard(cid: cart.id)) {
                              cartlist.removeAt(index);
                              setState(() {

                              });
                            }

                          },
                        ),
                      ],
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Consumer<ShopManager>(builder: (_, manager, child) {

                                    return Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Icon(cart.isSelect ? Icons.check_circle : Icons.check_circle_outline, color: Colors.amber),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 48.0,
                                          height: 48.0,
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: SBImage(
                                            url: cart.order.images[0],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: Text(cart.order.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal),
                                              maxLines: 2),
                                        ),
                                        Text("¥ "+cart.price.toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// -1
                                      Consumer<ShopProviders>(
                                        builder: (_, categorsState, child) {
                                          return InkWell(
                                            child: ClipRRect(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(17),

                                                    ///圆角
                                                    border: Border.all(
                                                        color: Colors.grey, width: 1)

                                                  ///边框颜色、宽
                                                ),
                                                child: Center(
                                                  child: Text("-"),
                                                ),
                                                width: 32,
                                                height: 32,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                            ),
                                            onTap: () => _deleteTap(cart),
                                          );
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(cart.count.toString()),
                                      ),

                                      /// +1
                                      Consumer<ShopProviders>(
                                        builder: (_, categorsState, child) {
                                          return InkWell(
                                            child: ClipRRect(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(17),

                                                    ///圆角
                                                    border: Border.all(
                                                        color: Colors.grey, width: 1)

                                                  ///边框颜色、宽
                                                ),
                                                child: Center(
                                                  child: Text("+"),
                                                ),
                                                width: 32,
                                                height: 32,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                            ),
                                            onTap: () => _addTap(cart),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(height: 1.0)
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            cartlist[index].isSelect = !cart.isSelect;
                          });
                        },
                      ),
                    ),
                  );
                },
                itemCount: cartlist.length,
              ),
            ),
            Container(
              height: 59.0,
              child: Column(
                children: [
                  Divider(height: 1.0),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text("共计:¥ "+total.toString(), style: TextStyle(color: Colors.red)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: Colors.red,
                            child: Text("结算", style: TextStyle(color: Colors.white)),
                            onPressed: ()=> _settlement(cartlist),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  _onRefresh() async {
    print("_onRefresh");
    cartlist = await ShopManager.getCardlist();
    addreslist = await AddresManager.getAddreslist();

    setState(() {

    });
  }

  _addTap(ShopCartModel cart) async {
    print("_addTap");
    cart.count = cart.count + 1;
    currentOrder = cart;
    setState(() {

    });
  }

  _deleteTap(ShopCartModel cart) async {
    print("_deleteTap");
    if (cart.count > 0) {
      cart.count = cart.count - 1;
      currentOrder = cart;
      setState(() {

      });
    }

  }


  _settlement(List cartlist) async {
    /// 判断收货地址
    if (AddresManager.defaultAddres.id == 0) {
      ZKCommonUtils.showToast("添加收货地址");
      routePush(AddressManagerViewController()).then((value) {
        _onRefresh();
      });
      return;
    }

    /// 再结算
    double price = 0.0;
    cartlist.map((e) async{
      ShopCartModel cart = e;
      price = cart.price * cart.count;
    }).toList();

    /// 获取我的余额
    WalletModel wallet = await WalletManager.getMyWallet();
    if (double.parse(wallet.balance) < price) {
      ZKCommonUtils.showToast("您的余额为:¥${wallet.balance}");
      return;
    }

    cartlist.map((e) async{
      ShopCartModel cart = e;
      await ShopManager.addOrder(
        cid: cart.cid,
        euid: cart.sid,
        count: cart.count,
        price: cart.price,
        addid: AddresManager.defaultAddres.id
      );
    }).toList();

    print("");
    pushAndRemoveUntil(ShopPaysuccessful());
  }

}
