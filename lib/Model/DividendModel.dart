
class DividendModel {
    String amount;
    String create_time;
    Factory factory;
    int fid;
    int id;
    int isWithdraw;
    int jid;
    String proportion;
    int rid;
    String type;
    int uid;
    String wages;

    DividendModel({this.amount, this.create_time, this.factory, this.fid, this.id, this.isWithdraw, this.jid, this.proportion, this.rid, this.type, this.uid, this.wages});

    factory DividendModel.fromJson(Map<String, dynamic> json) {
        return DividendModel(
            amount: json['amount'], 
            create_time: json['create_time'], 
            factory: json['factory'] != null ? Factory.fromJson(json['factory']) : null, 
            fid: json['fid'], 
            id: json['id'], 
            isWithdraw: json['isWithdraw'], 
            jid: json['jid'], 
            proportion: json['proportion'], 
            rid: json['rid'], 
            type: json['type'], 
            uid: json['uid'], 
            wages: json['wages'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['create_time'] = this.create_time;
        data['fid'] = this.fid;
        data['id'] = this.id;
        data['isWithdraw'] = this.isWithdraw;
        data['jid'] = this.jid;
        data['proportion'] = this.proportion;
        data['rid'] = this.rid;
        data['type'] = this.type;
        data['uid'] = this.uid;
        data['wages'] = this.wages;
        if (this.factory != null) {
            data['factory'] = this.factory.toJson();
        }
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
    String latitude;
    String location;
    String logo;
    String longitude;
    String province;
    String remark;
    int status;
    int uid;
    String update_time;

    Factory({this.addres, this.city, this.create_time, this.district, this.factory_name, this.id, this.latitude, this.location, this.logo, this.longitude, this.province, this.remark, this.status, this.uid, this.update_time});

    factory Factory.fromJson(Map<String, dynamic> json) {
        return Factory(
            addres: json['addres'], 
            city: json['city'], 
            create_time: json['create_time'], 
            district: json['district'], 
            factory_name: json['factory_name'], 
            id: json['id'], 
            latitude: json['latitude'], 
            location: json['location'], 
            logo: json['logo'], 
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
        return data;
    }
}