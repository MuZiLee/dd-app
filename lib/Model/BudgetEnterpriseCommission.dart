//BudgetEnterpriseCommission

class BudgetEnterpriseCommission {
    String advancedBill;
    String dandanBill;
    Factory factory;
    int fid;
    String hour;
    int id;
    int jid;
    String primaryBill;
    String remark;
    String salesmanBill;
    String signBill;
    String staffBill;
    int status;
    String strategicBill;
    String teacherBill;
    int type;
    int uid;

    BudgetEnterpriseCommission({this.advancedBill, this.dandanBill, this.factory, this.fid, this.hour, this.id, this.jid, this.primaryBill, this.remark, this.salesmanBill, this.signBill, this.staffBill, this.status, this.strategicBill, this.teacherBill, this.type, this.uid});

    factory BudgetEnterpriseCommission.fromJson(Map<String, dynamic> json) {
        return BudgetEnterpriseCommission(
            advancedBill: json['advancedBill'],
            dandanBill: json['dandanBill'],
            factory: json['factory'] != null ? Factory.fromJson(json['factory']) : null,
            fid: json['fid'],
            hour: json['hour'],
            id: json['id'],
            jid: json['jid'],
            primaryBill: json['primaryBill'],
            remark: json['remark'],
            salesmanBill: json['salesmanBill'],
            signBill: json['signBill'],
            staffBill: json['staffBill'],
            status: json['status'],
            strategicBill: json['strategicBill'],
            teacherBill: json['teacherBill'],
            type: json['type'],
            uid: json['uid'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['advancedBill'] = this.advancedBill;
        data['dandanBill'] = this.dandanBill;
        data['fid'] = this.fid;
        data['hour'] = this.hour;
        data['id'] = this.id;
        data['jid'] = this.jid;
        data['primaryBill'] = this.primaryBill;
        data['remark'] = this.remark;
        data['salesmanBill'] = this.salesmanBill;
        data['signBill'] = this.signBill;
        data['staffBill'] = this.staffBill;
        data['status'] = this.status;
        data['strategicBill'] = this.strategicBill;
        data['teacherBill'] = this.teacherBill;
        data['type'] = this.type;
        data['uid'] = this.uid;
        if (this.factory != null) {
            data['factory'] = this.factory.toJson();
        }
        return data;
    }
}

class Factory {
    String addres;
    String city;
    String create_time;
    String district;
    String factory_name;
    int id;
    String latitude;
    String location;
    String logo;
    String longitude;
    String province;
    String remark;
    int status;
    int uid;
    String update_time;

    Factory({this.addres, this.city, this.create_time, this.district, this.factory_name, this.id, this.latitude, this.location, this.logo, this.longitude, this.province, this.remark, this.status, this.uid, this.update_time});

    factory Factory.fromJson(Map<String, dynamic> json) {
        return Factory(
            addres: json['addres'],
            city: json['city'],
            create_time: json['create_time'],
            district: json['district'],
            factory_name: json['factory_name'],
            id: json['id'],
            latitude: json['latitude'],
            location: json['location'],
            logo: json['logo'],
            longitude: json['longitude'],
            province: json['province'],
            remark: json['remark'],
            status: json['status'],
            uid: json['uid'],
            update_time: json['update_time'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['addres'] = this.addres;
        data['city'] = this.city;
        data['create_time'] = this.create_time;
        data['district'] = this.district;
        data['factory_name'] = this.factory_name;
        data['id'] = this.id;
        data['latitude'] = this.latitude;
        data['location'] = this.location;
        data['logo'] = this.logo;
        data['longitude'] = this.longitude;
        data['province'] = this.province;
        data['remark'] = this.remark;
        data['status'] = this.status;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        return data;
    }
}