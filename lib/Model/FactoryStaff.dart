
import 'package:one/Model/EventsStaff.dart';
import 'package:one/Model/JobModel.dart';
import 'package:one/Model/PartenerPvivot.dart';
import 'package:one/Model/StrategicAlliance.dart';
import 'package:one/config.dart';
import 'package:one/Model/SigingInformation.dart';

class FactoryStaff {
  String create_time;
  Factory factory;
  int fid;
  int id;
  int jid;
  Job job;
  int pid;
  int status;
  int uid;
  int isSlip;
  String update_time;
  User user;
  SigingInformation sigingInformation;
  EnvironmentAndTreatment envAndTreat;
  EventsStaff advance;
  List<EventsStaff> punchIn;
  PartenerPvivot partenerPvivot;



  FactoryStaff({
    this.create_time,
    this.factory,
    this.fid,
    this.id,
    this.jid,
    this.job,
    this.pid,
    this.status,
    this.uid,
    this.isSlip,
    this.update_time,
    this.user,
    this.sigingInformation,
    this.envAndTreat,
    this.advance,
    this.punchIn,
    this.partenerPvivot,
  });

  factory FactoryStaff.fromJson(Map<String, dynamic> json) {

    return FactoryStaff(
      create_time: json['create_time'],
      factory: json['factory'] != null ? Factory.fromJson(json['factory']) : null,
      fid: json['fid'],
      id: json['id'],
      jid: json['jid'],
      job: json['job'] != null ? Job.fromJson(json['job']) : null,
      pid: json['pid'],
      status: json['status'],
      uid: json['uid'],
      isSlip: json['isSlip'],
      update_time: json['update_time'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      sigingInformation: json['sigingInformation'] != null ? SigingInformation.fromJson(json['sigingInformation']) : null,
      envAndTreat: json['envAndTreat'] != null ? EnvironmentAndTreatment.fromJson(json['envAndTreat']) : null,
      advance: json['advance'] != null ? EventsStaff.fromJson(json['advance']) : null,
      punchIn: json['punchIn'] != null ? (json['punchIn'] as List).map((i) => EventsStaff.fromJson(i)).toList() : null,
      partenerPvivot: json['partenerPvivot'] != null ? PartenerPvivot.fromJson(json['partenerPvivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    if (this.factory != null) {
      data['factory'] = this.factory.toJson();
    }

    data['fid'] = this.fid;
    data['id'] = this.id;
    data['jid'] = this.jid;
    if (this.job != null) {
      data['job'] = this.job.toJson();
    }

    data['pid'] = this.pid;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;

    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.sigingInformation != null) {
    data['sigingInformation'] = this.sigingInformation.toJson();
    }
    if (this.envAndTreat != null) {
      data['envAndTreat'] = this.envAndTreat.toJson();
    }
    if (this.advance != null) {
      data['advance'] = this.advance.toJson();
    }
    if (this.punchIn != null) {
      data['punchIn'] = this.punchIn.map((v) => v.toJson()).toList();
    }
    if (this.partenerPvivot != null) {
      data['partenerPvivot'] = this.partenerPvivot.toJson();
    }

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
  JobType job_type;
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
      job_type: json['job_type'] != null ? JobType.fromJson(json['job_type']) : null,
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
    if (this.job_type != null) {
      data['job_type'] = this.job_type.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      age: json['age'],
      avatar: json['avatar'] != null
          ? Config.BASE_URL+json['avatar']
          : Config.resources,
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
