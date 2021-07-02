import 'dart:convert';

import 'package:demo2020/Model/FImage.dart';
import 'package:demo2020/Provider/Location.dart';
import 'package:demo2020/config.dart';

class JobModel {
  String arithmetic_requirements;
  String base_salary;
  String certificates;
  String contract_note;
  String create_time;
  String diploma;
  String diploma_copy;
  String distance;
  String dust_free_clothes;
  String english_requirements;
  String face_recognition;
  Factory factory;
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

  JobModel(
      {this.arithmetic_requirements,
      this.base_salary,
      this.certificates,
      this.contract_note,
      this.create_time,
      this.diploma,
      this.diploma_copy,
      this.distance,
      this.dust_free_clothes,
      this.english_requirements,
      this.face_recognition,
      this.factory,
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

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      arithmetic_requirements: json['arithmetic_requirements'],
      base_salary: json['base_salary'],
      certificates: json['certificates'],
      contract_note: json['contract_note'],
      create_time: json['create_time'],
      diploma: json['diploma'],
      diploma_copy: json['diploma_copy'],
      distance: json['distance'],
      dust_free_clothes: json['dust_free_clothes'],
      english_requirements: json['english_requirements'],
      face_recognition: json['face_recognition'],
      factory:
          json['factory'] != null ? Factory.fromJson(json['factory']) : null,
      fid: json['fid'],
      id: json['id'],
      in_vivo_examination: json['in_vivo_examination'],
      isHot: json['isHot'],
      job_description: json['job_description'],
      job_environment: json['job_environment'],
      job_name: json['job_name'],
      job_payroll_time: json['job_payroll_time'],
//            job_type: json['job_type'] != null ? JobType.fromJson(json['job_type']) : null,
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
    data['distance'] = this.distance;
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
    if (this.factory != null) {
      data['factory'] = this.factory.toJson();
    }
    if (this.job_type != null) {
      data['job_type'] = this.job_type.toJson();
    }
    return data;
  }
}

class JobType {
  int id;
  int maximum_salary_range;
  int minimum_search_range;
  bool sort;
  int isHot;
  String title;
  int index;

  JobType(
      {this.id,
      this.maximum_salary_range,
      this.minimum_search_range,
      this.sort,
      this.isHot,
      this.title,
      this.index});

  factory JobType.fromJson(Map<String, dynamic> json) {
    return JobType(
      id: json['id'],
      maximum_salary_range: json['maximum_salary_range'],
      minimum_search_range: json['minimum_search_range'],
      sort: json['sort'],
      isHot: json['isHot'],
      title: json['title'],
      index: json['index'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['maximum_salary_range'] = this.maximum_salary_range;
    data['minimum_search_range'] = this.minimum_search_range;
    data['sort'] = this.sort;
    data['isHot'] = this.isHot;
    data['title'] = this.title;
    data['index'] = this.index;
    return data;
  }
}

class Factory {
  String addres;
  String city;
  String create_time;
  String district;
  String factory_name;
  int id;
  List<FImage> images;
  String latitude;
  String location;
  String logo;
  String longitude;
  String province;
  String remark;
  int status;
  int uid;
  String update_time;

  Factory(
      {this.addres,
      this.city,
      this.create_time,
      this.district,
      this.factory_name,
      this.id,
      this.images,
      this.latitude,
      this.location,
      this.logo,
      this.longitude,
      this.province,
      this.remark,
      this.status,
      this.uid,
      this.update_time});

  factory Factory.fromJson(Map<String, dynamic> json) {
    return Factory(
      addres: json['addres'],
      city: json['city'],
      create_time: json['create_time'],
      district: json['district'],
      factory_name: json['factory_name'],
      id: json['id'],
      images: json['images'] != null
          ? (json['images'] as List).map((i) => FImage.fromJson(i)).toList()
          : null,
      latitude: json['latitude'],
      location: json['location'],
      logo: json['logo'] != null ? Config.BASE_URL + json['logo'] : "",
      longitude: json['longitude'],
      province: json['province'],
      remark: json['remark'],
      status: json['status'],
      uid: json['uid'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addres'] = this.addres;
    data['city'] = this.city;
    data['create_time'] = this.create_time;
    data['district'] = this.district;
    data['factory_name'] = this.factory_name;
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['longitude'] = this.longitude;
    data['province'] = this.province;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class EnvironmentAndTreatment {
  String age_requirements;
  String dietary_standard;
  String dormitory_location;
  String ethnic_restrictions;
  int fid;
  int id;
  String is_experience;
  String is_insurance;
  String is_toilet;
  String night_shift_allowance;
  String people_of_dormitory;
  String required_certificates;
  int rest_day_count;
  String training_content;
  String training_time;
  String way_to_work;
  String working_hours;

  EnvironmentAndTreatment({
    this.age_requirements,
    this.dietary_standard,
    this.dormitory_location,
    this.ethnic_restrictions,
    this.fid,
    this.id,
    this.is_experience,
    this.is_insurance,
    this.is_toilet,
    this.night_shift_allowance,
    this.people_of_dormitory,
    this.required_certificates,
    this.rest_day_count,
    this.training_content,
    this.training_time,
    this.way_to_work,
    this.working_hours,
  });

  factory EnvironmentAndTreatment.fromJson(Map<String, dynamic> json) {
    return EnvironmentAndTreatment(
      age_requirements: json['age_requirements'],
      dietary_standard: json['dietary_standard'],
      dormitory_location: json['dormitory_location'],
      ethnic_restrictions: json['ethnic_restrictions'],
      fid: json['fid'],
      id: json['id'],
      is_experience: json['is_experience'],
      is_insurance: json['is_insurance'],
      is_toilet: json['is_toilet'],
      night_shift_allowance: json['night_shift_allowance'],
      people_of_dormitory: json['people_of_dormitory'],
      required_certificates: json['required_certificates'],
      rest_day_count: json['rest_day_count'],
      training_content: json['training_content'],
      training_time: json['training_time'],
      way_to_work: json['way_to_work'],
      working_hours: json['working_hours'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age_requirements'] = this.age_requirements;
    data['dietary_standard'] = this.dietary_standard;
    data['dormitory_location'] = this.dormitory_location;
    data['ethnic_restrictions'] = this.ethnic_restrictions;
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['is_experience'] = this.is_experience;
    data['is_insurance'] = this.is_insurance;
    data['is_toilet'] = this.is_toilet;
    data['night_shift_allowance'] = this.night_shift_allowance;
    data['people_of_dormitory'] = this.people_of_dormitory;
    data['required_certificates'] = this.required_certificates;
    data['rest_day_count'] = this.rest_day_count;
    data['training_content'] = this.training_content;
    data['training_time'] = this.training_time;
    data['way_to_work'] = this.way_to_work;
    data['working_hours'] = this.working_hours;
    return data;
  }
}
