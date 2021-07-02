
import 'package:demo2020/Model/EventsStaff.dart';

class WalletModel {
    String balance;
    String create_time;
    String egg_coin;
    int id;
    List<WLog> logs;
    String uid;
    String update_time;
    EUser user;

    WalletModel({this.balance = "0.0", this.create_time, this.egg_coin = "0.0", this.id, this.logs, this.uid, this.update_time, this.user});

    factory WalletModel.fromJson(Map<String, dynamic> json) {
        return WalletModel(
            balance: double.parse(json['balance']).toString(),
            create_time: json['create_time'], 
            egg_coin: double.parse(json['egg_coin']).toString(),
            id: json['id'], 
            logs: json['logs'] != null ? (json['logs'] as List).map((i) => WLog.fromJson(i)).toList() : null,
            uid: json['uid'].toString(),
            update_time: json['update_time'], 
            user: json['user'] != null ? EUser.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['balance'] = this.balance;
        data['create_time'] = this.create_time;
        data['egg_coin'] = this.egg_coin;
        data['id'] = this.id;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        if (this.logs != null) {
            data['logs'] = this.logs.map((v) => v.toJson()).toList();
        }
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}

class WLog {
    String amount;
    bool amount_type;
    String balance;
    String create_time;
    String deduction;
    String egg_coin;
    WEtype etype;
    int id;
    String single_number;
    int status;
    int tid;
    int uid;
    String update_time;
    int wid;

    WLog({this.amount, this.amount_type, this.balance, this.create_time, this.deduction, this.egg_coin, this.etype, this.id, this.single_number, this.status, this.tid, this.uid, this.update_time, this.wid});

    factory WLog.fromJson(Map<String, dynamic> json) {
        return WLog(
            amount: json['amount'], 
            amount_type: json['amount_type'] == 1 ? true : false,
            balance: json['balance'], 
            create_time: json['create_time'], 
            deduction: json['deduction'], 
            egg_coin: json['egg_coin'], 
            etype: json['etype'] != null ? WEtype.fromJson(json['etype']) : null,
            id: json['id'], 
            single_number: json['single_number'], 
            status: json['status'], 
            tid: json['tid'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
            wid: json['wid'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['amount_type'] = this.amount_type;
        data['balance'] = this.balance;
        data['create_time'] = this.create_time;
        data['deduction'] = this.deduction;
        data['egg_coin'] = this.egg_coin;
        data['id'] = this.id;
        data['single_number'] = this.single_number;
        data['status'] = this.status;
        data['tid'] = this.tid;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        data['wid'] = this.wid;
        if (this.etype != null) {
            data['etype'] = this.etype.toJson();
        }
        return data;
    }
}

class WEtype {
    int id;
    String title;

    WEtype({this.id, this.title});

    factory WEtype.fromJson(Map<String, dynamic> json) {
        return WEtype(
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


