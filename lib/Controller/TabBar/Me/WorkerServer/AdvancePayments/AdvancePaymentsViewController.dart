
import 'package:auto_size_text/auto_size_text.dart';
import 'package:one/Model/AdvanceModel.dart';
import 'package:one/Model/EventsStaff.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/StaffManager.dart';
import 'package:one/Provider/WalletManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardTextView.dart';
import 'package:one/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:one/Views/ThemeButton.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 预支工资
 */
class AdvancePaymentsViewController extends StatefulWidget {
  @override
  _AdvancePaymentsViewControllerState createState() => _AdvancePaymentsViewControllerState();
}

class _AdvancePaymentsViewControllerState extends State<AdvancePaymentsViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  String remark = "";


  @override
  Widget build(BuildContext context) {

    bool isAdvance = true;
    if (advanceModel != null) {
      isAdvance = false;
    }

    return BaseScaffold(
      title: "预支",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
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
              Container(padding: EdgeInsets.all(5),child: Text("可预支金额", style: TextStyle(fontSize: 13))),
              isAdvance ? Text("¥${availableAmount}", style: TextStyle(fontSize: 28)) : advanceModel.status == 0 ? Container(
                margin: EdgeInsets.all(32.0),
                child: Text("审批中...", style: TextStyle(fontSize: 28, color: Colors.grey)),
              ) : advanceModel.status == 1 ? Container(
                margin: EdgeInsets.all(32.0),
                child: Text("审批通过", style: TextStyle(fontSize: 28, color: Colors.grey)),
              ) : Container(
                margin: EdgeInsets.all(32.0),
                child: Text("审批不通过", style: TextStyle(fontSize: 28, color: Colors.grey)),
              ),
              SizedBox(height: 64),
              !isAdvance ? Container() : Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: RaisedButton(
                  child: Text("申请预支", style: TextStyle(color: Colors.white)),
                  color: Colors.deepOrangeAccent,
                  onPressed: () async{
                    await WalletManager.applyForAdvance(amount: availableAmount);
                    setState(() {
                      advanceModel = AdvanceModel(status: 0);
                    });
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  double availableAmount = 0.0;
  AdvanceModel advanceModel;
  _onRefresh() async {
    availableAmount = await WalletManager.availableAmount();
    advanceModel = await WalletManager.isAdvance();
    _refreshController.refreshFailed();
    setState(() {

    });
  }

//

}
