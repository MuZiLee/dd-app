
import 'dart:convert';

import 'package:demo2020/Model/BudgetEnterpriseCommission.dart';
import 'package:demo2020/Model/DividendModel.dart';
import 'package:demo2020/Model/MoneyModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';

class DividendManager extends ChangeNotifier {


  static getEnterpriseCommission(int rid) async {

    var url = "dividend/getBudgetEnterpriseCommission";
    SBResponse response = await SBRequest.post(url, arguments: {"uid":Account.user.id, "rid": rid});
    var data = response.data;
    List<BudgetEnterpriseCommission> commissionlist = [];
    response.data.map((json){
      commissionlist.add(BudgetEnterpriseCommission.fromJson(json));
    }).toList();

    return commissionlist;
  }

  /**
   * 可提现成的提成或分红
   */
  static getCashableCommission({int rid}) async {
    var url = "dividend/getCashableCommission";
    var arguments = {
      "rid" : rid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(jsonEncode(response.data));
    List commissionlist = [];

    response.data.map((json){

      commissionlist.add(DividendModel.fromJson(json));

    }).toList();
    return commissionlist;
  }

  /**
   * 可提现成的提成或分红
   */
  static getMoney({int rid}) async {
    var url = "paySlip/getMoney";
    var arguments = {
      "type" : rid,
      "uid": Account.user.id
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(jsonEncode(response.data));
    List commissionlist = [];

    response.data.map((json) {

      commissionlist.add(MoneyModel.fromJson(json));

    }).toList();
    return commissionlist;
  }



  /**
   * 提现到零钱
   */
  static withdrawToLooseChange({String amount, String commission_fee, int rid, int tid}) async {
    var url = "dividend/withdrawToLooseChange";
    var arguments = {
      "amount" : amount,
      "commission_fee" : commission_fee,
      "rid" : rid,
      "tid" : tid,
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }


}