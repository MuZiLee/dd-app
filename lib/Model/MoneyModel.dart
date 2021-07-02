class MoneyModel {
    String advancedBill;
    int advancedId;
    String dandanBill;
    int dandanId;
    int fid;
    String hour;
    int id;
    int jid;
    String primaryBill;
    int primaryId;
    String remark;
    String salesmanBill;
    int salesmanId;
    String signBill;
    String staffBill;
    int status;
    String strategicBill;
    int strategicId;
    String teacherBill;
    int teacherId;
    int type;
    int uid;

    MoneyModel({this.advancedBill, this.advancedId, this.dandanBill, this.dandanId, this.fid, this.hour, this.id, this.jid, this.primaryBill, this.primaryId, this.remark, this.salesmanBill, this.salesmanId, this.signBill, this.staffBill, this.status, this.strategicBill, this.strategicId, this.teacherBill, this.teacherId, this.type, this.uid});

    factory MoneyModel.fromJson(Map<String, dynamic> json) {
        return MoneyModel(
            advancedBill: json['advancedBill'],
            advancedId: json['advancedId'],
            dandanBill: json['dandanBill'],
            dandanId: json['dandanId'],
            fid: json['fid'],
            hour: json['hour'],
            id: json['id'],
            jid: json['jid'],
            primaryBill: json['primaryBill'],
            primaryId: json['primaryId'],
            remark: json['remark'],
            salesmanBill: json['salesmanBill'],
            salesmanId: json['salesmanId'],
            signBill: json['signBill'],
            staffBill: json['staffBill'],
            status: json['status'],
            strategicBill: json['strategicBill'],
            strategicId: json['strategicId'],
            teacherBill: json['teacherBill'],
            teacherId: json['teacherId'],
            type: json['type'],
            uid: json['uid'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['advancedBill'] = this.advancedBill;
        data['advancedId'] = this.advancedId;
        data['dandanBill'] = this.dandanBill;
        data['dandanId'] = this.dandanId;
        data['fid'] = this.fid;
        data['hour'] = this.hour;
        data['id'] = this.id;
        data['jid'] = this.jid;
        data['primaryBill'] = this.primaryBill;
        data['primaryId'] = this.primaryId;
        data['remark'] = this.remark;
        data['salesmanBill'] = this.salesmanBill;
        data['salesmanId'] = this.salesmanId;
        data['signBill'] = this.signBill;
        data['staffBill'] = this.staffBill;
        data['status'] = this.status;
        data['strategicBill'] = this.strategicBill;
        data['strategicId'] = this.strategicId;
        data['teacherBill'] = this.teacherBill;
        data['teacherId'] = this.teacherId;
        data['type'] = this.type;
        data['uid'] = this.uid;
        return data;
    }
}