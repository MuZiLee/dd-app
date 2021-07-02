
import 'package:one/Model/EventsStaff.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/EventsManager.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:ovprogresshud/progresshud.dart';

class StaffManager {



  /**
   * 请假申请
   * etid
   * start_time
   * end_time
   * content
   */
  static leave({String remark, String hour, String start_time, String end_time}) async{
    var url = "staff/addFlow";
    var arguments = {
      "fid": Account.user.staff.factory.id,
      "jid": Account.user.staff.job.id,
      "remark": remark,
      "hour": hour,
      "start_time": start_time,
      "end_time": end_time,
      "etid": EventsManager.leave_application
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }


  /**
   * 报销
   */
  static reimbursement({String remark, double cost, List images}) async {
    var url = "staff/addFlow";
    var arguments = {
      "fid": Account.user.staff.factory.id,
      "jid": Account.user.staff.job.id,
      "remark": remark,

      "cost": cost,
      "images": images,
      "etid": EventsManager.claim_for_reimbursement
    };

    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }

  /**
   * 离职
   */
  static quit({String remark, double star, String endTime}) async {
    var url = "staff/addFlow";
    var arguments = {
      "fid": Account.user.staff.factory.id,
      "jid": Account.user.staff.job.id,


      "remark": remark,
      "star": star,
      "end_time": endTime,
      "etid": EventsManager.quit_application
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }

  /**
   * 上传图片
   */
  static uploadImage(String path) async {

    SBResponse response = await SBRequest.uploadFile(path: path);

    if (response.code == 0) {
      print(response.data);
      return response.data['url'];
    } else {
      Progresshud.dismiss();
      ZKCommonUtils.showToast("上传失败");
      return null;
    }
  }

  /**
   * 打卡
   */
  static punch_the_clock({double hour}) async {
    var url = "staff/addFlow";
    var arguments = {
      "fid": Account.user.staff.factory.id,
      "jid": Account.user.staff.job.id,


      "hour": hour,
      "etid": EventsManager.punch_the_clock
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }

  /**
   * TODO: 获取打卡事件 来预算工资
   */
  static getPunchTheClocklist() async {
    var url = "staff/getPunchTheClocklist";

    SBResponse response = await SBRequest.post(url);
    List events = [];
    response.data.map((json) {
      events.add(EventsStaff.fromJson(json));
    }).toList();
    return events;
  }

  /**
   * 工作流 历史记录
   */
  static workflowHistory() async {
    var url = "staff/workflowHistory";

    SBResponse response = await SBRequest.post(url);
    List events = [];
    response.data.map((json) {
      EventsStaff staff = EventsStaff.fromJson(json);
      if (staff.etype.id != EventsManager.punch_the_clock) {
        events.add(staff);
      }
    }).toList();
    return events;
  }

  /**
   * 工资条
   */

  /**
   * 预支申请
   */
  static advancePayments({double cost = 0.0, double hour = 0.0, int jid, int fid, int pid, double total}) async {
    var url = "staff/advancePayments";
    var arguments = {
      "etid" : EventsManager.advance_payments,
      "cost" : cost,
      "hour" : hour,
      "jid" : jid,
      "fid" : fid,
      "pid" : pid,
      "total" : total
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
   * 获取当月的预支
   */
  static getSameMontcAdvancePayments() async {
    var url = "staff/getSameMontcAdvancePayments";
    SBResponse response = await SBRequest.post(url);

    List advance = [];
    response.data.map((json) {
      advance.add(EventsStaff.fromJson(json));
    }).toList();
    // * 这里只会有一条预支记录，当月的预支记录，如果没有申请过就是一个空数组
    return advance;
  }

  // 当月的打卡事件
  static getSameMonthClocklist() async{
    var url = "staff/getSameMonthClocklist";
    SBResponse response = await SBRequest.post(url);

    EventsStaff totalWordtime = EventsStaff(hour: 0.0, cost: "0.0");
    response.data.map((json) {
      EventsStaff event = EventsStaff.fromJson(json);
      totalWordtime.fid = event.fid;
      totalWordtime.jid = event.jid;
      totalWordtime.user = event.user;
      totalWordtime.uid = event.uid;
      totalWordtime.id = event.id;
      totalWordtime.pid = event.pid;
      totalWordtime.hour = totalWordtime.hour + event.hour;
      totalWordtime.factory = event.factory;
      totalWordtime.job = event.job;
      totalWordtime.etype = event.etype;
      totalWordtime.signingInfo = event.signingInfo;
      totalWordtime.etid = event.etid;
      ++totalWordtime.count;
    }).toList();
    return totalWordtime;
  }


}
