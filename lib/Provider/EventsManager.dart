import 'dart:convert';

import 'package:demo2020/Model/ApplyHistoryModel.dart';
import 'package:demo2020/Model/EventPartnerAudit.dart';
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/foundation.dart';
import 'package:nav_router/nav_router.dart';

class EventsManager extends ChangeNotifier {
  /*** 工厂录入 **/
  static int factory_entry = 1;

  /** 初级合伙人申请 **/
  static int junior_partner_application = 2;

  /** 高级合伙人申请 **/
  static int senior_partner_application = 3;

  /** 战略联盟申请 **/
  static int strategic_alliance_application = 4;

  /** 业务员申请 **/
  static int salesman_application = 5;

  /** 职位报名申请 **/
  static int position_application = 6;

  /** 请假申请 **/
  static int leave_application = 7;

  /** 报销申请 **/
  static int claim_for_reimbursement = 8;

  /** 工资条确认申请(发工资) **/
  static int payslip_confirmation_application = 9;

  /**离职申请**/
  static int quit_application = 10;

  /** 打卡 **/
  static int punch_the_clock = 11;

  /** 预支申请 **/
  static int advance_payments = 12;

  /**
   * 添加角色申请事件
   * etid RolesType
   * rid RolesType
   */
  static addRolesApple(
      {int etid,
      int rid,
      String remark,
      String province,
      String city,
      String county,
      String address,
      String enterpriseName,
      String sos_name,
      String sos_phone}) async {
    var url = "events/addRolesApple";
    var arguments = {
      "etid": etid,
      "rid": rid,
      "remark": remark,
      "province": province,
      "city": city,
      "county": county,
      "address": address,
      "name": enterpriseName,
      "sos_name": sos_name,
      "sos_phone": sos_phone,
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      await Account.getUserInfo();
      pop();
      return true;
    } else {
      return false;
    }
  }

  static getJobEvents({
    uid
  }) async{
    var url = "events/getJobEvents";
    var arguments = {
      "uid": uid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List events = [];

    response.data.map((json) {
      events.add(ApplyHistoryModel.fromJson(json));
    }).toList();
    return events;
  }

}
