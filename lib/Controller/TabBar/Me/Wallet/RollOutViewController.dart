import 'package:demo2020/Model/ServiceCharge.dart';
import 'package:demo2020/Provider/DividendManager.dart';
import 'package:demo2020/Provider/WalletManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RollOutViewController extends StatefulWidget {
  List commission = [];
  double business = 0.0;
  int rid = 0;
  int tid;
  RollOutViewController(this.commission, this.business, this.rid, this.tid);

  @override
  _RollOutViewControllerState createState() => _RollOutViewControllerState();
}

class _RollOutViewControllerState extends State<RollOutViewController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "转出到钱包",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
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
                placeholder: "可转出到钱包${(widget.business - double.parse(charge.commission_fee)).toStringAsFixed(2)}元",
                placeholderStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                onChanged: (value) {

                },
              ),
            ),

            ThemeButton("转出", onPressed: () async{

              var text = _textEditingController.text;
              if (await DividendManager.withdrawToLooseChange(amount: text, rid: widget.rid, commission_fee: charge.commission_fee, tid: widget.tid)) {
                pop();
              }


            }),
            Container(
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                child: Text("全部转出 手续费：${charge.commission_fee}", style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                onTap: (){

                  _textEditingController = TextEditingController(text: (widget.business - double.parse(charge.commission_fee)).toStringAsFixed(2));
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

  ServiceCharge charge = ServiceCharge(commission_fee: "0.00", service_charge_for_withdrawal: "0.00");
  _onRefresh() async {
    charge = await WalletManager.getServiceCharge();
    setState(() {

    });
  }
}
