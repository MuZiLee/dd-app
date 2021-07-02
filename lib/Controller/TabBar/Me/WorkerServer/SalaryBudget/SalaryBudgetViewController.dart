

import 'package:auto_size_text/auto_size_text.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/AdvancePayments/AdvancePaymentsViewController.dart';
import 'package:one/Model/EventsStaff.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/StaffManager.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 工资预算
 */
class SalaryBudgetViewController extends StatefulWidget {
  @override
  _SalaryBudgetViewControllerState createState() => _SalaryBudgetViewControllerState();
}

class _SalaryBudgetViewControllerState extends State<SalaryBudgetViewController> {


  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: "工资预算",
        child: CardRefresher(
          refreshController: refreshController,
          onRefresh: _onRefresh,
          child: ListView.builder(itemBuilder: (_, index) {
            return _buildChild(_, index: index);
          },itemCount: events.length),
        )
    );
  }
  
  static List events = [];

  /**
   * TODO： 获取工时列表
   */
  _onRefresh() async {
    events = await StaffManager.getPunchTheClocklist();
    setState(() {});
  }

  _buildChild(BuildContext context, {int index}) {

    EventsStaff staff = events[index];
    
    return Container(
      child: Column(
        children: [
          Table(
            border: _border(),
            children: [
              TableRow(children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: AutoSizeText(Account.user.staff.factory.factory_name, minFontSize: 5, maxFontSize: 15, maxLines: 1, textAlign: TextAlign.left),
                      ),
                      Text("", style: TextStyle(fontSize: 13), textAlign: TextAlign.left),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(" ", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
                      Text(staff.create_time, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right),
                    ],
                  ),
                )
              ]),
              TableRow(children: [
                Container(
                    margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("工种：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                            Text(staff.signingInfo.cooperation_mode, style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("工价：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                            Text("${Account.user.staff.sigingInformation.employee_unit_price}元", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.left),
                          ],
                        )

                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text("工时数：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
                          Text("${staff.hour}小时", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                        ],
                      ),
                      staff.signingInfo.cooperation_mode == "小时工" ? _hourly(staff) : _epfew(staff)
                    ],
                  ),
                ),
              ]),
            ],
          ),
          Divider(height: 1.0)
        ],
      ),
    );
  }

  _epfew(EventsStaff staff) {

    //其他扣款
//    double

    //法定标准天数 20.83
    double standard_days_of_the_month = 20.83;
    // (员工单价 / 当月标准天数) / 8 * 工时
    double wage = staff.signingInfo.employee_unit_price / standard_days_of_the_month / 8 * staff.hour - staff.signingInfo.income_tax - staff.signingInfo.insurance_premium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text("预算工资：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
        Text("${wage.toStringAsFixed(2)}元", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
      ],
    );
  }

  _hourly(EventsStaff staff) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text("预算工资：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
        Text("${Account.user.staff.sigingInformation.employee_unit_price * staff.hour}元/小时", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
      ],
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

  _columnWidths() {
    return {
      //列宽
      0: FixedColumnWidth(85.0),
      2: FixedColumnWidth(85.0),
    };
  }

}
