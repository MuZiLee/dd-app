class Resume {
  String create_time;
  String education;
  List<Educational> educational = [];
  int id;
  int marriage = 0;
  String nation;
  String origin;
  String sos_name;
  String sos_phone;
  String speciality;
  int uid;
  String update_time;
  List<Work> work = [];

  Resume(
      {this.create_time,
      this.education,
      this.educational,
      this.id,
      this.marriage,
      this.nation,
      this.origin,
      this.sos_name,
      this.sos_phone,
      this.speciality,
      this.uid,
      this.update_time,
      this.work});

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      create_time: json['create_time'],
      education: json['education'],
      educational: json['educational'] != null
          ? (json['educational'] as List)
              .map((i) => Educational.fromJson(i))
              .toList()
          : null,
      id: json['id'],
      marriage: json['marriage'],
      nation: json['nation'],
      origin: json['origin'],
      sos_name: json['sos_name'],
      sos_phone: json['sos_phone'],
      speciality: json['speciality'],
      uid: json['uid'],
      update_time: json['update_time'],
      work: json['work'] != null
          ? (json['work'] as List).map((i) => Work.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['education'] = this.education;
    data['id'] = this.id;
    data['marriage'] = this.marriage;
    data['nation'] = this.nation;
    data['origin'] = this.origin;
    data['sos_name'] = this.sos_name;
    data['sos_phone'] = this.sos_phone;
    data['speciality'] = this.speciality;
    data['uid'] = this.uid;
    data['update_time'] = this.update_time;
    if (this.educational != null) {
      data['educational'] = this.educational.map((v) => v.toJson()).toList();
    }
    if (this.work != null) {
      data['work'] = this.work.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Educational {
  int id = 0;
  String education;
  String school;
  String major;
  String graduation_time;
  int uid;
  String create_time;
  String update_time;

  Educational(
      {this.id,
      this.education,
      this.school,
      this.major,
      this.graduation_time,
      this.uid,
      this.create_time,
      this.update_time});

  factory Educational.fromJson(Map<String, dynamic> json) {
    return Educational(
      id: json['id'],
      education: json['education'],
      school: json['school'],
      major: json['major'],
      graduation_time: json['graduation_time'],
      uid: json['uid'],
      create_time: json['create_time'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['education'] = this.education;
    data['school'] = this.school;
    data['major'] = this.major;
    data['graduation_time'] = this.graduation_time;
    data['uid'] = this.uid;
    data['create_time'] = this.create_time;
    data['update_time'] = this.update_time;
    return data;
  }
}

class Work {
  int id;
  String company_name;
  String company_address;
  String company_phone;
  String company_job;
  String work_time;
  String dimission_time;
  String work_content;
  int uid;
  String create_time;
  String update_time;

  Work(
      {this.id,
      this.company_name,
      this.company_address,
      this.company_phone,
      this.company_job,
      this.work_time,
      this.dimission_time,
      this.work_content,
      this.uid,
      this.create_time,
      this.update_time});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: json['id'],
      company_name: json['company_name'],
      company_address: json['company_address'],
      company_phone: json['company_phone'],
      company_job: json['company_job'],
      work_time: json['work_time'],
      dimission_time: json['dimission_time'],
      work_content: json['work_content'],
      uid: json['uid'],
      create_time: json['create_time'],
      update_time: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.company_name;
    data['company_address'] = this.company_address;
    data['company_phone'] = this.company_phone;
    data['company_job'] = this.company_job;
    data['work_time'] = this.work_time;
    data['dimission_time'] = this.dimission_time;
    data['work_content'] = this.work_content;
    data['uid'] = this.uid;
    data['create_time'] = this.create_time;
    data['update_time'] = this.update_time;
    return data;
  }
}
