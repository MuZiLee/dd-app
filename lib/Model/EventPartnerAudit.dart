
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Model/User.dart';

class EventPartnerAudit {
    String create_time;
    int etid;
    Etype etype;
    Factory factory;
    int fid;
    int id;
    int jid;
    JobModel job;
    List<SBLogs> logs;
    int pid;
    int uid;
    String update_time;
    User user;

    EventPartnerAudit({this.create_time, this.etid, this.etype, this.factory, this.fid, this.id, this.jid, this.job, this.logs, this.pid, this.uid, this.update_time, this.user});

    factory EventPartnerAudit.fromJson(Map<String, dynamic> json) {
        return EventPartnerAudit(
            create_time: json['create_time'], 
            etid: json['etid'], 
            etype: json['etype'] != null ? Etype.fromJson(json['etype']) : null, 
            factory: json['factory'] != null ? Factory.fromJson(json['factory']) : null, 
            fid: json['fid'], 
            id: json['id'], 
            jid: json['jid'], 
            job: json['job'] != null ? JobModel.fromJson(json['job']) : null,
            logs: json['logs'] != null ? (json['logs'] as List).map((i) => SBLogs.fromJson(i)).toList() : null,
            pid: json['pid'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['etid'] = this.etid;
        data['fid'] = this.fid;
        data['id'] = this.id;
        data['jid'] = this.jid;
        data['pid'] = this.pid;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        if (this.etype != null) {
            data['etype'] = this.etype.toJson();
        }
        if (this.factory != null) {
            data['factory'] = this.factory.toJson();
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



class SBLogs {
    String create_time;
    int eid;
    int id;
    String remark;
    int rid;
    Role role;
    int status;
    int uid;
    String update_time;
    User user;

    SBLogs({this.create_time, this.eid, this.id, this.remark, this.rid, this.role, this.status, this.uid, this.update_time, this.user});

    factory SBLogs.fromJson(Map<String, dynamic> json) {
        return SBLogs(
            create_time: json['create_time'], 
            eid: json['eid'], 
            id: json['id'], 
            remark: json['remark'], 
            rid: json['rid'], 
            role: json['role'] != null ? Role.fromJson(json['role']) : null, 
            status: json['status'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['eid'] = this.eid;
        data['id'] = this.id;
        data['remark'] = this.remark;
        data['rid'] = this.rid;
        data['status'] = this.status;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        if (this.role != null) {
            data['role'] = this.role.toJson();
        }
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}

