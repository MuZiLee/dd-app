
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Model/SigingInformation.dart';
import 'package:demo2020/config.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

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
  List<Role> roles;
  int said;
  int sex;
  List<dynamic> owned;
  List<dynamic> rtitles;
  Staff staff; //员工
  Partner partner; //上级->上级所属于战略
  Company company; //自己的战略
  List<Hr> hrs;
  List<Teacher> teachers;
  String update_time;
  String username;
  JMUserInfo jmUserInfo;

  User(
      {this.age,
      this.avatar,
      this.birthday,
      this.code,
      this.company,
      this.create_time,
      this.hrs,
      this.id,
      this.isAdmin,
      this.isDeath,
      this.phone,
      this.registrationID,
      this.roles,
      this.said,
      this.sex,
      this.owned,
      this.rtitles,
      this.staff,
      this.partner,
      this.teachers,
      this.update_time,
      this.username});

  factory User.fromJson(Map<String, dynamic> json) {
//    print("当前用户:" + json['username'].toString());
//    print("拥有角色:" + json['owned'].toString());
    return User(
      age: json['age'],
      avatar: json['avatar'] != null
          ? Config.BASE_URL + json['avatar']
          : Config.BASE_URL + "/resources/avatar.png",
      birthday: json['birthday'],
      code: json['code'],
      company:
          json['company'] != null ? Company.fromJson(json['company']) : null,
      create_time: json['create_time'],
      hrs: json['hrs'] != null
          ? (json['hrs'] as List).map((i) => Hr.fromJson(i)).toList()
          : null,
      id: json['id'],
      isAdmin: json['isAdmin'],
      isDeath: json['isDeath'],
      phone: json['phone'],
      registrationID: json['registrationID'],
      roles: json['roles'] != null
          ? (json['roles'] as List).map((i) => Role.fromJson(i)).toList()
          : null,
      said: json['said'],
      sex: json['sex'],
      owned: json['owned'] != null ? json['owned'] : null,
      rtitles: json['rtitles'] != null ? json['rtitles'] : null,
      staff: json['staff'] != null ? Staff.fromJson(json['staff']) : null,
      partner:
          json['partner'] != null ? Partner.fromJson(json['partner']) : null,
      teachers: json['teachers'] != null
          ? (json['teachers'] as List).map((i) => Teacher.fromJson(i)).toList()
          : null,
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
    data['owned'] = this.owned;
    data['update_time'] = this.update_time;
    data['username'] = this.username;
//    if (this.company != null) {
//      data['company'] = this.company.toJson();
//    }
//    if (this.hrs != null) {
//      data['hrs'] = this.hrs.map((v) => v.toJson()).toList();
//    }
//    if (this.roles != null) {
//      data['roles'] = this.roles.map((v) => v.toJson()).toList();
//    }
//    if (this.staff != null) {
//      data['staff'] = this.staff.toJson();
//    }
//    if (this.partner != null) {
//      data['partner'] = this.partner.toJson();
//    }
//    if (this.teachers != null) {
//      data['teachers'] = this.teachers.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}


class Company {
  String address;
  String city;
  String county;
  String dd_dividend;
  int id;
  String jp_dividend;
  String name;
  String province;
  String sa_dividend;
  String sos_name;
  String soso_phone;
  String sp_dividend;
  int uid;

  Company(
      {this.address,
      this.city,
      this.county,
      this.dd_dividend,
      this.id,
      this.jp_dividend,
      this.name,
      this.province,
      this.sa_dividend,
      this.sos_name,
      this.soso_phone,
      this.sp_dividend,
      this.uid,});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      address: json['address'],
      city: json['city'],
      county: json['county'],
      dd_dividend: json['dd_dividend'],
      id: json['id'],
      jp_dividend: json['jp_dividend'],
      name: json['name'],
      province: json['province'],
      sa_dividend: json['sa_dividend'],
      sos_name: json['sos_name'],
      soso_phone: json['soso_phone'],
      sp_dividend: json['sp_dividend'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['county'] = this.county;
    data['dd_dividend'] = this.dd_dividend;
    data['id'] = this.id;
    data['jp_dividend'] = this.jp_dividend;
    data['name'] = this.name;
    data['province'] = this.province;
    data['sa_dividend'] = this.sa_dividend;
    data['sos_name'] = this.sos_name;
    data['soso_phone'] = this.soso_phone;
    data['sp_dividend'] = this.sp_dividend;
    data['uid'] = this.uid;
    return data;
  }
}

class Hr {
  String addres;
  String city;
  String create_time;
  String district;
  String factory_name;
  int id;
  String latitude;
  String location;
  String logo;
  String longitude;
  PivotX pivot;
  String province;
  int status;
  int uid;
  String update_time;

  Hr(
      {this.addres,
      this.city,
      this.create_time,
      this.district,
      this.factory_name,
      this.id,
      this.latitude,
      this.location,
      this.logo,
      this.longitude,
      this.pivot,
      this.province,
      this.status,
      this.uid,
      this.update_time});

  factory Hr.fromJson(Map<String, dynamic> json) {
    return Hr(
      addres: json['addres'],
      city: json['city'],
      create_time: json['create_time'],
      district: json['district'],
      factory_name: json['factory_name'],
      id: json['id'],
      latitude: json['latitude'],
      location: json['location'],
      logo: json['logo'] != null
          ? Config.BASE_URL + json['logo']
          : Config.BASE_URL + "/resources/logo.png",
      longitude: json['longitude'],
      pivot: json['pivot'] != null ? PivotX.fromJson(json['pivot']) : null,
      province: json['province'],
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
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int create_time;
  int fid;
  int id;
  double score;
  int uid;
  int update_time;

  Pivot(
      {this.create_time,
      this.fid,
      this.id,
      this.score,
      this.uid,
      this.update_time});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    print(json['score']);

    return Pivot(
      create_time: json['create_time'],
      fid: json['fid'],
      id: json['id'],
      score: json['score'] != null
          ? double.parse("${json['score'].toString().padLeft(2, '0')}")
          : 0.00,
      uid: json['uid'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['score'] = this.score;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    return data;
  }
}

class Partner {
  String create_time;
  int id;
  int pid;
  int sid;
  int uid;
  String update_time;
  UserX user;

  Partner(
      {this.create_time,
      this.id,
      this.pid,
      this.sid,
      this.uid,
      this.update_time,
      this.user});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      create_time: json['create_time'],
      id: json['id'],
      pid: json['pid'],
      sid: json['sid'],
      uid: json['uid'],
      update_time: json['update_time'],
      user: json['user'] != null ? UserX.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['sid'] = this.sid;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

/// id : 73
/// code : 999999
/// username : "张国栋"
/// phone : "13416801001"
/// sex : 1
/// age : 39
/// birthday : "2020/04/28"
/// isAdmin : 1
/// isDeath : 0
/// said : 0
/// avatar : "/uploads/images/20200225/81aba86c5789c65ab2e4d9a2fb0eb48e.jpg"
/// registrationID : "120c83f760a78ca0661"
/// create_time : "2020-04-28 08:10:00"
/// update_time : "2020-05-01 04:49:58"
class UserX {
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
  Strategic strategic;
  String update_time;
  String username;

  UserX(
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
      this.strategic,
      this.update_time,
      this.username});

  factory UserX.fromJson(Map<String, dynamic> json) {
    return UserX(
      age: json['age'],
      avatar: json['avatar'] != null
          ? Config.BASE_URL + json['avatar']
          : Config.BASE_URL + "/resources/avatar.png",
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
      strategic: json['strategic'] != null
          ? Strategic.fromJson(json['strategic'])
          : null,
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
    if (this.strategic != null) {
      data['strategic'] = this.strategic.toJson();
    }
    return data;
  }
}

class Strategic {
  String address;
  String city;
  String county;

  String dd_dividend;
  int id;
  String jp_dividend;
  String name;
  String province;
  String sa_dividend;
  String sos_name;
  String soso_phone;
  String sp_dividend;
  int uid;


  Strategic(
      {this.address,
      this.city,
      this.county,
      this.dd_dividend,
      this.id,
      this.jp_dividend,
      this.name,
      this.province,
      this.sa_dividend,
      this.sos_name,
      this.soso_phone,
      this.sp_dividend,
      this.uid,
      });

  factory Strategic.fromJson(Map<String, dynamic> json) {
    return Strategic(
      address: json['address'],
      city: json['city'],
      county: json['county'],
      dd_dividend: json['dd_dividend'],
      id: json['id'],
      jp_dividend: json['jp_dividend'],
      name: json['name'],
      province: json['province'],
      sa_dividend: json['sa_dividend'],
      sos_name: json['sos_name'],
      soso_phone: json['soso_phone'],
      sp_dividend: json['sp_dividend'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['county'] = this.county;
    data['dd_dividend'] = this.dd_dividend;
    data['id'] = this.id;
    data['jp_dividend'] = this.jp_dividend;
    data['name'] = this.name;
    data['province'] = this.province;
    data['sa_dividend'] = this.sa_dividend;
    data['sos_name'] = this.sos_name;
    data['soso_phone'] = this.soso_phone;
    data['sp_dividend'] = this.sp_dividend;
    data['uid'] = this.uid;
    return data;
  }
}

class Teacher {
  String addres;
  String city;
  String create_time;
  String district;
  String factory_name;
  int id;
  String latitude;
  String location;
  String logo;
  String longitude;
  Pivot pivot;
  String province;
  int status;
  int uid;
  SigingInformation sigingInformation;
  String update_time;

  Teacher(
      {this.addres,
      this.city,
      this.create_time,
      this.district,
      this.factory_name,
      this.id,
      this.latitude,
      this.location,
      this.logo,
      this.longitude,
      this.pivot,
      this.province,
      this.status,
      this.uid,
      this.sigingInformation,
      this.update_time});

  factory Teacher.fromJson(Map<String, dynamic> json) {


    return Teacher(
      addres: json['addres'].toString(),
      city: json['city'].toString(),
      create_time: json['create_time'].toString(),
      district: json['district'].toString(),
      factory_name: json['factory_name'].toString(),
      id: json['id'],
      location: json['location'].toString(),
      latitude: json['latitude'].toString(),
      logo: json['logo'] != null
          ? Config.BASE_URL + json['logo']
          : Config.BASE_URL + "/resources/logo.png",
      longitude: json['longitude'].toString(),
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      province: json['province'].toString(),
      status: json['status'],
      uid: json['uid'],
      sigingInformation: json['sigingInformation'] != null ? SigingInformation.fromJson(json['sigingInformation']) : null,
      update_time: json['update_time'].toString(),
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
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}



class PivotX {
  int create_time;
  int fid;
  int id;
  int score;
  int uid;
  int update_time;

  PivotX(
      {this.create_time,
      this.fid,
      this.id,
      this.score,
      this.uid,
      this.update_time});

  factory PivotX.fromJson(Map<String, dynamic> json) {
    return PivotX(
      create_time: json['create_time'],
      fid: json['fid'],
      id: json['id'],
      score: json['score'],
      uid: json['uid'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['score'] = this.score;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    return data;
  }
}

class Staff {
  String create_time;
  Factory factory;
  int fid;
  int id;
  int jid;
  JobModel job;
  int status;
  int uid;
  SigingInformation sigingInformation;
  String update_time;

  Staff(
      {this.create_time,
      this.factory,
      this.fid,
      this.id,
      this.jid,
      this.job,
      this.status,
      this.uid,
      this.sigingInformation,
      this.update_time});

  factory Staff.fromJson(Map<String, dynamic> json) {

    return Staff(
      create_time: json['create_time'] != null ? json['create_time'] : null,
      factory:
          json['factory'] != null ? Factory.fromJson(json['factory']) : null,
      fid: json['fid'],
      id: json['id'],
      jid: json['jid'],
      job: json['job'] != null ? JobModel.fromJson(json['job']) : null,
      sigingInformation: json['siging_information'] != null ? SigingInformation.fromJson(json['siging_information']) : null,
      status: json['status'],
      uid: json['uid'],
      update_time: json['update_time'] != null ? json['update_time'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['jid'] = this.jid;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['create_time'] = this.uid;
    data['update_time'] = this.uid;
    if (this.factory != null) {
      data['factory'] = this.factory.toJson();
    }
    if (this.job != null) {
      data['job'] = this.job.toJson();
    }
    return data;
  }
}

class Role {
  int id;
  String title;

  Role({this.id, this.title});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}


class SBUser {
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

    SBUser({this.age, this.avatar, this.birthday, this.code, this.create_time, this.id, this.isAdmin, this.isDeath, this.phone, this.registrationID, this.said, this.sex, this.update_time, this.username});

    factory SBUser.fromJson(Map<String, dynamic> json) {
        print(json['username']);
        print(json['id']);
        return SBUser(
            age: json['age'],
            avatar: Config.BASE_URL+json['avatar'],
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