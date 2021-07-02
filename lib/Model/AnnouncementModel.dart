
import 'package:one/config.dart';

class AnnouncementModel {
    String body;
    String create_time;
    String dandan_cost;
    String desn;
    int id;
    String image;
    String much_money;
    int pay_count;
    String title;
    int type;
    List<String> visible;

    AnnouncementModel({this.body, this.create_time, this.dandan_cost, this.desn, this.id, this.image, this.much_money, this.pay_count, this.title, this.type, this.visible});

    factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
        return AnnouncementModel(
            body: json['body'], 
            create_time: json['create_time'], 
            dandan_cost: json['dandan_cost'], 
            desn: json['desn'], 
            id: json['id'], 
            image: json['image'] != null ? Config.BASE_URL+json['image'] : Config.resources,
            much_money: json['much_money'], 
            pay_count: json['pay_count'], 
            title: json['title'], 
            type: json['type'], 
            visible: json['visible'] != null ? new List<String>.from(json['visible']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['body'] = this.body;
        data['create_time'] = this.create_time;
        data['dandan_cost'] = this.dandan_cost;
        data['desn'] = this.desn;
        data['id'] = this.id;
        data['image'] = this.image;
        data['much_money'] = this.much_money;
        data['pay_count'] = this.pay_count;
        data['title'] = this.title;
        data['type'] = this.type;
        if (this.visible != null) {
            data['visible'] = this.visible;
        }
        return data;
    }
}