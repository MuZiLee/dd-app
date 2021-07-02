
import 'package:demo2020/config.dart';

class ShopCategory {
    int id;
    String image;
    String name;

    ShopCategory({this.id, this.image, this.name});

    factory ShopCategory.fromJson(Map<String, dynamic> json) {
        return ShopCategory(
            id: json['id'], 
            image: json['image'] != null ? Config.BASE_URL+json['image'] : Config.resources,
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