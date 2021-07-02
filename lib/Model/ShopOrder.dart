
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';

class ShopOrder {
    String addid;
    Addres addres;
    int cid;
    int count;
    String create_time;
    int euid;
    EUser euser;
    int id;
    ShopProductsModel order;
    String price;
    int status;
    int uid;
    String update_time;
    EUser user;

    ShopOrder({this.addid, this.addres, this.cid, this.count, this.create_time, this.euid, this.euser, this.id, this.order, this.price, this.status, this.uid, this.update_time, this.user});

    factory ShopOrder.fromJson(Map<String, dynamic> json) {
        return ShopOrder(
            addid: json['addid'], 
            addres: json['addres'] != null ? Addres.fromJson(json['addres']) : null, 
            cid: json['cid'], 
            count: json['count'], 
            create_time: json['create_time'], 
            euid: json['euid'], 
            euser: json['euser'] != null ? EUser.fromJson(json['euser']) : null,
            id: json['id'], 
            order: json['order'] != null ? ShopProductsModel.fromJson(json['order']) : null,
            price: json['price'], 
            status: json['status'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
            user: json['user'] != null ? EUser.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['addid'] = this.addid;
        data['cid'] = this.cid;
        data['count'] = this.count;
        data['create_time'] = this.create_time;
        data['euid'] = this.euid;
        data['id'] = this.id;
        data['price'] = this.price;
        data['status'] = this.status;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        if (this.addres != null) {
            data['addres'] = this.addres.toJson();
        }
        if (this.euser != null) {
            data['euser'] = this.euser.toJson();
        }
        if (this.order != null) {
            data['order'] = this.order.toJson();
        }
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}

class Addres {
    String addres;
    String city;
    String create_time;
    String district;
    int id;
    int isDefault;
    String name;
    String phone;
    String province;
    int uid;
    String update_time;

    Addres({this.addres, this.city, this.create_time, this.district, this.id, this.isDefault, this.name, this.phone, this.province, this.uid, this.update_time});

    factory Addres.fromJson(Map<String, dynamic> json) {
        return Addres(
            addres: json['addres'], 
            city: json['city'], 
            create_time: json['create_time'], 
            district: json['district'], 
            id: json['id'], 
            isDefault: json['isDefault'], 
            name: json['name'], 
            phone: json['phone'], 
            province: json['province'], 
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
        data['id'] = this.id;
        data['isDefault'] = this.isDefault;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['province'] = this.province;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        return data;
    }
}

