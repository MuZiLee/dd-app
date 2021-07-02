
class SigingInformation {
  String startTime;
  String endTime;
  int fid;
  int id;

  /**
   * 售货员佣金
   */
  double commission_for_salesman;

  /**
   * 教师佣金
   */
  double commission_for_teacher;

  /**
   * 合作模式
   */
  String cooperation_mode;

  /**
   * 员工单价
   */
  double employee_unit_price;

  /**
   * 管理费
   */
  double management_expense;

  /**
   * 所得税
   */
  double income_tax;

  /**
   * 保险费
   */
  double insurance_premium;

  /**
   * 工资支付方式
   */
  String salary_payment_method; //蛋蛋发放
  /**
   * 结算日期
   */
  String settlement_date;

  /**
   * 签单价
   */
  double signed_unit_price;

  SigingInformation(
      {this.commission_for_salesman,
        this.commission_for_teacher,
        this.cooperation_mode,
        this.employee_unit_price,
        this.endTime,
        this.fid,
        this.id,
        this.income_tax,
        this.management_expense,
        this.insurance_premium,
        this.salary_payment_method,
        this.settlement_date,
        this.signed_unit_price,
        this.startTime});

  factory SigingInformation.fromJson(Map<String, dynamic> json) {
    return SigingInformation(
      commission_for_salesman: double.parse(json['commission_for_salesman']),
      commission_for_teacher: double.parse(json['commission_for_teacher']),
      cooperation_mode: json['cooperation_mode'],
      employee_unit_price: double.parse(json['employee_unit_price']),
      endTime: json['endTime'],
      fid: json['fid'],
      id: json['id'],
      income_tax: double.parse(json['income_tax']),
      management_expense: double.parse(json['management_expense']),
      insurance_premium: double.parse(json['insurance_premium']),
      salary_payment_method: json['salary_payment_method'],
      settlement_date: json['settlement_date'],
      signed_unit_price: double.parse(json['signed_unit_price']),
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission_for_salesman'] = this.commission_for_salesman;
    data['commission_for_teacher'] = this.commission_for_teacher;
    data['cooperation_mode'] = this.cooperation_mode;
    data['employee_unit_price'] = this.employee_unit_price;
    data['endTime'] = this.endTime;
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['income_tax'] = this.income_tax;
    data['insurance_premium'] = this.insurance_premium;
    data['salary_payment_method'] = this.salary_payment_method;
    data['settlement_date'] = this.settlement_date;
    data['signed_unit_price'] = this.signed_unit_price;
    data['startTime'] = this.startTime;
    return data;
  }
}