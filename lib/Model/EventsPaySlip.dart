import 'package:one/Model/EventsPaySlipAgent.dart';
import 'package:one/Model/EventsPaySlipEpfew.dart';
import 'package:one/Model/EventsPaySlipHourlyWorker.dart';
import 'package:one/Model/FactoryStaff.dart';
import 'package:one/Model/JobModel.dart';
import 'package:one/Model/User.dart';

class EventsPaySlip {
  String create_time;
  Factory factory;
  String fid;
  int id;
  String jid;
  Job job;
  UserX junior;
  String pid;
  String pwdid;
  String sid;
  UserX staff;
  int status;
  dynamic slip;
  Strategic strategic;
  UserX teacher;
  String tuid;
  String type;
  String uid;

  EventsPaySlip({
    this.create_time,
    this.factory,
    this.fid,
    this.id,
    this.jid,
    this.job,
    this.junior,
    this.pid,
    this.pwdid,
    this.sid,
    this.staff,
    this.status,
    this.slip,
    this.strategic,
    this.teacher,
    this.tuid,
    this.type,
    this.uid,
  });

  factory EventsPaySlip.fromJson(Map<String, dynamic> json) {
    return EventsPaySlip(
      create_time: json['create_time'],
      factory:
          json['factory'] != null ? Factory.fromJson(json['factory']) : null,
      fid: json['fid'],
      id: json['id'],
      jid: json['jid'],
      job: json['job'] != null ? Job.fromJson(json['job']) : null,
      junior: json['junior'] != null ? UserX.fromJson(json['junior']) : null,
      pid: json['pid'],
      pwdid: json['pwdid'],
      sid: json['sid'],
      slip: json['type'].toString().contains("小时工工资条")
          ? EventsPaySlipHourlyWorker.fromJson(json['slip'])
          : json['type'].toString().contains("同工同酬工资条")
              ? EventsPaySlipEpfew.fromJson(json['slip'])
              : EventsPaySlipAgent.fromJson(json['slip']),
      staff: json['staff'] != null ? UserX.fromJson(json['staff']) : null,
      status: json['status'],
      strategic: json['strategic'] != null
          ? Strategic.fromJson(json['strategic'])
          : null,
      teacher: json['teacher'] != null ? UserX.fromJson(json['teacher']) : null,
      tuid: json['tuid'],
      type: json['type'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['jid'] = this.jid;
    data['pid'] = this.pid;
    data['pwdid'] = this.pwdid;
    data['sid'] = this.sid;
    data['status'] = this.status;
    data['tuid'] = this.tuid;
    data['type'] = this.type;
    data['uid'] = this.uid;
    if (this.factory != null) {
      data['factory'] = this.factory.toJson();
    }
    if (this.job != null) {
      data['job'] = this.job.toJson();
    }
    if (this.junior != null) {
      data['junior'] = this.junior.toJson();
    }
    if (this.staff != null) {
      data['staff'] = this.staff.toJson();
    }
    if (this.strategic != null) {
      data['strategic'] = this.strategic.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher.toJson();
    }
    if (this.slip != null) {
      data['slip'] = this.slip.toJson();
    }
    return data;
  }
}

//class Junior {
//    int age;
//    String avatar;
//    String birthday;
//    int code;
//    String create_time;
//    int id;
//    int isAdmin;
//    int isDeath;
//    String phone;
//    String registrationID;
//    int said;
//    int sex;
//    String update_time;
//    String username;
//
//    Junior({this.age, this.avatar, this.birthday, this.code, this.create_time, this.id, this.isAdmin, this.isDeath, this.phone, this.registrationID, this.said, this.sex, this.update_time, this.username});
//
//    factory Junior.fromJson(Map<String, dynamic> json) {
//        return Junior(
//            age: json['age'],
//            avatar: json['avatar'],
//            birthday: json['birthday'],
//            code: json['code'],
//            create_time: json['create_time'],
//            id: json['id'],
//            isAdmin: json['isAdmin'],
//            isDeath: json['isDeath'],
//            phone: json['phone'],
//            registrationID: json['registrationID'],
//            said: json['said'],
//            sex: json['sex'],
//            update_time: json['update_time'],
//            username: json['username'],
//        );
//    }
//
//    Map<String, dynamic> toJson() {
//        final Map<String, dynamic> data = new Map<String, dynamic>();
//        data['age'] = this.age;
//        data['avatar'] = this.avatar;
//        data['birthday'] = this.birthday;
//        data['code'] = this.code;
//        data['create_time'] = this.create_time;
//        data['id'] = this.id;
//        data['isAdmin'] = this.isAdmin;
//        data['isDeath'] = this.isDeath;
//        data['phone'] = this.phone;
//        data['registrationID'] = this.registrationID;
//        data['said'] = this.said;
//        data['sex'] = this.sex;
//        data['update_time'] = this.update_time;
//        data['username'] = this.username;
//        return data;
//    }
//}

//class Teacher {
//    int age;
//    String avatar;
//    String birthday;
//    int code;
//    String create_time;
//    int id;
//    int isAdmin;
//    int isDeath;
//    String phone;
//    String registrationID;
//    int said;
//    int sex;
//    String update_time;
//    String username;
//
//    Teacher({this.age, this.avatar, this.birthday, this.code, this.create_time, this.id, this.isAdmin, this.isDeath, this.phone, this.registrationID, this.said, this.sex, this.update_time, this.username});
//
//    factory Teacher.fromJson(Map<String, dynamic> json) {
//        return Teacher(
//            age: json['age'],
//            avatar: json['avatar'],
//            birthday: json['birthday'],
//            code: json['code'],
//            create_time: json['create_time'],
//            id: json['id'],
//            isAdmin: json['isAdmin'],
//            isDeath: json['isDeath'],
//            phone: json['phone'],
//            registrationID: json['registrationID'],
//            said: json['said'],
//            sex: json['sex'],
//            update_time: json['update_time'],
//            username: json['username'],
//        );
//    }
//
//    Map<String, dynamic> toJson() {
//        final Map<String, dynamic> data = new Map<String, dynamic>();
//        data['age'] = this.age;
//        data['avatar'] = this.avatar;
//        data['birthday'] = this.birthday;
//        data['code'] = this.code;
//        data['create_time'] = this.create_time;
//        data['id'] = this.id;
//        data['isAdmin'] = this.isAdmin;
//        data['isDeath'] = this.isDeath;
//        data['phone'] = this.phone;
//        data['registrationID'] = this.registrationID;
//        data['said'] = this.said;
//        data['sex'] = this.sex;
//        data['update_time'] = this.update_time;
//        data['username'] = this.username;
//        return data;
//    }
//}

class Job {
  String arithmetic_requirements;
  String base_salary;
  String certificates;
  String contract_note;
  String create_time;
  String diploma;
  String diploma_copy;
  String dust_free_clothes;
  String english_requirements;
  String face_recognition;
  int fid;
  int id;
  String in_vivo_examination;
  int isHot;
  String job_description;
  String job_environment;
  String job_name;
  String job_payroll_time;
  String job_type;
  int maximum_salary_range;
  int minimum_search_range;
  int number_of_people_recruited;
  int number_of_recruiters;
  String phto;
  String reminder;
  String salary_structure;
  String smoke_scars;
  int status;
  String tattoo;
  String teturn_to_factory_rules;
  String traffic;
  String update_time;

  Job(
      {this.arithmetic_requirements,
      this.base_salary,
      this.certificates,
      this.contract_note,
      this.create_time,
      this.diploma,
      this.diploma_copy,
      this.dust_free_clothes,
      this.english_requirements,
      this.face_recognition,
      this.fid,
      this.id,
      this.in_vivo_examination,
      this.isHot,
      this.job_description,
      this.job_environment,
      this.job_name,
      this.job_payroll_time,
      this.job_type,
      this.maximum_salary_range,
      this.minimum_search_range,
      this.number_of_people_recruited,
      this.number_of_recruiters,
      this.phto,
      this.reminder,
      this.salary_structure,
      this.smoke_scars,
      this.status,
      this.tattoo,
      this.teturn_to_factory_rules,
      this.traffic,
      this.update_time});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      arithmetic_requirements: json['arithmetic_requirements'],
      base_salary: json['base_salary'],
      certificates: json['certificates'],
      contract_note: json['contract_note'],
      create_time: json['create_time'],
      diploma: json['diploma'],
      diploma_copy: json['diploma_copy'],
      dust_free_clothes: json['dust_free_clothes'],
      english_requirements: json['english_requirements'],
      face_recognition: json['face_recognition'],
      fid: json['fid'],
      id: json['id'],
      in_vivo_examination: json['in_vivo_examination'],
      isHot: json['isHot'],
      job_description: json['job_description'],
      job_environment: json['job_environment'],
      job_name: json['job_name'],
      job_payroll_time: json['job_payroll_time'],
      job_type: json['job_type'],
      maximum_salary_range: json['maximum_salary_range'],
      minimum_search_range: json['minimum_search_range'],
      number_of_people_recruited: json['number_of_people_recruited'],
      number_of_recruiters: json['number_of_recruiters'],
      phto: json['phto'],
      reminder: json['reminder'],
      salary_structure: json['salary_structure'],
      smoke_scars: json['smoke_scars'],
      status: json['status'],
      tattoo: json['tattoo'],
      teturn_to_factory_rules: json['teturn_to_factory_rules'],
      traffic: json['traffic'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arithmetic_requirements'] = this.arithmetic_requirements;
    data['base_salary'] = this.base_salary;
    data['certificates'] = this.certificates;
    data['contract_note'] = this.contract_note;
    data['create_time'] = this.create_time;
    data['diploma'] = this.diploma;
    data['diploma_copy'] = this.diploma_copy;
    data['dust_free_clothes'] = this.dust_free_clothes;
    data['english_requirements'] = this.english_requirements;
    data['face_recognition'] = this.face_recognition;
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['in_vivo_examination'] = this.in_vivo_examination;
    data['isHot'] = this.isHot;
    data['job_description'] = this.job_description;
    data['job_environment'] = this.job_environment;
    data['job_name'] = this.job_name;
    data['job_payroll_time'] = this.job_payroll_time;
    data['job_type'] = this.job_type;
    data['maximum_salary_range'] = this.maximum_salary_range;
    data['minimum_search_range'] = this.minimum_search_range;
    data['number_of_people_recruited'] = this.number_of_people_recruited;
    data['number_of_recruiters'] = this.number_of_recruiters;
    data['phto'] = this.phto;
    data['reminder'] = this.reminder;
    data['salary_structure'] = this.salary_structure;
    data['smoke_scars'] = this.smoke_scars;
    data['status'] = this.status;
    data['tattoo'] = this.tattoo;
    data['teturn_to_factory_rules'] = this.teturn_to_factory_rules;
    data['traffic'] = this.traffic;
    data['update_time'] = this.update_time;
    return data;
  }
}

//class Strategic {
//    String address;
//    String city;
//    String county;
//    Object create_time;
//    String dd_dividend;
//    String dd_service_charge;
//    int id;
//    String jp_dividend;
//    String name;
//    String province;
//    String sa_dividend;
//    String sos_name;
//    String soso_phone;
//    String sp_dividend;
//    int status;
//    int uid;
//    Object update_time;
//
//    Strategic({this.address, this.city, this.county, this.create_time, this.dd_dividend, this.dd_service_charge, this.id, this.jp_dividend, this.name, this.province, this.sa_dividend, this.sos_name, this.soso_phone, this.sp_dividend, this.status, this.uid, this.update_time});
//
//    factory Strategic.fromJson(Map<String, dynamic> json) {
//        return Strategic(
//            address: json['address'],
//            city: json['city'],
//            county: json['county'],
//            create_time: json['create_time'] != null ? Object.fromJson(json['create_time']) : null,
//            dd_dividend: json['dd_dividend'],
//            dd_service_charge: json['dd_service_charge'],
//            id: json['id'],
//            jp_dividend: json['jp_dividend'],
//            name: json['name'],
//            province: json['province'],
//            sa_dividend: json['sa_dividend'],
//            sos_name: json['sos_name'],
//            soso_phone: json['soso_phone'],
//            sp_dividend: json['sp_dividend'],
//            status: json['status'],
//            uid: json['uid'],
//            update_time: json['update_time'] != null ? Object.fromJson(json['update_time']) : null,
//        );
//    }
//
//    Map<String, dynamic> toJson() {
//        final Map<String, dynamic> data = new Map<String, dynamic>();
//        data['address'] = this.address;
//        data['city'] = this.city;
//        data['county'] = this.county;
//        data['dd_dividend'] = this.dd_dividend;
//        data['dd_service_charge'] = this.dd_service_charge;
//        data['id'] = this.id;
//        data['jp_dividend'] = this.jp_dividend;
//        data['name'] = this.name;
//        data['province'] = this.province;
//        data['sa_dividend'] = this.sa_dividend;
//        data['sos_name'] = this.sos_name;
//        data['soso_phone'] = this.soso_phone;
//        data['sp_dividend'] = this.sp_dividend;
//        data['status'] = this.status;
//        data['uid'] = this.uid;
//        if (this.create_time != null) {
//            data['create_time'] = this.create_time.toJson();
//        }
//        if (this.update_time != null) {
//            data['update_time'] = this.update_time.toJson();
//        }
//        return data;
//    }
//}
//
//class Staff {
//    int age;
//    String avatar;
//    String birthday;
//    int code;
//    String create_time;
//    int id;
//    int isAdmin;
//    int isDeath;
//    String phone;
//    String registrationID;
//    int said;
//    int sex;
//    String update_time;
//    String username;
//
//    Staff({this.age, this.avatar, this.birthday, this.code, this.create_time, this.id, this.isAdmin, this.isDeath, this.phone, this.registrationID, this.said, this.sex, this.update_time, this.username});
//
//    factory Staff.fromJson(Map<String, dynamic> json) {
//        return Staff(
//            age: json['age'],
//            avatar: json['avatar'],
//            birthday: json['birthday'],
//            code: json['code'],
//            create_time: json['create_time'],
//            id: json['id'],
//            isAdmin: json['isAdmin'],
//            isDeath: json['isDeath'],
//            phone: json['phone'],
//            registrationID: json['registrationID'],
//            said: json['said'],
//            sex: json['sex'],
//            update_time: json['update_time'],
//            username: json['username'],
//        );
//    }
//
//    Map<String, dynamic> toJson() {
//        final Map<String, dynamic> data = new Map<String, dynamic>();
//        data['age'] = this.age;
//        data['avatar'] = this.avatar;
//        data['birthday'] = this.birthday;
//        data['code'] = this.code;
//        data['create_time'] = this.create_time;
//        data['id'] = this.id;
//        data['isAdmin'] = this.isAdmin;
//        data['isDeath'] = this.isDeath;
//        data['phone'] = this.phone;
//        data['registrationID'] = this.registrationID;
//        data['said'] = this.said;
//        data['sex'] = this.sex;
//        data['update_time'] = this.update_time;
//        data['username'] = this.username;
//        return data;
//    }
//}
//
//class Factory {
//    String addres;
//    String city;
//    String create_time;
//    String district;
//    String factory_name;
//    int id;
//    String latitude;
//    String location;
//    String logo;
//    String longitude;
//    String province;
//    String remark;
//    int status;
//    int uid;
//    String update_time;
//
//    Factory({this.addres, this.city, this.create_time, this.district, this.factory_name, this.id, this.latitude, this.location, this.logo, this.longitude, this.province, this.remark, this.status, this.uid, this.update_time});
//
//    factory Factory.fromJson(Map<String, dynamic> json) {
//        return Factory(
//            addres: json['addres'],
//            city: json['city'],
//            create_time: json['create_time'],
//            district: json['district'],
//            factory_name: json['factory_name'],
//            id: json['id'],
//            latitude: json['latitude'],
//            location: json['location'],
//            logo: json['logo'],
//            longitude: json['longitude'],
//            province: json['province'],
//            remark: json['remark'],
//            status: json['status'],
//            uid: json['uid'],
//            update_time: json['update_time'],
//        );
//    }
//
//    Map<String, dynamic> toJson() {
//        final Map<String, dynamic> data = new Map<String, dynamic>();
//        data['addres'] = this.addres;
//        data['city'] = this.city;
//        data['create_time'] = this.create_time;
//        data['district'] = this.district;
//        data['factory_name'] = this.factory_name;
//        data['id'] = this.id;
//        data['latitude'] = this.latitude;
//        data['location'] = this.location;
//        data['logo'] = this.logo;
//        data['longitude'] = this.longitude;
//        data['province'] = this.province;
//        data['remark'] = this.remark;
//        data['status'] = this.status;
//        data['uid'] = this.uid;
//        data['update_time'] = this.update_time;
//        return data;
//    }
//}
