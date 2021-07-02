
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Model/ShopProductsModel.dart';

class ShopCartModel {
    int count;
    String create_time;
    int id;
    int cid;
    ShopProductsModel order;
    double price;
    int sid;
    int status;
    EUser suser;
    int uid;
    String update_time;
    EUser user;
    bool isSelect = true;

    ShopCartModel({this.count, this.create_time, this.id, this.cid, this.order, this.price, this.sid, this.status, this.suser, this.uid, this.update_time, this.user});

    factory ShopCartModel.fromJson(Map<String, dynamic> json) {
        return ShopCartModel(
            count: json['count'], 
            create_time: json['create_time'], 
            id: json['id'],
            cid: json['cid'],
            order: json['order'] != null ? ShopProductsModel.fromJson(json['order']) : null,
            price: json['price'] != null ? double.parse(json['price'].toString()) : 0.00,
            sid: json['sid'], 
            status: json['status'], 
            suser: json['suser'] != null ? EUser.fromJson(json['suser']) : null,
            uid: json['uid'], 
            update_time: json['update_time'], 
            user: json['user'] != null ? EUser.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['cid'] = this.cid;
        data['price'] = this.price;
        data['sid'] = this.sid;
        data['status'] = this.status;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        if (this.order != null) {
            data['order'] = this.order.toJson();
        }
        if (this.suser != null) {
            data['suser'] = this.suser.toJson();
        }
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}


