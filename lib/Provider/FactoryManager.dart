
import 'dart:convert';

import 'package:demo2020/Model/EventTeacherAudit.dart';
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Model/FactoryInfo.dart';
import 'package:demo2020/Model/FactoryStaff.dart';
import 'package:demo2020/Model/HRFactoryInfoModel.dart';
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Provider/API.dart';
import 'package:demo2020/Provider/Location.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/foundation.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';

class FactoryManager extends ChangeNotifier {


  static List jobWagesList() {
    return [

      JobType(title: "不限", minimum_search_range: 0, maximum_salary_range: 10000000, isHot: 0, index: 1),
      JobType(title: "0~1000", minimum_search_range: 0, maximum_salary_range: 1000, isHot: 0, index: 1),
      JobType(title: "1000~2000", minimum_search_range: 1000, maximum_salary_range: 2000, isHot: 0, index: 1),
      JobType(title: "2000~3000", minimum_search_range: 2000, maximum_salary_range: 3000, isHot: 0, index: 1),
      JobType(title: "3000~4000", minimum_search_range: 3000, maximum_salary_range: 4000, isHot: 0, index: 1),
      JobType(title: "4000~5000", minimum_search_range: 4000, maximum_salary_range: 5000, isHot: 0, index: 1),
      JobType(title: "5000~6000", minimum_search_range: 5000, maximum_salary_range: 6000, isHot: 0, index: 1),
      JobType(title: "6000~7000", minimum_search_range: 6000, maximum_salary_range: 7000, isHot: 0, index: 1),
      JobType(title: "7000~8000", minimum_search_range: 7000, maximum_salary_range: 8000, isHot: 0, index: 1),
      JobType(title: "8000~9000", minimum_search_range: 8000, maximum_salary_range: 9000, isHot: 0, index: 1),
      JobType(title: "9000~1万", minimum_search_range: 9000, maximum_salary_range: 10000, isHot: 0, index: 1),
      // JobType(title: "1万~2万", minimum_search_range: 10000, maximum_salary_range: 200000, isHot: 0, index: 1),
      // JobType(title: "2万~3万", minimum_search_range: 20000, maximum_salary_range: 300000, isHot: 0, index: 1),
      // JobType(title: "3万~4万", minimum_search_range: 30000, maximum_salary_range: 400000, isHot: 0, index: 1),
      // JobType(title: "4万~5万", minimum_search_range: 40000, maximum_salary_range: 500000, isHot: 0, index: 1),
      // JobType(title: "5万~6万", minimum_search_range: 50000, maximum_salary_range: 600000, isHot: 0, index: 1),
      // JobType(title: "6万~7万", minimum_search_range: 60000, maximum_salary_range: 700000, isHot: 0, index: 1),
      // JobType(title: "7万~8万", minimum_search_range: 700000, maximum_salary_range: 800000, isHot: 0, index: 1),
      // JobType(title: "8万~8万", minimum_search_range: 800000, maximum_salary_range: 900000, isHot: 0, index: 1),
      // JobType(title: "9万~10万", minimum_search_range: 900000, maximum_salary_range: 1000000, isHot: 0, index: 1),
      // JobType(title: "10万以上", minimum_search_range: 900000, maximum_salary_range: 10000000, isHot: 0, index: 1),
    ];
  }

  /**
   * 获取工厂详细信息
   */
  static getInfo({int fid}) async {
    var url = "factory/getInfo";
    SBResponse response = await SBRequest.post(url, arguments: {"id":fid});
    return FactoryInfo.fromJson(response.data);
  }

  /**
   * 职位类别
   */
  static getJobTypes() async {
    var url = "factory/getJobTypes";
    SBResponse response = await SBRequest.post(url);
    List jobTypes = [];
    response.data.map((json){
      JobType type = JobType.fromJson(json);
      type.index = 0;
      jobTypes.add(type);
    }).toList();
    return jobTypes;
  }

  /**`
   * usableJobList
   */
  static usableJobList({int jtid = 1, bool soty = true, int minimum_search_range = 0, int isHot = 0, int maximum_salary_range = 100000, int page = 1, int limit = 15, city}) async {
    var url = "factory/usableJobList";
    var arguments = {
      "latitude": Location.latitude != null ? Location.latitude : 0,
      "longitude": Location.longitude != null ? Location.longitude : 0,
      "minimum_search_range" : minimum_search_range,
      "maximum_salary_range" : maximum_salary_range,
      "jtid"     : jtid,
      "isHot"     : isHot,
      "page"     : page,
      "limit"    : limit,
      "city" : city
    };
    print(arguments);
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List jobs = [];
    response.data.map((json) {
      jobs.add(JobModel.fromJson(json));
    }).toList();

    if (jobs.length > 1) {
      if (soty == true) {
        jobs.sort((left,right)=>left.distance.compareTo(right.distance));
      } else {
        jobs.sort((left,right)=>right.distance.compareTo(left.distance));
      }
    }

    if (jobs.length > 2) {

      /// 插入职位广告
     List ads = await API.getAdList(type: 2);

     int tmp = 0;
     for (int i = 0; i<jobs.length; i++) {
        if (i > 0 && i % 2 == 0) {
          jobs.insert(i+tmp, ads[tmp]);
          tmp++;
        }
     }
    }
    return jobs;
  }

  /**
   * 报名申请
   */
  static apply({int jid, int fid}) async {
    var url = "factory/apply";
    var arguments = {
      "jid": jid,
      "fid": fid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      ZKCommonUtils.showToast("申请已提交");
      pop();
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }

  static isApply({int jid}) async {
    var url = "factory/isApply";
    var arguments = {
      "jid": jid,
    };
    Progresshud.show();
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    Progresshud.dismiss();
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 搜索职位
   */
  static jobSearch(String keyword,{int page = 1, int limit = 15}) async {
    var url = "factory/jobSearch";
    var arguments = {
      "keyword": keyword,
      "page": page,
      "limit": limit,
      "latitude": Location.latitude ?? 0,
      "longitude": Location.longitude ?? 0,
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List jobs = [];
    response.data.map((json) {
      jobs.add(JobModel.fromJson(json));
    }).toList();
    return jobs;
  }

  /**
   * 获取我的收藏
   */
  static getList() async{
    var url = "factory/getList";
    SBResponse response = await SBRequest.post(url);
    List jobs = [];
    response.data.map((json) {
      jobs.add(JobModel.fromJson(json));
    }).toList();
    return jobs;
  }

  /**
   * 驻场老师的审核事件--报名事件列表
   */
  static auditPATeacher({int fid, int page = 1, int limit = 15}) async {
    var url = "factory/auditPATeacher";
    var arguments = {
      "page": page,
      "limit": limit,
      "fid": fid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List events = [];
    response.data.map((json) {
      events.add(EventTeacherAudit.fromJson(json));
    }).toList();
    return events;
  }
  /**
   * 驻场老师的审核事件--入职确认
   */
  static inJobReview({int eid, int status, String remark}) async {
    var url = "factory/inJobReview";
    var arguments = {
      "eid": eid,
      "status": status,
      "remark": remark
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 驻场老师的审核事件--入职确认
   */
  static leaveReview({int eid, int status, String remark}) async {
    var url = "factory/inJobReview";
    var arguments = {
      "eid": eid,
      "status": status,
      "remark": remark
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 驻场老师的审核事件--请假事件列表
   * EventsStaff
   * 事件是员工提交的,所以使用员工事件表模型
   */

  /**
   * TODO : 获取--请假事件列表
   * TODO : 获取--报销事件列表
   * TODO : 获取--离职事件列表
   */
  static getStafflist({int fid, int etid, int page = 1, int limit = 30}) async {
    var url = "factory/getStafflist";
    var arguments = {
      "page": page,
      "limit": limit,
      "fid": fid,
      "etid": etid,
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List events = [];
    response.data.map((json) {
      events.add(EventsStaff.fromJson(json));
    }).toList();
    return events;
  }


  /**
   * TODO : 审核--请假事件审核
   * TODO : 审核--报销事件审核
   * TODO : 审核--离职事件审核
   */
  static staffAudit({int status, String remark, int eid}) async{
      var url = "factory/staffAudit";
      var arguments = {
        "status": status,
        "remark": remark,
        "eid": eid
      };
      SBResponse response = await SBRequest.post(url, arguments: arguments);
      if (response.code == 0) {
        return true;
      } else {
        return false;
      }
  }

  /**
   * 获取某工厂下所有员工
   */
  static getStaffInfolist({int fid}) async {
    var url = "factory/getStaffInfolist";
    var arguments = {
      "fid": fid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List staffs = [];

    response.data.map((json) {

      staffs.add(FactoryStaff.fromJson(json));

    }).toList();

    return staffs;
  }



  /**
   * 获取某工厂下的考勤
   */
  static getAttendancelist({int fid}) async{
    var url = "factory/getAttendancelist";
    SBResponse response = await SBRequest.post(url, arguments: {"fid":fid});
    List events = [];
    response.data.map((json) {
      events.add(EventsStaff.fromJson(json));
    }).toList();
    return events;
  }

  /**
   * 考勤审核
   */
  static setAttendance({int status, String remark, int eid}) async {
    var url = "factory/setAttendance";
    var arguments = {
      "status": status,
      "remark": remark,
      "eid": eid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }
  /**
   * 删除考勤
   */
  static delAttendance({int eid}) async {
    var url = "factory/delAttendance";
    var arguments = {
      "eid": eid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 工厂HR
   */
  static getFactroyHRInfo(int fid) async{
    var url = "factory/getFactroyHRInfo";
    SBResponse response = await SBRequest.post(url, arguments: {"fid":fid});
    print(response.data);
    if (response.code == 0) {
      return HRFactoryInfoModel.fromJson(response.data);
    } else {
      return null;
    }
  }


}