
class HRFactoryInfoModel {
    BaseicInfo baseicInfo;
    Information information;
    int injobCount;
    int quitCount;

    HRFactoryInfoModel({this.baseicInfo, this.information, this.injobCount, this.quitCount});

    factory HRFactoryInfoModel.fromJson(Map<String, dynamic> json) {
        return HRFactoryInfoModel(
            baseicInfo: json['baseicInfo'] != null ? BaseicInfo.fromJson(json['baseicInfo']) : null, 
            information: json['information'] != null ? Information.fromJson(json['information']) : null, 
            injobCount: json['injobCount'], 
            quitCount: json['quitCount'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['injobCount'] = this.injobCount;
        data['quitCount'] = this.quitCount;
        if (this.baseicInfo != null) {
            data['baseicInfo'] = this.baseicInfo.toJson();
        }
        if (this.information != null) {
            data['information'] = this.information.toJson();
        }
        return data;
    }
}

class BaseicInfo {
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

    BaseicInfo({this.addres, this.city, this.create_time, this.district, this.factory_name, this.id, this.latitude, this.location, this.logo, this.longitude, this.province, this.remark, this.status, this.uid, this.update_time});

    factory BaseicInfo.fromJson(Map<String, dynamic> json) {
        return BaseicInfo(
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

class Information {
    String average_age;
    List<String> bad_jobs;
    String existing_employees;
    String existing_recruitment_channels;
    int expected_demand;
    int fid;
    String fixed_assets;
    int id;
    List<String> labor_shortage_month;
    String nature_of_enterprise;
    String nature_of_plant;
    String plant_area;
    String ratio_of_men_to_women;
    String registered_capital;
    String stable_age;
    List<String> used_jobs;

    Information({this.average_age, this.bad_jobs, this.existing_employees, this.existing_recruitment_channels, this.expected_demand, this.fid, this.fixed_assets, this.id, this.labor_shortage_month, this.nature_of_enterprise, this.nature_of_plant, this.plant_area, this.ratio_of_men_to_women, this.registered_capital, this.stable_age, this.used_jobs});

    factory Information.fromJson(Map<String, dynamic> json) {
        return Information(
            average_age: json['average_age'], 
            bad_jobs: json['bad_jobs'] != null ? new List<String>.from(json['bad_jobs']) : null, 
            existing_employees: json['existing_employees'], 
            existing_recruitment_channels: json['existing_recruitment_channels'], 
            expected_demand: json['expected_demand'], 
            fid: json['fid'], 
            fixed_assets: json['fixed_assets'], 
            id: json['id'], 
            labor_shortage_month: json['labor_shortage_month'] != null ? new List<String>.from(json['labor_shortage_month']) : null, 
            nature_of_enterprise: json['nature_of_enterprise'], 
            nature_of_plant: json['nature_of_plant'], 
            plant_area: json['plant_area'], 
            ratio_of_men_to_women: json['ratio_of_men_to_women'], 
            registered_capital: json['registered_capital'], 
            stable_age: json['stable_age'], 
            used_jobs: json['used_jobs'] != null ? new List<String>.from(json['used_jobs']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['average_age'] = this.average_age;
        data['existing_employees'] = this.existing_employees;
        data['existing_recruitment_channels'] = this.existing_recruitment_channels;
        data['expected_demand'] = this.expected_demand;
        data['fid'] = this.fid;
        data['fixed_assets'] = this.fixed_assets;
        data['id'] = this.id;
        data['nature_of_enterprise'] = this.nature_of_enterprise;
        data['nature_of_plant'] = this.nature_of_plant;
        data['plant_area'] = this.plant_area;
        data['ratio_of_men_to_women'] = this.ratio_of_men_to_women;
        data['registered_capital'] = this.registered_capital;
        data['stable_age'] = this.stable_age;
        if (this.bad_jobs != null) {
            data['bad_jobs'] = this.bad_jobs;
        }
        if (this.labor_shortage_month != null) {
            data['labor_shortage_month'] = this.labor_shortage_month;
        }
        if (this.used_jobs != null) {
            data['used_jobs'] = this.used_jobs;
        }
        return data;
    }
}