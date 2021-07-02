

import 'package:one/CellItem.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RolesSelectViewController extends StatefulWidget {
  @override
  _RolesSelectViewControllerState createState() => _RolesSelectViewControllerState();
}

class _RolesSelectViewControllerState extends State<RolesSelectViewController> {
  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];
    /**
     * 初级合伙人申请
     */
    if (!Account.user.owned.contains(Account.junior_partner)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CellItem(imagePath: 'images/icon_public.png', title: '初级合伙人申请'),
          ],
        ),
      ));
    }


    /**
     * 高级合伙人申请
     */
    if (!Account.user.owned.contains(Account.senior_partner)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CellItem(imagePath: 'images/icon_public.png', title: '高级合伙人申请'),
          ],
        ),
      ));
    }

    /**
     * 战略联盟申请
     */
    if (!Account.user.owned.contains(Account.strategic_alliance)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CellItem(imagePath: 'images/icon_public.png', title: '战略联盟申请'),
          ],
        ),
      ));
    }

    /**
     * 业务员申请
     */
    if (!Account.user.owned.contains(Account.salesman)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CellItem(imagePath: 'images/icon_public.png', title: '业务员申请'),
          ],
        ),
      ));
    }


    return BaseScaffold(
      title: "合伙人申请",
      child: ListView(
        children: children,
      ),
    );
  }
}
