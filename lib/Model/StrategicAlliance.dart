/// id : 73
/// uid : 73
/// name : "张国栋公司"
/// province : "广东省"
/// city : "东莞市"
/// county : "常平镇"
/// address : "口岸大道53号"
/// sos_name : "张国栋"
/// soso_phone : "13416801001"
/// dd_dividend : "11.0"
/// sa_dividend : "27.5"
/// sp_dividend : "16.5"
/// jp_dividend : "45.0"
/// create_time : null
/// update_time : null
/// status : 1
/// dd_service_charge : "3.0"


class StrategicAlliance {


    // 初级分红比例
    String jp_dividend;
    // 高级全红比例
    String sp_dividend;
    // 战略分红比例
    String sa_dividend;
    // 蛋蛋分红比例
    String dd_dividend;

    // 服务费
    String dd_service_charge;

    int id;

    String province;
    String city;
    String county;
    String address;

    int status;

    int uid;
    String name;
    String sos_name;
    String soso_phone;
    String create_time;
    String update_time;

    StrategicAlliance({this.address, this.city, this.county, this.create_time, this.dd_dividend, this.dd_service_charge, this.id, this.jp_dividend, this.name, this.province, this.sa_dividend, this.sos_name, this.soso_phone, this.sp_dividend, this.status, this.uid, this.update_time});

    factory StrategicAlliance.fromJson(Map<String, dynamic> json) {
        return StrategicAlliance(
            address: json['address'], 
            city: json['city'], 
            county: json['county'], 
            create_time: json['create_time'], 
            dd_dividend: json['dd_dividend'], 
            dd_service_charge: json['dd_service_charge'], 
            id: json['id'], 
            jp_dividend: json['jp_dividend'], 
            name: json['name'], 
            province: json['province'], 
            sa_dividend: json['sa_dividend'], 
            sos_name: json['sos_name'], 
            soso_phone: json['soso_phone'], 
            sp_dividend: json['sp_dividend'], 
            status: json['status'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['city'] = this.city;
        data['county'] = this.county;
        data['create_time'] = this.create_time;
        data['dd_dividend'] = this.dd_dividend;
        data['dd_service_charge'] = this.dd_service_charge;
        data['id'] = this.id;
        data['jp_dividend'] = this.jp_dividend;
        data['name'] = this.name;
        data['province'] = this.province;
        data['sa_dividend'] = this.sa_dividend;
        data['sos_name'] = this.sos_name;
        data['soso_phone'] = this.soso_phone;
        data['sp_dividend'] = this.sp_dividend;
        data['status'] = this.status;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        return data;
    }
}