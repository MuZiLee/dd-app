//
//  文件名：MyResumeViewControlle
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/CellItem.dart';
import 'package:one/Model/Resume.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/ResumeManager.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 我的简历
class MyResumeViewControlle extends StatefulWidget {
  static const routeName = "/me/MyResume";

  MyResumeViewControlle();

  @override
  _MyResumeViewControlleState createState() => _MyResumeViewControlleState();
}

class _MyResumeViewControlleState extends State<MyResumeViewControlle> {


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的简历",
      child: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CellItem(imagePath: 'images/icon_look.png', title: '基本信息'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CellItem(imagePath: 'images/icon_look.png', title: '教育经历'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CellItem(imagePath: 'images/icon_look.png', title: '工作经验'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
