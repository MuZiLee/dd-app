
class AdvanceModel {
    String cost;
    String create_time;
    String end_time;
    int etid;
    int fid;
    String hour;
    int id;
    int jid;
    int pid;
    String remark;
    String start_time;
    int status;
    String total;
    int uid;
    String update_time;

    AdvanceModel({this.cost, this.create_time, this.end_time, this.etid, this.fid, this.hour, this.id, this.jid, this.pid, this.remark, this.start_time, this.status, this.total, this.uid, this.update_time});

    factory AdvanceModel.fromJson(Map<String, dynamic> json) {

        return AdvanceModel(
            cost: json['cost'], 
            create_time: json['create_time'], 
            end_time: json['end_time'], 
            etid: json['etid'], 
            fid: json['fid'], 
            hour: json['hour'], 
            id: json['id'], 
            jid: json['jid'],
            pid: json['pid'], 
            remark: json['remark'], 
            start_time: json['start_time'], 
            status: json['status'], 
            total: json['total'], 
            uid: json['uid'], 
            update_time: json['update_time'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cost'] = this.cost;
        data['create_time'] = this.create_time;
        data['end_time'] = this.end_time;
        data['etid'] = this.etid;
        data['fid'] = this.fid;
        data['hour'] = this.hour;
        data['id'] = this.id;
        data['jid'] = this.jid;
        data['pid'] = this.pid;
        data['remark'] = this.remark;
        data['start_time'] = this.start_time;
        data['status'] = this.status;
        data['total'] = this.total;
        data['uid'] = this.uid;
        data['update_time'] = this.update_time;

        return data;
    }
}