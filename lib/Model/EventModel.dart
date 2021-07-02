import 'package:demo2020/Model/User.dart';

/// id : 1
/// uid : 73
/// etid : 1
/// create_time : "2020-05-01 06:42:43"
/// update_time : "2020-05-01 06:42:43"
/// etype : {"id":1,"title":"工厂录入","name":"factory_entry"}
/// user : {"id":73,"code":999999,"username":"张国栋","phone":"13416801001","sex":1,"age":39,"birthday":"2020/04/28","isAdmin":1,"isDeath":0,"said":0,"avatar":"/uploads/images/20200225/81aba86c5789c65ab2e4d9a2fb0eb48e.jpg","registrationID":"120c83f760a78ca0661","create_time":"2020-04-28 08:10:00","update_time":"2020-05-01 04:49:58"}
/// logs : [{"id":4,"eid":1,"rid":3,"uid":73,"status":1,"remark":"","create_time":"2020-05-01 07:03:30","update_time":"2020-05-01 07:03:30","role":{"id":3,"title":"工人"},"user":{"id":73,"code":999999,"username":"张国栋","phone":"13416801001","sex":1,"age":39,"birthday":"2020/04/28","isAdmin":1,"isDeath":0,"said":0,"avatar":"/uploads/images/20200225/81aba86c5789c65ab2e4d9a2fb0eb48e.jpg","registrationID":"120c83f760a78ca0661","create_time":"2020-04-28 08:10:00","update_time":"2020-05-01 04:49:58"}}]

class EventsModel {
  int _id;
  int _uid;
  int _etid;
  String _createTime;
  String _updateTime;
  EtypeBean _etype;
  UserX _user;
  List<LogsBean> _logs;

  int get id => _id;

  int get uid => _uid;

  int get etid => _etid;

  String get createTime => _createTime;

  String get updateTime => _updateTime;

  EtypeBean get etype => _etype;

  UserX get user => _user;

  List<LogsBean> get logs => _logs;

  EventsModel(this._id, this._uid, this._etid, this._createTime,
      this._updateTime, this._etype, this._user, this._logs);

  EventsModel.map(dynamic obj) {
    this._id = obj["id"];
    this._uid = obj["uid"];
    this._etid = obj["etid"];
    this._createTime = obj["createTime"];
    this._updateTime = obj["updateTime"];
    this._etype = obj["etype"];
    this._user = obj["user"];
    this._logs = obj["logs"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["uid"] = _uid;
    map["etid"] = _etid;
    map["createTime"] = _createTime;
    map["updateTime"] = _updateTime;
    map["etype"] = _etype;
    map["user"] = _user;
    map["logs"] = _logs;
    return map;
  }
}

/// id : 4
/// eid : 1
/// rid : 3
/// uid : 73
/// status : 1
/// remark : ""
/// create_time : "2020-05-01 07:03:30"
/// update_time : "2020-05-01 07:03:30"
/// role : {"id":3,"title":"工人"}
/// user : {"id":73,"code":999999,"username":"张国栋","phone":"13416801001","sex":1,"age":39,"birthday":"2020/04/28","isAdmin":1,"isDeath":0,"said":0,"avatar":"/uploads/images/20200225/81aba86c5789c65ab2e4d9a2fb0eb48e.jpg","registrationID":"120c83f760a78ca0661","create_time":"2020-04-28 08:10:00","update_time":"2020-05-01 04:49:58"}

class LogsBean {
  int _id;
  int _eid;
  int _rid;
  int _uid;
  int _status;
  String _remark;
  String _createTime;
  String _updateTime;
  RoleBean _role;
  UserX _user;

  int get id => _id;

  int get eid => _eid;

  int get rid => _rid;

  int get uid => _uid;

  int get status => _status;

  String get remark => _remark;

  String get createTime => _createTime;

  String get updateTime => _updateTime;

  RoleBean get role => _role;

  UserX get user => _user;

  LogsBean(this._id, this._eid, this._rid, this._uid, this._status,
      this._remark, this._createTime, this._updateTime, this._role, this._user);

  LogsBean.map(dynamic obj) {
    this._id = obj["id"];
    this._eid = obj["eid"];
    this._rid = obj["rid"];
    this._uid = obj["uid"];
    this._status = obj["status"];
    this._remark = obj["remark"];
    this._createTime = obj["createTime"];
    this._updateTime = obj["updateTime"];
    this._role = obj["role"];
    this._user = obj["user"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["eid"] = _eid;
    map["rid"] = _rid;
    map["uid"] = _uid;
    map["status"] = _status;
    map["remark"] = _remark;
    map["createTime"] = _createTime;
    map["updateTime"] = _updateTime;
    map["role"] = _role;
    map["user"] = _user;
    return map;
  }
}



/// id : 3
/// title : "工人"

class RoleBean {
  int _id;
  String _title;

  int get id => _id;

  String get title => _title;

  RoleBean(this._id, this._title);

  RoleBean.map(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["title"] = _title;
    return map;
  }
}


/// id : 1
/// title : "工厂录入"
/// name : "factory_entry"

class EtypeBean {
  int _id;
  String _title;
  String _name;

  int get id => _id;

  String get title => _title;

  String get name => _name;

  EtypeBean(this._id, this._title, this._name);

  EtypeBean.map(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];
    this._name = obj["name"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["title"] = _title;
    map["name"] = _name;
    return map;
  }
}
