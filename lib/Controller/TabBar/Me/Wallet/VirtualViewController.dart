
import 'package:one/Model/WalletModel.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';

/// 蛋币
class VirtualViewController extends StatefulWidget {
  static const routeName = "/me/mywallet/virtual";

  WalletModel wallet;
  VirtualViewController(this.wallet);
  @override
  _VirtualViewControllerState createState() => _VirtualViewControllerState();
}

class _VirtualViewControllerState extends State<VirtualViewController> {


  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "蛋币",
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
            Container(padding: EdgeInsets.all(5),child: Text("我的蛋币", style: TextStyle(fontSize: 13))),
            Text("${widget.wallet.egg_coin}",
                style: TextStyle(fontSize: 28)),
            SizedBox(height: 64),
            Text("蛋币无法提现  可用于消费抵扣等", style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
