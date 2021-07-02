//
//  文件名：MyResumeViewControlle
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//


import 'package:demo2020/Model/Resume.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/ResumeManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import 'AddResumeViewController.dart';

/// 我的简历
class BasicInformationViewController extends StatefulWidget {
  static const routeName = "/me/MyResume";

  bool isShowAdd = true;
  String phone = Account.user.phone;
  BasicInformationViewController(this.isShowAdd, {this.phone});

  @override
  _BasicInformationViewControllerState createState() =>
      _BasicInformationViewControllerState();
}

class _BasicInformationViewControllerState
    extends State<BasicInformationViewController> {

  static Resume resume;

  _onRefresh(BuildContext context) async {
    resume = await ResumeManager.get(widget.phone);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "基本信息",
      actions: <Widget>[
       widget.isShowAdd == true ? Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: Colors.deepOrangeAccent,
            child: Text("编写", style: TextStyle(color: Colors.white)),
            onPressed: () {
              routePush(AddResumeViewController()).then((value){
                _onRefresh(context);
              });
            },
          ),
        ) : Container()
      ],
      child:  SafeArea(
        bottom: true,
        minimum: EdgeInsets.only(bottom: 42),
        child: CardRefresher(
          onRefresh: () => _onRefresh(context),
          child: SafeArea(
            bottom: true,
            maintainBottomViewPadding: true,
            child: resume != null && resume?.id != null ? SingleChildScrollView(
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("贯籍:"),
                          Text(resume?.origin != null ? resume?.origin : ""),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("婚否:"),
                          Text(resume?.marriage == 0 ? "未婚" : "已婚"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("民族:"),
                          Text(resume?.nation != null ? resume?.nation : ""),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("学历:"),
                          Text(resume?.education != null ? resume?.education : ""),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("特长:"),
                          Expanded(
                            child: Text(resume?.speciality != null ? resume?.speciality : ""),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("紧急联系人:"),
                          Text(resume?.sos_name != null ? resume?.sos_name : ""),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("紧急联系人电话:"),
                          Text(resume?.sos_phone != null ? resume?.sos_phone : ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ) : Error404View(),
          ),
        ),
      ),
    );
  }
}
