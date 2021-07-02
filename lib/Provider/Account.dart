import 'dart:convert';

import 'package:demo2020/Controller/Login/LoginViewController.dart';
import 'package:demo2020/Controller/TabBar/SBTabbarViewController.dart';
import 'package:demo2020/Model/FriendsModel.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_random_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends ChangeNotifier {
  static User user;

  /**普通的用户**/
  static int ordinary_users = 1;
  /**会员**/
  static int member = 2;
  /**工人**/
  static int worker = 3;

  /**初级合伙人**/
  static int junior_partner = 4;
  /**高级合伙人**/
  static int senior_partner = 5;
  /**准高级合伙人**/
  static int associate_senior_partner = 6;
  /**战略联盟**/
  static int strategic_alliance = 7;

  /**驻厂老师*/
  static int resident_teacher = 8;
  /**驻场经理**/
  static int resident_manager = 9;

  /**工厂HR**/
  static int factory_hr = 10;
  /**业务员**/
  static int salesman = 11;

  /**人事部**/
  static int ministry_of_personnel = 12;
  /**财务部**/
  static int finance_department = 13;

  /**总经理**/
  static int ceo = 14;
  /**蛋蛋**/
  static int dandankj = 15;

  /**
   * 是否登录过
   */
  static isExisting() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    print(shared.get("token"));
    var token = shared.getString("token");
    var phone = shared.getString("phone");
    var password = shared.getString("password");

    if (token != null && token.length > 0) {
      return await login(phone: phone, password: password);
    } else {
      return false;
    }
  }

  /**
   * 退出登录
   */
  static logout() async {
    await IM.logout();

    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove("token");
    shared.remove("phone");
    shared.remove("password");
    user = null;
    pushAndRemoveUntil(LoginViewController());

  }

  /**
   * 登录
   */
  static login({String phone, String password}) async {
    var url = "account/login";
    var arguments = {"phone": phone, "password": password};

    SBResponse response = await SBRequest.post(url, arguments: arguments);
    Progresshud.dismiss();
    if (response.code == 0) {

      // 保存token
      SharedPreferences shared = await SharedPreferences.getInstance();
      shared.setString("token", response.data);
      shared.setString("phone", phone);
      shared.setString("password", password);
      if (await getUserInfo() == false) {
        return false;
      }
      // 登录IM
      await IM.loginIM(phone: phone);
      if (user == null) {
        return false;
      } else {
        return true;
      }
    } else {
      ZKCommonUtils.showLongToast(response.msg);
      return false;
    }
  }

  /**
   * 获取修改密码验证码
   */
  static String autoCode = "";

  static getAuthCode({String phone}) async {
    if (phone == null || phone.length != 11) {
      return;
    }
    var url = "http://139.224.36.226:382/wgws/sendcode.action";
    autoCode = ZKRandom.random(lenght: 4);
    var arguments = {
      "AppKey": "378776199@qq.com",
      "CheckSum": "zgd456@456",
      "mobile": phone,
      "templateid": 17894503,
      "codeLen": 4,
      "authCode": autoCode,
    };

    Response response = await SBRequest.post2(url, arguments: arguments);
    var json = jsonDecode(response.data);

    print(response.runtimeType);
    print(response);
    if (json['code'] == 200) {
      ZKCommonUtils.showToast("验证码已送，请注意查收");
      return true;
    } else if (json['code'] == "16") {
      autoCode = "";
      ZKCommonUtils.showToast("操作次数过多,请30分钟后再试");
      return false;
    } else {
      autoCode = "";
      ZKCommonUtils.showToast(json['msg']);
      return false;
    }
  }

  /**
   * 申请好友
   */
  static addFriend({tuid, fuid}) async{
    var url = "account/addFriend";
    autoCode = ZKRandom.random(lenght: 4);
    var arguments = {
      "tuid": tuid,
      "fuid": fuid
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response == null) {
      return false;
    }
    if (response.code == 0) {
      ZKCommonUtils.showToast(response.msg);
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }

  /**
   * 获取好友申请列表
   */
  static getFriends() async{
    var url = "account/getFriends";
    SBResponse response = await SBRequest.post(url, arguments: {"uid":Account.user.id});

    List users = [];

    response.data.map((item){
      print(jsonEncode(item));
      users.add(FriendsModel.fromJson(item));
    }).toList();

    return users;
  }

  /**
   * 同意好友申请
   */
  static acceptInvitation({FriendsModel model}) async {
    var url = "account/acceptInvitation";
    SBResponse response = await SBRequest.post(url, arguments: {"id":model.id});
    return response.data;
  }

  /**
   * 拒绝好友申请
   */
  static declineInvitation({FriendsModel model}) async {
    var url = "account/declineInvitation";
    SBResponse response = await SBRequest.post(url, arguments: {"id":model.id});
    return response.data;
  }

  /**
   * 获取注册验证码
   */
  static getRegisterCode({String phone}) async {
    if (phone == null || phone.length != 11) {
      return;
    }

    var url = "http://139.224.36.226:382/wgws/sendcode.action";
    autoCode = ZKRandom.random(lenght: 4);
    var arguments = {
      "AppKey": "378776199@qq.com",
      "CheckSum": "zgd456@456",
      "mobile": phone,
      "templateid": 17856031,
      "codeLen": 4,
      "authCode": autoCode,
    };

    Response response = await SBRequest.post2(url, arguments: arguments);

    var json = jsonDecode(response.data);

    print(response.runtimeType);
    print(response);
    if (json['code'] == 200) {
      ZKCommonUtils.showToast("验证码已送，请注意查收："+autoCode);
      return true;
    } else if (json['code'] == "16") {
      autoCode = "";
      ZKCommonUtils.showToast("操作次数过多,请30分钟后再试");
      return false;
    } else {
      autoCode = "";
      ZKCommonUtils.showToast(json['msg']);
      return false;
    }
  }

  /**
   * 创建账号 注册
   */
  static createAccount({String phone, String password}) async {
    var url = "account/createAccount";
    SBResponse response = await SBRequest.post(url,
        arguments: {"phone": phone, "password": password});
    if (response?.data != null) {
      ZKCommonUtils.showToast(response.msg);
      autoCode = "";
      if (response.code == 0) {
        pop();
        print(response.data);
      }
    }

  }

  /**
   * 修改密码
   */
  static setPassword({String phone, String password}) async {
    var url = "account/setPassword";
    var arguments = {"phone": phone, "password": password};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showToast(response.msg);
    if (response.code == 0) {
      autoCode = "";
      pop();
    }
  }

  /**
   * 获取用户信息
   */
  static getInfoByPhone({String phone}) async {
    var url = "account/getInfoByPhone";
    var arguments = {"phone": phone};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    User user;
    if (response.code == 0) {
      user = User.fromJson(response.data);
    }
    return user;
  }

  /**
   * 获取用户信息 更新用户信息
   */
  static getUserInfo() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    print(shared.get("token"));

    var url = "account/getInfoByToken";
    SBResponse response = await SBRequest.post(url);
    print(jsonEncode(response.data));
    print(response.data['avatar']);
    user = User.fromJson(response.data);
//    if (IM.isLogin == false) {
//      await IM.loginIM(phone: user.phone);
//    }
    if (user.isDeath > 0) {
      ZKCommonUtils.showToast("账号异常,请联系您的经纪人");
      SharedPreferences shared = await SharedPreferences.getInstance();
      shared.remove("token");
      shared.remove("phone");
      shared.remove("password");
      pushAndRemoveUntil(LoginViewController());
      return false;
    }
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 通过邀请码获取用户信息
   */
  static getInfoByCode({String code}) async {
    var url = "account/getInfoByCode";
    var arguments = {
      "code": code
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return User.fromJson(response.data);
    } else {
      ZKCommonUtils.showLongToast(response.msg);
      return null;
    }
  }

  /**
   * 绑定邀请码
   */
  static bindInvitationCode({String code}) async {
    var url = "account/bindInvitationCode";
    var arguments = {
      "code": code
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showLongToast(response.msg);
    if (response.code == 0) {
      await getUserInfo();
      return true;
    } else {
      ZKCommonUtils.showToast(response.msg);
      return false;
    }
  }

  /**
   * 设置头像
   */
  static setAvatar(String avatar) async {

    var url = "account/setAvatar";
    SBResponse res = await SBRequest.post(url, arguments: {"url": avatar});
    Progresshud.dismiss();
    if (res.code == 0) {
      await getUserInfo();
      ZKCommonUtils.showToast("更新完成");
      return true;
    } else {
      ZKCommonUtils.showToast("保存失败");
      return false;
    }
  }

  /**
   * 设置姓名
   */
  static setUserName(String username) async {
    var url = "account/setUserName";
    var arguments = {
      "username": username
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      await getUserInfo();
      return true;
    } else {
      return false;
    }
  }

  /**
   * 设置性别
   */
  static setUserSex(int sex) async {
    var url = "account/setUserSex";
    var arguments = {
      "sex": sex
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      await getUserInfo();
      return true;
    } else {
      return false;
    }
  }

  static setBirthday({int age, String birthday}) async {
    var url = "account/setBirthday";
    var arguments = {
      "birthday": birthday,
      "age": age
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      await getUserInfo();
      return true;
    } else {
      return false;
    }

  }


/**
    var url = "account/XXX";
    var arguments = {

    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
 */
}
