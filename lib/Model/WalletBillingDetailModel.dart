
class WalletBillingDetailModel {
    String amount;
    String amount_type;
    String balance;
    String create_time;
    String deduction;
    String egg_coin;
    String egg_amount;
    Etype etype;
    int id;
    String single_number;
    int status;
    int tid;
    int uid;
    String update_time;
    int wid;

    WalletBillingDetailModel({this.amount, this.egg_amount, this.amount_type, this.balance, this.create_time, this.deduction, this.egg_coin, this.etype, this.id, this.single_number, this.status, this.tid, this.uid, this.update_time, this.wid});

    factory WalletBillingDetailModel.fromJson(Map<String, dynamic> json) {
        return WalletBillingDetailModel(
            amount: json['amount'],
            egg_amount: json['egg_amount'],
            amount_type: json['amount_type'],
            balance: json['balance'],
            create_time: json['create_time'],
            deduction: json['deduction'],
            egg_coin: json['egg_coin'],
            etype: json['etype'] != null ? Etype.fromJson(json['etype']) : null,
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
        data['egg_amount'] = this.egg_amount;
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

class Etype {
    int id;
    String title;

    Etype({this.id, this.title});

    factory Etype.fromJson(Map<String, dynamic> json) {
        return Etype(
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