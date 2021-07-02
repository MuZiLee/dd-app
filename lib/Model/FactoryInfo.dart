class FactoryInfo {
    String addres;
    String city;
    String create_time;
    String district;
    String factory_name;
    int id;
    List<Image> images;
    Information information;
    String latitude;
    String location;
    String logo;
    String longitude;
    Personnel personnel;
    String province;
    String remark;
    SigningInformation signingInformation;
    int status;
    int uid;
    String update_time;

    FactoryInfo({this.addres, this.city, this.create_time, this.district, this.factory_name, this.id, this.images, this.information, this.latitude, this.location, this.logo, this.longitude, this.personnel, this.province, this.remark, this.signingInformation, this.status, this.uid, this.update_time});

    factory FactoryInfo.fromJson(Map<String, dynamic> json) {
        return FactoryInfo(
            addres: json['addres'],
            city: json['city'],
            create_time: json['create_time'],
            district: json['district'],
            factory_name: json['factory_name'],
            id: json['id'],
            images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
            information: json['information'] != null ? Information.fromJson(json['information']) : null,
            latitude: json['latitude'],
            location: json['location'],
            logo: json['logo'],
            longitude: json['longitude'],
            personnel: json['personnel'] != null ? Personnel.fromJson(json['personnel']) : null,
            province: json['province'],
            remark: json['remark'],
            signingInformation: json['signingInformation'] != null ? SigningInformation.fromJson(json['signingInformation']) : null,
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

        if (this.images != null) {
            data['images'] = this.images.map((v) => v.toJson()).toList();
        }
        if (this.information != null) {
            data['information'] = this.information.toJson();
        }

        if (this.personnel != null) {
            data['personnel'] = this.personnel.toJson();
        }
        if (this.signingInformation != null) {
            data['signingInformation'] = this.signingInformation.toJson();
        }

        return data;
    }
}

class Image {
    int fid;
    int id;
    String url;

    Image({this.fid, this.id, this.url});

    factory Image.fromJson(Map<String, dynamic> json) {
        return Image(
            fid: json['fid'],
            id: json['id'],
            url: json['url'],
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

class Personnel {
    int fid;
    String follow_up_person;
    String follow_up_person_phone;
    String houseparent;
    String houseparent_phone;
    int id;
    String receptionist;
    String receptionist_phone;

    Personnel({this.fid, this.follow_up_person, this.follow_up_person_phone, this.houseparent, this.houseparent_phone, this.id, this.receptionist, this.receptionist_phone});

    factory Personnel.fromJson(Map<String, dynamic> json) {
        return Personnel(
            fid: json['fid'],
            follow_up_person: json['follow_up_person'],
            follow_up_person_phone: json['follow_up_person_phone'],
            houseparent: json['houseparent'],
            houseparent_phone: json['houseparent_phone'],
            id: json['id'],
            receptionist: json['receptionist'],
            receptionist_phone: json['receptionist_phone'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fid'] = this.fid;
        data['follow_up_person'] = this.follow_up_person;
        data['follow_up_person_phone'] = this.follow_up_person_phone;
        data['houseparent'] = this.houseparent;
        data['houseparent_phone'] = this.houseparent_phone;
        data['id'] = this.id;
        data['receptionist'] = this.receptionist;
        data['receptionist_phone'] = this.receptionist_phone;
        return data;
    }
}

class SigningInformation {
    String commission_for_salesman;
    String commission_for_teacher;
    String cooperation_mode;
    String employee_unit_price;
    String endTime;
    int fid;
    int id;
    String income_tax;
    String insurance_premium;
    String salary_payment_method;
    String settlement_date;
    String signed_unit_price;
    String startTime;

    SigningInformation({this.commission_for_salesman, this.commission_for_teacher, this.cooperation_mode, this.employee_unit_price, this.endTime, this.fid, this.id, this.income_tax, this.insurance_premium, this.salary_payment_method, this.settlement_date, this.signed_unit_price, this.startTime});

    factory SigningInformation.fromJson(Map<String, dynamic> json) {
        return SigningInformation(
            commission_for_salesman: json['commission_for_salesman'],
            commission_for_teacher: json['commission_for_teacher'],
            cooperation_mode: json['cooperation_mode'],
            employee_unit_price: json['employee_unit_price'],
            endTime: json['endTime'],
            fid: json['fid'],
            id: json['id'],
            income_tax: json['income_tax'],
            insurance_premium: json['insurance_premium'],
            salary_payment_method: json['salary_payment_method'],
            settlement_date: json['settlement_date'],
            signed_unit_price: json['signed_unit_price'],
            startTime: json['startTime'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['commission_for_salesman'] = this.commission_for_salesman;
        data['commission_for_teacher'] = this.commission_for_teacher;
        data['cooperation_mode'] = this.cooperation_mode;
        data['employee_unit_price'] = this.employee_unit_price;
        data['endTime'] = this.endTime;
        data['fid'] = this.fid;
        data['id'] = this.id;
        data['income_tax'] = this.income_tax;
        data['insurance_premium'] = this.insurance_premium;
        data['salary_payment_method'] = this.salary_payment_method;
        data['settlement_date'] = this.settlement_date;
        data['signed_unit_price'] = this.signed_unit_price;
        data['startTime'] = this.startTime;
        return data;
    }
}



class Pivot {
    int create_time;
    int fid;
    int id;
    String score;
    int uid;
    int update_time;

    Pivot({this.create_time, this.fid, this.id, this.score, this.uid, this.update_time});

    factory Pivot.fromJson(Map<String, dynamic> json) {
        return Pivot(
            create_time: json['create_time'],
            fid: json['fid'],
            id: json['id'],
            score: json['score'],
            uid: json['uid'],
            update_time: json['update_time'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['fid'] = this.fid;
        data['id'] = this.id;
        data['score'] = this.score;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        return data;
    }
}



class PivotX {
    int create_time;
    int fid;
    int id;
    int score;
    int uid;
    int update_time;

    PivotX({this.create_time, this.fid, this.id, this.score, this.uid, this.update_time});

    factory PivotX.fromJson(Map<String, dynamic> json) {
        return PivotX(
            create_time: json['create_time'],
            fid: json['fid'],
            id: json['id'],
            score: json['score'],
            uid: json['uid'],
            update_time: json['update_time'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['fid'] = this.fid;
        data['id'] = this.id;
        data['score'] = this.score;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;
        return data;
    }
}

