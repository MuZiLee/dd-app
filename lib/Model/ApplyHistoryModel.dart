
import 'User.dart';

class ApplyHistoryModel {
    String create_time;
    int etid;
    Etype etype;
    int fid;
    int id;
    int jid;
    List<Log> logs;
    Partner partner;
    int pid;
    int uid;
    String update_time;
    User user;

    ApplyHistoryModel({this.create_time, this.etid, this.etype, this.fid, this.id, this.jid, this.logs, this.partner, this.pid, this.uid, this.update_time, this.user});

    factory ApplyHistoryModel.fromJson(Map<String, dynamic> json) {
        return ApplyHistoryModel(
            create_time: json['create_time'], 
            etid: json['etid'], 
            etype: json['etype'] != null ? Etype.fromJson(json['etype']) : null, 
            fid: json['fid'], 
            id: json['id'], 
            jid: json['jid'], 
            logs: json['logs'] != null ? (json['logs'] as List).map((i) => Log.fromJson(i)).toList() : null, 
            partner: json['partner'] != null ? Partner.fromJson(json['partner']) : null, 
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
        if (this.logs != null) {
            data['logs'] = this.logs.map((v) => v.toJson()).toList();
        }
        if (this.partner != null) {
            data['partner'] = this.partner.toJson();
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
    int rid;
    Role role;
    int status;
    int uid;
    String update_time;
    UserX user;

    Log({this.create_time, this.eid, this.id, this.remark, this.rid, this.role, this.status, this.uid, this.update_time, this.user});

    factory Log.fromJson(Map<String, dynamic> json) {
        return Log(
            create_time: json['create_time'], 
            eid: json['eid'], 
            id: json['id'], 
            remark: json['remark'], 
            rid: json['rid'], 
            role: json['role'] != null ? Role.fromJson(json['role']) : null, 
            status: json['status'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
            user: json['user'] != null ? UserX.fromJson(json['user']) : null, 
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

class Partner {
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

    Partner({this.age, this.avatar, this.birthday, this.code, this.create_time, this.id, this.isAdmin, this.isDeath, this.phone, this.registrationID, this.said, this.sex, this.update_time, this.username});

    factory Partner.fromJson(Map<String, dynamic> json) {
        return Partner(
            age: json['age'], 
            avatar: json['avatar'], 
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
    List<RoleX> roles;
    int said;
    int sex;
    String update_time;
    String username;

    UserX({this.age, this.avatar, this.birthday, this.code, this.create_time, this.id, this.isAdmin, this.isDeath, this.phone, this.registrationID, this.roles, this.said, this.sex, this.update_time, this.username});

    factory UserX.fromJson(Map<String, dynamic> json) {
        return UserX(
            age: json['age'], 
            avatar: json['avatar'], 
            birthday: json['birthday'], 
            code: json['code'], 
            create_time: json['create_time'], 
            id: json['id'], 
            isAdmin: json['isAdmin'], 
            isDeath: json['isDeath'], 
            phone: json['phone'], 
            registrationID: json['registrationID'], 
            roles: json['roles'] != null ? (json['roles'] as List).map((i) => RoleX.fromJson(i)).toList() : null, 
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
        if (this.roles != null) {
            data['roles'] = this.roles.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class RoleX {
    int id;
    String title;

    RoleX({this.id, this.title});

    factory RoleX.fromJson(Map<String, dynamic> json) {
        return RoleX(
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