
import 'package:one/Model/EventsPaySlip.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovprogresshud/progresshud.dart';

class PaySlipManager extends ChangeNotifier {


  /**
   * type :小时工 同工同酬 代理招聘
   *
   */
  static addPaySlip(arguments) async {
    var url = "paySlip/addPaySlip";

    Progresshud.show();
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    Progresshud.dismiss();
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 我的工资条
   */
  static myPaySliplist() async {
    var url = "paySlip/myPaySliplist";
    SBResponse response = await SBRequest.post(url);
    List myPaySliplist = [];
    response.data.map((json) {
      myPaySliplist.add(EventsPaySlip.fromJson(json));
    }).toList();
    return myPaySliplist;
  }

  /**
   * 确认工资条
   */
  static confirmPaySlip({int id}) async {
    var url = "paySlip/confirmPaySlip";

    Progresshud.show();
    SBResponse response = await SBRequest.post(url, arguments: {"id": id});
    print(response.data);
    Progresshud.dismiss();
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 可提现工资
   */
  static withdrawableSalary() async {
    var url = "wallet/withdrawableSalary";
    SBResponse response = await SBRequest.post(url);
    return response.data != null ? double.parse(response.data.toString()) : "0.00";
  }

  static rolloutWageToWallet() async {
    var url = "wallet/rolloutWageToWallet";
    SBResponse response = await SBRequest.post(url);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

}