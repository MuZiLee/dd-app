import 'package:date_format/date_format.dart';
import 'package:demo2020/Model/EventsPaySlipHourlyWorker.dart';
import 'package:demo2020/Model/FactoryStaff.dart';
import 'package:demo2020/Model/PartenerPvivot.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/PaySlipManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EditorHourlyWorkerViewController extends StatefulWidget {
//  Teacher teacher;
//  FactoryStaff staff;
  EventsPaySlipHourlyWorker hourlyWorker;

  EditorHourlyWorkerViewController({this.hourlyWorker});

  @override
  _EditorHourlyWorkerViewControllerState createState() =>
      _EditorHourlyWorkerViewControllerState();
}

class _EditorHourlyWorkerViewControllerState
    extends State<EditorHourlyWorkerViewController> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  var hour = 0;

  /**
   * TODO： 总工时
   */
  _onRefresh() async {
    hour = await PaySlipManager.findHour(widget.hourlyWorker.uid);
    refreshController.refreshCompleted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "小时工工资条",
      child: SmartRefresher(
        header: MaterialClassicHeader(distance: 80.0),
        controller: refreshController,
        onRefresh: _onRefresh,
        child: GestureDetector(
          child: SingleChildScrollView(
            child: _build_Hourly_work(),
          ),
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        ),
      ),
    );
  }

  _build_Hourly_work() {
    if (widget.hourlyWorker != null) {
      print(widget.hourlyWorker.actual_salary);

      //总工时
      int total_working_hours = hour;
      //员工单价
      double employee_unit_price =
          double.parse(widget.hourlyWorker.employee_unit_price);
      // 补助(备注)
      double other_additions =
          double.parse(widget.hourlyWorker.other_additions);
      //借款
      double loan = double.parse(widget.hourlyWorker.loan);
      //其他扣款(备注) -
      double other_deductions =
          double.parse(widget.hourlyWorker.other_deductions);
      //保险费
      double insurance = double.parse(widget.hourlyWorker.insurance);
      //税费 元
      double taxes = double.parse(widget.hourlyWorker.taxes);

      //实发工资
      //员工工资 = (总工时 * 员工单价) + 补助(备注) - 借款 - 其他扣款(备注) - 保险费
      double actual_salary = (total_working_hours * employee_unit_price) +
          other_additions -
          loan -
          other_deductions -
          insurance -
          taxes;
      widget.hourlyWorker.actual_salary = actual_salary.toString();

      //签单价 = 签单价
      double sign_unit_price =
          double.parse(widget.hourlyWorker.sign_unit_price);
      //业务员提成 元
      double salesperson_commission =
          double.parse(widget.hourlyWorker.salesperson_commission) *
              total_working_hours;
      //驻场老师提成 元
      double resident_teacher_commission =
          double.parse(widget.hourlyWorker.resident_teacher_commission) *
              total_working_hours;

      // 总收益 = 签单价 * 总工时 - 员工工资 - 业务员提成 -  驻场老师提成 - 税费。（他剩下的我们都叫总收益）
      double total_revenue = (sign_unit_price * total_working_hours) -
          actual_salary -
          salesperson_commission -
          resident_teacher_commission -
          taxes;
      // 10%管理费
      double management_fee =
          double.parse(widget.hourlyWorker.management_fee) * 0.1;

      // 可分配利润 = 总收益 - 10%管理费。（以后余下的90%为可分配的利润）。
      double distributable_profit = total_revenue - management_fee;

      int sid = widget.hourlyWorker.staff.partenerPvivot.strategic.id;
      //初级分红比例
      double strategic_jp_dividend = double.parse(
          widget.hourlyWorker.staff.partenerPvivot.strategic.jp_dividend);
      double jp_dividend = distributable_profit * (strategic_jp_dividend / 100);
      widget.hourlyWorker.primary_dividend = jp_dividend.toStringAsFixed(2);
      //高级全红比例
      double strategic_sp_dividend = double.parse(
          widget.hourlyWorker.staff.partenerPvivot.strategic.sp_dividend);
      double sp_dividend = distributable_profit * (strategic_sp_dividend / 100);
      widget.hourlyWorker.advanced_dividend = sp_dividend.toStringAsFixed(2);
      //战略分红比例
      double strategic_sa_dividend = double.parse(
          widget.hourlyWorker.staff.partenerPvivot.strategic.sa_dividend);
      double sa_dividend = distributable_profit * (strategic_sa_dividend / 100);
      widget.hourlyWorker.strategic_dividend = sa_dividend.toStringAsFixed(2);
      //蛋蛋分红比例
      double strategic_dd_dividend = double.parse(
          widget.hourlyWorker.staff.partenerPvivot.strategic.dd_dividend);
      double dd_dividend = distributable_profit * (strategic_dd_dividend / 100);
      widget.hourlyWorker.dividend = dd_dividend.toStringAsFixed(2);

      print(dd_dividend);

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Column(
                children: [
                  SBImage(
                      url: widget.hourlyWorker.staff.user.avatar,
                      width: 58,
                      height: 58,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(widget.hourlyWorker.staff.user.username,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
            ),
          ),
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
                Text("${widget.hourlyWorker.employee_unit_price}/小时",
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
                Text("${total_working_hours}小时",
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
            },
            children: [
              TableRow(children: [
                Text('其他加项',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction(
                    "其他加项", "${widget.hourlyWorker.other_deductions}元", color: Colors.blue),
                _inputAction("其他加项备注", "备注",
                    color: Colors.grey, keyboardType: TextInputType.text),
              ])
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.0),
            child: Text('减项',
                style: TextStyle(
                    color: Colors.red,
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
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction("税费", "${widget.hourlyWorker.taxes}元"),
                Text('保险费',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction("保险费", "${widget.hourlyWorker.insurance}元"),
              ]),
              TableRow(children: [
                Text('借款',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                Text("${widget.hourlyWorker.loan}元",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none)),
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
            },
            children: [
              TableRow(children: [
                Container(
                  height: 21,
                  child: Text('其他扣款',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),
                _inputAction(
                    "其他扣款", "${widget.hourlyWorker.other_deductions}元"),
                _inputAction("其他扣款备注", "备注",
                    color: Colors.grey, keyboardType: TextInputType.text),
              ])
            ],
          ),
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
              0: FixedColumnWidth(70.0),
            },
            children: [
              TableRow(children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text('合计：',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("${widget.hourlyWorker.actual_salary}元",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none)),
                ),
              ])
            ],
          ),
          SizedBox(height: 64.0),
          widget.hourlyWorker.status == 0
              ? ThemeButton(
                  "提交",
                  onPressed: () async {
                    var data = widget.hourlyWorker.toJson();
                    data['type'] = "小时工工资条";

                    PartenerPvivot partenerPvivot =
                        widget.hourlyWorker.staff.partenerPvivot;
                    data['event'] = {
                      'type': "小时工工资条",
                      'tuid': widget.hourlyWorker.teacher.uid,
                      'fid': widget.hourlyWorker.staff.fid,
                      'jid': widget.hourlyWorker.staff.jid,
                      'uid': widget.hourlyWorker.staff.uid,
                      'pid': partenerPvivot.pid,
                      'sid': partenerPvivot.sid
                    };

                    if (await PaySlipManager.addPaySlip(data)) {
                      pop();
                    }
                  },
                )
              : Container()
        ],
      );
    } else {
      return Error404View();
    }
  }

  /**
   * 小时工 - 计算工资
   * 签单价 = 签单价
   * 保险费 = 保险费
   * 税费 = 税费
   * 借款 = 借款
   * 补助 = 补助。（驻场老师录入）
   * 其他扣款 = （驻场老师录入）
   * 员工单价 = 员工单价。
   * 员工工资  =  (总工时 * 员工单价) + 补助(备注) - 借款 - 其他扣款(备注) - 保险费
   */
  _inputAction(String title, String placeholder,
      {Color color = Colors.red,
      TextInputType keyboardType = TextInputType.multiline}) {
    return CupertinoTextField(
      placeholder: placeholder,
      placeholderStyle: TextStyle(fontSize: 12, color: color),
      clearButtonMode: OverlayVisibilityMode.editing,
      textAlign: TextAlign.start,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.top,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      style: TextStyle(fontSize: 12),
      onChanged: (value) {
        if (title == "其他加项") {
          widget.hourlyWorker.other_additions =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title == "其他加项备注") {
          widget.hourlyWorker.other_additions_remarks =
              value.length > 0 ? value : "暂无";
        }
        if (title == "其他扣款") {
          widget.hourlyWorker.other_deductions =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title == "其他扣款备注") {
          widget.hourlyWorker.other_deductions_remarks =
              value.length > 0 ? value : "暂无";
        }

        if (title.contains("保险费")) {
          widget.hourlyWorker.insurance =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("税费")) {
          widget.hourlyWorker.taxes =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("总工时")) {
          widget.hourlyWorker.total_working_hours =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }

        setState(() {});
      },
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
}
