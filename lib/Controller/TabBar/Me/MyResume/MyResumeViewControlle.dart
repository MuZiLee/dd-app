//
//  文件名：MyResumeViewControlle
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//

import 'package:demo2020/CellItem.dart';
import 'package:demo2020/Model/Resume.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/ResumeManager.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 我的简历
class MyResumeViewControlle extends StatefulWidget {
  static const routeName = "/me/MyResume";

  bool isShowAdd = true;
  String username;
  String phone = Account.user.phone;
  MyResumeViewControlle(this.isShowAdd, {this.username = "我的", this.phone});

  @override
  _MyResumeViewControlleState createState() => _MyResumeViewControlleState();
}

class _MyResumeViewControlleState extends State<MyResumeViewControlle> {


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.username + "简历",
      child: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CellItem(imagePath: 'images/icon_look.png', title: '基本信息', isShowAdd: widget.isShowAdd, phone: widget.phone,),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CellItem(imagePath: 'images/icon_look.png', title: '教育经历', isShowAdd: widget.isShowAdd, phone: widget.phone),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CellItem(imagePath: 'images/icon_look.png', title: '工作经验', isShowAdd: widget.isShowAdd, phone: widget.phone),
              ],
            ),
          )
        ],
      ),
    );
  }
}
