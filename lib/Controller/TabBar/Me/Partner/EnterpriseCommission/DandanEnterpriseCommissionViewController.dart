
import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo2020/Model/BudgetEnterpriseCommission.dart';
import 'package:demo2020/Model/DividendModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/DividendManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 蛋蛋企业佣金
 */
class DandanEnterpriseCommissionViewController extends StatefulWidget {

  int rid;
  DandanEnterpriseCommissionViewController({this.rid});

  @override
  _DandanEnterpriseCommissionViewControllerState createState() => _DandanEnterpriseCommissionViewControllerState();
}

class _DandanEnterpriseCommissionViewControllerState extends State<DandanEnterpriseCommissionViewController> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "蛋蛋分红(预算)",
      child: CardRefresher(
        refreshController: refreshController,
        onRefresh: _onRefresh,
        child: commissionlist.length > 0 ? ListView.builder(itemBuilder: (_, index) {
          return Column(
            children: [
              _buildChild(_, index: index),
              Divider(height: 1.0),
            ],
          );
        },itemCount: commissionlist.length) : Error404View(),
      )
    );
  }

  List commissionlist = [];
  _onRefresh() async {
    commissionlist = await DividendManager.getEnterpriseCommission(Account.dandankj);

    setState(() {

    });
  }

  _buildChild(BuildContext context, {int index}) {

    BudgetEnterpriseCommission dividend = commissionlist[index];

    return Container(
      child: Table(
        border: _border(),
        children: [
          TableRow(children: [
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: AutoSizeText(dividend.factory.factory_name, minFontSize: 5, maxFontSize: 12,maxLines: 1, textAlign: TextAlign.left),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0, top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("备注", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                  Text("${dividend.remark}", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),
            )
          ]),
          TableRow(children: [
            Container(
              margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("工价：${dividend.staffBill}元", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("佣金：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
                  Text("${dividend.dandanBill}元", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }

  _border() {
    //表格边框样式
    return TableBorder.all(
      color: Colors.grey,
      width: 0.5,
      style: BorderStyle.none,
    );
  }

  _columnWidths() {
    return {
      //列宽
      0: FixedColumnWidth(85.0),
      2: FixedColumnWidth(85.0),
    };
  }

}
