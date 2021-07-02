import 'package:one/Model/FactoryStaff.dart';
import 'package:one/Model/User.dart';

class EventsPaySlipAgent {
  String advanced_dividend; //高级分红
  String primary_dividend; //初级分红
  String strategic_dividend; //战略分红
  String dividend; //蛋蛋分红

  String salesperson_commission; //业务员提成
  String resident_teacher_commission; //驻场老师提成

  String sign_unit_price; //签单价
  String management_fee; //管理费
  String taxes; //税费

  int status; //财务是否审核

  String settlement_method; //结算方式

  int id;
  int uid; //员工ID
  String create_time;

  FactoryStaff staff;
  Teacher teacher;

  EventsPaySlipAgent({
    this.advanced_dividend = "0.0",
    this.create_time = "",
    this.dividend = "0.0",
    this.id = 0,
    this.management_fee = "0.0",
    this.primary_dividend = "0.0",
    this.resident_teacher_commission = "0.0",
    this.salesperson_commission = "0.0",
    this.settlement_method = "",
    this.sign_unit_price = "0.0",
    this.status = 0,
    this.strategic_dividend = "0.0",
    this.taxes = "0.0",
    this.uid = 0,
    this.staff,
  });

  factory EventsPaySlipAgent.fromJson(Map<String, dynamic> json) {
    return EventsPaySlipAgent(
      advanced_dividend: json['advanced_dividend'],
      create_time: json['create_time'],
      dividend: json['dividend'],
      id: json['id'],
      management_fee: json['management_fee'],
      primary_dividend: json['primary_dividend'],
      resident_teacher_commission: json['resident_teacher_commission'],
      salesperson_commission: json['salesperson_commission'],
      settlement_method: json['settlement_method'],
      sign_unit_price: json['sign_unit_price'],
      status: json['status'],
      strategic_dividend: json['strategic_dividend'],
      taxes: json['taxes'],
      uid: json['uid'],
      staff: json['staff'] != null ? FactoryStaff.fromJson(json['staff']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advanced_dividend'] = this.advanced_dividend;
    data['create_time'] = this.create_time;
    data['dividend'] = this.dividend;
    data['id'] = this.id;
    data['management_fee'] = this.management_fee;
    data['primary_dividend'] = this.primary_dividend;
    data['resident_teacher_commission'] = this.resident_teacher_commission;
    data['salesperson_commission'] = this.salesperson_commission;
    data['settlement_method'] = this.settlement_method;
    data['sign_unit_price'] = this.sign_unit_price;
    data['status'] = this.status;
    data['strategic_dividend'] = this.strategic_dividend;
    data['taxes'] = this.taxes;
    data['uid'] = this.uid;
    return data;
  }
}
