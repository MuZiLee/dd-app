
import 'package:one/Controller/TabBar/Me/Wallet/AddBankCardViewController.dart';
import 'package:one/Model/BankModel.dart';
import 'package:one/Provider/WalletManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 银行卡
class BankCardViewController extends StatefulWidget {
  static const routeName = "/me/mywallet/bankcard";

  @override
  _BankCardViewControllerState createState() => _BankCardViewControllerState();
}

class _BankCardViewControllerState extends State<BankCardViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  List detailslit = [];
  _onRefresh() async {
    _refreshController.refreshFailed();
    detailslit = await WalletManager.getMyCardList();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "银行卡",
      actions: <Widget>[
        FlatButton(
          child: Text("添加"),
          onPressed: () {

            routePush(AddBankCardViewController()).then((value) {
              _onRefresh();
            });

          },
        ),
      ],
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: detailslit.length == 0 ? Error404View() : CardRefresherListView(
          itemCount: detailslit.length,
          itemBuilder: (_, index) {
            MyBankModel cardInfo = detailslit[index];

            return InkWell(
              child: _buildBankCard(cardInfo),
              onTap: () {

                CardShowActionSheetController(
                  context,
                  title: cardInfo.bank.title,
                  subtitle: cardInfo.number.substring(0, 4) + " **** **** " + cardInfo.number.substring(cardInfo.number.length - 4),
                  actions: [
                    CupertinoActionSheetAction(
                      child: Text("删除", style: TextStyle(color: Colors.red)),
                      onPressed: () async{
//                        await Provider.of<WalletProvider>(context).deleteMyCard(
//                          bank_id: cardInfo.bank_id,
//                          key: cardInfo.key,
//                          id: cardInfo.id
//                        );
                        await _onRefresh();
                        Navigator.of(context).pop();
                      },
                    )
                  ]
                );

              },
            );

          },
        ),
      ),
    );
  }


  _buildBankCard(MyBankModel cardInfo) {
    return Card(
      color: Colors.green,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(cardInfo.bank.title),
              Text("储蓄卡", style: TextStyle(fontSize: 10, color: Colors.white)),
              SizedBox(height: 12),
              Text(cardInfo.number.substring(0, 4) + " **** **** " + cardInfo.number.substring(cardInfo.number.length - 4), style: TextStyle(fontSize: 23, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
