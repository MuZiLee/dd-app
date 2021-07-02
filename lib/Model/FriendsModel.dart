
import 'package:demo2020/Model/User.dart';

class FriendsModel {
    String create_time;
    int fuid;
    int id;
    int status;
    int tuid;
    User user;

    FriendsModel({this.create_time, this.fuid, this.id, this.status, this.tuid, this.user});

    factory FriendsModel.fromJson(Map<String, dynamic> json) {
        return FriendsModel(
            create_time: json['create_time'], 
            fuid: json['fuid'], 
            id: json['id'], 
            status: json['status'], 
            tuid: json['tuid'],
          user: User.fromJson(json['user']),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['fuid'] = this.fuid;
        data['id'] = this.id;
        data['status'] = this.status;
        data['tuid'] = this.tuid;
        data['user'] = this.user;
        return data;
    }
}