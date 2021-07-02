import 'package:one/CellItem.dart';
import 'package:one/Controller/TabBar/Me/Partner/EnterpriseCommission/EnterpriseCommissionViewController.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/**
 * 业务员
 */
class SalesmanViewController extends StatefulWidget {
  @override
  _SalesmanViewControllerState createState() => _SalesmanViewControllerState();
}

class _SalesmanViewControllerState extends State<SalesmanViewController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (Account.user.owned.contains(Account.salesman)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CellItem(
              imagePath: 'images/icon_link.png',
              title: '企业佣金',
              onPressed: () {
                routePush(EnterpriseCommissionViewController(rid: Account.salesman));
              },
            ),
          ],
        ),
      ));
    }

    return BaseScaffold(
      title: "业务员服务",
      child: ListView(
        children: children,
      ),
    );
  }
}
