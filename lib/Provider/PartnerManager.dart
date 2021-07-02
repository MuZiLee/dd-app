import 'package:one/Model/EventPartnerAudit.dart';
import 'package:one/Model/User.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';

/**
 * 合伙人管理器
 */
class PartnerManager {

  /**
   * 初级合伙人审核事件
   */
  static auditAuniorPartner({int page = 1, int limit = 15}) async {
    var url = "partner/auditAuniorPartner";
    var arguments = {
      "page" : page,
      "limit" : limit
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List events = [];

    response.data.map((json) {
      events.add(EventPartnerAudit.fromJson(json));
    }).toList();
    return events;
  }

  /**
   * 初级审核
   */
  static registrationReview({int eid, int status, String remark}) async {
    var url = "partner/registrationReview";
    var arguments = {
      "eid" : eid,
      "status" : status,
      "remark" : remark
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      print(response.data['logs']);
      print(response.data['logs'].toString());
      return true;
    } else {
      return false;
    }
  }

  /**
   * 删除事件
   */
  static delete({int eid}) async {
    var url = "partner/delete";
    var arguments = {
      "eid" : eid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * TODO: 获取我的初级合伙人
   */
  static getMyJuniorPartnerlist() async {
    var url = "partner/getMyJuniorPartnerlist";
    SBResponse response = await SBRequest.post(url);
    List jplist = [];
    response.data.map((json){
      jplist.add(User.fromJson(json));
    }).toList();
    return jplist;
  }

  /**
   * TODO: 获取我的初级合伙人
   */
  static getMySeniorPartner() async {
    var url = "partner/getMySeniorPartner";
    SBResponse response = await SBRequest.post(url);
    List jplist = [];
    response.data.map((json){
      jplist.add(User.fromJson(json));
    }).toList();
    return jplist;
  }
  /**
   * TODO: 获取我的准高级合伙人
   */
  static getMyASPartnerlist() async {
    var url = "partner/getMyASPartnerlist";
    SBResponse response = await SBRequest.post(url);
    List jplist = [];
    response.data.map((json){
      jplist.add(User.fromJson(json));
    }).toList();
    return jplist;
  }

  /**
   * 获取战略信息
   */
  static getStrategicInfor({int sid}) async{
    var url = "partner/getStrategicInfor";
    var arguments = {
      "sid" : sid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {

    }
  }

  /**
   * 我的员工
   */
  static getMyStafflist({int page = 1, int limit = 100}) async {
    var url = "partner/getMyStafflist";
    var arguments = {
      "page": page,
      "limit": limit
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List jplist = [];
    response.data.map((json){
      jplist.add(User.fromJson(json['user']));
    }).toList();
    return jplist;

  }

  static getMyPWorkerlist() async {
    var url = "partner/getMyPWorkerlist";
    SBResponse response = await SBRequest.post(url);
    List wusers = [];

    response.data.map((json){
      SBUser user = SBUser.fromJson(json);
      wusers.add(user);
    }).toList();

    return wusers;
  }




}