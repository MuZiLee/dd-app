import 'package:one/Controller/TabBar/Me/Wallet/RollOutViewController.dart';
import 'package:one/Controller/TabBar/Me/Wallet/RollOutWageViewController.dart';
import 'package:one/Provider/PaySlipManager.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/**
 * 工资转出
 */
class WageTransferViewController extends StatefulWidget {

  int rid = 0;
  String title = "";
  int tid;
  WageTransferViewController({this.title, this.rid, this.tid});

  @override
  _WageTransferViewControllerState createState() => _WageTransferViewControllerState();
}

class _WageTransferViewControllerState extends State<WageTransferViewController> {

  double amount = 0.0;
  List commission = [];
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      child: CardRefresher(
        onRefresh: () async{

          amount = await PaySlipManager.withdrawableSalary();
          setState(() {});
        },
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: 32),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                child: Container(
                  width: 58, height: 58,
                  color: Colors.deepOrangeAccent,
                  child: Center(child: Text("¥", style: TextStyle(fontSize: 28, color: Colors.white))),
                ),
              ),
              Container(padding: EdgeInsets.all(5),child: Text("可提现到钱包", style: TextStyle(fontSize: 13))),
              Text("¥${amount.toStringAsFixed(2)}", style: TextStyle(fontSize: 28)),
              SizedBox(height: 64),
              amount > 3 ? Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: RaisedButton(
                  child: Text("转出", style: TextStyle(color: Colors.white)),
                  color: Colors.deepOrangeAccent,
                  onPressed: () async{

                    if (amount < 3) {
                      return;
                    }
                    routePush(RollOutWageViewController(amount: amount)).then((value) {
                      pop();
                    });


                  },
                ),
              ) : Container(),


            ],
          ),
        ),
      ),
    );
  }


}
