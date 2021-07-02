
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/config.dart';

class ShopProductsModel {
    String create_time;
    int id;
    List<dynamic> images;
    String name;
    double price;
    int status;
    Stype stype;
    String text;
    int tid;
    int type;
    int uid;
    EUser user;

    ShopProductsModel({this.create_time, this.id, this.images, this.name, this.price, this.status, this.stype, this.text, this.tid, this.type, this.uid, this.user});

    factory ShopProductsModel.fromJson(Map<String, dynamic> json) {

        List _images = [];
        if (json['images'] != null) {
            json['images'].map((e){
                _images.add(e!=null?Config.BASE_URL+e:Config.resources);
            }).toList();
        }

        return ShopProductsModel(
            create_time: json['create_time'], 
            id: json['id'], 
            images: _images,
            name: json['name'], 
            price: json['price'] != null ? double.parse(json['price'].toString()) : 0.00,
            status: json['status'], 
            stype: json['stype'] != null ? Stype.fromJson(json['stype']) : null, 
            text: json['text'], 
            tid: json['tid'], 
            type: json['type'], 
            uid: json['uid'], 
            user: json['user'] != null ? EUser.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['name'] = this.name;
        data['price'] = this.price;
        data['status'] = this.status;
        data['text'] = this.text;
        data['tid'] = this.tid;
        data['type'] = this.type;
        data['uid'] = this.uid;
        if (this.images != null) {
            data['images'] = this.images;
        }
        if (this.stype != null) {
            data['stype'] = this.stype.toJson();
        }
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}



class Stype {
    int id;
    String image;
    String name;

    Stype({this.id, this.image, this.name});

    factory Stype.fromJson(Map<String, dynamic> json) {
        return Stype(
            id: json['id'], 
            image: json['image'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['name'] = this.name;
        return data;
    }
}