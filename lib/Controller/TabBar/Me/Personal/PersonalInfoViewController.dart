//
//  文件名：PersonalInfoViewController
//  所在包名：Controller.Me.Personal
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/Controller/TabBar/Me/Personal/EditorRealnameViewController.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/CardSeries/CardViewSeriesAvatar.dart';
import 'package:one/Views/CardSeries/CardViewSeriesDate.dart';
import 'package:one/Views/CardSeries/CardViewSeriesNumber.dart';
import 'package:one/Views/CardSeries/CardViewSeriesRight.dart';
import 'package:one/Views/CardSeries/CardViewSeriesSwitch.dart';
import 'package:one/Views/CardSeries/CardViewSeriesText.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';


/// 个人信息
class PersonalInfoViewController extends StatefulWidget {
  static const routeName = "/me/PersonalInfo";

  @override
  _PersonalInfoViewControllerState createState() =>
      _PersonalInfoViewControllerState();
}

class _PersonalInfoViewControllerState extends State<PersonalInfoViewController> {

  double progressValue = 0.0;

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "个人信息",
      elevation: 0.0,
      child: buildListView(),
    );
  }

  int newAge = 0;
  String placeholder;

  buildListView() {
    if (placeholder == null) {
      placeholder = Account.user.birthday;
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                CardViewSeriesAvatar(
                  title: "头像",
                  avatar: Account.user.avatar,
                  valueChanged: (image) async{
                    if (await Account.setAvatar(image)) {
                      setState(() {

                      });
                    }
                  },
                ),
                LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                )
              ],
            );
          } else if (index == 1) {
            return CardViewSeriesText(
              title: "蛋蛋ID",
              subtitle: Account.user.id.toString(),
              enabled: false,
            );
          } else if (index == 2) {
            return CardViewSeriesRight(
              title: "用户名",
              subtitle: Account.user.username,
              onTap: () {

                routePush(EditorRealnameViewController()).then((value) {
                  setState(() {

                  });
                });
              },
            );
          } else if (index == 3) {
            return CardViewSeriesSwitch(
              title: "性别",
              falseText: "女",
              trueText: "男",
              value: Account.user.sex == 0 ? false : true,
              onChanged: (value) {
                setSex(value);
              },
            );
          } else if (index == 4) {
            return CardViewSeriesNumber(
              title: "年龄",
              enabled: false,
              subtitle: newAge > 0 ? "${newAge}岁" : Account.user.age.toString() + "岁",
            );
          } else if (index == 5) {
            return CardViewSeriesDate(
              title: "生日",
              placeholder: placeholder,
              maxTime: new DateTime.now(),
              minTime: DateTime(1949,9,9),
              onConfirm: (DateTime dateTime) {
                setAge(age: newAge, birthday: placeholder);
              },
              valueChanged: (DateTime dateTime) {
                int year = DateTime.now().year - dateTime.year;
                setState(() {
                  newAge = year;
                  placeholder = "${dateTime.year}" +"-"+ "${dateTime.month}" +"-"+ "${dateTime.day}";
                });
              },
            );
          } else {
            return CardViewSeriesNumber(
              title: "手机号",
              subtitle: Account.user.phone,
              enabled: false
            );
          }
        },
        itemCount: 7);
  }


  /// 设置性别
  setSex(bool value) async {
    Account.setUserSex(value == true ? 1 : 0).then((value) {
      setState(() {

      });
    });
  }

  /// 设置年龄
  setAge({int age, String birthday}) async {
    Account.setBirthday(age: age, birthday: birthday).then((value) {
      setState(() {

      });
    });
  }
}
