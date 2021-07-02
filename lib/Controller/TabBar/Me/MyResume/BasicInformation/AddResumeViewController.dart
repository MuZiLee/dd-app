//
//  文件名：AddResumeViewController
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-13
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/Model/Resume.dart';
import 'package:one/Provider/ResumeManager.dart';
import 'package:one/Views/CardSeries/CardViewSeriesCity.dart';
import 'package:one/Views/CardSeries/CardViewSeriesEducation.dart';
import 'package:one/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:one/Views/CardSeries/CardViewSeriesNationality.dart';
import 'package:one/Views/CardSeries/CardViewSeriesSwitch.dart';
import 'package:one/Views/CardSeries/CardViewSeriesText.dart';
import 'package:one/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one/Views/card_settings/card_settings.dart';

/// 基本信息
class AddResumeViewController extends StatefulWidget {
  static const routeName = "/tabbar/me/myResume/AddResume";

  Resume resume;

  AddResumeViewController({this.resume}) {
    if (this.resume == null) {
      resume = Resume();
    }
  }

  @override
  _AddResumeViewControllerState createState() =>
      _AddResumeViewControllerState();
}

class _AddResumeViewControllerState extends State<AddResumeViewController> {

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "基本信息",
      child: Container(
        child: Form(
          child: CardSettings(
            // padding: 0,
            children: <Widget>[
              CardViewSeriesHeader(
                title: "*添加基本信息",
              ),
              CardViewSeriesCity(
                title: "籍贯",
                subtitle: widget.resume?.origin,
                isNotNull: true,
                onConfirm: (p, c, t) {
                  widget.resume.origin = p + " " + c + " " + t;
                },
              ),
              CardViewSeriesSwitch(
                  title: "婚否",
                  falseText: "未婚",
                  trueText: "已婚",
                  isNotNull: true,
                  value: widget.resume?.marriage == 0 ? true : false,
                  onChanged: (value) {
                    widget.resume.marriage = value ? 1 : 0;
                  }),
              CardViewSeriesNationality(
                title: "民族",
                isNotNull: true,
                subtitle: widget.resume?.nation,
                onConfirm: (value) {
                  widget.resume.nation = value;
                },
              ),
              CardViewSeriesEducation(
                title: "学历",
                isNotNull: true,
                subtitle: widget.resume?.education != null ? widget.resume?.education : "",
                onConfirm: (value) {
                  widget.resume.education = value;
                },
              ),
              CardViewSeriesText(
                title: "紧急联系人",
                isNotNull: true,
                placeholder: "姓名",
                subtitle: widget.resume?.sos_name,
                onChanged: (value) {
                  widget.resume.sos_name = value;
                },
              ),
              CardViewSeriesText(
                title: "紧急联系人电话",
                isNotNull: true,
                placeholder: "11位手机号",
                subtitle: widget.resume?.sos_phone,
                onChanged: (value) {
                  widget.resume.sos_phone = value;
                },
              ),
              CardViewSeriesTextView(
                title: "特长",
                isNotNull: true,
                color: Colors.grey,
                text: widget.resume?.speciality,
                valueChanged: (value) {
                  widget.resume.speciality = value;
                },
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            textColor: topColor,
            color: Colors.deepOrangeAccent,
            child: Text("提交"),
            onPressed: () {
              print(widget.resume.toJson());
              ResumeManager.saveBasicInformation(
                origin: widget.resume.origin,
                marriage: widget.resume.marriage,
                nation: widget.resume.nation,
                education: widget.resume.education,
                speciality: widget.resume.speciality,
                sos_name: widget.resume.sos_name,
                sos_phone: widget.resume.sos_phone
              );
            },
          ),
        )
      ],
    );
  }
}
