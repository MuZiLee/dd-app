
import 'package:demo2020/Model/EventsPaySlipAgent.dart';
import 'package:demo2020/Model/PartenerPvivot.dart';
import 'package:demo2020/Provider/PaySlipManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class EditorAgentViewController extends StatefulWidget {

  EventsPaySlipAgent agent;

  EditorAgentViewController({this.agent});

  @override
  _EditorAgentViewControllerState createState() => _EditorAgentViewControllerState();
}

class _EditorAgentViewControllerState extends State<EditorAgentViewController> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "代理招聘工资条",
      child: GestureDetector(
        child: SingleChildScrollView(
          child: _build_Agent(),
        ),
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      ),
    );
  }

  _build_Agent() {
    if (widget.agent != null) {

//    签单价 = 签单价
      double sign_unit_price = double.parse(widget.agent.sign_unit_price);
//    税费 = 税费
      double taxes = double.parse(widget.agent.taxes);
//    业务员提成 = 签单价 * %
      double salesperson_commission = double.parse(widget.agent.salesperson_commission);
      salesperson_commission = sign_unit_price * (salesperson_commission / 100);
//    驻场老师提成 = 签单价 * %
      double resident_teacher_commission = double.parse(widget.agent.resident_teacher_commission);
      resident_teacher_commission = sign_unit_price * (resident_teacher_commission / 100);
//    管理费 = 管理费
      double management_fee = double.parse(widget.agent.management_fee);



      // 总收益 = 签单价 - 管理费 - 业务员提成 -  驻场老师提成 - 税费。
      double total_revenue = sign_unit_price - management_fee - salesperson_commission - resident_teacher_commission - taxes;

      // 可分配利润 = 总收益 - 10%管理费。（以后余下的90%为可分配的利润）。
      double distributable_profit = total_revenue - (management_fee * 0.1);

      int sid = widget.agent.staff.partenerPvivot.strategic.id;
      //初级分红比例
      double strategic_jp_dividend = double.parse(widget.agent.staff.partenerPvivot.strategic.jp_dividend);
      double jp_dividend = distributable_profit * (strategic_jp_dividend / 100);
      widget.agent.primary_dividend = jp_dividend.toStringAsFixed(2);
      //高级全红比例
      double strategic_sp_dividend = double.parse(widget.agent.staff.partenerPvivot.strategic.sp_dividend);
      double sp_dividend = distributable_profit * (strategic_sp_dividend / 100);
      widget.agent.advanced_dividend = sp_dividend.toStringAsFixed(2);
      //战略分红比例
      double strategic_sa_dividend = double.parse(widget.agent.staff.partenerPvivot.strategic.sa_dividend);
      double sa_dividend = distributable_profit * (strategic_sa_dividend / 100);
      widget.agent.strategic_dividend = sa_dividend.toStringAsFixed(2);
      //蛋蛋分红比例
      double strategic_dd_dividend = double.parse(widget.agent.staff.partenerPvivot.strategic.dd_dividend);
      double dd_dividend = distributable_profit * (strategic_dd_dividend / 100);widget.agent.dividend = dd_dividend.toStringAsFixed(2);

      print(dd_dividend);

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Column(
                children: [
                  SBImage(
                      url: widget.agent.staff.user.avatar,
                      width: 58,
                      height: 58,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(widget.agent.staff.user.username,
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
                _inputAction("税费", "${widget.agent.taxes}元"),
                Text('管理费',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction("管理费", "${widget.agent.management_fee}元"),
              ]),

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
                  child: Text("0.0元",
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
          ThemeButton(
            "提交",
            onPressed: () async {
              var data = widget.agent.toJson();
              data['type'] = "代理招聘工资条";

              PartenerPvivot partenerPvivot = widget.agent.staff.partenerPvivot;
              data['event'] = {
                'type': "代理招聘工资条",
                'tuid': widget.agent.teacher.uid,
                'fid': widget.agent.staff.fid,
                'jid': widget.agent.staff.jid,
                'uid': widget.agent.staff.uid,
                'pid': partenerPvivot.pid,
                'sid': partenerPvivot.sid
              };


              if (await PaySlipManager.addPaySlip(data)) {
                pop();
              }

            },
          )
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
  _inputAction(String title, String placeholder, {Color color = Colors.blue, TextInputType keyboardType = TextInputType.multiline}) {
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
//        if (title.contains("其他加项")) {
//          widget.agent.other_additions =
//              double.parse(value.length > 0 ? value : "0.0").toString();
//        }
//        if (title.contains("其他加项备注")) {
//          widget.agent.other_additions_remarks =
//              double.parse(value.length > 0 ? value : "0.0").toString();
//        }
//        if (title.contains("其他扣款")) {
//          widget.agent.other_deductions =
//              double.parse(value.length > 0 ? value : "0.0").toString();
//        }
//        if (title.contains("其他扣款备注")) {
//          widget.agent.other_deductions_remarks = value;
//        }
//
//        if (title.contains("保险费")) {
//          widget.agent.insurance =
//              double.parse(value.length > 0 ? value : "0.0").toString();
//        }
//        if (title.contains("税费")) {
//          widget.agent.taxes =
//              double.parse(value.length > 0 ? value : "0.0").toString();
//        }
//        if (title.contains("总工时")) {
//          widget.agent.total_working_hours =
//              double.parse(value.length > 0 ? value : "0.0").toString();
//        }

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
