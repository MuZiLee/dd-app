import 'package:demo2020/Model/FactoryStaff.dart';
import 'package:demo2020/Model/User.dart';

class EventsPaySlipHourlyWorker {


  String sign_unit_price; //签单价
  String employee_unit_price; //员工单价


  String other_deductions; //其他扣款
  String other_deductions_remarks; //其他扣款备注
  String other_additions; //其他加项
  String other_additions_remarks; //其他加项备注

  String insurance; //保险费
  String loan; //借款
  String taxes; //税费

  String management_fee; // 管理费

  String total_working_hours; //总工时

  String resident_teacher_commission; //驻场老师提成
  String salesperson_commission; //业务员提成

  String primary_dividend; //初级分红
  String advanced_dividend; //高级分红
  String strategic_dividend; //战略分红
  String dividend; //蛋蛋分红



  String actual_salary;//实发工资

  int uid;
  int id;
  int status; //财务是否审核
  String settlement_method; //结算方式
  String create_time;

  FactoryStaff staff;
  Teacher teacher;

  EventsPaySlipHourlyWorker({
    this.advanced_dividend = "0.0",
    this.create_time,
    this.dividend = "0.0",
    this.employee_unit_price = "0.0",
    this.id,
    this.insurance = "0.0",
    this.loan = "0.0",
    this.other_deductions = "0.0",
    this.other_deductions_remarks = "暂无",
    this.other_additions = "0.0",
    this.other_additions_remarks = "暂无",

    this.primary_dividend = "0.0",
    this.resident_teacher_commission = "0.0",
    this.salesperson_commission = "0.0",
    this.settlement_method = "",
    this.sign_unit_price = "0.0",
    this.status = 0,
    this.strategic_dividend = "0.0",
    this.taxes = "0.0",
    this.management_fee = "0.0",
    this.total_working_hours = "0.0",
    this.actual_salary = "0.0",
    this.uid = 0,
    this.staff,
  });

  factory EventsPaySlipHourlyWorker.fromJson(Map<String, dynamic> json) {
    return EventsPaySlipHourlyWorker(
      advanced_dividend: json['advanced_dividend'],
      create_time: json['create_time'],
      dividend: json['dividend'],
      employee_unit_price: json['employee_unit_price'],
      id: json['id'],
      insurance: json['insurance'],
      loan: json['loan'],
      other_deductions: json['other_deductions'],
      other_deductions_remarks: json['other_deductions_remarks'],
      other_additions: json['other_additions'],
      other_additions_remarks: json['other_additions_remarks'],
      primary_dividend: json['primary_dividend'],
      resident_teacher_commission: json['resident_teacher_commission'],
      salesperson_commission: json['salesperson_commission'],
      settlement_method: json['settlement_method'],
      sign_unit_price: json['sign_unit_price'],
      status: json['status'],
      actual_salary: json['actual_salary'],
      strategic_dividend: json['strategic_dividend'],
      taxes: json['taxes'],
      management_fee: json['management_fee'],
      total_working_hours: json['total_working_hours'],
      uid: json['uid'],
      staff: json['staff'] != null ? FactoryStaff.fromJson(json['staff']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advanced_dividend'] = this.advanced_dividend;
    data['create_time'] = this.create_time;
    data['dividend'] = this.dividend;
    data['employee_unit_price'] = this.employee_unit_price;
    data['insurance'] = this.insurance;
    data['loan'] = this.loan;
    data['other_deductions'] = this.other_deductions;
    data['other_deductions_remarks'] = this.other_deductions_remarks;
    data['other_additions'] = this.other_additions;
    data['other_additions_remarks'] = this.other_additions_remarks;
    data['primary_dividend'] = this.primary_dividend;
    data['resident_teacher_commission'] = this.resident_teacher_commission;
    data['salesperson_commission'] = this.salesperson_commission;
    data['settlement_method'] = this.settlement_method;
    data['sign_unit_price'] = this.sign_unit_price;
    data['strategic_dividend'] = this.strategic_dividend;
    data['actual_salary'] = this.actual_salary;
    data['taxes'] = this.taxes;
    data['management_fee'] = this.management_fee;
    data['total_working_hours'] = this.total_working_hours;
    data['uid'] = this.uid;
//    if (this.staff != null) {
//      data['staff'] = this.staff.toJson();
//    }
    return data;
  }
}
