

import 'package:demo2020/Model/BankModel.dart';
import 'package:demo2020/Provider/WalletManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChangeWithdrawalViewController extends StatefulWidget {

  String amount = "0.0";
  ChangeWithdrawalViewController(this.amount);
  @override
  _ChangeWithdrawalViewControllerState createState() => _ChangeWithdrawalViewControllerState();
}

class _ChangeWithdrawalViewControllerState extends State<ChangeWithdrawalViewController> {


  RefreshController _refreshController = RefreshController(initialRefresh: true);

  List detailslit = [];
  MyBankModel mybank = null;
  _onRefresh() async {
    detailslit = await WalletManager.getMyCardList();
    mybank = detailslit.first;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "钱包提现",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: Container(
          child: Column(
            children: [

              Container(
                margin: EdgeInsets.all(32),
                child: Center(
                  child: Text("到账银行卡：${mybank != null ? mybank.bank.title+"(${mybank.number.substring(mybank.number.length-4, mybank.number.length)})" : ""}", style: TextStyle(fontSize: 12)),
                ),
              ),
              Text("预计2-24小时到账", style: TextStyle(fontSize: 13, color: Colors.grey)),
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
                  placeholder: "可提现金额${widget.amount}元",
                  placeholderStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                  onChanged: (value) {




                  },
                ),
              ),
              ThemeButton("提现", onPressed: () async{
                
                if (await WalletManager.withdraw(bid: mybank.id, amount:double.parse(_textEditingController.text))) {
                 pop();
                }
              }),
              Container(
                margin: EdgeInsets.all(30.0),
                child: InkWell(
                  child: Text("全部转出", style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                  onTap: (){

                    _textEditingController = TextEditingController(text: widget.amount);
                    setState(() {

                    });
                  },
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  TextEditingController _textEditingController = TextEditingController();

//  await WalletManager.withdraw();

}
