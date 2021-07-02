/// id : 1
/// version : "1.0.0"
/// build : 20042712
/// isStrong : "1"
/// review : 0
/// url : "http://fir.dandankj.com/ddio"
/// title : "版本更新"
/// subtitle : "1:修改一些已知bug"
/// system : "ios"

class VersionModel {
    int build;
    int id;
    int isStrong = 0;
    int review;
    String subtitle;
    String system;
    String title;
    String url;
    String version;

    VersionModel({this.build, this.id, this.isStrong, this.review, this.subtitle, this.system, this.title, this.url, this.version});

    factory VersionModel.fromJson(Map<String, dynamic> json) {
        return VersionModel(
            build: json['build'], 
            id: json['id'], 
            isStrong: json['isStrong'], 
            review: json['review'], 
            subtitle: json['subtitle'], 
            system: json['system'], 
            title: json['title'], 
            url: json['url'], 
            version: json['version'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['build'] = this.build;
        data['id'] = this.id;
        data['isStrong'] = this.isStrong;
        data['review'] = this.review;
        data['subtitle'] = this.subtitle;
        data['system'] = this.system;
        data['title'] = this.title;
        data['url'] = this.url;
        data['version'] = this.version;
        return data;
    }
}