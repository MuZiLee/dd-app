
import 'package:one/Model/WalletBillingDetailModel.dart';
import 'package:one/Provider/WalletManager.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 账单明细
class BillViewController extends StatefulWidget {
  static const routeName = "/me/mywallet/bill";

  @override
  _BillViewControllerState createState() => _BillViewControllerState();
}

class _BillViewControllerState extends State<BillViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "账单明细",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: CardRefresherListView(
          itemCount: detailslit.length,
          itemBuilder: (_, index) {

            WalletBillingDetailModel detail = detailslit[index];

            return Container(
              width: double.infinity,
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(detail.etype.title, style: TextStyle(fontSize: 13), textAlign: TextAlign.left),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(detail.amount_type.contains("支出") ? "-${double.parse(detail.egg_amount)}个" : "${double.parse(detail.egg_amount)}个", style: TextStyle(fontSize: 13, color: detail.amount_type.contains("支出") ? Colors.red : Colors.black), textAlign: TextAlign.right),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(detail.amount_type.contains("支出") ? "-${double.parse(detail.amount)}" : "¥${double.parse(detail.amount)}", style: TextStyle(fontSize: 13, color: detail.amount_type.contains("支出") ? Colors.red : Colors.black), textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(detail.create_time, style: TextStyle(fontSize: 10), textAlign: TextAlign.left),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text("蛋币${double.parse(detail.egg_coin)}", style: TextStyle(fontSize: 10), textAlign: TextAlign.right),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text("余额 ${double.parse(detail.balance)}", style: TextStyle(fontSize: 10), textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Divider(height: 1.0),
                  )
                ],
              ),
            );

          },
        ),
      ),
    );
  }

  List detailslit = [];
  _onRefresh() async {
    _refreshController.refreshFailed();
    detailslit = await WalletManager.billingDetailslist();
    setState(() {

    });
  }



}
