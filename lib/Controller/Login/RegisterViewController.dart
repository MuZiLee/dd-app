//
//  文件名：RegisterViewController
//  所在包名：Controller.Account
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-08
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/Controller/WebBrowser/WebBrowserViewController.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/InputViews.dart';
import 'package:one/Views/Keyboard/BlankToolBarTool.dart';
import 'package:one/Views/LogoWidget.dart';
import 'package:one/Views/ThemeButton.dart';
import 'package:one/config.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class RegisterViewController extends StatefulWidget {
  static const routeName = "/account/Register";

  @override
  _RegisterViewControllerState createState() => _RegisterViewControllerState();
}

class _RegisterViewControllerState extends State<RegisterViewController> {

  /// 用户注册协议
  String register_agreement = Config.BASE_URL+"/agreement/register_agreement.html";
  String privacy_agreement = Config.BASE_URL+"/agreement/privacy_agreement.html";

  //手机号
  String phone = "";

  //密码
  String passwor = "";

  //验证码
  String code = "";


  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  Widget build(BuildContext context) {
    return BlankToolBarTool.blankToolBarWidget(context,
        model: blankToolBarModel,
        body: BaseScaffold(
          title: "注册",
          elevation: 0.0,
          child: SingleChildScrollView(
            child: buildContainer(context),
          ),

        ));
  }

  bool aRadio = false;

  buildContainer(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              //LOGO
              LogoWidget(),

              SizedBox(
                height: 32.0,
              ),


              //手机号码
              PhoneInput(
                onChanged: (String value) => phone = value
              ),

              //登录密码
              PasswordInput(title: "请输入密码", onChanged: (String value) => passwor = value),

              /// 验证码
              AuthCodeInput(
                onChanged: (value) {
                  setState(() {
                    this.code = value;
                  });
                },
                onPressed: (){
                  if (phone.length != 11) {
                    ZKCommonUtils.showToast("手机号不正确");
                    return;
                  }


                  Account.getRegisterCode(phone: phone);
                },
              ),


              SizedBox(
                height: 64.0,
              ),

              Row(
                children: <Widget>[
                  Checkbox(value: aRadio, activeColor: Colors.deepOrangeAccent, onChanged: (value){
                    setState(() {
                      aRadio = value;
                    });
                  }),
                  InkWell(
                    child: Text(
                      "同意并继续《会员注册协议》",
                      style: TextStyle(
                        fontSize: 13,
                        color: aRadio == false ? Colors.grey : Colors.deepOrangeAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: (){
                      routePush(WebBrowserViewController(title: "会员注册协议", url: register_agreement,));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "《隐私政策》",
                      style: TextStyle(
                        fontSize: 13,
                        color: aRadio == false ? Colors.grey : Colors.deepOrangeAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: (){
                      routePush(WebBrowserViewController(title: "隐私政策", url: privacy_agreement,));
                    },
                  ),
                ],
              ),
              ThemeButton("注册新账号", onPressed: () {


                if (Account.autoCode != code) {
                  ZKCommonUtils.showToast("验证码不正确");
                  return;
                }

                if (aRadio == false) {
                  ZKCommonUtils.showToast("注册需要同意用户协议");
                  return;
                }

                if (phone == null || phone.length < 11) {
                  ZKCommonUtils.showToast("请输入正确手机号码");
                  return;
                }

                Account.createAccount(phone: phone, password: passwor);

              }),
            ],
          ),
        ),
      ),
    );
  }



}
