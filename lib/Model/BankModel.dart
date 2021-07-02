

import 'package:one/Model/User.dart';


class BankModel {
    String bank;
    String bank_code;
    int id;
    String rate;
    String title;

    BankModel({this.bank, this.bank_code, this.id, this.rate, this.title});

    factory BankModel.fromJson(Map<String, dynamic> json) {
        return BankModel(
            bank: json['bank'], 
            bank_code: json['bank_code'], 
            id: json['id'], 
            rate: json['rate'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bank'] = this.bank;
        data['bank_code'] = this.bank_code;
        data['id'] = this.id;
        data['rate'] = this.rate;
        data['title'] = this.title;
        return data;
    }
}

class BankValidateModel {
    String bank;
    String cardType;
    String key;
    List<BMssages> messages;
    String stat;
    bool validated;

    BankValidateModel({this.bank, this.cardType, this.key, this.messages, this.stat, this.validated});

    factory BankValidateModel.fromJson(Map<String, dynamic> json) {
        return BankValidateModel(
            bank: json['bank'],
            cardType: json['cardType'],
            key: json['key'],
            messages: json['messages'] != null ? (json['messages'] as List).map((i) => BMssages.fromJson(i)).toList() : null,
            stat: json['stat'],
            validated: json['validated'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bank'] = this.bank;
        data['cardType'] = this.cardType;
        data['key'] = this.key;
        data['stat'] = this.stat;
        data['validated'] = this.validated;
        if (this.messages != null) {
            data['messages'] = this.messages.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class BMssages {
    String errorCodes;
    String name;

    BMssages({this.errorCodes, this.name});

    factory BMssages.fromJson(Map<String, dynamic> json) {
        return BMssages(
            errorCodes: json['errorCodes'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCodes'] = this.errorCodes;
        data['name'] = this.name;
        return data;
    }
}


class MyBankModel {
    Bank bank;
    int bid;
    String create_time;
    int id;
    String name;
    String number;
    int uid;
    String update_time;

    MyBankModel({this.bank, this.bid, this.create_time, this.id, this.name, this.number, this.uid, this.update_time});

    factory MyBankModel.fromJson(Map<String, dynamic> json) {
        return MyBankModel(
            bank: json['bank'] != null ? Bank.fromJson(json['bank']) : null, 
            bid: json['bid'], 
            create_time: json['create_time'], 
            id: json['id'], 
            name: json['name'], 
            number: json['number'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bid'] = this.bid;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['name'] = this.name;
        data['number'] = this.number;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        if (this.bank != null) {
            data['bank'] = this.bank.toJson();
        }
        return data;
    }
}

class Bank {
    String bank;
    String bank_code;
    int id;
    String rate;
    String title;

    Bank({this.bank, this.bank_code, this.id, this.rate, this.title});

    factory Bank.fromJson(Map<String, dynamic> json) {
        return Bank(
            bank: json['bank'], 
            bank_code: json['bank_code'], 
            id: json['id'], 
            rate: json['rate'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bank'] = this.bank;
        data['bank_code'] = this.bank_code;
        data['id'] = this.id;
        data['rate'] = this.rate;
        data['title'] = this.title;
        return data;
    }
}