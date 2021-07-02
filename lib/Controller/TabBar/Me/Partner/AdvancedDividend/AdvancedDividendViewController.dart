
import 'package:auto_size_text/auto_size_text.dart';
import 'package:one/Model/DividendModel.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/DividendManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 高级分红 或 代收分红
 */
class AdvancedDividendViewController extends StatefulWidget {

  String title = "";
  AdvancedDividendViewController(this.title);

  @override
  _AdvancedDividendViewControllerState createState() => _AdvancedDividendViewControllerState();
}

class _AdvancedDividendViewControllerState extends State<AdvancedDividendViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  List commissionlist = [];
  _onRefresh() async {
    commissionlist = await DividendManager.getEnterpriseCommission(rid: Account.senior_partner);

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: commissionlist.length == 0 ? Error404View() : CardRefresherListView(
          itemCount: commissionlist.length,
          itemBuilder: (_, index) {
            return _buildChild(context, index: index);
          },
        ),
      ),
    );
  }

  _buildChild(BuildContext context, {int index}) {
    DividendModel dividend = commissionlist[index];

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
                  Text("${dividend.create_time}", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                  Text("${dividend.type}", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
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
                  Text("工价：${dividend.wages}元", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
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
                  Text("${dividend.amount}元", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
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


}
