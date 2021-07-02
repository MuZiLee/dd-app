
import 'package:demo2020/Model/WalletBillingDetailModel.dart';
import 'package:demo2020/Provider/WalletManager.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
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
          itemCount: detailslit?.length > 0 ? detailslit?.length : 0,
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
                        child: Text(detail.title, style: TextStyle(fontSize: 13), textAlign: TextAlign.left),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(detail.amount_type == false ? "-${double.parse(detail.egg_coin)}个" : "${double.parse(detail.egg_coin)}个", style: TextStyle(fontSize: 13), textAlign: TextAlign.right),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(detail.amount_type == false ? "￥-${double.parse(detail.amount)}" : "¥${double.parse(detail.amount)}", style: TextStyle(fontSize: 13), textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                  // 余额
                  Row(
                    children: [
                      Expanded(
                        child: Text(detail.create_time, style: TextStyle(fontSize: 10), textAlign: TextAlign.left),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text("剩余蛋币${double.parse(detail.total_egg)}", style: TextStyle(fontSize: 10), textAlign: TextAlign.right),
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
    print(detailslit);
    setState(() {

    });
  }



}
