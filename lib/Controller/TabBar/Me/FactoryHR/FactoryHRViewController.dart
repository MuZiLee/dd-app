
import 'package:demo2020/CellItem.dart';
import 'package:demo2020/Controller/TabBar/Me/FactoryHR/EmploymentViewController.dart';
import 'package:demo2020/Model/HRFactoryInfoModel.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/FactoryManager.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';

class FactoryHRViewController extends StatefulWidget {
  static const routeName = "/me/factoryHR";

  @override
  _FactoryHRViewControllerState createState() =>
      _FactoryHRViewControllerState();
}

class _FactoryHRViewControllerState extends State<FactoryHRViewController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    Account.user.hrs.map((Hr hr) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip(""),
            CellItem(
              imagePath: hr.logo,
              title: hr.factory_name,
              width: 32.0,
              height: 32.0,
              onPressed: () async{


                HRFactoryInfoModel info = await FactoryManager.getFactroyHRInfo(hr.id);
                Progresshud.dismiss();
                if (info != null) {
                  routePush(EmploymentViewController(factoryInfo: info));
                } else {
                  ZKCommonUtils.showToast("工厂信息获取失败~！");
                }

              },
            )
          ],
        ),
      ));
    }).toList();


    return BaseScaffold(
      title: "工厂HR服务",
      child: ListView(
        children: children,
      ),
    );
  }
}
