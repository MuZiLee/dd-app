
import 'package:one/Model/JobModel.dart';
import 'package:one/Model/SigingInformation.dart';
import 'package:one/Model/User.dart';
import 'package:one/config.dart';

class EventsStaff {
  String cost;
  String create_time;
  String end_time;
  int etid;
  Etype etype;
  Factory factory;
  int fid;
  double hour;
  int id;
  List<dynamic> images;
  int jid;
  Job job;
  List<Log> logs;
  int pid;
  String remark;
  String start_time;
  int uid;
  int status;
  SigingInformation signingInfo;
  String update_time;
  User user;
  double count;

  EventsStaff(
      {this.cost,
      this.create_time,
      this.end_time,
      this.etid,
      this.etype,
      this.factory,
      this.fid,
      this.id,
      this.jid,
      this.job,
      this.pid,
      this.hour = 0.0,
      this.images,
      this.logs,
      this.remark,
      this.start_time,
      this.uid,
      this.status,
      this.signingInfo,
      this.update_time,
      this.count = 0.0,
      this.user});

  factory EventsStaff.fromJson(Map<String, dynamic> json) {
    
    List images = [];
    if (json['images'] != null) {
      json['images'].map((url) {
        images.add(Config.BASE_URL+url);
      }).toList();
    }
    
    return EventsStaff(
      cost: json['cost'] != null ? json['cost'].toString() : "0.0",
      create_time: json['create_time'],
      end_time: json['end_time'],
      etid: json['etid'],
      etype: json['etype'] != null ? Etype.fromJson(json['etype']) : null,
      factory:
          json['factory'] != null ? Factory.fromJson(json['factory']) : null,
      fid: json['fid'],
      hour: json['hour'] != null ? json['hour'].toString() == "" ? 0.0 : double.parse(json['hour'].toString()) : 0.0,
      id: json['id'],
      images: json['images'] != null ? images : null,
      jid: json['jid'],
      job: json['job'] != null ? Job.fromJson(json['job']) : null,
      logs: json['logs'] != null
          ? (json['logs'] as List).map((i) => Log.fromJson(i)).toList()
          : null,
      pid: json['pid'],
      remark: json['remark'],
      start_time: json['start_time'],
      uid: json['uid'],
      status: json['status'],
      count: json['count'],
      signingInfo: json['signingInfo'] != null ? SigingInformation.fromJson(json['signingInfo']) : null,
      update_time: json['update_time'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    data['create_time'] = this.create_time;
    data['end_time'] = this.end_time;
    data['etid'] = this.etid;
    data['fid'] = this.fid;
    data['hour'] = this.hour;
    data['id'] = this.id;
    data['jid'] = this.jid;
    data['pid'] = this.pid;
    data['remark'] = this.remark;
    data['start_time'] = this.start_time;
    data['uid'] = this.uid;
    data['status'] = this.status;
    data['update_time'] = this.update_time;
    if (this.etype != null) {
      data['etype'] = this.etype.toJson();
    }
    if (this.factory != null) {
      data['factory'] = this.factory.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images;
    }
    if (this.job != null) {
      data['job'] = this.job.toJson();
    }
    if (this.logs != null) {
      data['logs'] = this.logs.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Log {
  String create_time;
  int eid;
  int id;
  String remark;
  Ruser ruser;
  int status;
  String uid;
  Role role;
  String update_time;

  Log(
      {this.create_time,
      this.eid,
      this.id,
      this.remark,
      this.ruser,
      this.status,
      this.uid,
      this.role,
      this.update_time});

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      create_time: json['create_time'],
      eid: json['eid'],
      id: json['id'],
      remark: json['remark'],
      ruser: json['ruser'] != null ? Ruser.fromJson(json['ruser']) : null,
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      status: json['status'],
      uid: json['uid'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['eid'] = this.eid;
    data['id'] = this.id;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    if (this.ruser != null) {
      data['ruser'] = this.ruser.toJson();
    }
    return data;
  }
}

class Ruser {
  int age;
  String avatar;
  String birthday;
  int code;
  String create_time;
  int id;
  int isAdmin;
  int isDeath;
  String phone;
  String registrationID;
  int said;
  int sex;
  String update_time;
  String username;

  Ruser(
      {this.age,
      this.avatar,
      this.birthday,
      this.code,
      this.create_time,
      this.id,
      this.isAdmin,
      this.isDeath,
      this.phone,
      this.registrationID,
      this.said,
      this.sex,
      this.update_time,
      this.username});

  factory Ruser.fromJson(Map<String, dynamic> json) {
    return Ruser(
      age: json['age'],
      avatar: json['avatar'] != null ? Config.BASE_URL+json['avatar'] : null,
      birthday: json['birthday'],
      code: json['code'],
      create_time: json['create_time'],
      id: json['id'],
      isAdmin: json['isAdmin'],
      isDeath: json['isDeath'],
      phone: json['phone'],
      registrationID: json['registrationID'],
      said: json['said'],
      sex: json['sex'],
      update_time: json['update_time'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['code'] = this.code;
    data['create_time'] = this.create_time;
    data['id'] = this.id;
    data['isAdmin'] = this.isAdmin;
    data['isDeath'] = this.isDeath;
    data['phone'] = this.phone;
    data['registrationID'] = this.registrationID;
    data['said'] = this.said;
    data['sex'] = this.sex;
    data['update_time'] = this.update_time;
    data['username'] = this.username;
    return data;
  }
}

class EUser {
  int age;
  String avatar;
  String birthday;
  int code;
  String create_time;
  int id;
  int isAdmin;
  int isDeath;
  String phone;
  String registrationID;
  int said;
  int sex;
  String update_time;
  String username;

  EUser(
      {this.age,
      this.avatar,
      this.birthday,
      this.code,
      this.create_time,
      this.id,
      this.isAdmin,
      this.isDeath,
      this.phone,
      this.registrationID,
      this.said,
      this.sex,
      this.update_time,
      this.username});

  factory EUser.fromJson(Map<String, dynamic> json) {
    return EUser(
      age: json['age'],
      avatar: json['avatar'] != null ? Config.BASE_URL+json['avatar'] : null,
      birthday: json['birthday'],
      code: json['code'],
      create_time: json['create_time'],
      id: json['id'],
      isAdmin: json['isAdmin'],
      isDeath: json['isDeath'],
      phone: json['phone'],
      registrationID: json['registrationID'],
      said: json['said'],
      sex: json['sex'],
      update_time: json['update_time'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['code'] = this.code;
    data['create_time'] = this.create_time;
    data['id'] = this.id;
    data['isAdmin'] = this.isAdmin;
    data['isDeath'] = this.isDeath;
    data['phone'] = this.phone;
    data['registrationID'] = this.registrationID;
    data['said'] = this.said;
    data['sex'] = this.sex;
    data['update_time'] = this.update_time;
    data['username'] = this.username;
    return data;
  }
}

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

//class Factory {
//  String addres;
//  String city;
//  String create_time;
//  String district;
//  String factory_name;
//  int id;
//  String latitude;
//  String location;
//  String logo;
//  String longitude;
//  String province;
//  String remark;
//  int status;
//  int uid;
//  String update_time;
//
//
//  Factory(
//      {this.addres,
//      this.city,
//      this.create_time,
//      this.district,
//      this.factory_name,
//      this.id,
//      this.latitude,
//      this.location,
//      this.logo,
//      this.longitude,
//      this.province,
//      this.remark,
//      this.status,
//      this.uid,
//      this.update_time});
//
//  factory Factory.fromJson(Map<String, dynamic> json) {
//    return Factory(
//      addres: json['addres'],
//      city: json['city'],
//      create_time: json['create_time'],
//      district: json['district'],
//      factory_name: json['factory_name'],
//      id: json['id'],
//      latitude: json['latitude'],
//      location: json['location'],
//      logo: json['logo'] != null ? Config.BASE_URL+json['logo'] : null,
//      longitude: json['longitude'],
//      province: json['province'],
//      remark: json['remark'],
//      status: json['status'],
//      uid: json['uid'],
//      update_time: json['update_time'],
//    );
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['addres'] = this.addres;
//    data['city'] = this.city;
//    data['create_time'] = this.create_time;
//    data['district'] = this.district;
//    data['factory_name'] = this.factory_name;
//    data['id'] = this.id;
//    data['latitude'] = this.latitude;
//    data['location'] = this.location;
//    data['logo'] = this.logo;
//    data['longitude'] = this.longitude;
//    data['province'] = this.province;
//    data['remark'] = this.remark;
//    data['status'] = this.status;
//    data['uid'] = this.uid;
//    data['update_time'] = this.update_time;
//    return data;
//  }
//}

class Etype {
  int id;
  String name;
  String title;

  Etype({this.id, this.name, this.title});

  factory Etype.fromJson(Map<String, dynamic> json) {
    return Etype(
      id: json['id'],
      name: json['name'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    return data;
  }
}
