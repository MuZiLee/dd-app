

import 'package:one/Model/FactoryStaff.dart';
import 'package:one/Model/User.dart';

class EventsPaySlipEpfew {
  String sign_unit_price; //签单价
  String employee_unit_price; //员工单价

  String primary_dividend; //初级分红
  String advanced_dividend; //高级分红
  String strategic_dividend; //战略分红
  String dividend; //蛋蛋分红

  String resident_teacher_commission; //驻场老师提成
  String salesperson_commission; //业务员提成

  String management_fee;//管理费

  String standard_days_of_the_month; //当月标准天数
  String actual_attendance_days; //实际出勤天数

  String overtime_work = "0"; //平时加班工时
  String overtime_pay = "0.0"; //平时加班工资
  String overtime_work_on_weekends = "0"; //周末加班工时
  String eeekend_overtime_pay = "0.0"; //周末加班工资
  String working_overtime_on_holidays = "0"; //法定节假日加班工时
  String overtime_pay_on_holidays = "0.0"; //法定节假日加班工资

  String other_additions = "0.0"; //其他加项
  String other_additions_remarks = "暂无"; //其他加项（备注）


  String other_deductions = "0.0"; //其他扣款
  String other_deductions_remarks = "暂无"; //其他扣款（备注）

  String withholding_payments = "0.0"; //代扣代缴款项

  String loan = "0.0"; //借款
  String food_expenses = "0.0"; //伙食费
  String provident_fund = "0.0"; //公积金
  String social_security_charges = "0.0"; //社保费
  String taxes = "0.0"; //税费

  String actual_salary = "0.0";//实发工资

  int id;
  String create_time;
  String settlement_method; //结算方式

  int status; //财务是否审核
  int uid; //员工ID

  Teacher teacher;
  FactoryStaff staff;



  EventsPaySlipEpfew({
    this.actual_attendance_days = "20.83",
    // 年工作日：365天-104天(休息日)-11天(法定节假日)=250天
    // 250天÷4季=62.5天/季
    // 250天÷12月=20.83天/月
    this.standard_days_of_the_month = "20.83",
    this.advanced_dividend = "0.0",
    this.create_time = "",
    this.dividend = "0.0",
    this.eeekend_overtime_pay = "0.0",
    this.employee_unit_price = "0.0",
    this.food_expenses = "0.0",
    this.id,
    this.loan = "0.0",
    this.management_fee = "0.0",
    this.other_additions = "0.0",
    this.other_additions_remarks = "暂无",
    this.other_deductions = "0.0",
    this.other_deductions_remarks = "暂无",
    this.overtime_pay = "0.0",
    this.overtime_pay_on_holidays = "0.0",
    this.overtime_work = "0.0",
    this.overtime_work_on_weekends = "0.0",
    this.primary_dividend = "0.0",
    this.provident_fund = "0.0",
    this.resident_teacher_commission = "0.0",
    this.salesperson_commission = "0.0",
    this.settlement_method = "",
    this.sign_unit_price = "0.0",
    this.social_security_charges = "0.0",
    this.actual_salary = "0.0",
    this.status = 0,
    this.strategic_dividend = "0.0",
    this.taxes = "0.0",
    this.uid = 0,
    this.withholding_payments = "0.0",
    this.working_overtime_on_holidays = "0.0",
  });

  factory EventsPaySlipEpfew.fromJson(Map<String, dynamic> json) {
    return EventsPaySlipEpfew(
      actual_attendance_days: json['actual_attendance_days'],
      advanced_dividend: json['advanced_dividend'],
      create_time: json['create_time'],
      dividend: json['dividend'],
      eeekend_overtime_pay: json['eeekend_overtime_pay'],
      employee_unit_price: json['employee_unit_price'],
      food_expenses: json['food_expenses'],
      id: json['id'],
      loan: json['loan'],
      actual_salary: json['actual_salary'],
      management_fee: json['management_fee'],
      other_additions: json['other_additions'],
      other_additions_remarks: json['other_additions_remarks'],
      other_deductions: json['other_deductions'],
      other_deductions_remarks: json['other_deductions_remarks'],
      overtime_pay: json['overtime_pay'],
      overtime_pay_on_holidays: json['overtime_pay_on_holidays'],
      overtime_work: json['overtime_work'],
      overtime_work_on_weekends: json['overtime_work_on_weekends'],
      primary_dividend: json['primary_dividend'],
      provident_fund: json['provident_fund'],
      resident_teacher_commission: json['resident_teacher_commission'],
      salesperson_commission: json['salesperson_commission'],
      settlement_method: json['settlement_method'],
      sign_unit_price: json['sign_unit_price'],
      social_security_charges: json['social_security_charges'],
      standard_days_of_the_month: json['standard_days_of_the_month'],
      status: json['status'],
      strategic_dividend: json['strategic_dividend'],
      taxes: json['taxes'],
      uid: json['uid'],
      withholding_payments: json['withholding_payments'],
      working_overtime_on_holidays: json['working_overtime_on_holidays'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actual_attendance_days'] = this.actual_attendance_days;
    data['advanced_dividend'] = this.advanced_dividend;
    data['create_time'] = this.create_time;
    data['dividend'] = this.dividend;
    data['eeekend_overtime_pay'] = this.eeekend_overtime_pay;
    data['employee_unit_price'] = this.employee_unit_price;
    data['food_expenses'] = this.food_expenses;
    data['id'] = this.id;
    data['loan'] = this.loan;
    data['actual_salary'] = this.actual_salary;
    data['management_fee'] = this.management_fee;
    data['other_additions'] = this.other_additions;
    data['other_additions_remarks'] = this.other_additions_remarks;
    data['other_deductions'] = this.other_deductions;
    data['other_deductions_remarks'] = this.other_deductions_remarks;
    data['overtime_pay'] = this.overtime_pay;
    data['overtime_pay_on_holidays'] = this.overtime_pay_on_holidays;
    data['overtime_work'] = this.overtime_work;
    data['overtime_work_on_weekends'] = this.overtime_work_on_weekends;
    data['primary_dividend'] = this.primary_dividend;
    data['provident_fund'] = this.provident_fund;
    data['resident_teacher_commission'] = this.resident_teacher_commission;
    data['salesperson_commission'] = this.salesperson_commission;
    data['settlement_method'] = this.settlement_method;
    data['sign_unit_price'] = this.sign_unit_price;
    data['social_security_charges'] = this.social_security_charges;
    data['standard_days_of_the_month'] = this.standard_days_of_the_month;
    data['status'] = this.status;
    data['strategic_dividend'] = this.strategic_dividend;
    data['taxes'] = this.taxes;
    data['uid'] = this.uid;
    data['withholding_payments'] = this.withholding_payments;
    data['working_overtime_on_holidays'] = this.working_overtime_on_holidays;
    return data;
  }
}
