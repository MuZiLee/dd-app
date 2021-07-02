import 'package:one/Controller/TabBar/Me/Wallet/BankCardViewController.dart';
import 'package:one/Controller/TabBar/Me/Wallet/ChangeWithdrawalViewController.dart';
import 'package:one/Provider/WalletManager.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/// 余额
class MoneyViewController extends StatefulWidget {
  static const routeName = "/me/mywallet/money";

  String balance = "0.0";
  MoneyViewController(this.balance);
  @override
  _MoneyViewControllerState createState() => _MoneyViewControllerState();
}

class _MoneyViewControllerState extends State<MoneyViewController> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "钱包",
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
            Container(padding: EdgeInsets.all(5),child: Text("我的余额", style: TextStyle(fontSize: 13))),
            Text("提现时间为 08：00~20：00", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text("¥${widget.balance}", style: TextStyle(fontSize: 28)),
            SizedBox(height: 64),
            double.parse(widget.balance) < 3 ? Container() : Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RaisedButton(
                child: Text("提现", style: TextStyle(color: Colors.white)),
                color: Colors.deepOrangeAccent,
                onPressed: () async{

                  if (!await WalletManager.isWorkers()) {
                    routePush(BankCardViewController()).then((value) {
                      pop();
                    });
                  } else {
                    routePush(ChangeWithdrawalViewController(widget.balance)).then((value) {
                      pop();
                    });
                  }

                },
              ),
            ),


          ],
        ),
      ),
    );
  }


}
