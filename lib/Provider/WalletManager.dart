
import 'dart:convert';

import 'package:demo2020/Model/AdvanceModel.dart';
import 'package:demo2020/Model/BankModel.dart';
import 'package:demo2020/Model/ServiceCharge.dart';
import 'package:demo2020/Model/WalletBillingDetailModel.dart';
import 'package:demo2020/Model/WalletModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';

class WalletManager extends ChangeNotifier {


//  # id, title
  /** '0', '创建钱包' **/
  static int CreateaWallet = 0;
  /** '1', '发工资' **/
  static int Pay = 1;
  /** '2', '预支' **/
  static int Advance = 2;
  /** '3', '业务提成' **/
  static int BusinessCommission = 3;
  /** '4', '驻场提成' **/
  static int ResidentCommission = 4;
  /** '5', '初级分红' **/
  static int PrimaryDividend = 5;
  /** '6', '高级分红' **/
  static int AdvancedDividend = 6;
  /** '7', '战略联盟分红' **/
  static int StrategicAllianceDividend = 7;
  /** '8', '蛋蛋分红' **/
  static int Dividend = 8;
  /** '9', '卖出' **/
  static int Sell = 9;
  /** '10', '消费' **/
  static int Consumption = 10;
  /** '11', 签到 **/
  static int SignIn = 11;
  /** '12', 分享 **/
  static int Share = 12;



  static getMyWallet() async{
    var url = "wallet/getMyWallet";
    SBResponse response = await SBRequest.post(url);
    if (response.code == 0) {
      return WalletModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  static availableAmount() async {
    var url = "wallet/availableAmount";
    SBResponse response = await SBRequest.post(url, arguments: {"uid":Account.user.id});
    return double.parse(response.data?.toString());
  }

  /**
   * 是否申请过预支
   */
  static isAdvance() async {
    var url = "wallet/isAdvance";
    SBResponse response = await SBRequest.post(url);
    if (response.code == 0 && response.data != null) {
      return AdvanceModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /**
   * 申请预支
   */
  static applyForAdvance({double amount = 0.0}) async {
    var url = "wallet/applyForAdvance";
    SBResponse response = await SBRequest.post(url, arguments: {"amount": amount});
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 转出手续费
   */
  static getServiceCharge() async {
    var url = "wallet/getServiceCharge";
    SBResponse response = await SBRequest.post(url);
    print(response.data);
    return ServiceCharge.fromJson(response.data);
  }

  /**
   * 账单明细
   */
  static billingDetailslist() async {
    var url = "wallet/billingDetailslist";
    SBResponse response = await SBRequest.post(url);
    List detailslit = [];
    response.data?.map((json){
      detailslit.add(WalletBillingDetailModel.fromJson(json));
    }).toList();
    return detailslit;
  }

  /**
   * 银行卡列表
   */
  static getBanklist() async {
    var url = "wallet/getBanklist";
    SBResponse response = await SBRequest.post(url);
    print(jsonEncode(response.data));

    List detailslit = [];
    response.data?.map((json){
      detailslit.add(BankModel.fromJson(json));
    }).toList();
    return detailslit;
  }

  /**
   * 我的银行卡
   */
  static getMyCardList() async {
    var url = "wallet/getMyCardList";
    SBResponse response = await SBRequest.post(url);
    print(jsonEncode(response.data));

    List detailslit = [];
    response.data.map((json){

      detailslit.add(MyBankModel.fromJson(json));

    }).toList();

    return detailslit;
  }

  /**
   * 验证银行卡号
   */
  static validateBankCardInfo({String cardNo}) async{

    var url = "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json";
    var arguments = {
      "cardNo": cardNo,
      "cardBinCheck" : "true"
    };
    dynamic data = await SBRequest.post3(url, arguments: arguments);
    print(data);

    BankValidateModel cardInfo = BankValidateModel.fromJson(data);

    return cardInfo;
  }

  /**
   * 添加银行卡
   */
  static addCard({String number, int bid, String name}) async {
    var url = "wallet/addCard";
    var arguments = {
      "number": number,
      "bid" : bid,
      "name" : name
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);

    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 提现
   */
  static withdraw({int bid, double amount = 0.0}) async {
    if (bid == null) {
      return true;
    }
    var url = "pay/singleCash";
    var arguments = {
      "bid":bid,
      "amount": amount
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    print(response.data);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }

  }

  /**
   * 是否有银行卡？
   */
  static isWorkers() async{
    var url = "bank/isWorkers";
    SBResponse response = await SBRequest.post(url);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }

  }

}