
import 'package:one/Model/EventsPaySlipEpfew.dart';
import 'package:one/Model/PartenerPvivot.dart';
import 'package:one/Provider/PaySlipManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/**
 * 同工同酬
 */
class EditorEpfewViewController extends StatefulWidget {

  EventsPaySlipEpfew epfew;
  EditorEpfewViewController({this.epfew});

  @override
  _EditorEpfewViewControllerState createState() => _EditorEpfewViewControllerState();
}

class _EditorEpfewViewControllerState extends State<EditorEpfewViewController> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "同工同酬工资条",
      child: GestureDetector(
        child: SingleChildScrollView(
          child: _build_epfew(),
        ),
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      ),
    );
  }

  _build_epfew() {
    if (widget.epfew != null) {
      /**
          签单价 = 签单价
          借款 = 借款
          其他加项 = 其他加项（备注）
          其他扣款 = 其他扣款（备注）
          员工单价 = 员工单价
          业务员提成 = 签单价 * %
          驻场老师提成 = 签单价 * %

          overtime_pay 平时加班工时
          weekend_overtime_pay
          overtim_pay_on_holidays
          加项工资 = (平时加班工时 * 平时加班工资) + (周末加班*周末加班工资) + (法定假日加班工时*法定节假日加班工资) + 其他加项。
          代扣代缴款项 = 伙食费 + 税金 + 社保费 + 公积金 + 其他扣款.
          员工工资 = (员工单价 / 当月标准天数 * 实际出勤天数) + 加项工资 - 代扣代缴款项。
       */
//    签单价 = 签单价
      double sign_unit_price = double.parse(widget.epfew.sign_unit_price);
      // 员工单价 = 员工单价
      double employee_unit_price = double.parse(widget.epfew.employee_unit_price);


//    业务员提成 = 签单价 * %
      double salesperson_commission = double.parse(widget.epfew.salesperson_commission);
      salesperson_commission = sign_unit_price * (salesperson_commission / 100);
//    驻场老师提成 = 签单价 * %
      double resident_teacher_commission = double.parse(widget.epfew.resident_teacher_commission);
      resident_teacher_commission = sign_unit_price * (resident_teacher_commission / 100);



      /// 加项
      // 平时加班工时
      double overtime_work = double.parse(widget.epfew.overtime_work);
      // 平时加班工资
      double overtime_pay = double.parse(widget.epfew.overtime_pay);
      overtime_pay = overtime_pay * overtime_work;

      // 周末加班工时
      double overtime_work_on_weekends = double.parse(widget.epfew.overtime_work_on_weekends);
      double eeekend_overtime_pay = double.parse(widget.epfew.eeekend_overtime_pay);

      // 法定节假日加班工时
      double working_overtime_on_holidays = double.parse(widget.epfew.working_overtime_on_holidays);
      double overtime_pay_on_holidays = double.parse(widget.epfew.overtime_pay_on_holidays);

      // 其他加项 = 其他加项（备注）
      double other_additions = double.parse(widget.epfew.other_additions);

      // 加项工资 = (平时加班工时 * 平时加班工资) + (周末加班*周末加班工资) + (法定假日加班工时*法定节假日加班工资) + 其他加项。
      double additional_salary = (overtime_work * overtime_pay) + (overtime_work_on_weekends * eeekend_overtime_pay) + (working_overtime_on_holidays * overtime_pay_on_holidays) + other_additions;

      /// 扣款
      // 伙食费
      double food_expenses = double.parse(widget.epfew.food_expenses);
      // 公积金
      double provident_fund = double.parse(widget.epfew.provident_fund);
      // 社保费
      double social_security_charges = double.parse(widget.epfew.social_security_charges);
      // 税费
      double taxes = double.parse(widget.epfew.taxes);

      //借款
      double loan = double.parse(widget.epfew.loan);
      // 其他扣款 = 其他扣款（备注）
      double other_deductions = double.parse(widget.epfew.other_deductions);

      // 代扣代缴款项 = 伙食费 + 社保费 + 公积金 + 税金 + 其他扣款.
      double withholding_payments = food_expenses + social_security_charges + provident_fund + taxes + other_deductions + loan;

      // 当月标准天数
      double standard_days_of_the_month = double.parse(widget.epfew.standard_days_of_the_month);
      // 实际出勤天数
      double actual_attendance_days = double.parse(widget.epfew.actual_attendance_days);

      /// 员工工资 = (员工单价 / 当月标准天数 * 实际出勤天数) + 加项工资 - 代扣代缴款项。
      double employee_salary = (employee_unit_price / standard_days_of_the_month * actual_attendance_days) + additional_salary - withholding_payments;
      employee_salary = double.parse(employee_salary.toStringAsFixed(2));
      widget.epfew.actual_salary = employee_salary.toStringAsFixed(2);

      ///    管理费 = 管理费
      double management_fee = double.parse(widget.epfew.management_fee);

      /// 总收益 = 签单价 - 管理费 - 业务员提成 -  驻场老师提成 - 税费。
      double total_revenue = sign_unit_price - management_fee - salesperson_commission - resident_teacher_commission - taxes;

      /// 可分配利润 = 总收益 - 10%管理费。（以后余下的90%为可分配的利润）。
      double distributable_profit = total_revenue - (management_fee * 0.1);

      int sid = widget.epfew.staff.partenerPvivot.strategic.id;
      ///初级分红比例
      double strategic_jp_dividend = double.parse(widget.epfew.staff.partenerPvivot.strategic.jp_dividend);
      double jp_dividend = distributable_profit * (strategic_jp_dividend / 100);
      widget.epfew.primary_dividend = jp_dividend.toStringAsFixed(2);
      ///高级全红比例
      double strategic_sp_dividend = double.parse(widget.epfew.staff.partenerPvivot.strategic.sp_dividend);
      double sp_dividend = distributable_profit * (strategic_sp_dividend / 100);
      widget.epfew.advanced_dividend = sp_dividend.toStringAsFixed(2);
      ///战略分红比例
      double strategic_sa_dividend = double.parse(widget.epfew.staff.partenerPvivot.strategic.sa_dividend);
      double sa_dividend = distributable_profit * (strategic_sa_dividend / 100);
      widget.epfew.strategic_dividend = sa_dividend.toStringAsFixed(2);
      ///蛋蛋分红比例
      double strategic_dd_dividend = double.parse(widget.epfew.staff.partenerPvivot.strategic.dd_dividend);
      double dd_dividend = distributable_profit * (strategic_dd_dividend / 100);widget.epfew.dividend = dd_dividend.toStringAsFixed(2);

      print(dd_dividend);

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Column(
                children: [
                  SBImage(
                      url: widget.epfew.staff.user.avatar,
                      width: 58,
                      height: 58,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(widget.epfew.staff.user.username,
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
                Text("${widget.epfew.employee_unit_price}元",
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
                _inputAction("税费", "${widget.epfew.taxes}元"),
                Text('管理费',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction("管理费", "${widget.epfew.management_fee}元"),
              ]),
              TableRow(children: [
                Text('当月标准天数',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction("当月标准天数", "${widget.epfew.standard_days_of_the_month}天"),
                Text('实际出勤天数',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                _inputAction("实际出勤天数", "${widget.epfew.actual_attendance_days}天"),
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
                  _inputAction("平时加班工时", "${widget.epfew.overtime_work}小时"),
                  Text('平时加班工资',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                  _inputAction("平时加班工资", "${widget.epfew.overtime_pay}元"),
                ]
              ),
              TableRow(
                  children: [
                    Text('周末加班工时',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                    _inputAction("周末加班工时", "${widget.epfew.overtime_work_on_weekends}小时"),
                    Text('周末加班工资',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                    _inputAction("周末加班工资", "${widget.epfew.eeekend_overtime_pay}元"),
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
                    _inputAction("法定假日加班工时", "${widget.epfew.working_overtime_on_holidays}小时"),
                    Text('法定假日加班工资',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                    _inputAction("法定假日加班工资", "${widget.epfew.overtime_pay_on_holidays}元"),
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
                    _inputAction("其他加项", "${widget.epfew.other_additions}元"),
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
                    _inputAction("其他加项备注", "${widget.epfew.other_additions_remarks}"),
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
                    _inputAction("伙食费", "${widget.epfew.food_expenses}元"),
                    Text('社保费',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                    _inputAction("社保费", "${widget.epfew.social_security_charges}"),
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
                    _inputAction("公积金", "${widget.epfew.provident_fund}元"),
                    Text('税金',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center),
                    _inputAction("税金", "${widget.epfew.taxes}元"),
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
                    Text("${widget.epfew.loan}元",
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
                  _inputAction("其他扣款", "${widget.epfew.other_deductions}元")
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
                  _inputAction("其他扣款备注备注", "${widget.epfew.other_deductions_remarks}")
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
              0: FixedColumnWidth(100.0),
            },
            children: [
              TableRow(children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text('实发工资：',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("${employee_salary}元",
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
              var data = widget.epfew.toJson();
              data['type'] = "同工同酬工资条";

              PartenerPvivot partenerPvivot = widget.epfew.staff.partenerPvivot;
              data['event'] = {
                'type': "同工同酬工资条",
                'tuid': widget.epfew.teacher.uid,
                'fid': widget.epfew.staff.fid,
                'jid': widget.epfew.staff.jid,
                'uid': widget.epfew.staff.uid,
                'pid': partenerPvivot.pid,
                'sid': partenerPvivot.sid
              };


              if (await PaySlipManager.addPaySlip(data)) {
                pop();
              }

            },
          ),
          SizedBox(height: 64.0),
        ],
      );
    } else {
      return Error404View();
    }
  }

  /**
      签单价 = 签单价
      借款 = 借款
      其他加项 = 其他加项（备注）
      其他扣款 = 其他扣款（备注）
      员工单价 = 员工单价
      业务员提成 = 签单价 * %
      驻场老师提成 = 签单价 * %

      overtime_pay 平时加班工时
      weekend_overtime_pay
      overtim_pay_on_holidays
      加项工资 = (平时加班工时 * 平时加班工资) + (周末加班*周末加班工资) + (法定假日加班工时*法定节假日加班工资) + 其他加项。
      代扣代缴款项 = 伙食费 + 税金 + 社保费 + 公积金 + 其他扣款.
      员工工资 = (员工单价 / 当月标准天数 * 实际出勤天数) + 加项工资 - 代扣代缴款项。
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
        if (title.contains("税费")) {
          widget.epfew.taxes = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("管理费")) {
          widget.epfew.management_fee = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("当月标准天数")) {
          widget.epfew.standard_days_of_the_month = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("实际出勤天数")) {
          widget.epfew.actual_attendance_days = double.parse(value.length > 0 ? value : "0.0").toString();
        }


        if (title.contains("平时加班工时")) {
          widget.epfew.overtime_work = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("平时加班工资")) {
          widget.epfew.overtime_pay = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("周末加班工时")) {
          widget.epfew.overtime_work_on_weekends = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("周末加班工资")) {
          widget.epfew.eeekend_overtime_pay = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("法定假日加班工时")) {
          widget.epfew.working_overtime_on_holidays = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("法定假日加班工资")) {
          widget.epfew.overtime_pay_on_holidays = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("其他加项")) {
          widget.epfew.other_additions =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("其他加项备注")) {
          widget.epfew.other_additions_remarks =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }

        if (title.contains("伙食费")) {
          widget.epfew.food_expenses = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("社保费")) {
          widget.epfew.social_security_charges = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("公积金")) {
          widget.epfew.provident_fund = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("税金")) {
          widget.epfew.taxes = double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("其他扣款")) {
          widget.epfew.other_deductions =
              double.parse(value.length > 0 ? value : "0.0").toString();
        }
        if (title.contains("其他扣款备注")) {
          widget.epfew.other_deductions_remarks = value;
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
