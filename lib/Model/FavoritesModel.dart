
import 'package:one/config.dart';

class FavoriteType {
  /// type:收藏类型
  /// 1:文章收藏
  static const aritcleType = 1;
  /// 2:职位收藏
  static const jobType = 2;
}


class FavoritesModel {
    int cid;
    String create_time;
    int id;
    String image;
    String subtitle;
    String title;
    int type; ///1:文章收藏    2:职位收藏
    int uid;

    FavoritesModel({this.cid, this.create_time, this.id, this.image, this.subtitle, this.title, this.type, this.uid});

    factory FavoritesModel.fromJson(Map<String, dynamic> json) {
        return FavoritesModel(
            cid: json['cid'],
            create_time: json['create_time'],
            id: json['id'],
            image: json['image'] != null ? Config.BASE_URL+json['image'] : Config.resources,
            subtitle: json['subtitle'],
            title: json['title'],
            type: json['type'],
            uid: json['uid'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cid'] = this.cid;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['image'] = this.image;
        data['subtitle'] = this.subtitle;
        data['title'] = this.title;
        data['type'] = this.type;
        data['uid'] = this.uid;
        return data;
    }
}