

class Enterprise {
  int id;
  int uid;
  String name;
  String province;
  String city;
  String county;
  String address;
  int status;
  String sosname;
  String sosphone;
  Object create_time;
  String update_time;
  String pg;
  String ag;
  String eg;
  String dg;

  Enterprise({this.id, this.uid, this.name, this.province, this.city, this.county, this.address, this.status, this.sosname, this.sosphone, this.create_time, this.update_time, this.pg, this.ag, this.eg, this.dg});

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    return Enterprise(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      province: json['province'],
      city: json['city'],
      county: json['county'],
      address: json['address'],
      status: json['status'],
      sosname: json['sosname'],
      sosphone: json['sosphone'],
      create_time: json['create_time'] != null ? json['create_time'] : "",
      update_time: json['update_time'],
      pg: json['pg'],
      ag: json['ag'],
      eg: json['eg'],
      dg: json['dg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['province'] = this.province;
    data['city'] = this.city;
    data['county'] = this.county;
    data['address'] = this.address;
    data['status'] = this.status;
    data['sosname'] = this.sosname;
    data['sosphone'] = this.sosphone;
    data['update_time'] = this.update_time;
    data['pg'] = this.pg;
    data['ag'] = this.ag;
    data['eg'] = this.eg;
    data['dg'] = this.dg;
    if (this.create_time != null) {
      data['create_time'] = this.create_time;
    }
    return data;
  }
}