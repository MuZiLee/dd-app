import 'package:demo2020/Controller/TabBar/Me/Wallet/BankCardViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/BillViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/CommissionWithdrawalViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/MoneyViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/PayCodeVerificationViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/VirtualViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/WageTransferViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/AdvancePayments/AdvancePaymentsViewController.dart';
import 'package:demo2020/Model/WalletModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/WalletManager.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 我的钱包
class MyWalletViewController extends StatefulWidget {
  static const routeName = "/me/mywallet";

  @override
  _MyWalletViewControllerState createState() => _MyWalletViewControllerState();
}

class _MyWalletViewControllerState extends State<MyWalletViewController> {
//  MyWalletModel myWallet;




  @override
  Widget build(BuildContext context) {

    List<Widget> slivers = [];


    SliverFixedExtentList header = SliverFixedExtentList(
      itemExtent: 150,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _buildChild(context);
      }, childCount: 1),
    );
    slivers.add(header);

    var title = Account.user.owned;

    List items = [
      {"image":"images/member/wallet/icon-wallet-013.png", "title":"提现"},
    ];

    if (Account.user.owned.contains(Account.worker)) {
      if (Account.user.staff.sigingInformation.cooperation_mode != "代理招聘") {
        items.add({"image":"images/member/price.png", "title":"预支"});
        items.add({"image":"images/member/payslip.png", "title":"工资提现"});
      }
    }

    if (Account.user.owned.contains(Account.salesman)) {
      items.add({"image":"images/member/resume.png", "title":"业务提成"});
    }
    if (Account.user.owned.contains(Account.resident_teacher)) {
      items.add({"image":"images/member/reimbursement.png", "title":"驻厂老师提成"});
    }
    if (Account.user.owned.contains(Account.junior_partner)) {
      items.add({"image":"images/member/wallet/icon-wallet-006.png", "title":"初级合伙人分红"});
    }
    if (Account.user.owned.contains(Account.senior_partner)) {
      items.add({"image":"images/member/wallet/icon-wallet-008.png", "title":"高级合伙人分红"});
    }
    if (Account.user.owned.contains(Account.strategic_alliance)) {
      items.add({"image":"images/member/wallet/icon-wallet-008.png", "title":"战略联盟分红"});
    }

    items.add({"image":"images/member/wallet/icon-wallet-003.png", "title":"银行卡"});


    /// items
    SliverStickyHeader ealletServers = SliverStickyHeader(
      sticky: false,
      header: CardHeaderTip("钱包服务"),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((_, int index) {

            return InkWell(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(items[index]['image'], width: 32.0,height: 32.0),
                    Text(items[index]['title'], style: TextStyle(fontSize: 13))
                  ],
                ),
              ),
              onTap: () {

                if (items[index]['title'] == "提现") {

                  routePush(MoneyViewController(wallet.balance)).then((value) {
                    _onRefresh();
                  });
                }
                if (items[index]['title'] == "工资提现") {
                  routePush(WageTransferViewController(title: "工资提现", rid: Account.worker, tid: WalletManager.BusinessCommission)).then((value) {

                    _onRefresh();
                  });
                }
                if (items[index]['title'] == "业务提成") {
                  routePush(CommissionWithdrawalViewController(title: "业务提成", rid: Account.member, tid: WalletManager.BusinessCommission)).then((value) {

                    _onRefresh();
                  });
                }

                if (items[index]['title'] == "驻厂老师提成") {
                  routePush(CommissionWithdrawalViewController(title: "驻厂老师提成", rid: Account.resident_teacher, tid: WalletManager.ResidentCommission)).then((value) {
                    _onRefresh();
                  });
                }
                if (items[index]['title'] == "初级合伙人分红") {
                  routePush(CommissionWithdrawalViewController(title: "初级合伙人分红", rid: Account.junior_partner, tid: WalletManager.PrimaryDividend)).then((value) {
                    _onRefresh();
                  });
                }

                if (items[index]['title'] == "高级合伙人分红") {
                  routePush(CommissionWithdrawalViewController(title: "高级合伙人分红", rid: Account.associate_senior_partner, tid: WalletManager.AdvancedDividend)).then((value) {
                    _onRefresh();
                  });
                }

                if (items[index]['title'] == "战略联盟分红") {
                  routePush(CommissionWithdrawalViewController(title: "战略联盟分红", rid: Account.strategic_alliance, tid: WalletManager.StrategicAllianceDividend,)).then((value) {
                    _onRefresh();
                  });
                }

                if (items[index]['title'] == "预支") {
                  routePush(AdvancePaymentsViewController());
                }

                if (items[index]['title'] == "银行卡") {
                  routePush(BankCardViewController());
                }


              },
            );

          },
          childCount: items.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 1.0, crossAxisSpacing: 1.0),
      ),
    );
    slivers.add(ealletServers);


    return BaseScaffold(
      title: "我的钱包",
      actions: <Widget>[
        FlatButton(
          child: Text("账单明细"),
          onPressed: () {
            routePush(BillViewController());

          },
        )
      ],
      child: CupertinoScrollbar(
        child: LayoutBuilder(
          builder: (i, c) {
            return CardRefresher(
              onRefresh: _onRefresh,
              refreshController: _refreshController,
              child: CustomScrollView(
                slivers: slivers,
              ),
            );
          },
        ),
      ),
    );

  }

  RefreshController _refreshController = RefreshController(initialRefresh: true);
  WalletModel wallet = WalletModel();
  _onRefresh() async {
    _refreshController.refreshFailed();
    wallet = await WalletManager.getMyWallet();
    setState(() {

    });
  }

  _buildChild(BuildContext context) {
    return Container(
      child: Table(
        border: _border(),
        children: [
          TableRow(children: [
            InkWell(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                color: Color(0xFF393F4C),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "images/member/wallet/icon-wallet-001.png",
                        width: 58.0,
                        height: 58.0,
                      ),
                    ),
                    Text("零钱", style: TextStyle(color: Color(0xFFD7D8DA))),
                    Text(wallet.balance, style: TextStyle(color: Color(0xFFD7D8DA))),
                  ],
                ),
              ),
              onTap: (){
                routePush(MoneyViewController(wallet.balance));
              },
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                color: Color(0xFF393F4C),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "images/member/wallet/icon-wallet-002.png",
                        width: 58.0,
                        height: 58.0,
                      ),
                    ),
                    Text("蛋币", style: TextStyle(color: Color(0xFFD7D8DA))),
                    Text(wallet.egg_coin, style: TextStyle(color: Color(0xFFD7D8DA))),
                  ],
                ),
              ),
              onTap: () {
                routePush(VirtualViewController(wallet));
              },
            )
          ]),
        ],
      ),
    );
  }

  _border() {
    //表格边框样式
    return TableBorder.all(
      color: Colors.grey,
      width: 0.5,
      style: BorderStyle.none,
    );
  }
}
