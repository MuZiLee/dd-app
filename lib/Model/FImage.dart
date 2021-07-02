
import 'package:one/config.dart';

class FImage {
  int fid;
  int id;
  String url;

  FImage({this.fid, this.id, this.url});

  factory FImage.fromJson(Map<String, dynamic> json) {
    return FImage(
      fid: json['fid'],
      id: json['id'],
      url: json['url'] != null
          ? Config.BASE_URL + json['url']
          : Config.resources,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fid'] = this.fid;
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}