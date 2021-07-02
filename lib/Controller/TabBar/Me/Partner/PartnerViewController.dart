
import 'package:demo2020/CellItem.dart';

import 'package:demo2020/Controller/TabBar/Me/Partner/EnterpriseCommission/EnterpriseCommissionViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/EnterpriseCommission/AdvancedEnterpriseCommissionViewController.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import 'EnterpriseCommission/AdvancedEnterpriseCommissionViewController.dart';

/**
 * 合伙人服务
 */
class PartnerViewController extends StatefulWidget {
  @override
  _PartnerViewControllerState createState() => _PartnerViewControllerState();
}

class _PartnerViewControllerState extends State<PartnerViewController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (Account.user.owned.contains(Account.junior_partner)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("初级合伙人"),
            CellItem(imagePath:'images/icon_look.png',title: '报名审核'),
            CellItem(imagePath:'images/icon_look.png',title: '我的工人'),
            CellItem(imagePath:'images/icon_look.png',title: '我的准工人'),
            CellItem(imagePath:'images/icon_link.png',title: '企业佣金', onPressed: () {
              routePush(EnterpriseCommissionViewController(rid: Account.junior_partner));
            }),
          ],
        ),
      ));
    }

    if (Account.user.owned.contains(Account.associate_senior_partner)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("*准高级合伙人"),
            CellItem(imagePath:'images/icon_look.png',title: '代收分红', subtitle: "等级提升后可到钱包提现",onPressed: () {
              routePush(AdvancedEnterpriseCommissionViewController());
            },),
          ],
        ),
      ));
    }

    if (Account.user.owned.contains(Account.senior_partner)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("高级合伙人"),
            CellItem(imagePath:'images/icon_look.png',title: '我的初级合伙人',),
            CellItem(imagePath:'images/icon_look.png',title: '高级分红',),

          ],
        ),
      ));
    }

    if (Account.user.owned.contains(Account.strategic_alliance)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("战略联盟"),
            CellItem(imagePath:'images/icon_look.png',title: '我的高级合伙人',),
            CellItem(imagePath:'images/icon_look.png',title: '我的准高级合伙人',),
            CellItem(imagePath:'images/icon_look.png',title: '战略合伙分红',),
          ],
        ),
      ));
    }


    return BaseScaffold(
      title: "合伙人服务",
      child: ListView(
        children: children,
      ),
    );
  }



}
