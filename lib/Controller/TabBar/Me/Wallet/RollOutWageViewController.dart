
import 'package:demo2020/Model/ServiceCharge.dart';
import 'package:demo2020/Provider/PaySlipManager.dart';
import 'package:demo2020/Provider/WalletManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class RollOutWageViewController extends StatefulWidget {

  double amount = 0.0;
  RollOutWageViewController({this.amount});

  @override
  _RollOutWageViewControllerState createState() => _RollOutWageViewControllerState();
}

class _RollOutWageViewControllerState extends State<RollOutWageViewController> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "转出到钱包",
      child: CardRefresher(
        refreshController: _refreshController,
        child: Column(
          children: [
            Container(
              height: 59.0,
              margin: EdgeInsets.all(20.0),
              child: CupertinoTextField(
                controller: _textEditingController,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.number,
                enabled: true,
                autofocus: true,
                style: TextStyle(fontSize: 30.0, color: Colors.black),
                prefix: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text("¥", style: TextStyle(fontSize: 30.0, color: Colors.grey)),
                ),
                placeholder: "可转出到钱包${widget.amount}元",
                placeholderStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                onChanged: (value) {

                },
              ),
            ),

            ThemeButton("转出", onPressed: () async{

              var text = _textEditingController.text;

              if (double.parse(text) < 3) {
                return;
              }

              if (await PaySlipManager.rolloutWageToWallet()) {
                pop();
              }


            }),
            Container(
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                child: Text("全部转出", style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                onTap: (){

                  _textEditingController = TextEditingController(text: (widget.amount).toStringAsFixed(2));
                  setState(() {

                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController _textEditingController = TextEditingController();

  RefreshController _refreshController = RefreshController(initialRefresh: true);



}
