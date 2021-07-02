//
//  文件名：PasswordViewController
//  所在包名：Controller.Account
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-08
//  版权所有 © 2019。 保留所有权利
//

import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/InputViews.dart';
import 'package:demo2020/Views/Keyboard/BlankToolBarTool.dart';
import 'package:demo2020/Views/LogoWidget.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordViewController extends StatefulWidget {
  static const routeName = "/account/Password";

  @override
  _PasswordViewControllerState createState() => _PasswordViewControllerState();
}

class _PasswordViewControllerState extends State<PasswordViewController> {
  //手机号
  String phone = "";

  //密码
  String password = "";

  //验证码
  String code = "";


  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  Widget build(BuildContext context) {
    return BlankToolBarTool.blankToolBarWidget(context,
        model: blankToolBarModel,
        body: BaseScaffold(
          title: '忘记密码',
          elevation: 0.0,
          child: SingleChildScrollView(
            child: buildContainer(context),
          )
        ));
  }


  Widget buildContainer(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32.0,
              ),
              //LOGO
              LogoWidget(),

              SizedBox(
                height: 32.0,
              ),

              /// 手机号码
              PhoneInput(
                onChanged: (value) => this.phone = value,
              ),

              /// 登录密码1
              PasswordInput(
                title: "请输入密码",
                onChanged: (value) => this.password = value,
              ),

              /// 验证码
              AuthCodeInput(
                onChanged: (value) => this.code = value,
                obscureText: false,
                onPressed: (){
                  if (phone.length != 11) {
                    ZKCommonUtils.showToast("手机号不正确");
                    return;
                  }
                  Account.getAuthCode(phone: phone);
                },
              ),

              SizedBox(
                height: 88.0,
              ),

              ThemeButton("修改密码", onPressed: () {
                print(
                    "phone:${phone}, password:${password}, code:${code}");

                if (Account.autoCode != code) {
                  ZKCommonUtils.showToast("验证码不正确");
                  return;
                }

                if (phone == null || phone.length < 11) {
                  ZKCommonUtils.showToast("请输入正确手机号码");
                  return;
                }

                Account.setPassword(phone: phone, password: password);


              }),
            ],
          ),
        ),
      ),
    );
  }




}
