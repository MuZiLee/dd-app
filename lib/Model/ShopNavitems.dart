
import 'package:one/config.dart';

class ShopNavitems {
    String icon;
    int id;
    String title;

    ShopNavitems({this.icon, this.id, this.title});

    factory ShopNavitems.fromJson(Map<String, dynamic> json) {
        return ShopNavitems(
            icon: json['icon'] != null ? Config.BASE_URL+json['icon'] : Config.resources,
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}