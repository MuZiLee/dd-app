
import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo2020/Model/EventsPaySlip.dart';
import 'package:demo2020/Model/EventsPaySlipAgent.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/PaySlipManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPaySlipViewController extends StatefulWidget {
  @override
  _MyPaySlipViewControllerState createState() => _MyPaySlipViewControllerState();
}

class _MyPaySlipViewControllerState extends State<MyPaySlipViewController> {

  int hour = 0;

  _onRefresh() async {
    myPaySliplist = await PaySlipManager.myPaySliplist();
    hour = await PaySlipManager.findHour(Account.user.id);
    _refreshController.refreshFailed();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "我的工资条",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: myPaySliplist.length > 0 ? CardRefresherListView(
          itemCount: myPaySliplist.length,
          itemBuilder: (_, index) {

            EventsPaySlip paySlip = myPaySliplist[index];


            Widget child = Container();
            if (paySlip.type == "小时工工资条") {
              child = _slip(paySlip);
            }
            if (paySlip.type == "同工同酬工资条") {
              child = _slip_epfew(paySlip);
            }
            if (paySlip.type == "代理招聘工资条") {
              child = _slip_agent(paySlip);
            }



            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Color(0xFFFAFAFA),
                  child: child,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: Text(paySlip.create_time, style: TextStyle(fontSize: 12), textAlign: TextAlign.right),
                ),
                Divider(height: 1.0)
              ],
            );

          },
        ) : Error404View(),
      ),
    );
  }

  _slip(EventsPaySlip paySlip) {
    if (paySlip.type.contains("小时工")) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.0),
            child: Text('工时',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.left),
          ),
          Table(
            border: _border(),
            children: [
              TableRow(children: [
                Text('工价',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("${paySlip.slip.employee_unit_price}/小时",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text('总工时',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("${hour}小时",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ]),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.0),
            child: Text('加项',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.left),
          ),
          Table(
            border: _border(),
            columnWidths: {
              //列宽
              0: FixedColumnWidth(70.0),
              1: FixedColumnWidth(70.0),
              2: FixedColumnWidth(50.0),
            },
            children: [
              TableRow(children: [
                Text('其他加项',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("${paySlip.slip.other_additions}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("备注",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                AutoSizeText(paySlip.slip.other_additions_remarks,
                    minFontSize: 5,
                    maxFontSize: 12,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ])
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.0),
            child: Text('减项',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.left),
          ),
          Table(
            border: _border(),
            columnWidths: {
              //列宽
              0: FixedColumnWidth(70.0),
              2: FixedColumnWidth(70.0),
            },
            children: [
              TableRow(children: [
                Text('税费',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("-${paySlip.slip.taxes}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text('保险费',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("-${paySlip.slip.insurance}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ]),
              TableRow(children: [
                Text('预支',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("-${paySlip.slip.loan}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none)
                    ,textAlign: TextAlign.center),
                Text(' ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text(' ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ]),
            ],
          ),
          SizedBox(height: 15),
          Table(
            border: _border(),
            columnWidths: {
              //列宽
              0: FixedColumnWidth(70.0),
              1: FixedColumnWidth(70.0),
              2: FixedColumnWidth(50.0),
            },
            children: [
              TableRow(children: [
                Container(
                  height: 21,
                  child: Text('其他扣款',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),
                Text("-${paySlip.slip.other_deductions}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("备注",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                AutoSizeText(paySlip.slip.other_deductions_remarks,
                    minFontSize: 5,
                    maxFontSize: 12,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ])
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.0),
            child: Text(' ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.left),
          ),
          Table(
            border: _border(),
            columnWidths: {
              //列宽
              0: FixedColumnWidth(80.0),
              2: FixedColumnWidth(100.0),
            },
            children: [
              TableRow(children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text('实发工资',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text("${paySlip.slip.actual_salary}元",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none)),
                ),
                paySlip.status == 0 ? InkWell(
                  child: Container(
                    color: Colors.deepOrange,
                    padding: EdgeInsets.all(5.0),
                    child: Text("确认",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    CardShowActionSheetController(
                        context,
                        title: "工资条",
                        subtitle: "选择操作",
                        actions: [
                        CupertinoActionSheetAction(
                          child: Text("确认"),
                          onPressed: () async{
                            pop();
                            await PaySlipManager.confirmPaySlip(id: paySlip.id);
                            setState(() {
                              _onRefresh();
                            });
                          },
                        )
                    ]);
                  },
                ) : Container(
                  child: Text("已确认",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),

              ])
            ],
          ),
        ],
      );
    }
  }

  _slip_agent(EventsPaySlip agent) {
    if (agent != null) {

//    签单价 = 签单价
      double sign_unit_price = double.parse(agent.slip.sign_unit_price);
//    税费 = 税费
      double taxes = double.parse(agent.slip.taxes);
//    业务员提成 = 签单价 * %
      double salesperson_commission = double.parse(agent.slip.salesperson_commission);
      salesperson_commission = sign_unit_price * (salesperson_commission / 100);
//    驻场老师提成 = 签单价 * %
      double resident_teacher_commission = double.parse(agent.slip.resident_teacher_commission);
      resident_teacher_commission = sign_unit_price * (resident_teacher_commission / 100);
//    管理费 = 管理费
      double management_fee = double.parse(agent.slip.management_fee);



//      // 总收益 = 签单价 - 管理费 - 业务员提成 -  驻场老师提成 - 税费。
//      double total_revenue = sign_unit_price - management_fee - salesperson_commission - resident_teacher_commission - taxes;
//
//      // 可分配利润 = 总收益 - 10%管理费。（以后余下的90%为可分配的利润）。
//      double distributable_profit = total_revenue - (management_fee * 0.1);
//
//      int sid = agent.slip.staff.partenerPvivot.strategic.id;
//      //初级分红比例
//      double strategic_jp_dividend = double.parse(agent.slip.staff.partenerPvivot.strategic.jp_dividend);
//      double jp_dividend = distributable_profit * (strategic_jp_dividend / 100);
//      agent.slip.primary_dividend = jp_dividend.toStringAsFixed(2);
//      //高级全红比例
//      double strategic_sp_dividend = double.parse(agent.slip.staff.partenerPvivot.strategic.sp_dividend);
//      double sp_dividend = distributable_profit * (strategic_sp_dividend / 100);
//      agent.slip.advanced_dividend = sp_dividend.toStringAsFixed(2);
//      //战略分红比例
//      double strategic_sa_dividend = double.parse(agent.slip.staff.partenerPvivot.strategic.sa_dividend);
//      double sa_dividend = distributable_profit * (strategic_sa_dividend / 100);
//      agent.slip.strategic_dividend = sa_dividend.toStringAsFixed(2);
//      //蛋蛋分红比例
//      double strategic_dd_dividend = double.parse(agent.slip.staff.partenerPvivot.strategic.dd_dividend);
//      double dd_dividend = distributable_profit * (strategic_dd_dividend / 100);
//      agent.slip.dividend = dd_dividend.toStringAsFixed(2);
//
//      print(dd_dividend);

      return Column(
        children: [

          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.0),
            child: Text('基础',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.left),
          ),

          Table(
            border: _border(),
            columnWidths: {
              //列宽
              0: FixedColumnWidth(70.0),
              2: FixedColumnWidth(70.0),
            },
            children: [
              TableRow(children: [
                Text('税费',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text(agent.slip.taxes,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text('管理费',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text(agent.slip.management_fee,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ]),

            ],
          ),

          SizedBox(height: 15),

//          Container(
//            width: double.infinity,
//            margin: EdgeInsets.only(left: 10.0),
//            child: Text('合计',
//                style: TextStyle(
//                    color: Colors.black,
//                    fontWeight: FontWeight.normal,
//                    fontSize: 12,
//                    decoration: TextDecoration.none),
//                textAlign: TextAlign.left),
//          ),

//          Table(
//            border: _border(),
//            columnWidths: {
//              //列宽
//              0: FixedColumnWidth(70.0),
//            },
//            children: [
//              TableRow(children: [
//                Container(
//                  margin: EdgeInsets.all(10.0),
//                  child: Text('合计：',
//                      style: TextStyle(
//                          color: Colors.red,
//                          fontWeight: FontWeight.normal,
//                          fontSize: 12,
//                          decoration: TextDecoration.none),
//                      textAlign: TextAlign.center),
//                ),
//                Container(
//                  margin: EdgeInsets.all(10.0),
//                  child: Text("0.0元",
//                      style: TextStyle(
//                          color: Colors.red,
//                          fontWeight: FontWeight.normal,
//                          fontSize: 12,
//                          decoration: TextDecoration.none)),
//                ),
//              ])
//            ],
//          ),
        ],
      );
    } else {
      return Error404View();
    }
  }

  _slip_epfew(EventsPaySlip epfew) {
    return Column(
      children: [

        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0),
          child: Text('基础',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.left),
        ),
        Table(
          border: _border(),
          children: [
            TableRow(children: [
              Text('员工单价',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              Text("${epfew.slip.employee_unit_price}元",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.left),
              Text(' ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              Text(" "),
            ]),
            TableRow(children: [
              Text('税费',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              Text("${epfew.slip.taxes}元",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),

              Text('管理费',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              Text("${epfew.slip.management_fee}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),

            ]),
            TableRow(children: [
              Text('当月标准天数',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              Text("${epfew.slip.standard_days_of_the_month}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),

              Text('实际出勤天数',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              Text("${epfew.slip.actual_attendance_days}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),

            ]),
          ],
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0),
          child: Text('加项工资',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.left),
        ),
        Table(
          border: _border(),
          children: [
            TableRow(
                children: [
                  Text('平时加班工时',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.overtime_work}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                  Text('平时加班工资',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.overtime_pay}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                ]
            ),
            TableRow(
                children: [
                  Text('周末加班',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.overtime_work_on_weekends}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                  Text('周末加班工资',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.eeekend_overtime_pay}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                ]
            ),

            TableRow(
                children: [
                  Text('法定假日加班工时',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.working_overtime_on_holidays}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text('法定节假日加班工资',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.overtime_pay_on_holidays}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            ),

          ],
        ),
        Table(
          border: _border(),
          columnWidths: {
            0: FixedColumnWidth(100.0),
          },
          children: [
            TableRow(
                children: [
                  Text('其他加项',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.other_additions}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            ),
            TableRow(
                children: [
                  Text('其他加项备注',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.other_additions_remarks}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0),
          child: Text('减项工资',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.left),
        ),
        Table(
          border: _border(),
          children: [
            TableRow(
                children: [
                  Text('伙食费',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.food_expenses}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                  Text('社保费',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.social_security_charges}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            ),
            TableRow(
                children: [
                  Text('公积金',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.provident_fund}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                  Text('税金',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.taxes}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),

                ]
            ),
            TableRow(
                children: [
                  Text('借款',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.loan}元",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text(' ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text(' ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            ),
          ],
        ),
        Table(
          border: _border(),
          columnWidths: {
            0: FixedColumnWidth(100.0),
          },
          children: [
            TableRow(
                children: [
                  Text('其他扣款',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.other_deductions}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            ),
            TableRow(
                children: [
                  Text('其他扣款备注',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  Text("${epfew.slip.other_deductions_remarks}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ]
            )
          ],
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0),
          child: Text('合计',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.left),
        ),
        Table(
          border: _border(),
          columnWidths: {
            //列宽
            0: FixedColumnWidth(80.0),
            2: FixedColumnWidth(100.0),
          },
          children: [
            TableRow(children: [
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text('实发工资',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text("${epfew.slip.actual_salary}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none)),
              ),
              epfew.status == 0 ? InkWell(
                child: Container(
                  color: Colors.deepOrange,
                  padding: EdgeInsets.all(5.0),
                  child: Text("确认",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),
                onTap: () {
                  CardShowActionSheetController(
                      context,
                      title: "工资条",
                      subtitle: "选择操作",
                      actions: [
                        CupertinoActionSheetAction(
                          child: Text("确认"),
                          onPressed: () async{
                            pop();
                            await PaySlipManager.confirmPaySlip(id: epfew.id);
                            setState(() {
                              _onRefresh();
                            });
                          },
                        )
                      ]);
                },
              ) : Container(
                child: Text("已确认",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ),

            ])
          ],
        ),
      ],
    );
  }



  _border() {
    //表格边框样式
    return TableBorder.all(
      color: Colors.grey,
      width: 0.5,
      style: BorderStyle.solid,
    );
  }

  List myPaySliplist = [];
  RefreshController _refreshController = RefreshController(initialRefresh: true);
}
