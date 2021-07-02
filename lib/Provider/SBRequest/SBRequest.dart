
import 'package:demo2020/config.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SBRequest extends ChangeNotifier {
  static getServerUrl() async {
    Response response = await post("/api/versions/getServerUrl");
    SBResponse sbResponse = await SBResponse.map(response.data);
    Config.BASE_URL = sbResponse.data;
    print(Config.BASE_URL);
  }

  static post(String url, {arguments, ProgressCallback onSendProgress}) async {
    if (url == null || url?.isEmpty) {
      print("Url不能为空");
      return null;
    }
    print('SBRequest.post');
    print("服务器地址:${Config.BASE_URL}");
    print("请求地址:${url}");
    print('请求参数:${arguments}');
    print("========= start ========");

    var shared = await SharedPreferences.getInstance();
    dynamic token = shared.get("token");
    print("token:${token}");
    BaseOptions options = BaseOptions(
        baseUrl: Config.BASE_URL + "/api/",
        headers: {"token": token != null ? token : ""});
    print(options.baseUrl);
    Dio dio = new Dio(options);

    try {
      Response response = await dio.post(url, data: arguments, onSendProgress: onSendProgress);
      print(response.data);
      return SBResponse.map(response.data);
    } on DioError catch (e) {
      Progresshud.dismiss();
      if (e?.message != null) {
        ZKCommonUtils.showToast(e?.message);
      }
      print("************ post请求出错**********");
      print(e?.request);
      var res = e.response.data;
      print(url);
      print("message:" + e?.message);
      print("⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡");
    }
  }

  static Future<Response> post2(String url,
      {arguments, ProgressCallback onSendProgress}) async {
    if (url == null || url?.isEmpty) {
      print("Url不能为空");
      return null;
    }
    print('SBRequest.post2');
    print("请求地址:${url}");
    print('请求参数:${arguments}');
    print("========= start ========");

    var shared = await SharedPreferences.getInstance();
    dynamic token = shared.get("token");
    BaseOptions options =
        BaseOptions(headers: {"token": token != null ? token : ""});
    Dio dio = new Dio(options);

    Response response = await dio.post(url, queryParameters: arguments, onSendProgress: onSendProgress);
    return response;
  }

  static post3(String url, {arguments}) async {
    if (url == null || url?.isEmpty) {
      print("Url不能为空");
      return null;
    }
    print('SBRequest.post3');
    print("请求地址:${url}");
    print('请求参数:${arguments}');
    print("========= start ========");
    BaseOptions options = BaseOptions();
    Dio dio = new Dio(options);

    Response response = await dio.post(url, queryParameters: arguments);

    return response.data;
  }

  /// 上传文件
  static Future uploadFile({String path, ProgressCallback onSendProgress}) async {

    //注意：dio3.x版本为了兼容web做了一些修改，上传图片的时候需要把File类型转换成String类型
    FormData formData = FormData.fromMap({
      "file":  await MultipartFile.fromFile(path)
    });
    Response response = await Dio().post(Config.BASE_URL+'/api/upload/one', data: formData, onSendProgress: onSendProgress);
    return SBResponse.map(response.data);
  }

}

/// code : 0
/// msg : "成功"
/// page : 1
/// limit : 15
/// data : null
class SBResponse {
  int _code;
  String _msg;
  int _page;
  int _limit;
  dynamic _data;

  int get code => _code;

  String get msg => _msg;

  int get page => _page;

  int get limit => _limit;

  dynamic get data => _data;

  SBResponse(this._code, this._msg, this._page, this._limit, this._data);

  SBResponse.map(dynamic obj) {
    this._code = obj["code"];
    this._msg = obj["msg"];
    this._page = obj["page"];
    this._limit = obj["limit"];
    this._data = obj["data"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["code"] = _code;
    map["msg"] = _msg;
    map["page"] = _page;
    map["limit"] = _limit;
    map["data"] = _data;
    return map;
  }
}
