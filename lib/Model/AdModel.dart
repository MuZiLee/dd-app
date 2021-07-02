import 'package:one/config.dart';

/// id : 9
/// type : 0: 启动广告 1:banner广告 2:职位广告
/// title : "服装服饰"
/// subtitle : "服装服饰专柜"
/// time : 10
/// image : "/uploads/images/98/e0510f3b4ec81fb98e025002bd7910.jpg"
/// url : "http://www.taobao.com"
/// create_time : "2020-04-27 17:38:16"

class AdModel {
    String create_time;
    int id;
    String image;
    String subtitle;
    int time;
    String title;
    int type;
    String url;

    AdModel({this.create_time, this.id, this.image, this.subtitle, this.time, this.title, this.type, this.url});

    factory AdModel.fromJson(Map<String, dynamic> json) {
        return AdModel(
            create_time: json['create_time'],
            id: json['id'],
            image: json['image'] != null ? Config.BASE_URL+json['image'] : "",
            subtitle: json['subtitle'],
            time: json['time'],
            title: json['title'],
            type: json['type'],
            url: json['url'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['image'] = this.image;
        data['subtitle'] = this.subtitle;
        data['time'] = this.time;
        data['title'] = this.title;
        data['type'] = this.type;
        data['url'] = this.url;
        return data;
    }
}