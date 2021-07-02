//
//  文件名：AddWorkExperienceViewController
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-14
//  版权所有 © 2019。 保留所有权利
//


import 'package:demo2020/Model/Resume.dart';
import 'package:demo2020/Provider/ResumeManager.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesDate.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/Views/card_settings/widgets/card_settings_panel.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 添加工作经历
class AddWorkExperienceViewController extends StatefulWidget {
  static const routeName = "/tabbar/me/myresume/AddWorkExperience";

  @override
  _AddWorkExperienceViewControllerState createState() => _AddWorkExperienceViewControllerState();
}

class _AddWorkExperienceViewControllerState extends State<AddWorkExperienceViewController> {

  Work work = Work();

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "工作经历",
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: selectedIconColor,
            child: Text('保存', style: TextStyle(color: topColor)),
            onPressed: () async{

              if (work.company_name == null) {
                ZKCommonUtils.showToast("公司名字不能为空");
                return;
              }
              if (work.company_address == null) {
                ZKCommonUtils.showToast("公司地址不能为空");
                return;
              }
              if (work.company_job == null) {
                ZKCommonUtils.showToast("所在职位不能为空");
                return;
              }
              if (work.work_time == null) {
                ZKCommonUtils.showToast("在职时长不能为空");
                return;
              }
              if (work.dimission_time == null) {
                ZKCommonUtils.showToast("离职时间不能为空");
                return;
              }
              if (work.work_content == null) {
                ZKCommonUtils.showToast("工作内容不能为空");
                return;
              }

              await ResumeManager.saveResumeWorkExperience(
                company_name: work.company_name,
                company_address: work.company_address,
                company_phone: work.company_phone,
                company_job: work.company_job,
                work_time: work.work_time,
                dimission_time: work.dimission_time,
                work_content: work.work_content
              );


            },
          ),
        )
      ],
      child: SingleChildScrollView(
        child: buildCardSettings(),
      ),

    );
  }

  buildCardSettings() {
    return Column(
      children: <Widget>[
        CardViewSeriesHeader(
          title: "*添加工作经历",
        ),
        CardViewSeriesText(
          title: "公司名称",
          isNotNull: true,
          placeholder: "公司名字",
          onChanged: (value) => work.company_name = value,
        ),
        CardViewSeriesText(
          title: "公司地址",
          isNotNull: true,
          placeholder: "公司地址",
          onChanged: (value) => work.company_address = value,
        ),
        CardViewSeriesText(
          title: "公司电话",
          placeholder: "公司电话",
          onChanged: (value) => work.company_phone = value,
        ),
        CardViewSeriesText(
          title: "所属职位",
          isNotNull: true,
          placeholder: "所在职位",
          onChanged: (value) => work.company_job = value,
        ),
        CardViewSeriesText(
          title: "在职时长",
          isNotNull: true,
          placeholder: "请输入",
          onChanged: (value) {
            work.work_time = value;
          },
        ),
        CardViewSeriesDate(
          title: "离职时间",
          isNotNull: true,
          maxTime: new DateTime.now(),
          minTime: DateTime(1949,9,9),
          placeholder: work.dimission_time,
          onConfirm: (DateTime dateTime) {
            work.dimission_time = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
          },
          valueChanged: (DateTime dateTime) {
            work.dimission_time = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
          },
        ),
        CardViewSeriesTextView(
          title: "工作内容",
          isNotNull: true,
          placeholder: "工作内容",
          valueChanged: (value) => work.work_content = value,
        ),

      ],
    );
  }

}
