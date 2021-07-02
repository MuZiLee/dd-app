import 'package:demo2020/Controller/Login/PasswordViewController.dart';
import 'package:demo2020/Controller/Login/RegisterViewController.dart';
import 'package:demo2020/Controller/TabBar/SBTabbarViewController.dart';
import 'package:demo2020/Provider/API.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Provider/Location.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/InputViews.dart';
import 'package:demo2020/Views/Keyboard/BlankToolBarTool.dart';
import 'package:demo2020/Views/LogoWidget.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewController extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginViewControllerState createState() => _LoginViewControllerState();
}

class _LoginViewControllerState extends State<LoginViewController> {
  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlankToolBarTool.blankToolBarWidget(context,
        model: blankToolBarModel,
        body: BaseScaffold(
            title: "登录",
            elevation: 0.0,
            child: SingleChildScrollView(
              child: buildContainer(context),
            )));
  }

  String phone = "";
  String password = "";

  buildContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
                height: 64.0,
              ),

              //手机号码
              PhoneInput(
                onChanged: (String value) => phone = value,
              ),

              //登录密码
              PasswordInput(
                title: "请输入密码",
                onChanged: (String value) => password = value,
              ),

              SizedBox(
                height: 32.0,
              ),

              buildColumn(context),

              ThemeButton("登录", onPressed: () {
                Progresshud.show();
                Future.delayed(Duration(seconds: 3), () async{
                  if (await Account.login(phone: phone, password: password)) {
                    pushAndRemoveUntil(SBTabbarViewController());
                  }

                });

              }),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            //新用户注册
            Expanded(
              flex: 1,
              child: Container(
                child: FlatButton(
                  child: Text("创建新账号",
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 10.0),
                      textAlign: TextAlign.left),
                  onPressed: () {
                    routePush(RegisterViewController());
                  },
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            //修改密码
            Expanded(
              flex: 1,
              child: Container(
                child: FlatButton(
                  child: Text(
                    "忘记密码",
                    style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () {
                    routePush(PasswordViewController());
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
