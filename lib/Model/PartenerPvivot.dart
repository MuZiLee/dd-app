import 'package:demo2020/Model/StrategicAlliance.dart';

class PartenerPvivot {
  String create_time;
  int id;
  int pid;
  int sid;
  int uid;
  String update_time;
  StrategicAlliance strategic;

  PartenerPvivot({
    this.create_time,
    this.id,
    this.pid,
    this.sid,
    this.uid,
    this.update_time,
    this.strategic,
  });

  factory PartenerPvivot.fromJson(Map<String, dynamic> json) {
    return PartenerPvivot(
      create_time: json['create_time'],
      id: json['id'],
      pid: json['pid'],
      sid: json['sid'],
      uid: json['uid'],
      update_time: json['update_time'],
      strategic: json['strategic'] != null ? StrategicAlliance.fromJson(json['strategic']) : null,
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
    if (this.strategic != null) {
      data['strategic'] = this.strategic.toJson();
    }

    return data;
  }
}
