//
//  文件名：PreferencesViewController
//  所在包名：Controller.Me.Preferences
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//



import 'package:demo2020/Controller/TabBar/Me/Preferences/AboutUs/AboutUsViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Preferences/AddGoods/AddGoodsViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Preferences/Feedback/FeedbackViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Preferences/MyGoods/MyGoodsViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Preferences/MyOrder/MyOrderViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Preferences/SalesRecord/SalesRecordViewController.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesRight.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/Views/card_settings/card_settings.dart';
import 'package:demo2020/Views/card_settings/widgets/card_settings_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/// 系统设置
class PreferencesViewController extends StatefulWidget {
  static const routeName = "/me/Preferences";


  @override
  _PreferencesViewControllerState createState() =>
      _PreferencesViewControllerState();
}

class _PreferencesViewControllerState extends State<PreferencesViewController> {

  String cache;

  @override
  Widget build(BuildContext context) {

    if (cache == null) {
      cache = ModalRoute.of(context).settings.arguments;
    }

    return BaseScaffold(
      title: "系统设置",
      child: SingleChildScrollView(
        child: buildColumn(context),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            //Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      CardViewSeriesRight(
                        title: "我的商品",
                        subtitle: "销售中的商品",
                        subtitleColor: Colors.grey,
                        onTap: () {
                          routePush(MyGoodsViewController());
                        },
                      ),
                      CardViewSeriesRight(
                        title: "销售记录",
                        subtitle: "卖出",
                        subtitleColor: Colors.grey,
                        onTap: () {
                          routePush(SalesRecordViewController());
                        },
                      ),
                      CardViewSeriesRight(
                        title: "发布商品",
                        subtitle: "发布",
                        subtitleColor: Colors.grey,
                        onTap: () {
                          routePush(AddGoodsViewController());
                        },
                      ),
                      CardViewSeriesHeader(title: "", height: 12),
                      CardViewSeriesRight(
                        title: "我的订单",
                        subtitle: "我的购物",
                        subtitleColor: Colors.grey,
                        onTap: () {
                          routePush(MyOrderViewController());
                        },
                      ),
                      CardViewSeriesHeader(title: "", height: 32),
                      CardViewSeriesText(
                        title: "意见反馈",
                        placeholder: "",
                        enabled: false,
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          routePush(FeedbackViewController());
                        },
                      ),
                      CardViewSeriesText(
                        title: "关于蛋蛋",
                        placeholder: "",
                        enabled: false,
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          routePush(AboutUsViewController());
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: 58,
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: ThemeButton("退出账号", onPressed: () {

                    jmessageLoginOut(context);

                  }),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 登出
  jmessageLoginOut(BuildContext context) {

    CardShowActionSheetController(
      context,
      title: "退出登录",
      subtitle: "退出登录,数据将会初清空",
      actions: [
        CupertinoActionSheetAction(
          child: Text("退出登录", style: TextStyle(color: Colors.red)),
          onPressed: () async{

            await Account.logout();
          },
        ),
      ]
    );



  }

}
