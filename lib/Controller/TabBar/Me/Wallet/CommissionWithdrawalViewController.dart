
import 'package:demo2020/Controller/TabBar/Me/Wallet/RollOutViewController.dart';
import 'package:demo2020/Model/DividendModel.dart';
import 'package:demo2020/Model/MoneyModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/DividendManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class CommissionWithdrawalViewController extends StatefulWidget {


  int rid = 0;
  String title = "";
  int tid;
  CommissionWithdrawalViewController({this.title, this.rid, this.tid});

  @override
  _CommissionWithdrawalViewControllerState createState() => _CommissionWithdrawalViewControllerState();
}

class _CommissionWithdrawalViewControllerState extends State<CommissionWithdrawalViewController> {

  double businessCommission = 0.0;
  List commission = [];
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      child: CardRefresher(
        onRefresh: () async{

          List commission = await DividendManager.getMoney(rid: widget.rid);
          if (widget.rid == Account.resident_teacher) {
            commission.map((e) {
              businessCommission = businessCommission + double.parse(e.teacherBill);
            }).toList();
          } else if (widget.rid == Account.junior_partner) {
            commission.map((e) {
              businessCommission = businessCommission + double.parse(e.primaryBill);
            }).toList();
          } else if (widget.rid == Account.senior_partner) {
            commission.map((e) {
              businessCommission = businessCommission + double.parse(e.advancedBill);
            }).toList();
          } else if (widget.rid == Account.strategic_alliance) {
            commission.map((e) {
              businessCommission = businessCommission + double.parse(e.strategicBill);
            }).toList();
          } else if (widget.rid == Account.salesman) {
            commission.map((e) {
              businessCommission = businessCommission + double.parse(e.salesmanBill);
            }).toList();
          } else if (widget.rid == Account.dandankj) {
            commission.map((e) {
              businessCommission = businessCommission + double.parse(e.dandanBill);
            }).toList();
          }

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
              Text("¥${businessCommission.toStringAsFixed(2)}", style: TextStyle(fontSize: 28)),
              SizedBox(height: 64),
              businessCommission > 3 ? Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: RaisedButton(
                  child: Text("提现", style: TextStyle(color: Colors.white)),
                  color: Colors.deepOrangeAccent,
                  onPressed: () async{

                    if (businessCommission < 3) {
                      return;
                    }
                    routePush(RollOutViewController(commission, businessCommission, widget.rid, widget.tid)).then((value) {
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
