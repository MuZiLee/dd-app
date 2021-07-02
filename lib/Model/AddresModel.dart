class AddresModel {
  String addres;
  String city;
  String create_time;
  String district;
  int id;
  bool isDefault;
  String name;
  String phone;
  String province;
  int uid;
  int index;
  String update_time;

  AddresModel(
      {this.addres,
      this.city,
      this.create_time,
      this.district,
      this.id,
      this.isDefault,
      this.name,
      this.phone,
      this.province,
      this.uid,
      this.index,
      this.update_time});

  factory AddresModel.fromJson(Map<String, dynamic> json) {
    return AddresModel(
      addres: json['addres'],
      city: json['city'],
      create_time: json['create_time'],
      district: json['district'],
      id: json['id'],
      isDefault: json['isDefault'] == null || json['isDefault'] == 0 ? false : true,
      name: json['name'],
      phone: json['phone'],
      province: json['province'],
      uid: json['uid'],
      update_time: json['update_time'],
    );
  }


}
