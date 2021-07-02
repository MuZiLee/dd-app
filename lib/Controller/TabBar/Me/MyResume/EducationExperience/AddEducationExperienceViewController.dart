//
//  文件名：AddEducationExperienceViewController
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-13
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/Model/Resume.dart';
import 'package:one/Provider/ResumeManager.dart';
import 'package:one/Views/CardSeries/CardViewSeriesEducation.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardViewSeriesDate.dart';
import 'package:one/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:one/Views/CardSeries/CardViewSeriesText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one/Views/card_settings/card_settings.dart';


/// 添加 编辑 教育经历
class AddEducationExperienceViewController extends StatefulWidget {
  static const routeName = "/tabbar/me/resume/AddEducationExperience";


  AddEducationExperienceViewController(){

  }

  @override
  _AddEducationExperienceViewControllerState createState() => _AddEducationExperienceViewControllerState();
}

class _AddEducationExperienceViewControllerState extends State<AddEducationExperienceViewController> {

  Educational educationex = Educational();

  @override
  Widget build(BuildContext context) {


    return BaseScaffold(
      title: "教育经历",
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: selectedIconColor,
            child: Text('保存', style: TextStyle(color: topColor)),
            onPressed: () async{
              await ResumeManager.saveResumeEducationalExperience(
                education: educationex.education,
                school: educationex.school,
                major: educationex.major,
                graduation_time: educationex.graduation_time
              );
            },
          ),
        )
      ],
      child: CardSettings(
        // padding: 0,
        children: <Widget>[
          CardViewSeriesHeader(
            title: "*添加教育经历",
          ),
          CardViewSeriesEducation(
            title: "学历",
            isNotNull: true,
//            subtitle: educationex?.education != null ? educationex.education : "选择学历",
            onConfirm: (value) => educationex.education = value,
          ),
          CardViewSeriesText(
            title: "毕业学校",
            placeholder: "学校名称",
            isNotNull: true,
            onChanged: (value) => educationex.school = value,
          ),
          CardViewSeriesDate(
            title: "毕业时间",
            isNotNull: true,
            maxTime: new DateTime.now(),
            minTime: DateTime(1949,9,9),
            valueChanged: (DateTime dateTime) {
              educationex.graduation_time = "${dateTime.year}" +"-"+ "${dateTime.month}" +"-"+ "${dateTime.day}";
            },
          ),
          CardViewSeriesText(
            title: "所学专业:",
            isNotNull: true,
            placeholder: "专业名称",
            onChanged: (value) => educationex.major = value,
          ),

        ],
      ),

    );
  }
}
